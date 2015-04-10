From: Michael Turquette <mturquette@linaro.org>
Subject: Re: [PATCH v8 00/18] Tegra124 CL-DVFS / DFLL clocksource + cpufreq
Date: Fri, 10 Apr 2015 14:11:57 -0700
Message-ID: <20150410211157.14369.51754@quantum>
References: <1425213881-5262-1-git-send-email-mikko.perttunen@kapsi.fi>
 <20150311100741.GK19577@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150311100741.GK19577@ulmo.nvidia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: gnurou@gmail.com, pgaikwad@nvidia.com, vinceh@nvidia.com, swarren@wwwdotorg.org, viresh.kumar@linaro.org, pdeschrijver@nvidia.com, linux-pm@vger.kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, Mikko Perttunen <mikko.perttunen@kapsi.fi>, pwalmsley@nvidia.com, linux-tegra@vger.kernel.org, tuomas.tynkkynen@iki.fi, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Quoting Thierry Reding (2015-03-11 03:07:43)
> Hi Mike,
> 
> Have you had a chance to look at these changes to the Tegra clock
> driver? If you're fine with it, I'd like to take these patches through
> the Tegra tree because the rest of the series depends on them. I can
> provide a stable branch in case we need to base other Tegra clock
> changes on top of this.

Hi Thierry,

Clock patches (and corresponding DT binding descriptions and changes to
DTS) look fine to me. Please add:

Acked-by: Michael Turquette <mturquette@linaro.org>

I did have a question about the beahvior of clk_put in one of Mikko's
patches but it should not gate this series. I'm just trying to find out
if we have a bug in the framework or if the Tegra driver is a special
case.

Also I do not think a stable branch is necessary.

Regards,
Mike

