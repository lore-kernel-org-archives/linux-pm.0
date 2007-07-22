From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: crash with 2.6.22.1 crash:ll_rw_blk.c
	blk_remove_plug()
Date: Mon, 23 Jul 2007 00:17:18 +0200
Message-ID: <20070722221717.GV11657__21808.4890781485$1185142687$gmane$org@kernel.dk>
References: <469DD37C.8050200@bfs.de> <20070718103342.GI11657@kernel.dk>
	<469DF233.5080902@bfs.de> <20070718110724.GN11657@kernel.dk>
	<469E072E.7080400@bfs.de> <20070718123142.GV11657@kernel.dk>
	<46A38B1E.3090605@bfs.de>
	<a781481a0707221020m3c3a397fifa9076aefc63148a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <a781481a0707221020m3c3a397fifa9076aefc63148a@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Satyam Sharma <satyam.sharma@gmail.com>
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, wharms@bfs.de
List-Id: linux-pm@vger.kernel.org

On Sun, Jul 22 2007, Satyam Sharma wrote:
> Hi Walter,
>
> Thanks for reporting this.
>
> On 7/22/07, walter harms <wharms@bfs.de> wrote:
>> hello all,
>> on my asus notebook tm620 there is a crash with 2.6.22 and 2.6.21
>
> Did this happen when you were resuming from a suspend-to-ram/disk?
> [ I ask because I see swsusp in the trace below, linux-pm added to Cc: ]
>
>> ....
>> Using IPI Shortcut mode
>> WARNING: at block/ll_rw_blk.c:1575 blk_remove_plug()
>>  [<c01ac87e>] blk_remove_plug+0x36/0x5a
>>  [<c01ac8b6>] __generic_unplug_device+0x14/0x1f
>>  [<c01ad587>] __make_request+0x39b/0x49c
>>  [<c01abc8c>] generic_make_request+0x228/0x255
>>  [<c01adb54>] submit_bio+0xa5/0xac
>>  [<c013e233>] mempool_alloc+0x37/0xae
>>  [<c01314dc>] submit+0xc2/0x11d
>>  [<c0131585>] bio_read_page+0x24/0x27
>>  [<c013188b>] swsusp_check+0x4f/0xaf
>>  [<c012f6c2>] software_resume+0x5f/0x108
>>  [<c037867e>] kernel_init+0xb0/0x212
>>  [<c0103a16>] ret_from_fork+0x6/0x1c
>>  [<c03785ce>] kernel_init+0x0/0x212
>>  [<c03785ce>] kernel_init+0x0/0x212
>>  [<c010465b>] kernel_thread_helper+0x7/0x10
>>  =======================
>
> Surprising, that's a WARN_ON(!irqs_disabled()) but IRQs are disabled
> alright on that codepath. OTOH, __make_request() is heavily goto-driven,
> uses the non-save/restore variants of spin_lock_irq, and does not even
> balance locks / unlocks for some error paths ... gaah.

__make_request() must be called from process context, hence
spin_lock_irq() is perfectly already and the fastest way to go. And of
course the locking is balanced! So please save your 'gaah's for code
you actually took the time to try and understand.

But it does look like unbalanced irq disable/enable calls. I'd guess in
the suspend/resume path. Obviously something more esoteric, since this
is the first such report for 2.6.22, so like some not-very-used driver
for instance.

-- 
Jens Axboe
