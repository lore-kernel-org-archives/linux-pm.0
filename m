From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH RFC 25/27] devicetree: bindings: Document qcom,msm-id and
 qcom,board-id
Date: Thu, 19 Nov 2015 08:36:40 -0700
Message-ID: <20151119153640.GC893@linaro.org>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
 <1447799871-56374-26-git-send-email-lina.iyer@linaro.org>
 <CAL_JsqJAOEvs08Jydn9wWtM7-Oxd=MmmDER48VRF7z3Gkzt0CQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36051 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758601AbbKSPgo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Nov 2015 10:36:44 -0500
Received: by pacdm15 with SMTP id dm15so84365359pac.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2015 07:36:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAL_JsqJAOEvs08Jydn9wWtM7-Oxd=MmmDER48VRF7z3Gkzt0CQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Krzysztof =?utf-8?Q?Koz=C5=82owski?= <k.kozlowski@samsung.com>, msivasub@codeaurora.org, Andy Gross <agross@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, ahaslam@baylibre.com, mtitinger@baylibre.com, Kumar Gala <galak@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Thu, Nov 19 2015 at 07:37 -0700, Rob Herring wrote:
>On Tue, Nov 17, 2015 at 4:37 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
>> From: Kumar Gala <galak@codeaurora.org>
>>
>> The top level qcom,msm-id and qcom,board-id are utilized by bootloaders
>> on Qualcomm MSM platforms to determine which device tree should be
>> utilized and passed to the kernel.
>
>See [1] and the link there to the prior version which is like this one.
>
Thanks Rob. Andy Gross sent me that link and I am waiting on the changes
along with the dtb tool to make it. These patches will go away after
Stephen's changes. I just put it in here for completeness.

Thanks,
Lina

>[1] https://lkml.org/lkml/2015/10/26/651
