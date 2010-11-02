From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] One more power management fix for 2.6.37
Date: Tue, 2 Nov 2010 17:49:08 -0400
Message-ID: <AANLkTikF+8VsxyjmXUc_6Epd923g5DCxneNArFNTGrZ___25225.4519415603$1288734854$gmane$org@mail.gmail.com>
References: <201010292358.27975.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201010292358.27975.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Greg KH <greg@kroah.com>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Oct 29, 2010 at 5:58 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>
> Please pull one more power management fix for 2.6.37 from:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git pm-fixes
>
> It fixes a regression in the core I/O runtime PM code.

I think we have more. It may be the driver core, though. So I added
GregKH to the recipients too...

On resume-from-ram with basically current -git (-rc1 + four patches):

  ...
  ata1.01: configured for MWDMA2
  ata1: EH complete
  PM: resume of devices complete after 3240.438 msecs
  ------------[ cut here ]------------
  WARNING: at lib/kref.c:34 kref_get+0x23/0x2c()
  Hardware name: HP Compaq 2510p Notebook PC
  Modules linked in: iwlagn [last unloaded: scsi_wait_scan]
  Pid: 7985, comm: pm-suspend Not tainted 2.6.37-rc1-00004-geb8abb9 #11
  Call Trace:
   [<ffffffff81036082>] warn_slowpath_common+0x80/0x98
   [<ffffffff810360af>] warn_slowpath_null+0x15/0x17
   [<ffffffff8120001f>] kref_get+0x23/0x2c
   [<ffffffff811fee1b>] kobject_get+0x1a/0x21
   [<ffffffff812d84bb>] get_device+0x14/0x1a
   [<ffffffff812dfcd5>] dpm_resume_end+0x230/0x37c
   [<ffffffff81060a09>] suspend_devices_and_enter+0x158/0x188
   [<ffffffff81060b04>] enter_state+0xcb/0xcf
   [<ffffffff810602cf>] state_store+0xa7/0xc6
   [<ffffffff811fec2b>] kobj_attr_store+0x17/0x19
   [<ffffffff810f75dc>] sysfs_write_file+0xf2/0x12e
   [<ffffffff810ab99c>] vfs_write+0xb0/0x12f
   [<ffffffff810abbf8>] sys_write+0x45/0x6c
   [<ffffffff81001fab>] system_call_fastpath+0x16/0x1b
  ---[ end trace af18256edd598c9c ]---

Any ideas? I incuded the "ata1:..." lines, but the timestamps are actually

  ...
  [11627.776490] ata1: EH complete
  [11629.384719] PM: resume of devices complete after 3240.438 msecs
  [11629.400284] ------------[ cut here ]------------
  ...

so it's a second and a half after that ata1 resume EH complete
message, and a bit after it says that it's completed all device
resumes.

This oops is then followed by a lot of other oopses,most of which
didn't get captured because the box hung afterwards. But the next oops
was in kmem_cache_alloc(), so I think it's because the device
refcounts were bad and had caused slab corruption when being freed too
early or something. So I think the other oopses are all a result of
this kref problem.

Hmm?

                         Linus
