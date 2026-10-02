Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55221495531
	for <linux-pm@vger.kernel.org>; Fri,  2 Oct 2026 13:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790947862; cv=none; b=uPdi2JE2sLCMnKuOA+tvxj0KYDu+ZyR/AbC69caK4bNxxy+45Sct7ymIMcjslTfvI9yDr70T2P5IjwJO79BebbQtL9rz7HD1Izh+OV/47Zsdc62MVy4rUXNXmIJgW8kJe59tLGOu21WwG52J/aoyEN6Iq9uht20PYFyMcfMhJIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790947862; c=relaxed/simple;
	bh=wQZASrm/f1N5BLfOUw2JFHihCFRl7Nbs/i914LiJ3xI=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ac2hekqc2TzwbIyzw22LeZmh62qmGoj10ZD1df0gUqVTwJBHya7Yyn8mnrublh2CialYn+5euQjvuc9QQlVooZnPn7nR9wnEuDVExb69BYZJ47LltjzVdm2J9yWbJbY4gflN4v1XJ2oLx1rtmipo3QAc/NxnFmQaBPZdovzyOBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c08MIF6T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c08MIF6T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 002C51F0089C
	for <linux-pm@vger.kernel.org>; Fri,  2 Oct 2026 13:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790947860;
	bh=sE8bXXV2aYl7I0eHUtl6v66dSznCvnKz176VEoS4MxE=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=c08MIF6TFp30XoozLY7hPI62jW6F4+6WRpgGc2EtmTP+G4FwJQVXYA/eGHiXdPDvw
	 PFdVCsOa/uGQ1MT0aLyDNlZImI/l0vr4SnlEApZXHOvkx2lahiHpGecTGwvILw7Oco
	 +KB7mdwVnROvDiqP7l+wEFso8/6SJCodlQvs027oUr/pthm9oWwrIK4RscxB77l2Ot
	 KAiZ1jGEy8NOKqSSZZVLs+ecAO3afa5565KAiyHSGeWOBHseDy8THd0kDgn32c+JTe
	 iRSXH9OqMboU/QkNoNu1UNRK7aBpkBhGY+UeA/I6UkvWr4Q/EUNL2k+r8pigRgYbV2
	 kO+du45rxPing==
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a779b23f05so22658231fa.1
        for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2026 06:30:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByx0Nhe3l1v9FDe1s3RvVuiymZYowsjJsE5j2iVUi0wpxzq8DzRxKUTAR4CzhrA5alwnsMSgpFwyg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLSNWizhUGADT7j60x75nDBBgWB6pvkP3Ntv0n9T/UxNrVDHrib
	vw1lBjizVdPOlXnDqD1iEKwnjj8nXsURYLvVCibkJABfyr+iqJnMXg3n9mTA2EeGZGrCOj5ROO8
	fENAyhs4CZIUrB4ssdxwlXY0/Sr8hHabvRfsS5OdZRg==
X-Received: by 2002:a2e:9fc6:0:b0:3a6:10d4:61c4 with SMTP id
 38308e7fff4ca-3a887813cd1mr7252281fa.28.1790947858689; Fri, 02 Oct 2026
 06:30:58 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 2 Oct 2026 16:30:57 +0300
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 2 Oct 2026 16:30:57 +0300
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260928-arm-psci-system_reset2-vendor-reboots-v26-6-b24e2348e8e1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928-arm-psci-system_reset2-vendor-reboots-v26-0-b24e2348e8e1@oss.qualcomm.com>
 <20260928-arm-psci-system_reset2-vendor-reboots-v26-6-b24e2348e8e1@oss.qualcomm.com>
Date: Fri, 2 Oct 2026 16:30:57 +0300
X-Gmail-Original-Message-ID: <CAMRc=MdSfBvZF4UJm=eBBD-GAJD7oFw3e+6UJeoXgidoPGzm-w@mail.gmail.com>
X-Gm-Features: AclHuK9NRrBpOxbdKY64qOqdzxHen1rX4zRRIEbqfUSn0FJYeFcgfvAtIpYZWTI
Message-ID: <CAMRc=MdSfBvZF4UJm=eBBD-GAJD7oFw3e+6UJeoXgidoPGzm-w@mail.gmail.com>
Subject: Re: [PATCH v26 06/10] power: reset: Add psci-reboot-mode driver
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, Andre Draszik <andre.draszik@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	Srinivas Kandagatla <srini@kernel.org>, Ulf Hansson <ulf.hansson@oss.qualcomm.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Bjorn Andersson <andersson@kernel.org>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Souvik Chakravarty <Souvik.Chakravarty@arm.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>, 
	Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	John Stultz <john.stultz@linaro.org>, Moritz Fischer <moritz.fischer@ettus.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Christian Loehle <christian.loehle@arm.com>, Lee Jones <lee@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>, Abel Vesa <abelvesa@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Sudeep Holla <sudeep.holla@kernel.org>, Andy Yan <andyshrk@163.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 28 Sep 2026 08:09:18 +0200, Shivendra Pratap
