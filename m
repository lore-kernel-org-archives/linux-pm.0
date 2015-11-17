From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v6 0/9] samsung: pmu: split up SoC specific PMU data
Date: Tue, 17 Nov 2015 15:11:30 +0900
Message-ID: <564AC512.2090403@samsung.com>
References: <1447740351-14246-1-git-send-email-pankaj.dubey@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:36101 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751465AbbKQGLh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Nov 2015 01:11:37 -0500
In-reply-to: <1447740351-14246-1-git-send-email-pankaj.dubey@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pankaj Dubey <pankaj.dubey@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: kgene.kim@samsung.com, thomas.ab@samsung.com, amitdanielk@gmail.com, olof@lixom.net, khilman@linaro.org, arnd@arndb.de

On 17.11.2015 15:05, Pankaj Dubey wrote:
> In this series I am splitting up SoC specific PMU configuration data into
> mach-exynos folder itself, before moving all of them under
> drivers/soc/samsung/. Also instead of making all changes in single patch it
> has been broken into SoC specific patches to avoid large size of patch.
> With this approach there will not be unwanted big churns just after
> adding exynos-pmu under drivers/soc/samsung.
> 
> All these patches are just refactoring to keep minimal changes while moving
> exynos-pmu driver under drivers/soc/samsung/. Support for exynos7 PMU can
> be added on top of it, in such a manner that for ARM64 build, ARM related
> SoC's PMU will not get compiled and thus unnecessary increasing kernel image size.
> 
> These patches have been prepared on top of Kukjin Kim's for-next merged with
> driver-samsung and on top of
> cherry-picked change from [1].
> 
> 1: ARM: EXYNOS: Constify local exynos_pmu_data structure
>    https://lkml.org/lkml/2015/10/28/917
> 
> For testing entire patchset on Peach-Pi (Exynos5880) based chromebook for boot
> and S2R functionality.
> 
> Tested-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> 
> For testing entire patchset on on Trats2 (Exynos4412, S2R, reboot, poweroff)
> and Odroid XU3 (Exynos5422, reboot, poweroff).
> 
> Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Don't add it here. It will get lost.

Tags given to a cover letter applies for all patches so this tested-by
should be added to each patch.

Best regards,
Krzysztof


