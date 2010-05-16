From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: Is it supposed to be ok to call del_gendisk while
 userspace is frozen?
Date: Sun, 16 May 2010 17:49:09 +1000
Message-ID: <4BEFA375.7030404__12714.1702258543$1273996224$gmane$org@crca.org.au>
References: <Pine.LNX.4.44L0.1005142231390.11498-100000@netrider.rowland.org>
	<201005152230.10230.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201005152230.10230.rjw@sisk.pl>
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

On 16/05/10 06:30, Rafael J. Wysocki wrote:
> On Saturday 15 May 2010, Alan Stern wrote:
>> On Thu, 13 May 2010, Matt Reimer wrote:
>>
>>>> I don't see anything wrong with the patch itself, but I dislike the
>>>> description.  Devices can come and go from any hotpluggable bus, not
>>>> just MMC/SD.  That just happens to be the first place the problem was
>>>> observed.
>>>
>>> Good point. How about this?
>>>
>>> Matt
>>>
>>>  From 813bd223e5a2fa577b9e64ddf12654a93d0aab8b Mon Sep 17 00:00:00 2001
>>> From: Matt Reimer<mreimer@sdgsystems.com>
>>> Date: Thu, 13 May 2010 14:36:54 -0700
>>> Subject: [PATCH] fs: prevent hang on suspend/resume when MMC/SD card present
>>>
>>> Devices can come and go bus during suspend or resume, when the
>>> writeback thread is frozen, resulting in a hang. Prevent the hang
>>> by thawing the writeback thread in del_gendisk().
>>
>> I would have said "the block layer's writeback thread", but this is
>> okay.
>
> OK, so now I have a question who's going to take the patch.

I object to the patch.

Tell the patch it ought to exit once thawed, by all means.

Make the patch unfreezeable to begin with, by all means.

But don't go down the path of having $random_code_path unfreeze a 
thread. That will lead to unpredictability, confusion and bugs.

If you know a disk is going to be unregistered during resume, use the 
hooks early in the suspend / hibernate process to block new I/O and 
flush what's already there so that there's no need to block on the 
writeback thread, and/or no need to have the writeback thread frozen.

Regards,

Nigel