<shivendra.pratap@oss.qualcomm.com> said:
> PSCI supports different types of resets like SYSTEM_RESET, SYSTEM_RESET2
> ARCH WARM reset and SYSTEM_RESET2 vendor-specific resets. Currently
> there is no common driver that handles all supported psci resets at one
> place. Additionally, there is no common mechanism to issue the supported
> psci resets from userspace.
>
> Add psci-reboot-mode as an auxiliary device created by the psci-devices
> driver. Define two types of PSCI resets, predefined-resets and
> vendor-specific resets. Predefined-resets are defined by psci driver
> and vendor-specific resets are defined by SoC vendors, under the
> psci:reboot-mode node of SoC device tree.
>
> Register the driver with the reboot-mode framework to interface these
> resets to userspace. When userspace initiates a supported command, pass
> the reset arguments to the PSCI driver to enable command-based reset.
>
> This change allows userspace to issue supported PSCI reset commands
> using the standard reboot system calls while enabling SoC vendors to
> define their specific resets for PSCI.
>
> Suggested-by: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
> Suggested-by: Lee Jones <lee@kernel.org>
> Suggested-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---
>  MAINTAINERS                            |   1 +
>  drivers/firmware/psci/psci-devices.c   |   4 ++
>  drivers/power/reset/Kconfig            |  11 ++++
>  drivers/power/reset/Makefile           |   1 +
>  drivers/power/reset/psci-reboot-mode.c | 104 +++++++++++++++++++++++++++++++++
>  5 files changed, 121 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 70a11f2ff61d..1007d5cd2e13 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22058,6 +22058,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/arm/psci.yaml
>  F:	drivers/firmware/psci/
> +F:	drivers/power/reset/psci-reboot-mode.c
>  F:	include/linux/psci.h
>  F:	include/uapi/linux/psci.h
>
> diff --git a/drivers/firmware/psci/psci-devices.c b/drivers/firmware/psci/psci-devices.c
> index d23befc490ed..04f24b8d9943 100644
> --- a/drivers/firmware/psci/psci-devices.c
> +++ b/drivers/firmware/psci/psci-devices.c
> @@ -20,6 +20,10 @@ static const struct arm_psci_device_info arm_psci_devices[] = {
>  	{
>  		.name = "psci-cpuidle-domain",
>  	},
> +	{
> +		.name = "psci-reboot-mode",
> +		.of_node_name = "reboot-mode",
> +	},
>  };
>
>  static void arm_psci_auxiliary_device_release(struct device *dev)
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index bce996bbef28..f165a41d40ed 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -360,6 +360,17 @@ config NVMEM_REBOOT_MODE
>  	  then the bootloader can read it and take different
>  	  action according to the mode.
>
> +config PSCI_REBOOT_MODE
> +	bool "PSCI reboot mode driver"
> +	depends on ARM_PSCI_DEVICES
> +	select AUXILIARY_BUS
> +	select REBOOT_MODE
> +	help
> +	  Say y here to enable the PSCI reboot mode driver. The driver
> +	  registers with the reboot-mode framework to configure PSCI
> +	  reset commands, which are executed by the PSCI driver during
> +	  psci_sys_reset().
> +
>  config POWER_MLXBF
>  	tristate "Mellanox BlueField power handling driver"
>  	depends on (GPIO_MLXBF2 || GPIO_MLXBF3) && ACPI
> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> index e31cab4ba78e..45d8aaaffaa1 100644
> --- a/drivers/power/reset/Makefile
> +++ b/drivers/power/reset/Makefile
> @@ -41,5 +41,6 @@ obj-$(CONFIG_REBOOT_MODE) += reboot-mode.o
>  obj-$(CONFIG_SYSCON_REBOOT_MODE) += syscon-reboot-mode.o
>  obj-$(CONFIG_POWER_RESET_SC27XX) += sc27xx-poweroff.o
>  obj-$(CONFIG_NVMEM_REBOOT_MODE) += nvmem-reboot-mode.o
> +obj-$(CONFIG_PSCI_REBOOT_MODE) += psci-reboot-mode.o
>  obj-$(CONFIG_POWER_MLXBF) += pwr-mlxbf.o
>  obj-$(CONFIG_POWER_RESET_QEMU_VIRT_CTRL) += qemu-virt-ctrl.o
> diff --git a/drivers/power/reset/psci-reboot-mode.c b/drivers/power/reset/psci-reboot-mode.c
> new file mode 100644
> index 000000000000..bf2dd6626feb
> --- /dev/null
> +++ b/drivers/power/reset/psci-reboot-mode.c
> @@ -0,0 +1,104 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/auxiliary_bus.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/kconfig.h>

Huh?

With that removed:

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
