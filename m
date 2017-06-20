From: "Wangtao (Kevin, Kirin)" <kevin.wangtao@hisilicon.com>
Subject: Re: [PATCH 3/3] arm64: dts: register Hi3660's thermal sensor
Date: Tue, 20 Jun 2017 16:32:09 +0800
Message-ID: <7abe5b01-c728-accd-d6bb-05d9ceee2176@hisilicon.com>
References: <1497930035-60894-1-git-send-email-kevin.wangtao@hisilicon.com>
 <1497930035-60894-3-git-send-email-kevin.wangtao@hisilicon.com>
 <CAFGCpxwmN3jAZn2chK+QQ-YKg7TwWJOTHSi1VzwcSQ7Mm3gQng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([45.249.212.188]:8353 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750863AbdFTIci (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Jun 2017 04:32:38 -0400
In-Reply-To: <CAFGCpxwmN3jAZn2chK+QQ-YKg7TwWJOTHSi1VzwcSQ7Mm3gQng@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Guodong Xu <guodong.xu@linaro.org>
Cc: edubezval@gmail.com, Leo Yan <leo.yan@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, will.deacon@arm.com, xuwei5@hisilicon.com, catalin.marinas@arm.com, sunzhaosheng@hisilicon.com, rui.zhang@intel.com, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org



在 2017/6/20 15:38, Guodong Xu 写道:
> 
> 
> 2017年6月20日 上午11:49，"Tao Wang" <kevin.wangtao@hisilicon.com <mailto:kevin.wangtao@hisilicon.com>>写道：
> 
>     Bind thermal sensor driver for Hi3660.
> 
>     Signed-off-by: Tao Wang <kevin.wangtao@hisilicon.com <mailto:kevin.wangtao@hisilicon.com>>
>     Signed-off-by: Leo Yan <leo.yan@linaro.org <mailto:leo.yan@linaro.org>>
>     ---
>       arch/arm64/boot/dts/hisilicon/hi3660.dtsi |    7 +++++++
>       1 file changed, 7 insertions(+)
> 
>     diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
>     index 3983086..cc67958 100644
>     --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
>     +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
>     @@ -156,5 +156,12 @@
> 
> 
> i am wondering which tree this patch should be applied to. Actually Olof Johansson olof@lixom.net <mailto:olof@lixom.net> just merged hi3660 dts into his tree. You should better rebase you dts patch onto that.
Can you share me the git path?
> 
> 
>                              clock-names = "uartclk", "apb_pclk";
>                              status = "disabled";
>                      };
>     +
>     +               tsensor: tsensor {
>     +                       compatible = "hisilicon,thermal-hi3660";
>     +                       reg = <0x0 0xfff30000 0x0 0x1000>;
>     +                       #thermal-sensor-cells = <1>;
>     +                       status = "ok";
> 
> 
> please remove status ok. that's default. redundant.
ok
> 
>     +               };
>              };
>       };
>     --
>     1.7.9.5
> 
> 
>     _______________________________________________
>     linux-arm-kernel mailing list
>     linux-arm-kernel@lists.infradead.org <mailto:linux-arm-kernel@lists.infradead.org>
>     http://lists.infradead.org/mailman/listinfo/linux-arm-kernel <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>
> 
> 
