From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] cpufreq: tegra: fix the wrong clock name
Date: Fri, 23 Aug 2013 10:24:39 -0600
Message-ID: <52178CC7.2070003@wwwdotorg.org>
References: <1377222238-9439-1-git-send-email-josephl@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:39636 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754625Ab3HWQYo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 23 Aug 2013 12:24:44 -0400
In-Reply-To: <1377222238-9439-1-git-send-email-josephl@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joseph Lo <josephl@nvidia.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org

On 08/22/2013 07:43 PM, Joseph Lo wrote:
> The "cpu" and "pclk_p_cclk" was a virtual clock name that was used in
> the legacy Tegra clock framework. It was not used after converting to
> CCF. Fix it as the correct clock name that we are using.

Tested-by: Stephen Warren <swarren@nvidia.com>
