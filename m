From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH V2 5/5] ARM: dts: exynos4412: Rename OPP nodes as
 opp@<opp-hz>
Date: Thu, 05 Nov 2015 10:51:28 +0900
Message-ID: <563AB620.5090904@samsung.com>
References: <cover.1446687367.git.viresh.kumar@linaro.org>
 <a911512c457ac95b6d8cb46eb631786cb4b64da9.1446687367.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:36062 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756352AbbKEBvh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2015 20:51:37 -0500
In-reply-to: <a911512c457ac95b6d8cb46eb631786cb4b64da9.1446687367.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, robh+dt@kernel.org, sboyd@codeaurora.org, lee.jones@linaro.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, mark.rutland@arm.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, nm@ti.com, devicetree@vger.kernel.org, b.zolnierkie@samsung.com, m.szyprowski@samsung.com, Kukjin Kim <kgene@kernel.org>, "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" <linux-samsung-soc@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>

On 05.11.2015 10:41, Viresh Kumar wrote:
> OPP bindings got updated to name OPP nodes this way, make changes
> according to that.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm/boot/dts/exynos4412.dtsi | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)

I see this patch does not depend on the rest of patchset so I presume
this can co through samsung-soc?

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

