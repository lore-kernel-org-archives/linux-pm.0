From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v3 4/5] PM: Add visible HIBERNATION_INTERFACE
	and hide HIBERNATION
Date: Wed, 16 Mar 2011 01:53:31 +0100
Message-ID: <201103160153.32080.rjw__46628.3903726891$1300236894$gmane$org@sisk.pl>
References: <1299906471-31011-1-git-send-email-rshriram@cs.ubc.ca>
	<201103152238.29405.rjw@sisk.pl>
	<AANLkTimyDVG7YjNmQGjo7pnKyZE1cXSZyVNx_rekNgNC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTimyDVG7YjNmQGjo7pnKyZE1cXSZyVNx_rekNgNC@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: rshriram@cs.ubc.ca
Cc: linux-pm@lists.linux-foundation.org, xen-devel@lists.xensource.com
List-Id: linux-pm@vger.kernel.org

On Tuesday, March 15, 2011, Shriram Rajagopalan wrote:
> 2011/3/15 Rafael J. Wysocki <rjw@sisk.pl>:
> > Hi,
> >
> > Sorry, I didn't have the time to review the patch in detail before.
> >
> > On Saturday, March 12, 2011, Shriram Rajagopalan wrote:
> >> HIBERNATION covers the main hibernation control code and freeze-thaw
> >> pm events, that xen's save/restore also uses. Explicitly enabling
> >> an independant hibernation functionality to enable xen's save/restore
> >> is a bit ugly. Define a new user visible symbol HIBERNATION_INTERFACE
> >> that "selects" HIBERNATION and covers the main hibernation control code
> >> instead of HIBERNATION. This way, we can also make XEN_SAVE_RESTORE
> >> "select" HIBERNATION, enabling only the freeze-thaw code.
> >>
> >> Signed-off-by: Shriram Rajagopalan <rshriram@cs.ubc.ca>
> >> ---
> >>  kernel/power/Kconfig     |    9 +++++++--
> >>  kernel/power/hibernate.c |    4 ++++
> >>  kernel/power/main.c      |    2 +-
> >>  kernel/power/user.c      |    2 ++
> >>  4 files changed, 14 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> >> index 4603f08..493c678 100644
> >> --- a/kernel/power/Kconfig
> >> +++ b/kernel/power/Kconfig
> >> @@ -19,10 +19,15 @@ config SUSPEND_FREEZER
> >>         Turning OFF this setting is NOT recommended! If in doubt, say Y.
> >>
> >>  config HIBERNATION
> >> -     bool "Hibernation (aka 'suspend to disk')"
> >> -     depends on SWAP && ARCH_HIBERNATION_POSSIBLE
> >> +     def_bool n
> >
> > You don't need that.  Simply use "bool"
> >
> >> +     depends on ARCH_HIBERNATION_POSSIBLE
> >
> > That need not depend on it, HIBERNATION_INTERFACE should instead.
> >
> Does that mean the pm_ops interface does not depend on the ARCH_HIB.. ?

That's as far as I remember, but no, it only depends on HIBERNATION.

> >>       select LZO_COMPRESS
> >>       select LZO_DECOMPRESS
> >
> > These two selects may be moved to HIBERNATION_INTERFACE too.
> >
> >> +
> >> +config HIBERNATION_INTERFACE
> >> +     bool "Hibernation (aka 'suspend to disk')"
> >> +     depends on SWAP
> >> +     select HIBERNATION
> >>       ---help---
> >>         Enable the suspend to disk (STD) functionality, which is usually
> >>         called "hibernation" in user interfaces.  STD checkpoints the
> >> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> >> index 1832bd2..13bcf69 100644
> >> --- a/kernel/power/hibernate.c
> >> +++ b/kernel/power/hibernate.c
> >> @@ -592,6 +592,7 @@ static int prepare_processes(void)
> >>   *   hibernate - The granpappy of the built-in hibernation management
> >>   */
> >>
> >> +#ifdef CONFIG_HIBERNATION_INTERFACE
> >
> > Please don't do that.  Please make the whole hibernate.c depend on
> > CONFIG_HIBERNATION_INTERFACE.
> >
> This #if only wraps the hibernate() function. There is a whole lot of code
> (global functions too) before the hibernate() function.
> 
> As i mentioned in the first email 0/5, simply making
> hibernate.c and user.c depend on HIBERNATION_INTERFACE does not work.
> 
> I got the following linker errors.
> 
> kernel/built-in.o: In function `sys_reboot':
> kernel/sys.c:440: undefined reference to `hibernate'
> kernel/built-in.o: In function `state_store':
> kernel/power/main.c:185: undefined reference to `hibernate'
> kernel/built-in.o: In function `hibernate_preallocate_memory':
> kernel/power/snapshot.c:1411: undefined reference to `swsusp_show_speed'
> kernel/built-in.o: In function `swsusp_check':
> kernel/power/swap.c:933: undefined reference to `swsusp_resume_device'
> kernel/power/swap.c:938: undefined reference to `swsusp_resume_block'
> kernel/power/swap.c:946: undefined reference to `swsusp_resume_block'
> kernel/built-in.o: In function `load_image_lzo':
> kernel/power/swap.c:878: undefined reference to `swsusp_show_speed'
> kernel/built-in.o: In function `load_image':
> kernel/power/swap.c:741: undefined reference to `swsusp_show_speed'
> kernel/built-in.o: In function `save_image_lzo':
> kernel/power/swap.c:502: undefined reference to `lzo1x_1_compress'
> kernel/power/swap.c:543: undefined reference to `swsusp_show_speed'
> kernel/built-in.o: In function `swsusp_swap_check':
> kernel/power/swap.c:221: undefined reference to `swsusp_resume_block'
> kernel/power/swap.c:221: undefined reference to `swsusp_resume_device'
> kernel/built-in.o: In function `mark_swapfiles':
> kernel/power/swap.c:195: undefined reference to `swsusp_resume_block'
> kernel/power/swap.c:202: undefined reference to `swsusp_resume_block'
> kernel/built-in.o: In function `save_image':
> kernel/power/swap.c:418: undefined reference to `swsusp_show_speed'
> drivers/built-in.o: In function `acpi_suspend':
> drivers/acpi/sleep.c:584: undefined reference to `hibernate'
> drivers/built-in.o: In function `ata_scsi_start_stop_xlat':
> drivers/ata/libata-scsi.c:1331: undefined reference to
> `system_entering_hibernation'
> drivers/built-in.o: In function `acpi_sleep_init':
> drivers/acpi/sleep.c:782: undefined reference to `hibernation_set_ops'
> arch/x86/power/built-in.o: In function `restore_registers':
> arch/x86/power/hibernate_asm_64.S:145: undefined reference to `in_suspend'
> 
> Seeing errors from arch/.. was also the reason why I made HIBERNATE depend on
> ARCH_HIBERNATION_POSSIBLE

Well, all of those things above are fixable.

Basically, I can do the patch for you, but that'll take some time.
Stay tuned. :-)

Thanks,
Rafael
