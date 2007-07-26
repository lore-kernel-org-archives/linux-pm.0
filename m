From: walter harms <wharms@bfs.de>
Subject: Re: crash with 2.6.22.1 crash:ll_rw_blk.c
	blk_remove_plug()
Date: Thu, 26 Jul 2007 09:05:17 +0200
Message-ID: <46A847AD.5000803__261.356429155235$1185433583$gmane$org@bfs.de>
References: <469DD37C.8050200@bfs.de> <20070718103342.GI11657@kernel.dk>
	<469DF233.5080902@bfs.de> <20070718110724.GN11657@kernel.dk>
	<469E072E.7080400@bfs.de> <20070718123142.GV11657@kernel.dk>
	<46A38B1E.3090605@bfs.de>
	<a781481a0707221020m3c3a397fifa9076aefc63148a@mail.gmail.com>
	<20070722221717.GV11657@kernel.dk>
	<a781481a0707241722y5ef33a72qe61d5f4299cff273@mail.gmail.com>
	<20070725111836.GR3287@kernel.dk>
Reply-To: wharms@bfs.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070725111836.GR3287@kernel.dk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Satyam Sharma <satyam.sharma@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org



Jens Axboe wrote:
> On Wed, Jul 25 2007, Satyam Sharma wrote:
>> On 7/23/07, Jens Axboe <jens.axboe@oracle.com> wrote:
>>> On Sun, Jul 22 2007, Satyam Sharma wrote:
>>>> Hi Walter,
>>>>
>>>> Thanks for reporting this.
>>>>
>>>> On 7/22/07, walter harms <wharms@bfs.de> wrote:
>>>>> hello all,
>>>>> on my asus notebook tm620 there is a crash with 2.6.22 and 2.6.21
>>>> Did this happen when you were resuming from a suspend-to-ram/disk?
>>>> [ I ask because I see swsusp in the trace below, linux-pm added to Cc: ]
>>>>
>>>>> ....
>>>>> Using IPI Shortcut mode
>>>>> WARNING: at block/ll_rw_blk.c:1575 blk_remove_plug()
>>>>>  [<c01ac87e>] blk_remove_plug+0x36/0x5a
>>>>>  [<c01ac8b6>] __generic_unplug_device+0x14/0x1f
>>>>>  [<c01ad587>] __make_request+0x39b/0x49c
>>>>>  [<c01abc8c>] generic_make_request+0x228/0x255
>>>>>  [<c01adb54>] submit_bio+0xa5/0xac
>>>>>  [<c013e233>] mempool_alloc+0x37/0xae
>>>>>  [<c01314dc>] submit+0xc2/0x11d
>>>>>  [<c0131585>] bio_read_page+0x24/0x27
>>>>>  [<c013188b>] swsusp_check+0x4f/0xaf
>>>>>  [<c012f6c2>] software_resume+0x5f/0x108
>>>>>  [<c037867e>] kernel_init+0xb0/0x212
>>>>>  [<c0103a16>] ret_from_fork+0x6/0x1c
>>>>>  [<c03785ce>] kernel_init+0x0/0x212
>>>>>  [<c03785ce>] kernel_init+0x0/0x212
>>>>>  [<c010465b>] kernel_thread_helper+0x7/0x10
>>>>>  =======================
>>>> Surprising, that's a WARN_ON(!irqs_disabled()) but IRQs are disabled
>>>> alright on that codepath. OTOH, __make_request() is heavily goto-driven,
>>>> uses the non-save/restore variants of spin_lock_irq, and does not even
>>>> balance locks / unlocks for some error paths ... gaah.
>>> __make_request() must be called from process context, hence
>>> spin_lock_irq() is perfectly already and the fastest way to go. And of
>>> course the locking is balanced! So please save your 'gaah's for code
>>> you actually took the time to try and understand.
>> You're right, I didn't really look at that code for long (it even 
>> explicitly
>> comments about what's going with the locking in there!) sorry about
>> that.
>>
>> [ Off-topic: BTW does every call to __make_request() end up in
>> blk_remove_plug()? Since you're explicitly making the assumption
>> that it *must* be called from process context (and hence the use of
>> the non-save/restore variants), you could consider putting a
>> WARN_ON(irqs_disabled()) over there, and perhaps a WARN_ON
>> (!spin_is_locked(queue_lock)) in blk_remove_plug() instead, and
>> other such similar functions that currently have the !irqs_disabled
>> check. This way you'd effectively cover _both_ the assertions,
>> and in appropriate places -- just a suggestion. ]
> 
> No, blk_remove_plug() will only be called for sync bios, or where we
> have to wait for request allocation (which will unplug the device).
> 
> __generic_make_request() already does a might_sleep() check, so it
> should catch this already.
> 
>>> But it does look like unbalanced irq disable/enable calls. I'd guess in
>>> the suspend/resume path. Obviously something more esoteric, since this
>>> is the first such report for 2.6.22, so like some not-very-used driver
>>> for instance.
>> Now that I do look at the codepath, it does seem surprising irqs were
>> not disabled there. There are a bunch of calls to _other_ functions
>> between the spin_lock_irq and the blk_remove_plug via
>> __generic_unplug_device that would also have complained about
>> !irqs_disabled.
>>
>> Walter, does this happen reproducibly?
> 
> As I previously wrote, it's like some of the device power up or resume
> routines that botch the irq enable/disable stuff. It'd be interesting to
> start stripping down the config until the warning goes away - or enable
> CONFIG_PM_DEBUG which may help as well.
> 

hi all,
i have recompiled the kernel with CONFIG_PM_DEBUG but that resulted in nothing
more that a magic number after the backtrace, does anyone care ?

I played with hda=c,h,s to overcome the detection problem but no success here
beside some "TSC instability". i did not try this with a working kernel, it is only
to give you all information i have.

re,
 wh
