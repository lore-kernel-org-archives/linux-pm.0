From: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH] Revert "arm64: dts: marvell: add CPU Idle power state
 support on Armada 7K/8K"
Date: Wed, 5 Dec 2018 08:57:50 +0200
Message-ID: <20181205065750.kv554kuygbi63pju@sapphire.tkos.co.il>
References: <3ece60154be74bd6534387db8da578194f823b43.1543938362.git.baruch@tkos.co.il>
 <87o9a1w9dm.fsf@bootlin.com>
 <20181204164843.edwszhv375yyhppb@sapphire.tkos.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20181204164843.edwszhv375yyhppb@sapphire.tkos.co.il>
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

On Tue, Dec 04, 2018 at 06:48:43PM +0200, Baruch Siach wrote:
> On Tue, Dec 04, 2018 at 05:21:25PM +0100, Gregory CLEMENT wrote:
> >  On mar., d=E9c. 04 2018, Baruch Siach <baruch@tkos.co.il> wrote:
> > > This reverts commit 8ed46368776b3bc93d74c1f8f2bfb9fd8a9ad805.
> > >
> > > This commit breaks boot on Armada 8K based systems. Reverting it makes
> > > affected systems boot again.
> > >
> > > Reported-by: Sergey Matyukevich <geomatsi@gmail.com>
> > > Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> > =

> > I would like to know more about it because on the McBin I use there is
> > no issue with 4.20-rc1.
> > =

> > Do you observe this issue with the arm64 defconfig or do you have some
> > specific configuration option?
> =

> I tested the attached defconfig on Clearfog GT-8K and on another custom A=
rmada =

> 8K based board.
> =

> Tomorrow I'll test Macchiatobin with this config and the arm64 defconfig.

I reproduced same issue on a Macchiatobin board with both this config and t=
he =

arm64 defconfig. The latter produced this splat:

[   22.868568] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[   22.874694] rcu: 	0-...!: (1 GPs behind) idle=3D408/0/0x0 softirq=3D251/=
251 fqs=3D0
[   22.881950] rcu: 	2-...!: (0 ticks this GP) idle=3D7b4/0/0x0 softirq=3D1=
68/168 fqs=3D0
[   22.889465] rcu: 	(detected by 1, t=3D5252 jiffies, g=3D-967, q=3D294)
[   22.895498] Task dump for CPU 0:
[   22.898739] swapper/0       R  running task        0     0      0 0x0000=
0028
[   22.905819] Call trace:
[   22.908285]  __switch_to+0x94/0xd0
[   22.911702]  arm_cpuidle_suspend+0x30/0x38
[   22.915818]  arm_enter_idle_state+0x38/0x68
[   22.920019]  cpuidle_enter_state+0x1d0/0x240
[   22.924306]  cpuidle_enter+0x18/0x20
[   22.927898]  call_cpuidle+0x1c/0x38
[   22.931400]  do_idle+0x254/0x280
[   22.934641]  cpu_startup_entry+0x24/0x28
[   22.938581]  rest_init+0xd4/0xe0
[   22.941824]  arch_call_rest_init+0xc/0x14
[   22.945849]  start_kernel+0x3d8/0x400
[   22.949524] Task dump for CPU 2:
[   22.952764] swapper/2       R  running task        0     0      1 0x0000=
002a
[   22.959843] Call trace:
[   22.962299]  __switch_to+0x94/0xd0
[   22.965715]  arm_cpuidle_suspend+0x30/0x38
[   22.969828]  arm_enter_idle_state+0x38/0x68
[   22.974028]  cpuidle_enter_state+0x1d0/0x240
[   22.978315]  cpuidle_enter+0x18/0x20
[   22.981905]  call_cpuidle+0x1c/0x38
[   22.985408]  do_idle+0x254/0x280
[   22.988648]  cpu_startup_entry+0x20/0x28
[   22.992590]  secondary_start_kernel+0x15c/0x170
[   22.997141] rcu: rcu_preempt kthread starved for 5252 jiffies! g-967 f0x=
0 RCU_GP_WAIT_FQS(5) ->state=3D0x402 ->cpu=3D2
[   23.007534] rcu: RCU grace-period kthread stack dump:
[   23.012606] rcu_preempt     I    0    10      2 0x00000028
[   23.018116] Call trace:
[   23.020572]  __switch_to+0x94/0xd0
[   23.023987]  __schedule+0x1e0/0x5c0
[   23.027488]  schedule+0x38/0xa0
[   23.030643]  schedule_timeout+0x198/0x338
[   23.034670]  rcu_gp_kthread+0x43c/0x7b0
[   23.038524]  kthread+0x124/0x128
[   23.041766]  ret_from_fork+0x10/0x18

