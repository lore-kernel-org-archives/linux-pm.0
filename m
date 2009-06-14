From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.30 enabling cpu1 on resume fails after suspend
	to memory
Date: Sun, 14 Jun 2009 14:00:25 +0200
Message-ID: <200906141400.27331.rjw__40608.5251867355$1244980875$gmane$org@sisk.pl>
References: <20090614120950.116536fa@pluto-lenny.milky.way>
	<200906141319.40536.rjw@sisk.pl>
	<20090614134851.637daf37@pluto-lenny.milky.way>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090614134851.637daf37@pluto-lenny.milky.way>
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
To: "Benjamin S." <sbenni@gmx.de>, Ingo Molnar <mingo@elte.hu>
Cc: js@sig21.net, Matthew Wilcox <matthew@wil.cx>, Linux PCI <linux-pci@vger.kernel.org>, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Thomas Gleixner <tglx@linutronix.de>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sunday 14 June 2009, Benjamin S. wrote:
> On Sun, 14 Jun 2009 13:19:40 +0200
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > On Sunday 14 June 2009, Benjamin S. wrote:
> > > 
> > > On Sun, 14 Jun 2009 12:35:24 +0200
> > > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > > 
> > > > Thanks for the report, the problem seems to be related to the chipset, because
> > > > I'm unable to reproduce it with SB600 and a fairly new AMD CPU.
> > > > 
> > > > Does the resume work if you comment out suspend_device_irqs() and
> > > > resume_device_irqs() in drivers/base/power/main.c ?
> > > 
> > > Yes, 2.6.30 without the two lines resumes without problems.\
> > 
> > Does it help (with the two lines present again) if the kernel is compiled with
> > CONFIG_PCI_MSI unset?
> 
> Yes, it works.

OK, we need some help.

Ingo,

Evidently, the change of the interrupt handling during suspend-resume,
commit 2ed8d2b3a81bdbb0418301628ccdb008ac9f40b7 (PM: Rework handling of
interrupts during suspend-resume) broke resume (specifically, the enabling of
nonboot CPUs) on the Benjamin's machine, but only if MSI support is enabled.
Also, resume works if suspend_device_irqs() and resume_device_irqs() in
drivers/base/power/main.c are commented out.

Is there anything the MSI code does in __enable_irq() and/or __disable_irq()
that might cause this problem to appear?

Best,
Rafael
