From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: [RFC 09/15] PM / Hibernate: user,
 implement user_ops writer
Date: Thu, 01 Apr 2010 08:06:34 +1100
Message-ID: <4BB3B95A.5000901@crca.org.au>
References: <1269361063-3341-1-git-send-email-jslaby@suse.cz>
	<201003302303.12758.rjw@sisk.pl> <4BB2B3E5.7020708@crca.org.au>
	<201003312225.25085.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201003312225.25085.rjw@sisk.pl>
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

On 01/04/10 07:25, Rafael J. Wysocki wrote:
> On Wednesday 31 March 2010, Nigel Cunningham wrote:
>> Hi.
>>
>> On 31/03/10 08:03, Rafael J. Wysocki wrote:
>>>>> Now, an attractive thing would be to compress data while creating the image
>>>>> and that may be done in the following way:
>>>>>
>>>>> have a buffer ready
>>>>> repeat:
>>>>> - copy image pages to the buffer (instead of copying them directly into the
>>>>>      image storage space)
>>>>> - if buffer is full, compress it and copy the result to the image storage
>>>>>      space, page by page.
>>>>
>>>> A few points that might be worth considering:
>>>>
>>>> Wouldn't compressing the image while creating it rather than while
>>>> writing increase the overall time taken to hibernate (since the time
>>>> taken can't then be combined with the time for writing the image)?
>>>
>>> It would, but that's attractive anyway, because the image could be larger than
>>> 1/2 of memory this way without using the LRU pages as temporary storage
>>> space (which I admit I'm reluctant to do).
>>>
>>>> Wouldn't it also increase the memory requirements?
>>>
>>> Not really, or just a little bit (the size of the buffer).  I'm talking about
>>> the image that's created atomically after we've frozen devices.
>>
>> The buffer would be the size of the compressed image.
>
> Not necessarily if the image is compressed in chunks.  According to
> measurements I did some time ago, 256 KiB chunks were sufficient.

I must be missing something. You're talking about doing compression of 
the image during the atomic copy, right? If that's the case, where do 
the 256KiB chunks come in?

>> Assuming you rely on 50+% compression, you'll still need to ensure that at
>> least 1/3 of memory is available for the buffer for the compressed data.
>
> That's correct.
>
>> This would give maximum image size of only 1/6th of memory more than without
>> compression - not much of a gain.
>
> Still, on a 1 GiB machine that's about 170 MiB which is quite some data.
>
>> It's also ugly because if you find that you don't achieve the expected
>> compression, you'll need to undo the going atomic, free some more memory
>> and try again - or just give up (which I hope you won't consider to be a
>> real option).
>
>  From my experience we can safely assume 50% compression in all cases.

I've seen it lower in some cases - lots of video or such like in memory. 
But then perhaps that's just because I'm not discarding anything.

>> Regarding using LRU pages as temporary storage, if it wasn't safe and
>> reliable, I would have stopped doing it ages ago.
>
> We've been through that already and as you can see I'm still not convinced.
> Sorry, but that's how it goes.  The fact that ToI uses this approach without
> seeing any major breakage is a good indication that it _may_ be safe in
> general, not that it _is_ safe in all cases one can imagine.

It's not "any major breakage", but no breakage at all over a course of 
about 6 or 7 years of usage. I agree that it's not mathematical proof, 
but still...

> Besides, that would be a constraint on the future changes of the mm subsystem
> that I'm not sure we should introduce.  At least the mm people would need to
> accept that and there's a long way before we're even able to ask them.

It doesn't need to be that way. As with KMS, a simple way of flagging 
which pages need to be atomically copied is all that's necessary.

Regards,

Nigel
