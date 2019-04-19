From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v7 00/10] Add support for XO 1.75 to OLPC battery driver
Date: Fri, 19 Apr 2019 09:57:16 +0200
Message-ID: <20190419075716.GB6795@gmail.com>
References: <20190418144655.18758-1-lkundrak@v3.sk>
 <20190418202000.hcojhcf2f47te44u@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190418202000.hcojhcf2f47te44u@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Lubomir Rintel <lkundrak@v3.sk>, Darren Hart <dvhart@infradead.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, x86@kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>
List-Id: linux-pm@vger.kernel.org


* Sebastian Reichel <sre@kernel.org> wrote:

> Hi,
> 
> On Thu, Apr 18, 2019 at 04:46:45PM +0200, Lubomir Rintel wrote:
> > This patch set modifies the OLPC battery driver so that it could eventually
> > be used on an Arm-based OLPC XO 1.75 machine.
> > 
> > Compared to the previous version, it addresses review comments for the
> > x86 platform parts from Thomas Gleixner. Details in individual patches'
> > change logs.
> > 
> > I've failed to version the previous iteration of the set that should've
> > been "v6" for the change logs to make sense. Sorry for that.
> > 
> > Thank you,
> > Lubo
> 
> I queued up the complete patchset via an immutable branch based on
> v5.1-rc1. X86 maintainers can pull this signed immutable branch as
> required. Thanks for the patches,

Would you mind sending these patches to Linus yourself, as part of the 
power-supply tree?

That's where it really belongs, the impact on arch/x86/ was mostly 
drive-by (and it's now all Acked-by Thomas), the meat of the changes is 
in the OLPC battery driver.

Thanks,

	Ingo
