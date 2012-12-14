From: Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 1/2] cpuidle: fix finding state with min power_usage
Date: Fri, 14 Dec 2012 12:43:48 -0500
Message-ID: <50CB6554.8060305@redhat.com>
References: <1355491060-970-1-git-send-email-sivaramn@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34882 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756101Ab2LNRoG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 14 Dec 2012 12:44:06 -0500
In-Reply-To: <1355491060-970-1-git-send-email-sivaramn@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sivaram Nair <sivaramn@nvidia.com>
Cc: rafael.j.wysocki@intel.com, len.brown@intel.com, daniel.lezcano@linaro.org, khilman@ti.com, ccross@android.com, youquan.song@intel.com, akpm@linux-foundation.org, shuox.liu@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/14/2012 08:17 AM, Sivaram Nair wrote:
> Since cpuidle_state.power_usage is a signed value, use INT_MAX (instead
> of -1) to init the local copies so that functions that tries to find
> cpuidle states with minimum power usage works correctly even if they use
> non-negative values.
>
> Signed-off-by: Sivaram Nair <sivaramn@nvidia.com>

Reviewed-by: Rik van Riel <riel@redhat.com>

-- 
All rights reversed
