From: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH] Revert "arm64: dts: marvell: add CPU Idle power state
 support on Armada 7K/8K"
Date: Wed, 5 Dec 2018 10:40:36 +0200
Message-ID: <20181205084036.wjqqqruapxqa4hvg@sapphire.tkos.co.il>
References: <3ece60154be74bd6534387db8da578194f823b43.1543938362.git.baruch@tkos.co.il>
 <87o9a1w9dm.fsf@bootlin.com>
 <20181204164843.edwszhv375yyhppb@sapphire.tkos.co.il>
 <20181205065750.kv554kuygbi63pju@sapphire.tkos.co.il>
 <87k1kowf7i.fsf@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <87k1kowf7i.fsf@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Sergey Matyukevich <geomatsi@gmail.com>, linux-pm@vger.kernel.org, orenbh <orenbh@marvell.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi Gregory,

On Wed, Dec 05, 2018 at 09:27:45AM +0100, Gregory CLEMENT wrote:
>  On mer., d=E9c. 05 2018, Baruch Siach <baruch@tkos.co.il> wrote:
> > On Tue, Dec 04, 2018 at 06:48:43PM +0200, Baruch Siach wrote:
> >> On Tue, Dec 04, 2018 at 05:21:25PM +0100, Gregory CLEMENT wrote:
> >> >  On mar., d=E9c. 04 2018, Baruch Siach <baruch@tkos.co.il> wrote:
> >> > > This reverts commit 8ed46368776b3bc93d74c1f8f2bfb9fd8a9ad805.
> >> > >
> >> > > This commit breaks boot on Armada 8K based systems. Reverting it m=
akes
> >> > > affected systems boot again.
> >> > >
> >> > > Reported-by: Sergey Matyukevich <geomatsi@gmail.com>
> >> > > Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> >> > =

> >> > I would like to know more about it because on the McBin I use there =
is
> >> > no issue with 4.20-rc1.
> >> > =

> >> > Do you observe this issue with the arm64 defconfig or do you have so=
me
> >> > specific configuration option?
> >> =

> >> I tested the attached defconfig on Clearfog GT-8K and on another custo=
m Armada =

> >> 8K based board.
> >> =

> >> Tomorrow I'll test Macchiatobin with this config and the arm64 defconf=
ig.
> >
> > I reproduced same issue on a Macchiatobin board with both this config a=
nd the =

> > arm64 defconfig. The latter produced this splat:
> =

> OK thanks, for this, I also got the confirmation by my colleagues. The
> only difference I can think of, is the firmware, but the surprising
> thing, is that I have an old firmware: 17.06.2 and that with a recent
> one, it doesn't work.

This is right. I'm running the latest Marvell ATF release 18.09.4 (based on =

upstream version 1.5).

> So I will apply it in mvebu/fixes.

Thanks,
baruch

> > [   22.868568] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > [   22.874694] rcu: 	0-...!: (1 GPs behind) idle=3D408/0/0x0 softirq=3D=
251/251 fqs=3D0
> > [   22.881950] rcu: 	2-...!: (0 ticks this GP) idle=3D7b4/0/0x0 softirq=
=3D168/168 fqs=3D0
> > [   22.889465] rcu: 	(detected by 1, t=3D5252 jiffies, g=3D-967, q=3D29=
4)
> > [   22.895498] Task dump for CPU 0:
> > [   22.898739] swapper/0       R  running task        0     0      0 0x=
00000028
> > [   22.905819] Call trace:
> > [   22.908285]  __switch_to+0x94/0xd0
> > [   22.911702]  arm_cpuidle_suspend+0x30/0x38
> > [   22.915818]  arm_enter_idle_state+0x38/0x68
> > [   22.920019]  cpuidle_enter_state+0x1d0/0x240
> > [   22.924306]  cpuidle_enter+0x18/0x20
> > [   22.927898]  call_cpuidle+0x1c/0x38
> > [   22.931400]  do_idle+0x254/0x280
> > [   22.934641]  cpu_startup_entry+0x24/0x28
> > [   22.938581]  rest_init+0xd4/0xe0
> > [   22.941824]  arch_call_rest_init+0xc/0x14
> > [   22.945849]  start_kernel+0x3d8/0x400
> > [   22.949524] Task dump for CPU 2:
> > [   22.952764] swapper/2       R  running task        0     0      1 0x=
0000002a
> > [   22.959843] Call trace:
> > [   22.962299]  __switch_to+0x94/0xd0
> > [   22.965715]  arm_cpuidle_suspend+0x30/0x38
> > [   22.969828]  arm_enter_idle_state+0x38/0x68
> > [   22.974028]  cpuidle_enter_state+0x1d0/0x240
> > [   22.978315]  cpuidle_enter+0x18/0x20
> > [   22.981905]  call_cpuidle+0x1c/0x38
> > [   22.985408]  do_idle+0x254/0x280
> > [   22.988648]  cpu_startup_entry+0x20/0x28
> > [   22.992590]  secondary_start_kernel+0x15c/0x170
> > [   22.997141] rcu: rcu_preempt kthread starved for 5252 jiffies! g-967=
 f0x0 RCU_GP_WAIT_FQS(5) ->state=3D0x402 ->cpu=3D2
