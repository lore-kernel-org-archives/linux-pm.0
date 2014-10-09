From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v8 2/7] arm: dts: qcom: Add power-controller device node
 for 8974 Krait CPUs
Date: Thu, 9 Oct 2014 09:57:04 -0600
Message-ID: <20141009155704.GC1277@ilina-mac.local>
References: <1412718106-17049-1-git-send-email-lina.iyer@linaro.org>
 <1412718106-17049-3-git-send-email-lina.iyer@linaro.org>
 <54347473.5010605@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:42604 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752436AbaJIP5I (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Oct 2014 11:57:08 -0400
Received: by mail-pd0-f175.google.com with SMTP id v10so20574pde.20
        for <linux-pm@vger.kernel.org>; Thu, 09 Oct 2014 08:57:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <54347473.5010605@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: daniel.lezcano@linaro.org, khilman@linaro.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org

On Tue, Oct 07 2014 at 17:17 -0600, Stephen Boyd wrote:
>On 10/07/2014 02:41 PM, Lina Iyer wrote:
>>@@ -144,7 +148,27 @@
>>  			};
>>  		};
>>-		saw_l2: regulator@f9012000 {
>>+		saw0: power-controller@f9089000 {
>>+			compatible = "qcom,msm8974-saw2-v2.1-cpu";
>>+			reg = <0xf9089000 0x1000>;
>
>Please add the aliases.
Will do.
>
>
>-- 
>Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
>hosted by The Linux Foundation
>
