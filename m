From: Thomas Renninger <trenn@suse.de>
Subject: Re: [linux-pm] [PATCH] acpi: intel_idle : break dependency between modules
Date: Thu, 28 Jun 2012 09:34:47 +0200
Message-ID: <201206280934.48147.trenn@suse.de>
References: <201206261301.25550.trenn@suse.de> <1340788068-16422-1-git-send-email-daniel.lezcano@linaro.org> <4FEB31E1.2030209@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <4FEB31E1.2030209@linux.vnet.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linaro-dev@lists.linaro.org, linux-pm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, June 27, 2012 06:16:33 PM Srivatsa S. Bhat wrote:
> On 06/27/2012 02:37 PM, Daniel Lezcano wrote:
> > When the system is booted with some cpus offline, the idle
> > driver is not initialized. When a cpu is set online, the
> > acpi code call the intel idle init function. Unfortunately
> > this code introduce a dependency between intel_idle and acpi.
> > 
> > This patch is intended to remove this dependency by using the
> > notifier of intel_idle. In order to make it work, the notifier
> > must be initialized in the right order, acpi then intel_idle.
> > This is done in the Makefile.
> 
> There is a much better way of doing this. See below.
> 
> > This patch has the benefit of
> > encapsulating the intel_idle driver and remove some exported
> > functions.
> > 
> 
> Nice :)
> 
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > ---
> >  drivers/Makefile                |    3 ++-
> >  drivers/acpi/processor_driver.c |    7 -------
> >  drivers/idle/intel_idle.c       |   22 ++++++++++++++--------
> >  include/linux/cpuidle.h         |    7 -------
> >  4 files changed, 16 insertions(+), 23 deletions(-)
> > 
> > diff --git a/drivers/Makefile b/drivers/Makefile
> > index 2ba29ff..a2454b8 100644
> > --- a/drivers/Makefile
> > +++ b/drivers/Makefile
> > @@ -12,8 +12,9 @@ obj-$(CONFIG_PCI)		+= pci/
> >  obj-$(CONFIG_PARISC)		+= parisc/
> >  obj-$(CONFIG_RAPIDIO)		+= rapidio/
> >  obj-y				+= video/
> > -obj-y				+= idle/
> > +# acpi must come before idle for initialization
> >  obj-$(CONFIG_ACPI)		+= acpi/
> > +obj-y				+= idle/
> >  obj-$(CONFIG_SFI)		+= sfi/
> >  # PnP must come after ACPI since it will eventually need to check if acpi
> >  # was used and do nothing if so
> 
> OK, so all you are trying to do here is ensure that the intel idle related
> notifier runs _after_ the acpi related one.
I might oversee something, if you have concerns, please point me to it.
If it's all about keeping the order of excuting these functions:
   acpi_processor_start(pr)
and
   intel_idle_cpu_init()
There should be no need for it. Intel idle is pretty separated.

  Thomas