baruch

> > > ---
> > >  .../boot/dts/marvell/armada-ap806-quad.dtsi   |  4 ---
> > >  arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 27 -----------------=
--
> > >  2 files changed, 31 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi b/arc=
h/arm64/boot/dts/marvell/armada-ap806-quad.dtsi
> > > index 64632c873888..01ea662afba8 100644
> > > --- a/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi
> > > +++ b/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi
> > > @@ -20,28 +20,24 @@
> > >  			compatible =3D "arm,cortex-a72", "arm,armv8";
> > >  			reg =3D <0x000>;
> > >  			enable-method =3D "psci";
> > > -			cpu-idle-states =3D <&CPU_SLEEP_0>;
> > >  		};
> > >  		cpu1: cpu@1 {
> > >  			device_type =3D "cpu";
> > >  			compatible =3D "arm,cortex-a72", "arm,armv8";
> > >  			reg =3D <0x001>;
> > >  			enable-method =3D "psci";
> > > -			cpu-idle-states =3D <&CPU_SLEEP_0>;
> > >  		};
> > >  		cpu2: cpu@100 {
> > >  			device_type =3D "cpu";
> > >  			compatible =3D "arm,cortex-a72", "arm,armv8";
> > >  			reg =3D <0x100>;
> > >  			enable-method =3D "psci";
> > > -			cpu-idle-states =3D <&CPU_SLEEP_0>;
> > >  		};
> > >  		cpu3: cpu@101 {
> > >  			device_type =3D "cpu";
> > >  			compatible =3D "arm,cortex-a72", "arm,armv8";
> > >  			reg =3D <0x101>;
> > >  			enable-method =3D "psci";
> > > -			cpu-idle-states =3D <&CPU_SLEEP_0>;
> > >  		};
> > >  	};
> > >  };
> > > diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm=
64/boot/dts/marvell/armada-ap806.dtsi
> > > index 073610ac0a53..7d94c1fa592a 100644
> > > --- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> > > +++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> > > @@ -28,33 +28,6 @@
> > >  		method =3D "smc";
> > >  	};
> > >  =

