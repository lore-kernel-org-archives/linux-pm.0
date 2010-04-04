From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: [RFC 09/15] PM / Hibernate: user,
 implement user_ops writer
Date: Mon, 05 Apr 2010 09:08:28 +1000
Message-ID: <4BB91BEC.6030906@crca.org.au>
References: <1269361063-3341-1-git-send-email-jslaby@suse.cz>	<201003312225.25085.rjw@sisk.pl>
	<4BB3B95A.5000901@crca.org.au> <201003312336.50620.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201003312336.50620.rjw@sisk.pl>
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

Hi again.

On 01/04/10 08:36, Rafael J. Wysocki wrote:
>>>> Regarding using LRU pages as temporary storage, if it wasn't safe and
>>>> reliable, I would have stopped doing it ages ago.
>>>
>>> We've been through that already and as you can see I'm still not convinced.
>>> Sorry, but that's how it goes.  The fact that ToI uses this approach without
>>> seeing any major breakage is a good indication that it _may_ be safe in
>>> general, not that it _is_ safe in all cases one can imagine.
>>
>> It's not "any major breakage", but no breakage at all over a course of
>> about 6 or 7 years of usage. I agree that it's not mathematical proof,
>> but still...
>
> I'd say without any reported breakage you could blame on the usage of LRU
> pages.  But I think even if such things were reported, it wouldn't be really
> straightforward to track them down to the LRU, because they wouldn't be
> reproducible.

That depends on the cause. There are only so many things that can change 
the contents of the LRU. Freezing tasks significantly reduces that 
number, and with memory allocation tracking, it shouldn't be that hard 
to figure out what caused the issue - especially when we find the 
problem while atomic and can therefore dump etc data structures without 
worrying about locking. Ugly, yes. But it would reliably find the cause.

>>> Besides, that would be a constraint on the future changes of the mm subsystem
>>> that I'm not sure we should introduce.  At least the mm people would need to
>>> accept that and there's a long way before we're even able to ask them.
>>
>> It doesn't need to be that way. As with KMS, a simple way of flagging
>> which pages need to be atomically copied is all that's necessary.
>
> I'm not sure about that.
>
> Besides, assuming that the LRU pages are really safe, I'd prefer to save them
> directly as a part of the image along with the atomic copy instead of using
> them as temporary storage.

We're obviously not going to agree on this. Can we nevertheless find a 
way ahead in which we're both happy? Seek to minimise the differences, 
even if some of the TuxOnIce code isn't merged?

Regards,

Nigel
