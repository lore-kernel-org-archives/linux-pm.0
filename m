From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 2/3] cpufreq: dt: Add generic platform-device creation
 support
Date: Tue, 29 Mar 2016 13:03:51 +0900
Message-ID: <56F9FEA7.60608@samsung.com>
References: <cover.1458801338.git.viresh.kumar@linaro.org>
 <f38f15d2299e2d448aa12b8992fe2a0be84110f5.1458801338.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:62706 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708AbcC2ED7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Mar 2016 00:03:59 -0400
In-reply-to: <f38f15d2299e2d448aa12b8992fe2a0be84110f5.1458801338.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, arnd.bergmann@linaro.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, kgene.kim@samsung.com, xf@rock-chips.com, heiko@sntech.de, mmcclint@codeaurora.org, linux-kernel@vger.kernel.org

On 24.03.2016 15:40, Viresh Kumar wrote:
> Multiple platforms are using the generic cpufreq-dt driver now, and all
> of them are required to create a platform device with name "cpufreq-dt",
> in order to get the cpufreq-dt probed.
> 
> Many of them do it from platform code, others have special drivers just
> to do that.
> 
> It would be more sensible to do this at a generic place, where all such
> platform can mark their entries.
> 
> This patch adds a separate file to get this device created. Currently
> the compat list of platforms that we support is empty, and will be
> filled in as and when we move platforms to use it.
> 
> It always compiles as part of the kernel and so doesn't need a
> module-exit operation.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/Kconfig              | 11 +++++++++
>  drivers/cpufreq/Makefile             |  1 +
>  drivers/cpufreq/cpufreq-dt-platdev.c | 48 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 60 insertions(+)
>  create mode 100644 drivers/cpufreq/cpufreq-dt-platdev.c

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>



Best regards,

Krzysztof

