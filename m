From: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH] Revert "arm64: dts: marvell: add CPU Idle power state
 support on Armada 7K/8K"
Date: Tue, 4 Dec 2018 18:48:43 +0200
Message-ID: <20181204164843.edwszhv375yyhppb@sapphire.tkos.co.il>
References: <3ece60154be74bd6534387db8da578194f823b43.1543938362.git.baruch@tkos.co.il>
 <87o9a1w9dm.fsf@bootlin.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="pfgdlwwcft2x2cw2"
Content-Transfer-Encoding: 8bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <87o9a1w9dm.fsf@bootlin.com>
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
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Sergey Matyukevich <geomatsi@gmail.com>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, orenbh <orenbh@marvell.com>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org


--pfgdlwwcft2x2cw2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Gregory,

On Tue, Dec 04, 2018 at 05:21:25PM +0100, Gregory CLEMENT wrote:
>  On mar., déc. 04 2018, Baruch Siach <baruch@tkos.co.il> wrote:
> > This reverts commit 8ed46368776b3bc93d74c1f8f2bfb9fd8a9ad805.
> >
> > This commit breaks boot on Armada 8K based systems. Reverting it makes
> > affected systems boot again.
> >
> > Reported-by: Sergey Matyukevich <geomatsi@gmail.com>
> > Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> 
> I would like to know more about it because on the McBin I use there is
> no issue with 4.20-rc1.
> 
> Do you observe this issue with the arm64 defconfig or do you have some
> specific configuration option?

I tested the attached defconfig on Clearfog GT-8K and on another custom Armada 
8K based board.

Tomorrow I'll test Macchiatobin with this config and the arm64 defconfig.

baruch

