From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v2 0/5] thermal: imx: Add nvmem-cells binding on imx6sx
Date: Thu, 31 Aug 2017 16:48:18 +0800
Message-ID: <20170831084817.GC3787@dragon>
References: <cover.1500041281.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751336AbdHaIsb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 31 Aug 2017 04:48:31 -0400
Content-Disposition: inline
In-Reply-To: <cover.1500041281.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Rob Herring <robh+dt@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>, Dong Aisheng <aisheng.dong@nxp.com>, Bai Ping <ping.bai@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, Octavian Purdila <octavian.purdila@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jul 14, 2017 at 05:11:05PM +0300, Leonard Crestez wrote:
> Leonard Crestez (5):
>   thermal: imx: Add nvmem-cells alternate binding for OCOTP access
>   nvmem: core: Add nvmem_cell_read_u32
>   thermal: imx: Add support for reading OCOTP through nvmem
>   ARM: dts: imx6sx: Use nvmem-cells for tempmon
>   ARM: dts: imx6ul: Add imx6ul-tempmon

For last two dts patches,

Acked-by: Shawn Guo <shawnguo@kernel.org>
