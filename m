From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [RFC PATCH] ata: ahci: Enable DEVSLP by default on x86 modern
 standby platform
Date: Mon, 02 Jul 2018 15:08:43 -0700
Message-ID: <ca753f719e123d8e3c2306b8d55f3d4a656cbd2f.camel@linux.intel.com>
References: <20180702190845.7456-1-srinivas.pandruvada@linux.intel.com>
         <20180702202151.GK533219@devbig577.frc2.facebook.com>
         <5493bfdb-14a9-a55d-f96e-b9c8a29f1d63@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5493bfdb-14a9-a55d-f96e-b9c8a29f1d63@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Tejun Heo <tj@kernel.org>
Cc: rjw@rjwysocki.net, alan.cox@intel.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Mario.Limonciello@dell.com
List-Id: linux-pm@vger.kernel.org

Hi Hans,

On Mon, 2018-07-02 at 23:27 +0200, Hans de Goede wrote:
> Hi,
> 
> On 02-07-18 22:21, Tejun Heo wrote:
> > On Mon, Jul 02, 2018 at 12:08:45PM -0700, Srinivas Pandruvada
> > wrote:
> > > From: Srinivas <srinivas.pandruvada@linux.intel.com>
> > > 
> > > One of the requirement for modern x86 system to enter lowest
> > > power mode
> > > (SLP_S0) is SATA IP block to be off. This is true even during
> > > when
> > > platform is suspended to idle and not only in opportunistic
> > > (runtime)
> > > suspend.
> > > 
> > > Several of these system don't have traditional ACPI S3, so it is
> > > important that they enter SLP_S0 state, to avoid draining battery
> > > even
> > > during suspend even with out of the box Linux installation.
> 
> Question can systems which do have S3 not also enter SLP_S0 state
> during
> normal operation to save power?
S3 systems don't enter SLP_S0. When in suspend via S3 all devices are
simply turn off all except some for wakeup.

> 
> I guess the change of that happening without being in a suspend like
> state
> (screen turned off, etc), is very small because there will always be
> something blocking entering of SLP_S0, so that it is not worth
> bothering looking into SLP_S0 on systems which use S3 for suspend ?
> 
SLP_S0 is suspend like state without big exit latency. To achieve this
state the IP blocks, clocks and voltage rails needs to be in certain
predefined state. If anyone of those constraints not met, the system
will not reach this state. Unlike S3, we need to make sure that devices
reach right suspend state. In S3 we wouldn't have cared much, as
BIOS/ACPI will take action and turn off anyway.
If you achieve SLP_S0, the power will be lower or equal to S3 but will
be immediately able to resume.


> > > SATA IP block doesn't get turned off till SATA is in DEVSLP mode.
> > > Here
> > > user has to either use scsi-host sysfs or tools like powertop to
> > > set
> > > the sata-host link_power_management_policy to min_power.
> > > 
> > > This change sets by default link power management policy to
> > > min_power
> > > for some platforms.  To avoid regressions, the following
> > > conditions
> > > are used:
> > > - The kernel config is already set to use med_power_with_dipm or
> > > deeper
> > > - System is a modern standby system using ACPI low power idle
> > > flag
> > > - The platform is not blacklisted for Suspend to Idle and suspend
> > > to idle is used instead of S3
> > > This combination will make sure that systems are fairly recent
> > > and
> > > since getting shipped with modern standby standby, the DEVSLP
> > > function
> > > is already validated.
> > > 
> > > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.int
> > > el.com>
> > 
> > Seems sane to me.  Hans, what do you think?
> 
> I think this is going in the right direction, but min_power enables
> both DEVSLP and HIPM, AFAIK Windows at least in the past did not
> enable HIPM be default.

Windows and Linux will need to meet the same criteria to reach SLP_S0
state. OS is not deciding whether we meet criteria or not, it is
firmware deciding, and it will look for SATA IP to be in certain
predefined state, before generating this SLP_S0 signal.


> Srinivas can you figure out what Windows does wrt HIPM?

We can see that under Windows the SATA rail voltage is dropped. I don't
know if there is any other method other than DEVSLP configuration. But
I will surely check around.


> We may need a new med_power_with_dipm_and_devslp level if windows
> does
> not enable HIPM by default on these systems. In hind sight we really
> should have separate bools for each, rather then coding this in
> a single level, ah well.
Agree. We can certainly do this for even safer implementation.

Thanks,
Srinivas

> 
> Regards,
> 
> Hans
