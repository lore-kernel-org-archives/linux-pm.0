From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.30 enabling cpu1 on resume fails after suspend
	to memory
Date: Sun, 14 Jun 2009 14:09:21 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0906141405450.2800__7824.52216740257$1244981421$gmane$org@localhost.localdomain>
References: <20090614120950.116536fa@pluto-lenny.milky.way>
	<200906141319.40536.rjw@sisk.pl>
	<20090614134851.637daf37@pluto-lenny.milky.way>
	<200906141400.27331.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200906141400.27331.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: js@sig21.net, Matthew Wilcox <matthew@wil.cx>, Linux PCI <linux-pci@vger.kernel.org>, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, "Benjamin S." <sbenni@gmx.de>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 14 Jun 2009, Rafael J. Wysocki wrote:
> Evidently, the change of the interrupt handling during suspend-resume,
> commit 2ed8d2b3a81bdbb0418301628ccdb008ac9f40b7 (PM: Rework handling of
> interrupts during suspend-resume) broke resume (specifically, the enabling of
> nonboot CPUs) on the Benjamin's machine, but only if MSI support is enabled.
> Also, resume works if suspend_device_irqs() and resume_device_irqs() in
> drivers/base/power/main.c are commented out.
> 
> Is there anything the MSI code does in __enable_irq() and/or __disable_irq()
> that might cause this problem to appear?

Not that I'm aware of. Which of the devices is using MSI ? Have to
tried to skip only the MSI ones in suspend/resume_device_irqs() ?

Thanks,

	tglx
