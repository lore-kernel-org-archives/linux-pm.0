From: Matthew McClintock <mmcclint@codeaurora.org>
Subject: Re: [PATCH V3 2/4] cpufreq: dt: Add generic platform-device creation support
Date: Wed, 13 Apr 2016 14:46:22 -0500
Message-ID: <10F8C39E-E29B-46F0-93F9-1BCF894D600A@codeaurora.org>
References: <cover.1459325515.git.viresh.kumar@linaro.org> <cover.1459325515.git.viresh.kumar@linaro.org> <9de0943d865948c7cffae4be3c6cfc8e5b2743ca.1459325515.git.viresh.kumar@linaro.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:51580 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752551AbcDMTq2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Apr 2016 15:46:28 -0400
In-Reply-To: <9de0943d865948c7cffae4be3c6cfc8e5b2743ca.1459325515.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, arnd.bergmann@linaro.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, kgene.kim@samsung.com, xf@rock-chips.com, heiko@sntech.de, k.kozlowski@samsung.com, linux-kernel@vger.kernel.org

On Mar 30, 2016, at 3:15 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> 
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
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Test on ipq4019.

Tested-by: Matthew McClintock <mmcclint@codeaurora.org>

-M
