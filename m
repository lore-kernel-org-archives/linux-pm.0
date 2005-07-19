From: Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: PM Summit in Ottawa
Date: Wed, 20 Jul 2005 00:02:31 +1000
Message-ID: <1121781751.3130.64.camel@localhost>
References: <F7DC2337C7631D4386A2DF6E8FB22B300410F9A0@hdsmsx401.amr.corp.intel.com>
	<20050717211230.GA26394@kroah.com>
	<1121638067.13493.15.camel@localhost>
	<Pine.LNX.4.50.0507181130410.19183-100000@monsoon.he.net>
Reply-To: ncunningham@cyclades.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============52873096935912534=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.50.0507181130410.19183-100000@monsoon.he.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Patrick Mochel <mochel@digitalimplant.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>
Cc: david-b@pacbell.net, abelay@novell.com, Vojtech Pavlik <vojtech@suse.cz>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============52873096935912534==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi.

Added linux-pm to the cc. I think but am not sure that everyone is on
the list, but erred on the side of caution and left the cc as is.

On Tue, 2005-07-19 at 04:32, Patrick Mochel wrote:
> On Mon, 18 Jul 2005, Nigel Cunningham wrote:
> 
> > > suspend2
> > - diffstat from yesterday misleading (same file changed in multiple
> > patches counted multiple times; patchset includes things that should be
> > merged separately/not at all etc).
> 
> Would you mind specifying exactly what the right numbers are?

Sure. Numbers taken from my current development tree:

Workthreads patch: Support for freezing selected kernel threads.
 drivers/acpi/osl.c          |    2 +-
 drivers/block/ll_rw_blk.c   |    2 +-
 drivers/char/hvc_console.c  |    2 +-
 drivers/char/hvcs.c         |    2 +-
 drivers/input/serio/serio.c |    2 +-
 drivers/md/dm-crypt.c       |    2 +-
 drivers/scsi/hosts.c        |    2 +-
 drivers/usb/net/pegasus.c   |    2 +-
 include/linux/kthread.h     |   16 ++++++++++++++++
 include/linux/workqueue.h   |    9 ++++++---
 kernel/kmod.c               |    4 ++++
 kernel/kthread.c            |   23 ++++++++++++++++++++++-
 kernel/sched.c              |    4 ++--
 kernel/softirq.c            |    3 +--
 kernel/workqueue.c          |   21 ++++++++++++---------
 15 files changed, 71 insertions(+), 25 deletions(-)

Syncthreads patch: Support for freezing processes that are in sys_*sync after other userspace processes.
 fs/buffer.c           |   45 +++++++++++++++++++++++++++++++++++++++++++--
 include/linux/sched.h |    2 ++
 2 files changed, 45 insertions(+), 2 deletions(-)

