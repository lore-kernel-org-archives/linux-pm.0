From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v10 0/7] devfreq: Add devfreq-event class to provide raw
 data for devfreq device
Date: Fri, 30 Jan 2015 09:44:29 +0900
Message-ID: <54CAD3ED.50404@samsung.com>
References: <1422245793-8552-1-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1422245793-8552-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kgene@kernel.org
Cc: Chanwoo Choi <cw00.choi@samsung.com>, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, rafael.j.wysocki@intel.com, mark.rutland@arm.com, a.kesavan@samsung.com, tomasz.figa@gmail.com, k.kozlowski@samsung.com, b.zolnierkie@samsung.com, robh+dt@kernel.org, sangbae90.lee@samsung.com, inki.dae@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Dear Kukjin,

The patch(1-3) of this patchset is merged to linux-pm.git (Rafael J. Wysocki).
We can check it on following url:
- https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/commit/?h=bleeding-edge&id=8bf997796bd9bc8e3f997f26cbac7dd2c6661a76

Could you please pick remaining patches(4-7) related to Exynos DT files?

Best Regards,
Chanwoo Choi


On 01/26/2015 01:16 PM, Chanwoo Choi wrote:
> This patchset add new devfreq_event class to provide raw data to determine
> current utilization of device  which is used for devfreq governor.
> 
> The following description explains the feature of two kind of devfreq class:
> - devfreq class (existing)
>  : devfreq consumer device use raw data from devfreq_event device for
>    determining proper current system state and change voltage/frequency
>    dynamically using various governors.
> - devfreq_event class (new)
>  : Provide measured raw data to devfreq device for governor
> 
> Changelog:
> 
> Changes from v9:
> (https://lkml.org/lkml/2015/1/20/68)
> - Fix the operation of enable_count in devfreq_event_{enable|disable}_edev().
> 
> Changes from v8:
> (https://lkml.org/lkml/2015/1/12/299)
> - Fix issue of devfreq-event.c driver by Myunjoo's comment
>   : Merge patch2 (resource-managed function) with patch1
>   : Fix bug in devfreq_event_{enable|disable}_edev() about enable_count operation
>   : Simplify error checking code in devfreq_event_get_event()
>   : Define devfreq_event_get_drvdata() as static inline function type
>   : Reduce the time of critical section scope in devfreq_event_remove_edev()
>   : Rename field name of devfreq_event_data structure
>     (total_event / event -> total_count / load_count)
> - Drop following patch[1] because Exynos5260 cannot be tested for exynos-ppmu.c driver
>   [1] [PATCHv8 7/9] ARM: dts: Add PPMU dt node for Exynos5260 SoC
>       - https://lkml.org/lkml/2015/1/12/301
> - Clean-up exynos-ppmu.c without update
> 
> Changes from v7:
> (https://lkml.org/lkml/2015/1/7/795)
> - Use EXPORT_SYMBOL_GPL macro instead of EXPORT_SYMBOL
> - Fix the binding document of exynos-ppmu.c driver
> - Drop the devfreq-event type patch because it isnt' clear
> - Fix bug of devfreq_event_add_edev() when fail to execute device_register()
> - Modify resource free operation on following functions:
>   : devfreq_event_remove_edev()
>   : devfreq_event_release_edev()
> 
> Changes from v6:
> (https://lkml.org/lkml/2014/12/28/139)
> - This patchset is based on v3.19-rc3.
> 1. devfreq-event class driver
> - Fix build break if devfreq-event framework is off
> - Add resource-managed function for devfreq-event device
> : devm_devfreq_event_add_edev()
> : devm_devfreq_event_remove_edev()
> 
> Changes from v5:
> (https://lkml.org/lkml/2014/12/22/527)
> - Rebase these patch-set on v3.19-rc1 and Test it.
> 1. exynos-ppmu.c
> - Change the error value when of_iomap() fail to map the memory
> - Remove owner setting of platform_driver
> - Add exynos_ppmu_disable() function
> 2. exynos dts file
> - Add PPMU node to Exynos3250-based Monk board
> - Remove ppmu_cpu node on Exynos4412-based TRATS2 board and add ppmu_leftbus/rightbus node
> 
> Changes from v4:
> (https://lkml.org/lkml/2014/12/16/511)
> 1. devfreq-event class driver
> - Add devfreq_event_get_edev_count() function
> - Modify the simple description of devfreq-event framework in devfreq-event.c
> - Minimize the usage range of global lock usage in devfreq_event_add_edev()
> - Remove '_is_enabled()' function pointer in devfreq_event_ops structure
> - Add separte CONFIG_PM_DEVFREQ_EVENT configuration
> - Add new devfreq-event.h header file including devfreq-event helper functions
> 2. exynos dts file
> - Add new patch to support PPMU with DEVFREQ-event on Exynos4412-based TRATS2
> 
> Changes from v3:
> (https://lkml.org/lkml/2014/12/12/219)
> 1. devfreq-event class driver
> - Fix return value of devfreq_event_get_event()
> - Add new structure devfreq_event_data for devfreq_event_get_event()
> - Modify the prototype of devfreq_event_get_event() function
> - Call of_node_put after calling of_parse_phandle() to decrement refcount
> 2. exynos-ppmu driver
> - Modify usage of devfreq_event_get_event() function
>   according to new prototype of this funciton
> - Add the additional description to exynos-ppmu.txt how to add PPMU node
>   in board dts file
> - Use 'PPMU_EVENT' macro to remove duplicate codes
> - Add the support of PPMU for Exynos5260
> 3. exynos dts file
> - Add missing PPMU_FSYS node to exynos3250.dtsi
> - Fix 'ppmu_mfc_l' node name as 'ppmu_mfc' because exynos3250 has only one MFC IP.
> - Add missing PPMU_ACP/G3D to exynos4.dtsi
> 4. etc
> - Fix wrong abbreviation of PPMU (PPMU :Platform Performance Monitoring Unit)
> - Add new patch to support the PPMU of Exynos5260 SoC
> 
> Changes from v2:
> (https://lkml.org/lkml/2014/12/9/304)
> 1. devfreq-event class driver
> - Rename all the helper functions of devfreq-event device
> - Add devfreq_event_remove_edev() instead of devfreq_put_event_dev()
> - Add devfreq_event_release_edev() to initialize it before put device
> - Add the detailed description of devfreq-event API
> - Add the attributes of devfreq-event class (enable_count)
> - Check the overflow about event/total_event data in devfreq_event_get_event()
> - Remove the 'exclusive flag' feature
> - Set set_event()/get_event() functions as mandary
> - Add missing of_node_put() call
> - Change variable type of 'get_event()' funciton from 'int' to 'u64'
> 2. exynos-ppmu driver
> - Remove un-used field (struct devfreq)
> - Use 'of_get_child_by_name()' instead of 'of_find_node_by_name()'
> - Add missing of_node_put() call
> - Fix wrong clock control
> - Use devfreq_event_remove_edev() instead of devfreq_remove_device()
> - Add the documentation for exynos-ppmu driver
> - Remove 'enable/disable/is_enabled/reset' function of exynos-ppmu driver
> 3. exynos3250-rinato.dts
> - Add ppmu_{leftbus|rightbus} dt node and remove ppmu_cpu dt node
> 
> Changes from v1:
> (https://lkml.org/lkml/2014/9/5/11)
> - Code clean
> - Add the description of devfreq-event structure
> - Add 'is_enabled' function to devfreq_event_ops structure
> - Add 'enable_count' field to devfreq_event_dev structure
> - Check whether devfreq-event device is enabled or not
>   during calling devfreq_event API
> - Define the type of devfreq-event device as following
>   : DEVFREQ_EVENT_TYPE_RAW_DATA
>   : DEVFREQ_EVENT_TYPE_UTILIZATION
>   : DEVFREQ_EVENT_TYPE_BANDWIDTH
>   : DEVFREQ_EVENT_TYPE_LATENCY
> - Add the exclusive feature of devfreq-event device.
>   If devfreq-event device is used on only on devfreq driver,
>   should used 'devfreq_enable_event_dev_exclusive()' function
> - Add new patch6 for test on Exynos3250-based Rinato board
> 
> Chanwoo Choi (7):
>   devfreq: event: Add new devfreq_event class to provide basic data for devfreq governor
>   devfreq: event: Add exynos-ppmu devfreq-event driver
>   devfreq: event: Add documentation for exynos-ppmu devfreq-event driver
>   ARM: dts: Add PPMU dt node for Exynos3250 SoC
>   ARM: dts: Add PPMU dt node for Exynos4 SoCs
>   ARM: dts: exynos: Add PPMU node for Exynos3250-based Rinato/Monk board
>   ARM: dts: exynos: Add PPMU node for Exynos4412-based TRATS2 board
> 
>  .../bindings/devfreq/event/exynos-ppmu.txt         | 110 +++++
>  arch/arm/boot/dts/exynos3250-monk.dts              |  40 ++
>  arch/arm/boot/dts/exynos3250-rinato.dts            |  40 ++
>  arch/arm/boot/dts/exynos3250.dtsi                  |  74 +++
>  arch/arm/boot/dts/exynos4.dtsi                     | 108 +++++
>  arch/arm/boot/dts/exynos4210.dtsi                  |   8 +
>  arch/arm/boot/dts/exynos4412-trats2.dts            |  40 ++
>  drivers/devfreq/Kconfig                            |   2 +
>  drivers/devfreq/Makefile                           |   6 +-
>  drivers/devfreq/devfreq-event.c                    | 494 +++++++++++++++++++++
>  drivers/devfreq/event/Kconfig                      |  25 ++
>  drivers/devfreq/event/Makefile                     |   2 +
>  drivers/devfreq/event/exynos-ppmu.c                | 374 ++++++++++++++++
>  drivers/devfreq/event/exynos-ppmu.h                |  93 ++++
>  include/linux/devfreq-event.h                      | 196 ++++++++
>  15 files changed, 1611 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
>  create mode 100644 drivers/devfreq/devfreq-event.c
>  create mode 100644 drivers/devfreq/event/Kconfig
>  create mode 100644 drivers/devfreq/event/Makefile
>  create mode 100644 drivers/devfreq/event/exynos-ppmu.c
>  create mode 100644 drivers/devfreq/event/exynos-ppmu.h
>  create mode 100644 include/linux/devfreq-event.h
> 
