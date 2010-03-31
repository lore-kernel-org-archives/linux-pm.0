From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: [RFC 09/15] PM / Hibernate: user,
 implement user_ops writer
Date: Wed, 31 Mar 2010 13:31:01 +1100
Message-ID: <4BB2B3E5.7020708@crca.org.au>
References: <1269361063-3341-1-git-send-email-jslaby@suse.cz>	<201003300009.18315.rjw@sisk.pl>
	<4BB1508E.9030103@crca.org.au> <201003302303.12758.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201003302303.12758.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Jiri Slaby <jirislaby@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi.

On 31/03/10 08:03, Rafael J. Wysocki wrote:
>>> Now, an attractive thing would be to compress data while creating the image
>>> and that may be done in the following way:
>>>
>>> have a buffer ready
>>> repeat:
>>> - copy image pages to the buffer (instead of copying them directly into the
>>>     image storage space)
>>> - if buffer is full, compress it and copy the result to the image storage
>>>     space, page by page.
>>
>> A few points that might be worth considering:
>>
>> Wouldn't compressing the image while creating it rather than while
>> writing increase the overall time taken to hibernate (since the time
>> taken can't then be combined with the time for writing the image)?
>
> It would, but that's attractive anyway, because the image could be larger than
> 1/2 of memory this way without using the LRU pages as temporary storage
> space (which I admit I'm reluctant to do).
>
>> Wouldn't it also increase the memory requirements?
>
> Not really, or just a little bit (the size of the buffer).  I'm talking about
> the image that's created atomically after we've frozen devices.

The buffer would be the size of the compressed image. Assuming you rely 
on 50+% compression, you'll still need to ensure that at least 1/3 of 
memory is available for the buffer for the compressed data. This would 
give maximum image size of only 1/6th of memory more than without 
compression - not much of a gain.

It's also ugly because if you find that you don't achieve the expected 
compression, you'll need to undo the going atomic, free some more memory 
and try again - or just give up (which I hope you won't consider to be a 
real option).

Regarding using LRU pages as temporary storage, if it wasn't safe and 
reliable, I would have stopped doing it ages ago. The only problem I can 
recall having was when KMS was introduced, and that was solved by adding 
a very small amount of code to let us find those pages and make sure 
they're atomically copied instead. We did have a period where we were 
paranoid about the issue - the support for checksumming LRU pages prior 
to writing the LRU, then checking the checksums prior to the atomic copy 
is still in TuxOnIce and used. Searching through my mail archives, I'm 
unable to find anyone with a debugging message that says something other 
than "0 pages resaved in atomic copy".

Regards,

Nigel
