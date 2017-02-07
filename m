From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 1/4] MIPS: BMIPS: Update defconfig
Date: Tue, 7 Feb 2017 09:48:45 +0530
Message-ID: <20170207041845.GN3131@vireshk-i7>
References: <20170206215119.87099-1-code@mmayer.net>
 <20170206215119.87099-2-code@mmayer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34343 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751164AbdBGESs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Feb 2017 23:18:48 -0500
Received: by mail-pf0-f174.google.com with SMTP id e4so29439870pfg.1
        for <linux-pm@vger.kernel.org>; Mon, 06 Feb 2017 20:18:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170206215119.87099-2-code@mmayer.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Markus Mayer <code@mmayer.net>
Cc: Ralf Baechle <ralf@linux-mips.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Markus Mayer <mmayer@broadcom.com>, MIPS Linux Kernel List <linux-mips@linux-mips.org>, Power Management List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 06-02-17, 13:51, Markus Mayer wrote:
> From: Markus Mayer <mmayer@broadcom.com>
> 
> Ran "make savedefconfig" to bring bmips_stb_defconfig up to date.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---
>  arch/mips/configs/bmips_stb_defconfig | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/mips/configs/bmips_stb_defconfig b/arch/mips/configs/bmips_stb_defconfig
> index 4eb5d6e..3be15cb 100644
> --- a/arch/mips/configs/bmips_stb_defconfig
> +++ b/arch/mips/configs/bmips_stb_defconfig
> @@ -9,7 +9,6 @@ CONFIG_MIPS_O32_FP64_SUPPORT=y
>  # CONFIG_SWAP is not set
>  CONFIG_NO_HZ=y
>  CONFIG_BLK_DEV_INITRD=y
> -CONFIG_RD_GZIP=y
>  CONFIG_EXPERT=y
>  # CONFIG_VM_EVENT_COUNTERS is not set
>  # CONFIG_SLUB_DEBUG is not set
> @@ -24,7 +23,6 @@ CONFIG_INET=y
>  # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
>  # CONFIG_INET_XFRM_MODE_TUNNEL is not set
>  # CONFIG_INET_XFRM_MODE_BEET is not set
> -# CONFIG_INET_LRO is not set
>  # CONFIG_INET_DIAG is not set
>  CONFIG_CFG80211=y
>  CONFIG_NL80211_TESTMODE=y
> @@ -34,8 +32,6 @@ CONFIG_DEVTMPFS=y
>  CONFIG_DEVTMPFS_MOUNT=y
>  # CONFIG_STANDALONE is not set
>  # CONFIG_PREVENT_FIRMWARE_BUILD is not set
> -CONFIG_PRINTK_TIME=y
> -CONFIG_BRCMSTB_GISB_ARB=y
>  CONFIG_MTD=y
>  CONFIG_MTD_CFI=y
>  CONFIG_MTD_CFI_INTELEXT=y
> @@ -51,16 +47,15 @@ CONFIG_USB_USBNET=y
>  # CONFIG_INPUT is not set
>  # CONFIG_SERIO is not set
>  # CONFIG_VT is not set
> -# CONFIG_DEVKMEM is not set
>  CONFIG_SERIAL_8250=y
>  # CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
>  CONFIG_SERIAL_8250_CONSOLE=y
>  CONFIG_SERIAL_OF_PLATFORM=y
>  # CONFIG_HW_RANDOM is not set
> -CONFIG_POWER_SUPPLY=y
>  CONFIG_POWER_RESET=y
>  CONFIG_POWER_RESET_BRCMSTB=y
>  CONFIG_POWER_RESET_SYSCON=y
> +CONFIG_POWER_SUPPLY=y
>  # CONFIG_HWMON is not set
>  CONFIG_USB=y
>  CONFIG_USB_EHCI_HCD=y
> @@ -82,6 +77,7 @@ CONFIG_CIFS=y
>  CONFIG_NLS_CODEPAGE_437=y
>  CONFIG_NLS_ASCII=y
>  CONFIG_NLS_ISO8859_1=y
> +CONFIG_PRINTK_TIME=y
>  CONFIG_DEBUG_FS=y
>  CONFIG_MAGIC_SYSRQ=y
>  CONFIG_CMDLINE_BOOL=y

This is what happens when people don't update defconfigs properly :)

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
