#this file will only run if you have the accompanying csvs
#you have to change the file name to match the csv name in 3 places
#where the exclamation marks are

import string
import pandas as pd
import os
import csv
from collections import defaultdict
from nltk.corpus import stopwords
from nltk.stem.wordnet import WordNetLemmatizer

os.chdir("/Users/Zac/Desktop/presentation/comments/csv")

columns = defaultdict(list)
#converst the csv column to a readable format to count likes
#this needs to match other input field
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
with open("iphone3G.csv", encoding = "ISO-8859-1") as f:
	reader = csv.DictReader(f) # read column into a dictionary format
	for row in reader: # read a row as {column1: value1, column2: value2,...}
		for (k,v) in row.items(): # go over each column name and value 
			columns[k].append(v) # append the value into the appropriate list based on column name k

likes = columns["likes"]
comments = columns["textComments"]
dictA = dict(zip(likes, comments))
likes = mynewlist = [s for s in likes if s.isdigit()] #removes spaces
likes= list(map(int, likes)) #convert to integers,


# Python program to find N largest 
# element from given list of integers 
  
# Function returns N largest elements or highest number of likes
final_list = []
def maxelements(list1, N): 
    #sets the length of top list
    for i in range(0, N):  
        max1 = 0
        
        for j in range(len(list1)):      
            if list1[j] > max1:
                max1 = list1[j]        
        #have to remove from list so list can continue to be compared to            
        list1.remove(max1);
        final_list.append(max1)
    print("\tHighest Number of Likes are")      
    print(final_list)
    print("")
    return final_list

list1 = likes 
N = 10
# Calling the function

maxelements(list1, N)
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
data = pd.read_csv('iphone3G.csv', encoding = "ISO-8859-1")
print("\tComments with the most Likes are:")
for c in final_list:
    x = data.loc[data['likes'] == c, 'commentText']
    print("")
    print(x)
    

# Open the input file
# Check permissions and existience
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
try:
    s = open("iphone3G.csv", encoding = "ISO-8859-1").read()
    s = s.translate(s.maketrans('', '', string.punctuation))
    s = s.lower()
    s = s.rstrip()
except:
    print("Can not open file")
try:
    a = open(".csv").read() #dont have to change this
    a = a.translate(s.maketrans('', '', string.punctuation))
    a = a.lower()
    #removes all whitespaces on the right
    a = a.rstrip()
    
except:
    print("Can not open file")
    

lmtzr = WordNetLemmatizer() 
# Import the corpus of English stop words
stop = stopwords.words('english')
# Uncomment the print statement below to see what words are included by default
#print (stop)
# count characters 
num_chars = len(s)
# count lines 
num_lines = s.count('\n')
#splits words at white spaces into a list of comma separated strings
words = s.split() #+ a.split() 

#first method to remove stop words
counts = dict() #empty dictionary
for word in words:
    if word not in stop:
        # Lemmatize - Lemmatizing is similar to stemming but reduces the word to its root as defined in the dictionary
        lmtzr.lemmatize(word)
        # Now add to counts dictionary if it does not exist
        if word not in counts:
            counts[word] = 1
        else:
            counts[word] += 1

#second method to remove stop words
d = counts       
if "to" in d:
    del d["to"]
if "the" in d:
    del d["the"]
if "very" in d:
    del d["very"]
if "in" in d:
    del d["in"]
if "i" in d:
    del d["i"]
if "you" in d:
    del d["you"]
if "is" in d:
    del d["is"]
if "a" in d:
    del d["a"]
if "and" in d:
    del d["and"]
if "was" in d:
    del d["was"]
if "on" in d:
    del d["on"]
if "have" in d:
    del d["have"]
if "of" in d:
    del d["of"]
if "that" in d:
    del d["that"]
if "its" in d:
    del d["its"]
if "of" in d:
    del d["of"]
if "my" in d:
    del d["my"]
if "lol" in d:
    del d["lol"]
if "how" in d:
    del d["how"]
if "from" in d:
    del d["from"]
if "can" in d:
    del d["can"]
if "as" in d:
    del d["as"]
if "just" in d:
    del d["just"]
if "he" in d:
    del d["he"]
if "this" in d:
    del d["this"]
if "it" in d:
    del d["it"]
if "so" in d:
    del d["so"]
if "your" in d:
    del d["your"]
if "for" in d:
    del d["for"]
if "at" in d:
    del d["at"]
if "but" in d:
    del d["but"]
if "an" in d:
    del d["an"]
if "with" in d:
    del d["with"]
if "if" in d:
    del d["if"]
if "when" in d:
    del d["when"]
if "then" in d:
    del d["then"]
if "are" in d:
    del d["are"]
if "they" in d:
    del d["they"]
if "has" in d:
    del d["has"]
if "be" in d:
    del d["be"]
if "u" in d:
    del d["u"]
if "or" in d:
    del d["or"]
if "im" in d:
    del d["im"]
if "do" in d:
    del d["do"]
if "thats" in d:
    del d["thats"]
if "haha" in d:
    del d["haha"]
if "me" in d:
    del d["me"]
if "c2a0" in d:
    del d["c2a0"]
if "phone" in d:
    del d["phone"]
if "iphone" in d:
    del d["iphone"]
if "iphone" in d:
    del d["than"]

num_words = sum(d[w] for w in d) #get the total number of words

lst = [(d[w], w) for w in d]
lst.sort()
lst.reverse()

print('Your input file has characters = ' + str(num_chars))
print('Your input file has num_lines = ' + str(num_lines))
print('Your input file has num_words = ' + str(num_words))

print('\n The 30 most frequent words are \n')

i = 1
for count, word in lst[:50]: #count looks like a global expression but it will be defined in the for lop as the value of the key where words is the key
    print('%2s.  %4s %s \t%s' % (i, count, word, count/num_words))
    i += 1

for count, word in lst[:50]: #count looks like a global expression but it will be defined in the for lop as the value of the key where words is the key
    print('%s' % (int(count)))
    i += 1
for count, word in lst[:50]: #count looks like a global expression but it will be defined in the for lop as the value of the key where words is the key
    print('%s' % (word))
    i += 1
i = 1
for count, word in lst[:50]: #count looks like a global expression but it will be defined in the for lop as the value of the key where words is the key
    print('%2s' % i)
    i += 1
for count, word in lst[:50]: #count looks like a global expression but it will be defined in the for lop as the value of the key where words is the key
    print('%2s' % (count/(num_words)))
    i += 1
#Used this part to make word cloud in https://www.wordclouds.com
#for count, word in lst[:45]: #count looks like a global expression but it will be defined in the for lop as the value of the key where words is the key
#    print('%s' % (count))
#    i += 1