Remainder of the patches: This includes arch specific support, removing
mtrr sysdev support (which will go away if/when I do hotplug cpu). Of
the 85 files, 50 are new. Some are admittedly small. That's because I've
been asked to try and separate out functionality areas into different
files. Perhaps I went overboard.

 Documentation/kernel-parameters.txt |    9 
 Documentation/power/internals.txt   |  364 +++++++
 Documentation/power/suspend2.txt    |  631 +++++++++++++
 Documentation/power/todo.txt        |   12 
 arch/i386/kernel/cpu/mtrr/main.c    |   32 
 arch/i386/kernel/smp.c              |    2 
 arch/i386/mm/init.c                 |   36 
 arch/i386/mm/pageattr.c             |   41 
 arch/i386/power/Makefile            |    2 
 arch/i386/power/smp.c               |   86 +
 arch/ppc/Kconfig                    |    2 
 arch/ppc/kernel/swsusp.c            |   88 +
 arch/ppc/mm/init.c                  |   14 
 arch/ppc/platforms/pmac_feature.c   |    5 
 arch/ppc/syslib/of_device.c         |    2 
 arch/x86_64/kernel/asm-offsets.c    |    2 
 arch/x86_64/kernel/suspend.c        |    3 
 arch/x86_64/mm/init.c               |   19 
 drivers/acpi/sleep/proc.c           |   11 
 drivers/macintosh/Kconfig           |    4 
 drivers/macintosh/via-pmu.c         |    7 
 include/asm-i386/suspend.h          |    1 
 include/asm-i386/suspend2.h         |  403 ++++++++
 include/asm-i386/tlbflush.h         |    5 
 include/asm-ppc/cpu_context.h       |   98 ++
 include/asm-ppc/suspend2.h          |   45 
 include/asm-x86_64/suspend2.h       |  437 +++++++++
 include/linux/dyn_pageflags.h       |   63 +
 include/linux/kernel.h              |    2 
 include/linux/netlink.h             |    1 
 include/linux/suspend.h             |    2 
 include/linux/suspend2.h            |  216 ++++
 init/do_mounts.c                    |   28 
 init/do_mounts_initrd.c             |   14 
 init/main.c                         |    5 
 kernel/kthread.c                    |    1 
 kernel/power/Kconfig                |   78 +
 kernel/power/Makefile               |   23 
 kernel/power/atomic_copy.c          |  464 +++++++++
 kernel/power/atomic_copy.h          |   15 
 kernel/power/block_io.h             |   57 +
 kernel/power/compression.c          |  637 +++++++++++++
 kernel/power/driver_model.c         |   95 +
 kernel/power/driver_model.h         |   24 
 kernel/power/encryption.c           |  597 ++++++++++++
 kernel/power/extent.c               |  206 ++++
 kernel/power/extent.h               |   83 +
 kernel/power/io.c                   | 1001 ++++++++++++++++++++
 kernel/power/io.h                   |   37 
 kernel/power/pagedir.c              |  324 ++++++
 kernel/power/pagedir.h              |   54 +
 kernel/power/pageflags.c            |  126 ++
 kernel/power/pageflags.h            |   84 +
 kernel/power/plugins.c              |  319 ++++++
 kernel/power/plugins.h              |  179 +++
 kernel/power/power.h                |    2 
 kernel/power/power_off.c            |  148 +++
 kernel/power/power_off.h            |   13 
 kernel/power/prepare_image.c        |  585 ++++++++++++
 kernel/power/prepare_image.h        |   33 
 kernel/power/proc.c                 |  336 +++++++
 kernel/power/proc.h                 |   68 +
 kernel/power/suspend.c              | 1177 ++++++++++++++++++++++++
 kernel/power/suspend.h              |   28 
 kernel/power/suspend2-smp.c         |   12 
 kernel/power/suspend2-smp.h         |    7 
 kernel/power/suspend2.h             |   24 
 kernel/power/suspend2_common.h      |   53 +
 kernel/power/suspend_block_io.c     |  817 +++++++++++++++++
 kernel/power/suspend_checksums.c    |  619 ++++++++++++
 kernel/power/suspend_file.c         | 1613 +++++++++++++++++++++++++++++++++
 kernel/power/suspend_swap.c         | 1723 ++++++++++++++++++++++++++++++++++++
 kernel/power/swsusp.c               |    7 
 kernel/power/swsusp.h               |   24 
 kernel/power/ui.c                   | 1136 +++++++++++++++++++++++
 kernel/power/ui.h                   |   57 +
 kernel/power/userspace-nofreeze.c   |   69 +
 kernel/power/version.h              |    5 
 kernel/sys.c                        |    6 
 lib/Makefile                        |    2 
 lib/dyn_pageflags.c                 |   78 +
 lib/vsprintf.c                      |   28 
 mm/bootmem.c                        |    4 
 mm/swapfile.c                       |    1 
 mm/vmscan.c                         |    4 
 85 files changed, 15721 insertions(+), 54 deletions(-)

There are other patches, but they belong in the
will-go-away/should-be-merged-anyway etc category.

> >
> > > 	- must merge portions that are not core, in tiny pieces.
> > > 	- Nigel and Pavel will work together.
> >
> > Is that a command or a statement? :>
> 
> Heh, neither. It's a necessity for success. :)(

:>

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.


--===============52873096935912534==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============52873096935912534==--