> 
> Thierry
> 
> On Sun, Mar 01, 2015 at 02:44:23PM +0200, Mikko Perttunen wrote:
> > Hi, this is v8 of the Tegra124 cpufreq series. Aside rebasing on latest -next,
> > the following changes have been done:
> > 
> > clk: tegra: Add binding for the Tegra124 DFLL clocksource
> > - Changed dfll@ -> clock@
> > - Changed compatibility string to "nvidia,tegra124-dfll"
> > - Clarified how the vdd-cpu-supply property is used
> > - Marked nvidia,cg-scale as optional since it is a boolean property
> > - Expanded the 'FS mode' term to 'full speed mode'
> > - Added dvco reset control
> > 
> > ARM: tegra: Add the DFLL to Tegra124 device tree
> > - Changed dfll@ -> clock@
> > - Added dvco reset control
> > 
> > ARM: tegra: Enable the DFLL on the Jetson TK1
> > - Changed dfll@ -> clock@
> > 
> > clk: tegra: Initialize PLL_X before CCLK_G to ensure it has a parent
> > - Added
> > 
> > clk: tegra: Introduce ability for SoC-specific reset control callbacks
> > - Added
> > 
> > clk: tegra: Add DFLL DVCO reset control for Tegra124
> > - Changed to use SoC-specific reset control callback
> > 
> > clk: tegra: Add Tegra124 DFLL clocksource platform driver
> > - Don't set DVCO reset handlers
> > 
> > clk: tegra: Add library for the DFLL clock source (open-loop mode)
> > - Use reset control instead of function pointers
> > 
> > also added acks from v7.
> > 
> > The series is available in a git repository at
> >   git://github.com/cyndis/linux.git cldvfs-v8
> > 
> > Tested by me on Jetson-TK1 (rev. D).
> > 
> > Original cover letter:
> > 
> > This series implements the DFLL/CL-DVFS clock source for the fast CPU
> > cluster on Tegra124, and a cpufreq driver that uses the DFLL for
> > clocking the CPU. Most of this is based on Paul Walmsley's public patch
> > set from December 2013, which is available at
> > http://comments.gmane.org/gmane.linux.ports.tegra/15273
> > 
> > The DFLL clock hardware is a voltage-controlled oscillator plus
> > control logic that compares the generated output clock with a
> > 51 MHz reference clock, and can make decisions to either lower
> > or raise the DFLL voltage to keep the output rate close to the
> > software-requested rate. The voltage changes are done by
> > communicating with an off-chip PMIC via either I2C or PWM.
> > As the DFLL oscillator is powered via the CPU rail, using
> > the DFLL as the CPU clocksource also gives us dynamic CPU
> > voltage scaling.
> > 
> > This series has been tested on the Jetson TK1 (Rev C). Porting this to
> > the Venice2 should be simple, though do note that it does not have
> > active cooling.
> > 
> > Thanks,
> > Tuomas
> > 
> > Mikko Perttunen (3):
> >   clk: tegra: Introduce ability for SoC-specific reset control callbacks
> >   clk: tegra: Initialize PLL_X before CCLK_G to ensure it has a parent
> >   ARM: tegra: Add CPU regulator to the Jetson TK1 device tree
> > 
> > Paul Walmsley (1):
> >   clk: tegra: Add DFLL DVCO reset control for Tegra124
> > 
> > Tuomas Tynkkynen (14):
> >   clk: tegra: Add binding for the Tegra124 DFLL clocksource
> >   clk: tegra: Add library for the DFLL clock source (open-loop mode)
> >   clk: tegra: Add closed loop support for the DFLL
> >   clk: tegra: Add functions for parsing CVB tables
> >   clk: tegra: Add Tegra124 DFLL clocksource platform driver
> >   clk: tegra: Save/restore CCLKG_BURST_POLICY on suspend
> >   clk: tegra: Add the DFLL as a possible parent of the cclk_g clock
> >   ARM: tegra: Add the DFLL to Tegra124 device tree
> >   ARM: tegra: Enable the DFLL on the Jetson TK1
> >   cpufreq: tegra124: Add device tree bindings
> >   cpufreq: tegra: Rename tegra-cpufreq to tegra20-cpufreq
> >   cpufreq: Add cpufreq driver for Tegra124
> >   ARM: tegra: Add entries for cpufreq on Tegra124
> >   ARM: tegra: enable Tegra124 cpufreq driver by default
> > 
> >  .../bindings/clock/nvidia,tegra124-dfll.txt        |   79 +
> >  .../bindings/cpufreq/tegra124-cpufreq.txt          |   44 +
> >  arch/arm/boot/dts/tegra124-jetson-tk1.dts          |   15 +-
> >  arch/arm/boot/dts/tegra124.dtsi                    |   34 +
> >  arch/arm/configs/tegra_defconfig                   |    1 +
> >  arch/arm/mach-tegra/Kconfig                        |    1 +
> >  drivers/clk/tegra/Makefile                         |    3 +
> >  drivers/clk/tegra/clk-dfll.c                       | 1755 ++++++++++++++++++++
> >  drivers/clk/tegra/clk-dfll.h                       |   54 +
> >  drivers/clk/tegra/clk-tegra-super-gen4.c           |   50 +-
> >  drivers/clk/tegra/clk-tegra124-dfll-fcpu.c         |  163 ++
> >  drivers/clk/tegra/clk-tegra124.c                   |   82 +
> >  drivers/clk/tegra/clk.c                            |   36 +-
> >  drivers/clk/tegra/clk.h                            |    3 +
> >  drivers/clk/tegra/cvb.c                            |  133 ++
> >  drivers/clk/tegra/cvb.h                            |   67 +
> >  drivers/cpufreq/Kconfig.arm                        |   13 +-
> >  drivers/cpufreq/Makefile                           |    3 +-
> >  drivers/cpufreq/tegra124-cpufreq.c                 |  217 +++
> >  .../cpufreq/{tegra-cpufreq.c => tegra20-cpufreq.c} |    0
> >  include/dt-bindings/reset/tegra124-car.h           |   11 +
> >  21 files changed, 2730 insertions(+), 34 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
> >  create mode 100644 Documentation/devicetree/bindings/cpufreq/tegra124-cpufreq.txt
> >  create mode 100644 drivers/clk/tegra/clk-dfll.c
> >  create mode 100644 drivers/clk/tegra/clk-dfll.h
> >  create mode 100644 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
> >  create mode 100644 drivers/clk/tegra/cvb.c
> >  create mode 100644 drivers/clk/tegra/cvb.h
> >  create mode 100644 drivers/cpufreq/tegra124-cpufreq.c
> >  rename drivers/cpufreq/{tegra-cpufreq.c => tegra20-cpufreq.c} (100%)
> >  create mode 100644 include/dt-bindings/reset/tegra124-car.h
> > 
> > --
> > 2.3.0
> > 
