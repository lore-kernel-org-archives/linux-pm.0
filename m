From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: PM/hibernate swapfile regression
Date: Tue, 14 Jul 2009 18:21:05 +0200
Message-ID: <200907141821.06101.rjw@sisk.pl>
References: <20090714135453.GA26976@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090714135453.GA26976@osiris.boeblingen.de.ibm.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Hans-Joachim Picht <hans@linux.vnet.ibm.com>, pm list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 14 July 2009, Heiko Carstens wrote:
> We've seen this bug:
> 
> Jul  8 13:16:02 h05lp03 kernel: BUG: sleeping function called from invalid context at /home/autobuild/BUILD/linux-2.6.30-20090707/include/linux/writeback.h:87
> Jul  8 13:16:02 h05lp03 kernel: in_atomic(): 1, irqs_disabled(): 0, pid: 24377, name: bash
> Jul  8 13:16:02 h05lp03 kernel: 3 locks held by bash/24377:
> Jul  8 13:16:02 h05lp03 kernel: #0:  (&buffer->mutex){+.+.+.}, at: [<0000000000276e74>] sysfs_write_file+0x4c/0x1ac
> Jul  8 13:16:02 h05lp03 kernel: #1:  (pm_mutex#2){+.+.+.}, at: [<000000000018f128>] hibernate+0x34/0x200
> Jul  8 13:16:02 h05lp03 kernel: #2:  (swap_lock){+.+.-.}, at: [<00000000001f371c>] swap_type_of+0x44/0x158
> Jul  8 13:16:02 h05lp03 kernel: CPU: 8 Not tainted 2.6.30-39.x.20090707-s390xdefault #1
> Jul  8 13:16:02 h05lp03 kernel: Process bash (pid: 24377, task: 000000012ce84240, ksp: 00000000c262bb00)
> Jul  8 13:16:02 h05lp03 kernel: 0000000000000000 00000000c262ba88 0000000000000002 0000000000000000
> Jul  8 13:16:02 h05lp03 kernel:       00000000c262bb28 00000000c262baa0 00000000c262baa0 00000000005448c4
> Jul  8 13:16:02 h05lp03 kernel:       0000000000000000 000000012ce84718 000000013d5bf1a8 0000000000000000
> Jul  8 13:16:02 h05lp03 kernel:       000000000000000d 0000000000000000 00000000c262baf8 000000000000000e
> Jul  8 13:16:02 h05lp03 kernel:       0000000000553da8 0000000000105600 00000000c262ba88 00000000c262bad0
> Jul  8 13:16:02 h05lp03 kernel: Call Trace:
> Jul  8 13:16:02 h05lp03 kernel: ([<00000000001054fc>] show_trace+0xf0/0x148)
> Jul  8 13:16:02 h05lp03 kernel: [<00000000001391ba>] __might_sleep+0x172/0x188
> Jul  8 13:16:02 h05lp03 kernel: [<000000000021f738>] ifind+0x88/0xe4
> Jul  8 13:16:02 h05lp03 kernel: [<0000000000220b0e>] iget5_locked+0x66/0x1d8
> Jul  8 13:16:02 h05lp03 kernel: [<000000000023b676>] bdget+0x5e/0x150
> Jul  8 13:16:02 h05lp03 kernel: [<00000000001f37b2>] swap_type_of+0xda/0x158
> Jul  8 13:16:02 h05lp03 kernel: [<0000000000192342>] swsusp_write+0x4e/0x458
> Jul  8 13:16:02 h05lp03 kernel: [<000000000018f254>] hibernate+0x160/0x200
> Jul  8 13:16:02 h05lp03 kernel: [<000000000018d8da>] state_store+0x82/0xa8
> Jul  8 13:16:02 h05lp03 kernel: [<0000000000276f20>] sysfs_write_file+0xf8/0x1ac
> Jul  8 13:16:02 h05lp03 kernel: [<000000000020663a>] vfs_write+0xae/0x15c
> Jul  8 13:16:02 h05lp03 kernel: [<00000000002067e0>] SyS_write+0x54/0xac
> Jul  8 13:16:02 h05lp03 kernel: [<0000000000117a96>] sysc_noemu+0x10/0x16
> Jul  8 13:16:02 h05lp03 kernel: [<00000047083e36b4>] 0x47083e36b4
> 
> Looks like this was introduced with git commit a1bb7d61 "PM/hibernate: fix "swap
> breaks after hibernation failures"".
> Calling bdget while holding a spinlock doesn't seem to be a good idea...

Agreed, sorry for missing that.

Alan, can you please prepare a fix?

Rafael
