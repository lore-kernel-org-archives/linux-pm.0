From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 0/3] 96boards: add thermal senor support to hikey board
Date: Thu, 19 Mar 2015 13:59:46 +0000
Message-ID: <20150319135946.GG18473@leverpostej>
References: <1426751849-10604-1-git-send-email-kong.kongxinwei@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37207 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754578AbbCSOAT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 19 Mar 2015 10:00:19 -0400
Content-Disposition: inline
In-Reply-To: <1426751849-10604-1-git-send-email-kong.kongxinwei@hisilicon.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kongxinwei <kong.kongxinwei@hisilicon.com>
Cc: "rui.zhuang@intel.com" <rui.zhuang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linuxarm@huawei.com" <linuxarm@huawei.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "liguozhu@hisilicon.com" <liguozhu@hisilicon.com>, "xuwei5@hisilicon.com" <xuwei5@hisilicon.com>

On Thu, Mar 19, 2015 at 07:57:26AM +0000, kongxinwei wrote:
> The Linaro connect introduce 96boards series in Hong Kong,The HiKey board
> is the first board to be certified 96Boards Consumer Edition compatible.
> This board is based on the HiSilicon SoC. you can get more information
> from https://www.96boards.org.
> 
> The hisilicon SoC contains thermal module, this thermal module has 4 sensors,
> 
> 	- sensor 0: local sensor;
> 	- sensor 1: remote sensor for ACPU cluster 1;
> 	- sensor 2: remote sensor for ACPU cluster 2;
> 	- sensor 3: remote sensor for GPU;
> 
> It can obtain this device temperature by operating this hardware. The new
> sensor driver satisfies thermal framework and to realize the ACPU ,GPU and
> so on to cool function.
> 
> kongxinwei (3):
>   thermal: hisilicon: add new hisilicon thermal sensor driver
>   dts: hi6220: enable thermal sensor for hisilicon SoC
>   dt-bindings: Document the hi6220 thermal sensor bindings
> 
>  .../bindings/thermal/hisilicon-thermal.txt         |  51 ++
>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi          | 153 ++++++
>  drivers/thermal/Kconfig                            |   8 +
>  drivers/thermal/Makefile                           |   1 +
>  drivers/thermal/hisi_thermal.c                     | 531 +++++++++++++++++++++

Mainline does not have a hi6220 dtsi.

Which tree is this against?

What are your dependencies?

Mark.
