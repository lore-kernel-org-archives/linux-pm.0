From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Suspend-devel] 2.6.25-rc2 System no longer powers
	off after suspend-to-disk. Screen becomes green.
Date: Thu, 21 Feb 2008 17:27:20 +0100
Message-ID: <200802211727.21593.rjw__7129.59784218601$1203611429$gmane$org@sisk.pl>
References: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com>
	<200802201639.02502.jesse.barnes@intel.com>
	<b6a2187b0802201800n12f90b22x8cb0c2ad6e0c402@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <b6a2187b0802201800n12f90b22x8cb0c2ad6e0c402@mail.gmail.com>
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
To: Jeff Chua <jeff.chua.linux@gmail.com>
Cc: Dave Airlie <airlied@linux.ie>, Greg KH <gregkh@suse.de>, lkml <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Jesse Barnes <jesse.barnes@intel.com>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, 21 of February 2008, Jeff Chua wrote:
> On Thu, Feb 21, 2008 at 8:39 AM, Jesse Barnes <jesse.barnes@intel.com> wrote:
> > On Wednesday, February 20, 2008 4:35 pm Jeff Chua wrote:
> >  > On Thu, Feb 21, 2008 at 5:37 AM, Jesse Barnes <jesse.barnes@intel.com>
> >  wrote:
> >  > >  Ok, can you give this patch a try with the 'platform' method?  It should
> >  > > at least tell us what ACPI would like the device to do at suspend time,
> >  > > but it probably won't fix the hang.
> 
> It says "calling pci_set_power_state with 3". Then after all then it
> still hangs, and then resume with Mr Green.
> 
> PM: Syncing filesystems ... done.
> Freezing user space processes ... (elapsed 0.00 seconds) done.
> Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
> PM: Shrinking memory...  ^H-^Hdone (0 pages freed)
> PM: Freed 0 kbytes in 0.20 seconds (0.00 MB/s)
> ACPI: Preparing to enter system sleep state S4
> Suspending console(s)
> sd 0:0:0:0: [sda] Synchronizing SCSI cache
> drm_sysfs_suspend
> ACPI: PCI interrupt for device 0000:00:02.0 disabled
> calling pci_set_power_state with 3

So it returns the right value.

Jeff, Jesse, please check one thing for me.

Please boot 2.6.25-rc2 (or better, the current head of the Linus' tree) with
no_console_suspend and try to do the following:

# echo 8 > /proc/sys/kernel/printk
# echo core > /sys/power/pm_test
# echo disk > /sys/power/state

(that will run a test of the freeze/unfreeze code without creating the image)
and then

# echo mem > /sys/power/state

(that will run a test of the suspend/resume code without actually suspending).

I'd like to know if that works.

Thanks,
Rafael