> > > -	cpus {
> > > -		#address-cells =3D <1>;
> > > -		#size-cells =3D <0>;
> > > -
> > > -		idle_states {
> > > -			entry_method =3D "arm,pcsi";
> > > -
> > > -			CPU_SLEEP_0: cpu-sleep-0 {
> > > -				compatible =3D "arm,idle-state";
> > > -				local-timer-stop;
> > > -				arm,psci-suspend-param =3D <0x0010000>;
> > > -				entry-latency-us =3D <80>;
> > > -				exit-latency-us  =3D <160>;
> > > -				min-residency-us =3D <320>;
> > > -			};
> > > -
> > > -			CLUSTER_SLEEP_0: cluster-sleep-0 {
> > > -				compatible =3D "arm,idle-state";
> > > -				local-timer-stop;
> > > -				arm,psci-suspend-param =3D <0x1010000>;
> > > -				entry-latency-us =3D <500>;
> > > -				exit-latency-us =3D <1000>;
> > > -				min-residency-us =3D <2500>;
> > > -			};
> > > -		};
> > > -	};
> > > -
> > >  	ap806 {
> > >  		#address-cells =3D <2>;
> > >  		#size-cells =3D <2>;
> =

> -- =

>      http://baruch.siach.name/blog/                  ~. .~   Tk Open Syst=
ems
> =3D}------------------------------------------------ooO--U--Ooo----------=
--{=3D
>    - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -

> CONFIG_SYSVIPC=3Dy
> CONFIG_POSIX_MQUEUE=3Dy
> CONFIG_AUDIT=3Dy
> CONFIG_NO_HZ_IDLE=3Dy
> CONFIG_HIGH_RES_TIMERS=3Dy
> CONFIG_PREEMPT=3Dy
> CONFIG_BSD_PROCESS_ACCT=3Dy
> CONFIG_BSD_PROCESS_ACCT_V3=3Dy
> CONFIG_TASKSTATS=3Dy
> CONFIG_TASK_DELAY_ACCT=3Dy
> CONFIG_TASK_XACCT=3Dy
> CONFIG_TASK_IO_ACCOUNTING=3Dy
> CONFIG_IKCONFIG=3Dy
> CONFIG_IKCONFIG_PROC=3Dy
> CONFIG_NUMA_BALANCING=3Dy
> CONFIG_MEMCG=3Dy
> CONFIG_MEMCG_SWAP=3Dy
> CONFIG_BLK_CGROUP=3Dy
> CONFIG_CGROUP_PIDS=3Dy
> CONFIG_CGROUP_HUGETLB=3Dy
> CONFIG_CPUSETS=3Dy
> CONFIG_CGROUP_DEVICE=3Dy
> CONFIG_CGROUP_CPUACCT=3Dy
> CONFIG_CGROUP_PERF=3Dy
> CONFIG_USER_NS=3Dy
> CONFIG_SCHED_AUTOGROUP=3Dy
> CONFIG_BLK_DEV_INITRD=3Dy
> CONFIG_INITRAMFS_SOURCE=3D"rootfs-armv8.cpio"
> # CONFIG_RD_BZIP2 is not set
> # CONFIG_RD_LZMA is not set
> # CONFIG_RD_XZ is not set
> # CONFIG_RD_LZO is not set
> # CONFIG_RD_LZ4 is not set
> CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy
> CONFIG_KALLSYMS_ALL=3Dy
> # CONFIG_COMPAT_BRK is not set
> CONFIG_PROFILING=3Dy
> CONFIG_ARCH_MVEBU=3Dy
> CONFIG_PCI=3Dy
> CONFIG_PCI_IOV=3Dy
> CONFIG_HOTPLUG_PCI=3Dy
> CONFIG_PCI_HOST_GENERIC=3Dy
> CONFIG_PCIE_ARMADA_8K=3Dy
> CONFIG_ARM64_VA_BITS_48=3Dy
> CONFIG_SCHED_MC=3Dy
> CONFIG_NUMA=3Dy
> CONFIG_CRASH_DUMP=3Dy
> # CONFIG_ARM64_VHE is not set
> CONFIG_COMPAT=3Dy
> CONFIG_HIBERNATION=3Dy
> CONFIG_CPU_IDLE=3Dy
> CONFIG_ARM_CPUIDLE=3Dy
> CONFIG_CPU_FREQ=3Dy
> CONFIG_CPUFREQ_DT=3Dy
> CONFIG_ARM_SCPI_CPUFREQ=3Dy
> CONFIG_ARM_SCPI_PROTOCOL=3Dy
> CONFIG_EFI_CAPSULE_LOADER=3Dy
> CONFIG_ARM64_CRYPTO=3Dy
> CONFIG_CRYPTO_SHA1_ARM64_CE=3Dy
> CONFIG_CRYPTO_SHA2_ARM64_CE=3Dy
> CONFIG_CRYPTO_GHASH_ARM64_CE=3Dy
> CONFIG_CRYPTO_AES_ARM64_CE_CCM=3Dy
> CONFIG_CRYPTO_AES_ARM64_CE_BLK=3Dy
> CONFIG_JUMP_LABEL=3Dy
> CONFIG_BLK_DEV_INTEGRITY=3Dy
> # CONFIG_IOSCHED_DEADLINE is not set
> # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
> CONFIG_KSM=3Dy
> CONFIG_TRANSPARENT_HUGEPAGE=3Dy
> CONFIG_CMA=3Dy
> CONFIG_NET=3Dy
> CONFIG_PACKET=3Dy
> CONFIG_UNIX=3Dy
> CONFIG_INET=3Dy
> CONFIG_IP_MULTICAST=3Dy
> CONFIG_IP_PNP=3Dy
> CONFIG_IP_PNP_DHCP=3Dy
> CONFIG_IP_PNP_BOOTP=3Dy
> CONFIG_NETFILTER=3Dy
> CONFIG_NF_CONNTRACK=3Dy
> CONFIG_NF_CONNTRACK_EVENTS=3Dy
> CONFIG_NETFILTER_XT_TARGET_CHECKSUM=3Dy
> CONFIG_NETFILTER_XT_TARGET_LOG=3Dy
> CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=3Dy
> CONFIG_NETFILTER_XT_MATCH_CONNTRACK=3Dy
> CONFIG_IP_NF_IPTABLES=3Dy
> CONFIG_IP_NF_FILTER=3Dy
> CONFIG_IP_NF_TARGET_REJECT=3Dy
> CONFIG_IP_NF_NAT=3Dy
> CONFIG_IP_NF_TARGET_MASQUERADE=3Dy
> CONFIG_IP_NF_MANGLE=3Dy
> CONFIG_IP6_NF_IPTABLES=3Dy
> CONFIG_IP6_NF_FILTER=3Dy
> CONFIG_IP6_NF_TARGET_REJECT=3Dy
> CONFIG_IP6_NF_MANGLE=3Dy
> CONFIG_IP6_NF_NAT=3Dy
> CONFIG_IP6_NF_TARGET_MASQUERADE=3Dy
> CONFIG_BRIDGE=3Dy
> CONFIG_BRIDGE_VLAN_FILTERING=3Dy
> CONFIG_VLAN_8021Q=3Dy
> CONFIG_VLAN_8021Q_GVRP=3Dy
> CONFIG_VLAN_8021Q_MVRP=3Dy
> CONFIG_DNS_RESOLVER=3Dy
> # CONFIG_WIRELESS is not set
> CONFIG_UEVENT_HELPER_PATH=3D"/sbin/hotplug"
> CONFIG_DEVTMPFS=3Dy
> CONFIG_DEVTMPFS_MOUNT=3Dy
> CONFIG_DMA_CMA=3Dy
> CONFIG_BRCMSTB_GISB_ARB=3Dy
> CONFIG_VEXPRESS_CONFIG=3Dy
> CONFIG_MTD=3Dy
> # CONFIG_MTD_OF_PARTS is not set
> CONFIG_MTD_BLOCK=3Dy
> CONFIG_MTD_M25P80=3Dy
> CONFIG_MTD_SPI_NOR=3Dy
> CONFIG_BLK_DEV_LOOP=3Dy
> CONFIG_BLK_DEV_NBD=3Dy
> CONFIG_VIRTIO_BLK=3Dy
> CONFIG_SRAM=3Dy
> CONFIG_EEPROM_AT25=3Dy
> # CONFIG_SCSI_PROC_FS is not set
> CONFIG_BLK_DEV_SD=3Dy
> CONFIG_SCSI_SAS_LIBSAS=3Dy
> CONFIG_SCSI_SAS_ATA=3Dy
> CONFIG_ATA=3Dy
> CONFIG_SATA_AHCI=3Dy
> CONFIG_SATA_AHCI_PLATFORM=3Dy
> CONFIG_AHCI_MVEBU=3Dy
> # CONFIG_ATA_SFF is not set
> CONFIG_NETDEVICES=3Dy
> CONFIG_MACVLAN=3Dy
> CONFIG_MACVTAP=3Dy
> CONFIG_TUN=3Dy
> CONFIG_VETH=3Dy
> CONFIG_VIRTIO_NET=3Dy
> # CONFIG_NET_VENDOR_3COM is not set
> # CONFIG_NET_VENDOR_ADAPTEC is not set
> # CONFIG_NET_VENDOR_AGERE is not set
> # CONFIG_NET_VENDOR_ALACRITECH is not set
> # CONFIG_NET_VENDOR_ALTEON is not set
> # CONFIG_NET_VENDOR_AMAZON is not set
> # CONFIG_NET_VENDOR_AMD is not set
> # CONFIG_NET_VENDOR_AQUANTIA is not set
> # CONFIG_NET_VENDOR_ARC is not set
> # CONFIG_NET_VENDOR_ATHEROS is not set
> # CONFIG_NET_VENDOR_BROADCOM is not set
> # CONFIG_NET_VENDOR_BROCADE is not set
> # CONFIG_NET_VENDOR_CAVIUM is not set
> # CONFIG_NET_VENDOR_CHELSIO is not set
> # CONFIG_NET_VENDOR_CISCO is not set
> # CONFIG_NET_VENDOR_DEC is not set
> # CONFIG_NET_VENDOR_DLINK is not set
> # CONFIG_NET_VENDOR_EMULEX is not set
> # CONFIG_NET_VENDOR_EZCHIP is not set
> # CONFIG_NET_VENDOR_HISILICON is not set
> # CONFIG_NET_VENDOR_HP is not set
> # CONFIG_NET_VENDOR_HUAWEI is not set
> # CONFIG_NET_VENDOR_INTEL is not set
> CONFIG_MVPP2=3Dy
> # CONFIG_NET_VENDOR_MELLANOX is not set
> # CONFIG_NET_VENDOR_MICREL is not set
> # CONFIG_NET_VENDOR_MICROCHIP is not set
> # CONFIG_NET_VENDOR_MYRI is not set
> # CONFIG_NET_VENDOR_NATSEMI is not set
> # CONFIG_NET_VENDOR_NETRONOME is not set
> # CONFIG_NET_VENDOR_NVIDIA is not set
> # CONFIG_NET_VENDOR_OKI is not set
> # CONFIG_NET_VENDOR_QLOGIC is not set
> # CONFIG_NET_VENDOR_QUALCOMM is not set
> # CONFIG_NET_VENDOR_RDC is not set
> # CONFIG_NET_VENDOR_REALTEK is not set
> # CONFIG_NET_VENDOR_RENESAS is not set
> # CONFIG_NET_VENDOR_ROCKER is not set
> # CONFIG_NET_VENDOR_SAMSUNG is not set
> # CONFIG_NET_VENDOR_SEEQ is not set
> # CONFIG_NET_VENDOR_SOLARFLARE is not set
> # CONFIG_NET_VENDOR_SILAN is not set
> # CONFIG_NET_VENDOR_SIS is not set
> # CONFIG_NET_VENDOR_SMSC is not set
> # CONFIG_NET_VENDOR_STMICRO is not set
> # CONFIG_NET_VENDOR_SUN is not set
> # CONFIG_NET_VENDOR_SYNOPSYS is not set
> # CONFIG_NET_VENDOR_TEHUTI is not set
> # CONFIG_NET_VENDOR_TI is not set
> # CONFIG_NET_VENDOR_VIA is not set
> # CONFIG_NET_VENDOR_WIZNET is not set
> CONFIG_MDIO_BUS_MUX_MMIOREG=3Dy
> CONFIG_SFP=3Dy
> CONFIG_MARVELL_PHY=3Dy
> CONFIG_MARVELL_10G_PHY=3Dy
> # CONFIG_USB_NET_DRIVERS is not set
> # CONFIG_WLAN is not set
> CONFIG_INPUT_POLLDEV=3Dy
> CONFIG_INPUT_EVDEV=3Dy
> CONFIG_KEYBOARD_GPIO=3Dy
> CONFIG_KEYBOARD_CROS_EC=3Dy
> CONFIG_INPUT_MISC=3Dy
> # CONFIG_SERIO_SERPORT is not set
> CONFIG_SERIO_AMBAKMI=3Dy
> CONFIG_VT_HW_CONSOLE_BINDING=3Dy
> CONFIG_LEGACY_PTY_COUNT=3D16
> CONFIG_SERIAL_8250=3Dy
> CONFIG_SERIAL_8250_CONSOLE=3Dy
> CONFIG_SERIAL_8250_EXTENDED=3Dy
> CONFIG_SERIAL_8250_SHARE_IRQ=3Dy
> CONFIG_SERIAL_8250_DW=3Dy
> CONFIG_SERIAL_OF_PLATFORM=3Dy
> CONFIG_SERIAL_AMBA_PL011=3Dy
> CONFIG_SERIAL_AMBA_PL011_CONSOLE=3Dy
> CONFIG_SERIAL_MVEBU_UART=3Dy
> # CONFIG_HW_RANDOM_CAVIUM is not set
> CONFIG_I2C=3Dy
> # CONFIG_I2C_COMPAT is not set
> CONFIG_I2C_CHARDEV=3Dy
> CONFIG_I2C_MUX=3Dy
> CONFIG_I2C_MUX_PCA954x=3Dy
> CONFIG_I2C_MV64XXX=3Dy
> CONFIG_I2C_PXA=3Dy
> CONFIG_SPI=3Dy
> CONFIG_SPI_ORION=3Dy
> CONFIG_SPI_PL022=3Dy
> CONFIG_SPI_ROCKCHIP=3Dy
> CONFIG_SPI_SPIDEV=3Dy
> CONFIG_PTP_1588_CLOCK=3Dy
> CONFIG_PINCTRL_SINGLE=3Dy
> CONFIG_PINCTRL_MAX77620=3Dy
> CONFIG_GPIO_DWAPB=3Dy
> CONFIG_GPIO_PL061=3Dy
> CONFIG_GPIO_XGENE=3Dy
> CONFIG_GPIO_PCA953X=3Dy
> CONFIG_GPIO_PCA953X_IRQ=3Dy
> CONFIG_GPIO_MAX77620=3Dy
> CONFIG_POWER_RESET_GPIO=3Dy
> CONFIG_POWER_RESET_GPIO_RESTART=3Dy
> CONFIG_POWER_RESET_SYSCON=3Dy
> CONFIG_BATTERY_BQ27XXX=3Dy
> CONFIG_SENSORS_ARM_SCPI=3Dy
> CONFIG_SENSORS_LM90=3Dy
> CONFIG_SENSORS_INA2XX=3Dy
> CONFIG_THERMAL=3Dy
> CONFIG_THERMAL_GOV_POWER_ALLOCATOR=3Dy
> CONFIG_CPU_THERMAL=3Dy
> CONFIG_THERMAL_EMULATION=3Dy
> CONFIG_ARMADA_THERMAL=3Dy
> CONFIG_WATCHDOG=3Dy
> CONFIG_ARM_SBSA_WATCHDOG=3Dy
> CONFIG_MFD_CROS_EC=3Dy
> CONFIG_MFD_MAX77620=3Dy
> CONFIG_MFD_RK808=3Dy
> CONFIG_MFD_SEC_CORE=3Dy
> CONFIG_REGULATOR=3Dy
> CONFIG_REGULATOR_FIXED_VOLTAGE=3Dy
> CONFIG_REGULATOR_FAN53555=3Dy
> CONFIG_REGULATOR_GPIO=3Dy
> CONFIG_REGULATOR_MAX77620=3Dy
> CONFIG_BACKLIGHT_LCD_SUPPORT=3Dy
> # CONFIG_LCD_CLASS_DEVICE is not set
> # CONFIG_BACKLIGHT_GENERIC is not set
> CONFIG_USB=3Dy
> CONFIG_USB_XHCI_HCD=3Dy
> CONFIG_USB_XHCI_PLATFORM=3Dy
> CONFIG_USB_STORAGE=3Dy
> CONFIG_NOP_USB_XCEIV=3Dy
> CONFIG_MMC=3Dy
> CONFIG_MMC_BLOCK_MINORS=3D32
> CONFIG_MMC_ARMMMCI=3Dy
> CONFIG_MMC_SDHCI=3Dy
> CONFIG_MMC_SDHCI_PLTFM=3Dy
> CONFIG_MMC_SDHCI_OF_ARASAN=3Dy
> CONFIG_MMC_SDHCI_CADENCE=3Dy
> CONFIG_MMC_SPI=3Dy
> CONFIG_MMC_DW=3Dy
> CONFIG_MMC_DW_EXYNOS=3Dy
> CONFIG_MMC_DW_K3=3Dy
> CONFIG_MMC_SDHCI_XENON=3Dy
> CONFIG_NEW_LEDS=3Dy
> CONFIG_LEDS_CLASS=3Dy
> CONFIG_LEDS_GPIO=3Dy
> CONFIG_LEDS_SYSCON=3Dy
> CONFIG_LEDS_TRIGGERS=3Dy
> CONFIG_LEDS_TRIGGER_HEARTBEAT=3Dy
> CONFIG_LEDS_TRIGGER_CPU=3Dy
> CONFIG_LEDS_TRIGGER_DEFAULT_ON=3Dy
> CONFIG_RTC_CLASS=3Dy
> CONFIG_RTC_DRV_ARMADA38X=3Dy
> CONFIG_DMADEVICES=3Dy
> CONFIG_MV_XOR_V2=3Dy
> CONFIG_SYNC_FILE=3Dy
> CONFIG_VFIO=3Dy
> CONFIG_VFIO_PCI=3Dy
> CONFIG_VIRTIO_PCI=3Dy
> CONFIG_VIRTIO_BALLOON=3Dy
> CONFIG_VIRTIO_MMIO=3Dy
> CONFIG_COMMON_CLK_VERSATILE=3Dy
> CONFIG_CLK_SP810=3Dy
> CONFIG_CLK_VEXPRESS_OSC=3Dy
> CONFIG_COMMON_CLK_RK808=3Dy
> CONFIG_COMMON_CLK_SCPI=3Dy
> CONFIG_COMMON_CLK_CS2000_CP=3Dy
> CONFIG_COMMON_CLK_S2MPS11=3Dy
> CONFIG_CLK_QORIQ=3Dy
> CONFIG_HWSPINLOCK=3Dy
> CONFIG_ARM_TIMER_SP804=3Dy
> CONFIG_MAILBOX=3Dy
> CONFIG_ARM_MHU=3Dy
> CONFIG_PLATFORM_MHU=3Dy
> CONFIG_ARM_SMMU=3Dy
> CONFIG_ARM_SMMU_V3=3Dy
> CONFIG_EXTCON_USB_GPIO=3Dy
> CONFIG_RESET_CONTROLLER=3Dy
> CONFIG_PHY_MVEBU_CP110_COMPHY=3Dy
> CONFIG_EXT4_FS=3Dy
> CONFIG_EXT4_FS_POSIX_ACL=3Dy
> CONFIG_FANOTIFY=3Dy
> CONFIG_VFAT_FS=3Dy
> CONFIG_TMPFS=3Dy
> CONFIG_HUGETLBFS=3Dy
> CONFIG_CONFIGFS_FS=3Dy
> # CONFIG_MISC_FILESYSTEMS is not set
> # CONFIG_NETWORK_FILESYSTEMS is not set
> CONFIG_NLS_CODEPAGE_437=3Dy
> CONFIG_NLS_ISO8859_1=3Dy
> CONFIG_KEYS=3Dy
> CONFIG_CRYPTO_ECDH=3Dy
> CONFIG_CRYPTO_CCM=3Dy
> CONFIG_CRYPTO_GCM=3Dy
> CONFIG_CRYPTO_ECB=3Dy
> CONFIG_CRYPTO_CMAC=3Dy
> CONFIG_CRYPTO_ARC4=3Dy
> CONFIG_CRYPTO_ANSI_CPRNG=3Dy
> # CONFIG_CRYPTO_DEV_VIRTIO is not set
> CONFIG_CRYPTO_DEV_SAFEXCEL=3Dy
> CONFIG_XZ_DEC=3Dy
> CONFIG_PRINTK_TIME=3Dy
> CONFIG_DEBUG_INFO=3Dy
> CONFIG_DEBUG_FS=3Dy
> CONFIG_MAGIC_SYSRQ=3Dy
> CONFIG_DEBUG_KERNEL=3Dy
> # CONFIG_SCHED_DEBUG is not set
> # CONFIG_DEBUG_PREEMPT is not set
> # CONFIG_FTRACE is not set
> CONFIG_MEMTEST=3Dy

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- =

     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=3D}------------------------------------------------ooO--U--Ooo------------=
{=3D
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
