From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: Is it supposed to be ok to call del_gendisk while
 userspace is frozen?
Date: Mon, 17 May 2010 07:32:57 +1000
Message-ID: <4BF06489.1050200__22189.4594877542$1274045748$gmane$org@crca.org.au>
References: <Pine.LNX.4.44L0.1005142231390.11498-100000@netrider.rowland.org>
	<201005152230.10230.rjw@sisk.pl> <4BEFA375.7030404@crca.org.au>
	<201005162138.07105.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201005162138.07105.rjw@sisk.pl>
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
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Matt Reimer <mattjreimer@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi.

On 17/05/10 05:38, Rafael J. Wysocki wrote:
> On Sunday 16 May 2010, Nigel Cunningham wrote:
>> Hi.
>>
>> On 16/05/10 06:30, Rafael J. Wysocki wrote:
>>> On Saturday 15 May 2010, Alan Stern wrote:
>>>> On Thu, 13 May 2010, Matt Reimer wrote:
>>>>
>>>>>> I don't see anything wrong with the patch itself, but I dislike the
>>>>>> description.  Devices can come and go from any hotpluggable bus, not
>>>>>> just MMC/SD.  That just happens to be the first place the problem was
>>>>>> observed.
>>>>>
>>>>> Good point. How about this?
>>>>>
>>>>> Matt
>>>>>
>>>>>   From 813bd223e5a2fa577b9e64ddf12654a93d0aab8b Mon Sep 17 00:00:00 2001
>>>>> From: Matt Reimer<mreimer@sdgsystems.com>
>>>>> Date: Thu, 13 May 2010 14:36:54 -0700
>>>>> Subject: [PATCH] fs: prevent hang on suspend/resume when MMC/SD card present
>>>>>
>>>>> Devices can come and go bus during suspend or resume, when the
>>>>> writeback thread is frozen, resulting in a hang. Prevent the hang
>>>>> by thawing the writeback thread in del_gendisk().
>>>>
>>>> I would have said "the block layer's writeback thread", but this is
>>>> okay.
>>>
>>> OK, so now I have a question who's going to take the patch.
>>
>> I object to the patch.
>>
>> Tell the patch it ought to exit once thawed, by all means.
>
> I'm not sure what you mean.  Care to explain?

I mean "Set up some sort of flag that it can look at once thawed at 
resume time, and use that to tell it to exit at that point."

>> Make the patch unfreezeable to begin with, by all means.
>
> That wouldn't work.

Why not?

>> But don't go down the path of having $random_code_path unfreeze a
>> thread. That will lead to unpredictability, confusion and bugs.
>
> As a general rule, I agree, but this particular case is somewhat special.
>
>> If you know a disk is going to be unregistered during resume,
>
> How do we check that, exactly?

Well, if you can figure out that you need to go down this path at this 
point in the process, you must be able to apply the same logic to come 
to the same conclusion earlier in the process.

>> use the hooks early in the suspend / hibernate process to block new I/O and
>> flush what's already there so that there's no need to block on the
>> writeback thread, and/or no need to have the writeback thread frozen.
>
> I'm not sure if that's realistic.  Do you have a specific implementation in
> mind?

No - just the conviction that there must be a way in which the logic 
that says we need to call del_gendisk can be applied earlier to clean 
things up at an earlier stage.

I'd love to look at it further, but I'm moving house on Wednesday, so 
have a little bit of a pressing need to do some packing at the moment :) 
That said, next week, life is going to be very different - I could look 
at it then.

Regards,

Nigel
