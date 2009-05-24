From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2 bugs related to suspend to disk
Date: Sun, 24 May 2009 21:58:14 +0200
Message-ID: <200905242158.15093.rjw__39203.7749560133$1243195199$gmane$org@sisk.pl>
References: <4A199A7A.3010705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4A199A7A.3010705@gmail.com>
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
To: Marcin Slusarz <marcin.slusarz@gmail.com>
Cc: Linux PM List <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sunday 24 May 2009, Marcin Slusarz wrote:
> 1) echo platform > /sys/power/disk; echo disk > /sys/power/state
> 
> works but prints:
> 
> BUG: sleeping function called from invalid context at include/linux/writeback.h:87
> in_atomic(): 1, irqs_disabled(): 0, pid: 6509, name: sh
> 3 locks held by sh/6509:
>  #0:  (&buffer->mutex){+.+.+.}, at: [<>] sysfs_write_file+0x38/0x119
>  #1:  (pm_mutex){+.+.+.}, at: [<>] hibernate+0x17/0x169
>  #2:  (swap_lock){+.+...}, at: [<>] swap_type_of+0x2e/0xed
> Pid: 6509, comm: sh Not tainted 2.6.30-rc7-mod #124
> Call Trace:
>  ? __debug_show_held_locks
>  ? bdev_test
>  __might_sleep
>  ifind
>  ? bdev_test
>  iget5_locked
>  ? bdev_set
>  bdget
>  swap_type_of
>  swsusp_write
>  ? acpi_sleep_tts_switch
>  hibernate
>  state_store
>  kobj_attr_store
>  sysfs_write_file
>  vfs_write
>  sys_write
>  system_call_fastpath
> 
> 2) "s2disk" (from suspend-0.8) suspends, but doesn't resume (and I need to mkswap && swapon -a later)
> 
> It's not a regression, because I never tried to STD (STR worked).

Both look strange, at least the first one does.

Thanks for the report, I'll do my best to take care of this as soon as I can.

Best,
Rafael
