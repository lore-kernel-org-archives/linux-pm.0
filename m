From: Scott Branden <scott.branden@broadcom.com>
Subject: Re: [PATCH v3 2/3] thermal: broadcom: ns-thermal: default on iProc
 SoCs
Date: Fri, 28 Apr 2017 13:36:39 -0700
Message-ID: <6628a958-087d-1221-7717-c07eeaec3cce@broadcom.com>
References: <1493410291-16679-1-git-send-email-jon.mason@broadcom.com>
 <1493410291-16679-3-git-send-email-jon.mason@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1493410291-16679-3-git-send-email-jon.mason@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Mason <jon.mason@broadcom.com>, Florian Fainelli <florian.fainelli@broadcom.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 17-04-28 01:11 PM, Jon Mason wrote:
> Tweak the Kconfig description to mention support for NSP and make the
> default on for iProc based platforms.
>
> Signed-off-by: Jon Mason <jon.mason@broadcom.com>
> ---
>  drivers/thermal/broadcom/Kconfig | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/thermal/broadcom/Kconfig b/drivers/thermal/broadcom/Kconfig
> index f0dea8a..b6f4b85 100644
> --- a/drivers/thermal/broadcom/Kconfig
> +++ b/drivers/thermal/broadcom/Kconfig
> @@ -1,8 +1,9 @@
>  config BCM_NS_THERMAL
>  	tristate "Northstar thermal driver"
>  	depends on ARCH_BCM_IPROC || COMPILE_TEST
If this driver is used on these SoCs then it:
depends on ARCH_BCM_NSP || ARCH_BCM_5301X || COMPILE_TEST
?
> +	default y if ARCH_BCM_IPROC
>  	help
> -	  Northstar is a family of SoCs that includes e.g. BCM4708, BCM47081,
> -	  BCM4709 and BCM47094. It contains DMU (Device Management Unit) block
> -	  with a thermal sensor that allows checking CPU temperature. This
> -	  driver provides support for it.
> +	  Support for the Northstar and Northstar Plus family of SoCs (e.g.
> +	  BCM4708, BCM4709, BCM5301x, BCM95852X, etc). It contains DMU (Device
> +	  Management Unit) block with a thermal sensor that allows checking CPU
> +	  temperature.
>