> > ---
> >  .../boot/dts/marvell/armada-ap806-quad.dtsi   |  4 ---
> >  arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 27 -------------------
> >  2 files changed, 31 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi
> > index 64632c873888..01ea662afba8 100644
> > --- a/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi
> > +++ b/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi
> > @@ -20,28 +20,24 @@
> >  			compatible = "arm,cortex-a72", "arm,armv8";
> >  			reg = <0x000>;
> >  			enable-method = "psci";
> > -			cpu-idle-states = <&CPU_SLEEP_0>;
> >  		};
> >  		cpu1: cpu@1 {
> >  			device_type = "cpu";
> >  			compatible = "arm,cortex-a72", "arm,armv8";
> >  			reg = <0x001>;
> >  			enable-method = "psci";
> > -			cpu-idle-states = <&CPU_SLEEP_0>;
> >  		};
> >  		cpu2: cpu@100 {
> >  			device_type = "cpu";
> >  			compatible = "arm,cortex-a72", "arm,armv8";
> >  			reg = <0x100>;
> >  			enable-method = "psci";
> > -			cpu-idle-states = <&CPU_SLEEP_0>;
> >  		};
> >  		cpu3: cpu@101 {
> >  			device_type = "cpu";
> >  			compatible = "arm,cortex-a72", "arm,armv8";
> >  			reg = <0x101>;
> >  			enable-method = "psci";
> > -			cpu-idle-states = <&CPU_SLEEP_0>;
> >  		};
> >  	};
> >  };
> > diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> > index 073610ac0a53..7d94c1fa592a 100644
> > --- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> > +++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> > @@ -28,33 +28,6 @@
> >  		method = "smc";
> >  	};
> >  
> > -	cpus {
> > -		#address-cells = <1>;
> > -		#size-cells = <0>;
> > -
> > -		idle_states {
> > -			entry_method = "arm,pcsi";
> > -
> > -			CPU_SLEEP_0: cpu-sleep-0 {
> > -				compatible = "arm,idle-state";
> > -				local-timer-stop;
> > -				arm,psci-suspend-param = <0x0010000>;
> > -				entry-latency-us = <80>;
> > -				exit-latency-us  = <160>;
> > -				min-residency-us = <320>;
> > -			};
> > -
> > -			CLUSTER_SLEEP_0: cluster-sleep-0 {
> > -				compatible = "arm,idle-state";
> > -				local-timer-stop;
> > -				arm,psci-suspend-param = <0x1010000>;
> > -				entry-latency-us = <500>;
> > -				exit-latency-us = <1000>;
> > -				min-residency-us = <2500>;
> > -			};
> > -		};
> > -	};
> > -
> >  	ap806 {
> >  		#address-cells = <2>;
> >  		#size-cells = <2>;

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -

--pfgdlwwcft2x2cw2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=defconfig

CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_AUDIT=y
CONFIG_NO_HZ_IDLE=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_PREEMPT=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_NUMA_BALANCING=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_USER_NS=y
CONFIG_SCHED_AUTOGROUP=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE="rootfs-armv8.cpio"
# CONFIG_RD_BZIP2 is not set
# CONFIG_RD_LZMA is not set
# CONFIG_RD_XZ is not set
# CONFIG_RD_LZO is not set
# CONFIG_RD_LZ4 is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_KALLSYMS_ALL=y
# CONFIG_COMPAT_BRK is not set
CONFIG_PROFILING=y
CONFIG_ARCH_MVEBU=y
CONFIG_PCI=y
CONFIG_PCI_IOV=y
CONFIG_HOTPLUG_PCI=y
CONFIG_PCI_HOST_GENERIC=y
CONFIG_PCIE_ARMADA_8K=y
CONFIG_ARM64_VA_BITS_48=y
CONFIG_SCHED_MC=y
CONFIG_NUMA=y
CONFIG_CRASH_DUMP=y
# CONFIG_ARM64_VHE is not set
CONFIG_COMPAT=y
CONFIG_HIBERNATION=y
CONFIG_CPU_IDLE=y
CONFIG_ARM_CPUIDLE=y
CONFIG_CPU_FREQ=y
CONFIG_CPUFREQ_DT=y
CONFIG_ARM_SCPI_CPUFREQ=y
CONFIG_ARM_SCPI_PROTOCOL=y
CONFIG_EFI_CAPSULE_LOADER=y
CONFIG_ARM64_CRYPTO=y
CONFIG_CRYPTO_SHA1_ARM64_CE=y
CONFIG_CRYPTO_SHA2_ARM64_CE=y
CONFIG_CRYPTO_GHASH_ARM64_CE=y
CONFIG_CRYPTO_AES_ARM64_CE_CCM=y
CONFIG_CRYPTO_AES_ARM64_CE_BLK=y
CONFIG_JUMP_LABEL=y
CONFIG_BLK_DEV_INTEGRITY=y
# CONFIG_IOSCHED_DEADLINE is not set
# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
CONFIG_KSM=y
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_CMA=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_IP_PNP_BOOTP=y
CONFIG_NETFILTER=y
CONFIG_NF_CONNTRACK=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=y
CONFIG_NETFILTER_XT_TARGET_LOG=y
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=y
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
CONFIG_IP_NF_MANGLE=y
CONFIG_IP6_NF_IPTABLES=y
CONFIG_IP6_NF_FILTER=y
CONFIG_IP6_NF_TARGET_REJECT=y
CONFIG_IP6_NF_MANGLE=y
CONFIG_IP6_NF_NAT=y
CONFIG_IP6_NF_TARGET_MASQUERADE=y
CONFIG_BRIDGE=y
CONFIG_BRIDGE_VLAN_FILTERING=y
CONFIG_VLAN_8021Q=y
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_DNS_RESOLVER=y
# CONFIG_WIRELESS is not set
CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_DMA_CMA=y
CONFIG_BRCMSTB_GISB_ARB=y
CONFIG_VEXPRESS_CONFIG=y
CONFIG_MTD=y
# CONFIG_MTD_OF_PARTS is not set
CONFIG_MTD_BLOCK=y
CONFIG_MTD_M25P80=y
CONFIG_MTD_SPI_NOR=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_NBD=y
CONFIG_VIRTIO_BLK=y
CONFIG_SRAM=y
CONFIG_EEPROM_AT25=y
# CONFIG_SCSI_PROC_FS is not set
CONFIG_BLK_DEV_SD=y
CONFIG_SCSI_SAS_LIBSAS=y
CONFIG_SCSI_SAS_ATA=y
CONFIG_ATA=y
CONFIG_SATA_AHCI=y
CONFIG_SATA_AHCI_PLATFORM=y
CONFIG_AHCI_MVEBU=y
# CONFIG_ATA_SFF is not set
CONFIG_NETDEVICES=y
CONFIG_MACVLAN=y
CONFIG_MACVTAP=y
CONFIG_TUN=y
CONFIG_VETH=y
CONFIG_VIRTIO_NET=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
# CONFIG_NET_VENDOR_AGERE is not set
# CONFIG_NET_VENDOR_ALACRITECH is not set
# CONFIG_NET_VENDOR_ALTEON is not set
# CONFIG_NET_VENDOR_AMAZON is not set
# CONFIG_NET_VENDOR_AMD is not set
# CONFIG_NET_VENDOR_AQUANTIA is not set
# CONFIG_NET_VENDOR_ARC is not set
# CONFIG_NET_VENDOR_ATHEROS is not set
# CONFIG_NET_VENDOR_BROADCOM is not set
# CONFIG_NET_VENDOR_BROCADE is not set
# CONFIG_NET_VENDOR_CAVIUM is not set
# CONFIG_NET_VENDOR_CHELSIO is not set
# CONFIG_NET_VENDOR_CISCO is not set
# CONFIG_NET_VENDOR_DEC is not set
# CONFIG_NET_VENDOR_DLINK is not set
# CONFIG_NET_VENDOR_EMULEX is not set
# CONFIG_NET_VENDOR_EZCHIP is not set
# CONFIG_NET_VENDOR_HISILICON is not set
# CONFIG_NET_VENDOR_HP is not set
# CONFIG_NET_VENDOR_HUAWEI is not set
# CONFIG_NET_VENDOR_INTEL is not set
CONFIG_MVPP2=y
# CONFIG_NET_VENDOR_MELLANOX is not set
# CONFIG_NET_VENDOR_MICREL is not set
# CONFIG_NET_VENDOR_MICROCHIP is not set
# CONFIG_NET_VENDOR_MYRI is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
# CONFIG_NET_VENDOR_NETRONOME is not set
# CONFIG_NET_VENDOR_NVIDIA is not set
# CONFIG_NET_VENDOR_OKI is not set
# CONFIG_NET_VENDOR_QLOGIC is not set
# CONFIG_NET_VENDOR_QUALCOMM is not set
# CONFIG_NET_VENDOR_RDC is not set
# CONFIG_NET_VENDOR_REALTEK is not set
# CONFIG_NET_VENDOR_RENESAS is not set
# CONFIG_NET_VENDOR_ROCKER is not set
# CONFIG_NET_VENDOR_SAMSUNG is not set
# CONFIG_NET_VENDOR_SEEQ is not set
# CONFIG_NET_VENDOR_SOLARFLARE is not set
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
# CONFIG_NET_VENDOR_SMSC is not set
# CONFIG_NET_VENDOR_STMICRO is not set
# CONFIG_NET_VENDOR_SUN is not set
# CONFIG_NET_VENDOR_SYNOPSYS is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
# CONFIG_NET_VENDOR_TI is not set
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
CONFIG_MDIO_BUS_MUX_MMIOREG=y
CONFIG_SFP=y
CONFIG_MARVELL_PHY=y
CONFIG_MARVELL_10G_PHY=y
# CONFIG_USB_NET_DRIVERS is not set
# CONFIG_WLAN is not set
CONFIG_INPUT_POLLDEV=y
CONFIG_INPUT_EVDEV=y
CONFIG_KEYBOARD_GPIO=y
CONFIG_KEYBOARD_CROS_EC=y
CONFIG_INPUT_MISC=y
# CONFIG_SERIO_SERPORT is not set
CONFIG_SERIO_AMBAKMI=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_LEGACY_PTY_COUNT=16
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
CONFIG_SERIAL_8250_DW=y
CONFIG_SERIAL_OF_PLATFORM=y
CONFIG_SERIAL_AMBA_PL011=y
CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
CONFIG_SERIAL_MVEBU_UART=y
# CONFIG_HW_RANDOM_CAVIUM is not set
CONFIG_I2C=y
# CONFIG_I2C_COMPAT is not set
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y
CONFIG_I2C_MUX_PCA954x=y
CONFIG_I2C_MV64XXX=y
CONFIG_I2C_PXA=y
CONFIG_SPI=y
CONFIG_SPI_ORION=y
CONFIG_SPI_PL022=y
CONFIG_SPI_ROCKCHIP=y
CONFIG_SPI_SPIDEV=y
CONFIG_PTP_1588_CLOCK=y
CONFIG_PINCTRL_SINGLE=y
CONFIG_PINCTRL_MAX77620=y
CONFIG_GPIO_DWAPB=y
CONFIG_GPIO_PL061=y
CONFIG_GPIO_XGENE=y
CONFIG_GPIO_PCA953X=y
CONFIG_GPIO_PCA953X_IRQ=y
CONFIG_GPIO_MAX77620=y
CONFIG_POWER_RESET_GPIO=y
CONFIG_POWER_RESET_GPIO_RESTART=y
CONFIG_POWER_RESET_SYSCON=y
CONFIG_BATTERY_BQ27XXX=y
CONFIG_SENSORS_ARM_SCPI=y
CONFIG_SENSORS_LM90=y
CONFIG_SENSORS_INA2XX=y
CONFIG_THERMAL=y
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
CONFIG_CPU_THERMAL=y
CONFIG_THERMAL_EMULATION=y
CONFIG_ARMADA_THERMAL=y
CONFIG_WATCHDOG=y
CONFIG_ARM_SBSA_WATCHDOG=y
CONFIG_MFD_CROS_EC=y
CONFIG_MFD_MAX77620=y
CONFIG_MFD_RK808=y
CONFIG_MFD_SEC_CORE=y
CONFIG_REGULATOR=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_FAN53555=y
CONFIG_REGULATOR_GPIO=y
CONFIG_REGULATOR_MAX77620=y
CONFIG_BACKLIGHT_LCD_SUPPORT=y
# CONFIG_LCD_CLASS_DEVICE is not set
# CONFIG_BACKLIGHT_GENERIC is not set
CONFIG_USB=y
CONFIG_USB_XHCI_HCD=y
CONFIG_USB_XHCI_PLATFORM=y
CONFIG_USB_STORAGE=y
CONFIG_NOP_USB_XCEIV=y
CONFIG_MMC=y
CONFIG_MMC_BLOCK_MINORS=32
CONFIG_MMC_ARMMMCI=y
CONFIG_MMC_SDHCI=y
CONFIG_MMC_SDHCI_PLTFM=y
CONFIG_MMC_SDHCI_OF_ARASAN=y
CONFIG_MMC_SDHCI_CADENCE=y
CONFIG_MMC_SPI=y
CONFIG_MMC_DW=y
CONFIG_MMC_DW_EXYNOS=y
CONFIG_MMC_DW_K3=y
CONFIG_MMC_SDHCI_XENON=y
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_SYSCON=y
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
CONFIG_LEDS_TRIGGER_CPU=y
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_DRV_ARMADA38X=y
CONFIG_DMADEVICES=y
CONFIG_MV_XOR_V2=y
CONFIG_SYNC_FILE=y
CONFIG_VFIO=y
CONFIG_VFIO_PCI=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_MMIO=y
CONFIG_COMMON_CLK_VERSATILE=y
CONFIG_CLK_SP810=y
CONFIG_CLK_VEXPRESS_OSC=y
CONFIG_COMMON_CLK_RK808=y
CONFIG_COMMON_CLK_SCPI=y
CONFIG_COMMON_CLK_CS2000_CP=y
CONFIG_COMMON_CLK_S2MPS11=y
CONFIG_CLK_QORIQ=y
CONFIG_HWSPINLOCK=y
CONFIG_ARM_TIMER_SP804=y
CONFIG_MAILBOX=y
CONFIG_ARM_MHU=y
CONFIG_PLATFORM_MHU=y
CONFIG_ARM_SMMU=y
CONFIG_ARM_SMMU_V3=y
CONFIG_EXTCON_USB_GPIO=y
CONFIG_RESET_CONTROLLER=y
CONFIG_PHY_MVEBU_CP110_COMPHY=y
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_FANOTIFY=y
CONFIG_VFAT_FS=y
CONFIG_TMPFS=y
CONFIG_HUGETLBFS=y
CONFIG_CONFIGFS_FS=y
# CONFIG_MISC_FILESYSTEMS is not set
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y
CONFIG_KEYS=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_ARC4=y
CONFIG_CRYPTO_ANSI_CPRNG=y
# CONFIG_CRYPTO_DEV_VIRTIO is not set
CONFIG_CRYPTO_DEV_SAFEXCEL=y
CONFIG_XZ_DEC=y
CONFIG_PRINTK_TIME=y
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_FS=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_KERNEL=y
# CONFIG_SCHED_DEBUG is not set
# CONFIG_DEBUG_PREEMPT is not set
# CONFIG_FTRACE is not set
CONFIG_MEMTEST=y

--pfgdlwwcft2x2cw2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--pfgdlwwcft2x2cw2--
