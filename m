From: =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: Re: [PATCH 2/2] thermal: add brcmstb AVS TMON driver
Date: Tue, 06 Jun 2017 14:27:48 +0200
Message-ID: <fdccd1ebb4ec0eb4f675168bdcb15fe4@milecki.pl>
References: <20170605210930.65432-1-code@mmayer.net>
 <20170605210930.65432-3-code@mmayer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170605210930.65432-3-code@mmayer.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Markus Mayer <code@mmayer.net>
Cc: Mark Rutland <mark.rutland@arm.com>, Device Tree List <devicetree@vger.kernel.org>, Doug Berger <opendmb@gmail.com>, Markus Mayer <mmayer@broadcom.com>, Power Management List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Brian Norris <computersforpeace@gmail.com>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 2017-06-05 23:09, Markus Mayer wrote:
> --- /dev/null
> +++ b/drivers/thermal/broadcom/brcmstb_thermal.c
> @@ -0,0 +1,361 @@
> +/*
> + * Broadcom STB AVS TMON thermal sensor driver
> + *
> + * Copyright (c) 2015-2017 Broadcom
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, 
> and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + */

The headers says GPL v2 but it doesn't match MODULE_LICENSE. Please be
consistent.


> +/* Convert a HW code to a temperature reading (millidegree celsius) */
> +static inline int avs_tmon_code_to_temp(u32 code)
> +{
> +	return (410040 - (int)((code & 0x3FF) * 487));
> +}

I got similar hardcoded values and Eduardo told me to move them to the 
DT.
See discussion in: https://patchwork.kernel.org/patch/9642119/

Hint: thermal_zone_get_offset + thermal_zone_get_slope