> > [   23.007534] rcu: RCU grace-period kthread stack dump:
> > [   23.012606] rcu_preempt     I    0    10      2 0x00000028
> > [   23.018116] Call trace:
> > [   23.020572]  __switch_to+0x94/0xd0
> > [   23.023987]  __schedule+0x1e0/0x5c0
> > [   23.027488]  schedule+0x38/0xa0
> > [   23.030643]  schedule_timeout+0x198/0x338
> > [   23.034670]  rcu_gp_kthread+0x43c/0x7b0
> > [   23.038524]  kthread+0x124/0x128
> > [   23.041766]  ret_from_fork+0x10/0x18
> >
> > baruch
> >
> >> > > ---
> >> > >  .../boot/dts/marvell/armada-ap806-quad.dtsi   |  4 ---
> >> > >  arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 27 --------------=
-----
> >> > >  2 files changed, 31 deletions(-)
> >> > >
> >> > > diff --git a/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi b/=
arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi
> >> > > index 64632c873888..01ea662afba8 100644
> >> > > --- a/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi
> >> > > +++ b/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi
> >> > > @@ -20,28 +20,24 @@
> >> > >  			compatible =3D "arm,cortex-a72", "arm,armv8";
> >> > >  			reg =3D <0x000>;
> >> > >  			enable-method =3D "psci";
> >> > > -			cpu-idle-states =3D <&CPU_SLEEP_0>;
> >> > >  		};
> >> > >  		cpu1: cpu@1 {
> >> > >  			device_type =3D "cpu";
> >> > >  			compatible =3D "arm,cortex-a72", "arm,armv8";
> >> > >  			reg =3D <0x001>;
> >> > >  			enable-method =3D "psci";
> >> > > -			cpu-idle-states =3D <&CPU_SLEEP_0>;
> >> > >  		};
> >> > >  		cpu2: cpu@100 {
> >> > >  			device_type =3D "cpu";
> >> > >  			compatible =3D "arm,cortex-a72", "arm,armv8";
> >> > >  			reg =3D <0x100>;
> >> > >  			enable-method =3D "psci";
> >> > > -			cpu-idle-states =3D <&CPU_SLEEP_0>;
> >> > >  		};
> >> > >  		cpu3: cpu@101 {
> >> > >  			device_type =3D "cpu";
> >> > >  			compatible =3D "arm,cortex-a72", "arm,armv8";
> >> > >  			reg =3D <0x101>;
> >> > >  			enable-method =3D "psci";
> >> > > -			cpu-idle-states =3D <&CPU_SLEEP_0>;
> >> > >  		};
> >> > >  	};
> >> > >  };
> >> > > diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/=
arm64/boot/dts/marvell/armada-ap806.dtsi
> >> > > index 073610ac0a53..7d94c1fa592a 100644
> >> > > --- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> >> > > +++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> >> > > @@ -28,33 +28,6 @@
> >> > >  		method =3D "smc";
> >> > >  	};
> >> > >  =

> >> > > -	cpus {
> >> > > -		#address-cells =3D <1>;
> >> > > -		#size-cells =3D <0>;
> >> > > -
> >> > > -		idle_states {
> >> > > -			entry_method =3D "arm,pcsi";
> >> > > -
> >> > > -			CPU_SLEEP_0: cpu-sleep-0 {
> >> > > -				compatible =3D "arm,idle-state";
> >> > > -				local-timer-stop;
> >> > > -				arm,psci-suspend-param =3D <0x0010000>;
> >> > > -				entry-latency-us =3D <80>;
> >> > > -				exit-latency-us  =3D <160>;
> >> > > -				min-residency-us =3D <320>;
> >> > > -			};
> >> > > -
> >> > > -			CLUSTER_SLEEP_0: cluster-sleep-0 {
> >> > > -				compatible =3D "arm,idle-state";
> >> > > -				local-timer-stop;
> >> > > -				arm,psci-suspend-param =3D <0x1010000>;
> >> > > -				entry-latency-us =3D <500>;
> >> > > -				exit-latency-us =3D <1000>;
> >> > > -				min-residency-us =3D <2500>;
> >> > > -			};
> >> > > -		};
> >> > > -	};
> >> > > -
> >> > >  	ap806 {
> >> > >  		#address-cells =3D <2>;
> >> > >  		#size-cells =3D <2>;

-- =

     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=3D}------------------------------------------------ooO--U--Ooo------------=
{=3D
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
