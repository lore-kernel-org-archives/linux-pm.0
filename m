From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [RFC PATCH V2 3/8] genirq: Add runtime power management support
 for IRQ chips
Date: Tue, 12 Jan 2016 13:43:11 -0800
Message-ID: <20160112214311.GA6491@xsjsorenbubuntu>
References: <1450349309-8107-1-git-send-email-jonathanh@nvidia.com>
 <1450349309-8107-4-git-send-email-jonathanh@nvidia.com>
 <569548AA.8090903@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <569548AA.8090903@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Jon Hunter <jonathanh@nvidia.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Jiang Liu <jiang.liu@linux.intel.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2016-01-12 at 08:40PM +0200, Grygorii Strashko wrote:
> Hi Jon,
>=20
> On 12/17/2015 12:48 PM, Jon Hunter wrote:
> > Some IRQ chips may be located in a power domain outside of the CPU
> > subsystem and hence will require device specific runtime power mana=
gement.
> > In order to support such IRQ chips, add a pointer for a device stru=
cture
> > to the irq_chip structure, and if this pointer is populated by the =
IRQ
> > chip driver and the flag CHIP_HAS_RPM is set, then the pm_runtime_g=
et/put
> > APIs for this chip will be called when an IRQ is requested/freed,
> > respectively.
> >=20
> > Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>=20
> I've tried to test these patches with OMAP GPIO and I see it works, i=
n general.
> "In general" - because OMAP GPIO has some code which is expected to b=
e used
> very late during suspend or when entering deep CPUIdle states, so I c=
an't use
> this approach "out-of-the-box" until i find the way to sort it out.
>=20
> Hope some one else can try to test it with GPIO. Soren?

I try to find the person who had the failing test that triggered my
involvement. That would basically just cover the case that the GPIO
controller is used as IRQ controller and needs to be enabled even if no
GPIO has been requested.
Suspend/resume may be more difficult. We have some out-of-tree code for
that. But unfortunately not 100% stable. I'll check what happens and
report back.

	Thanks,
	S=C3=B6ren
