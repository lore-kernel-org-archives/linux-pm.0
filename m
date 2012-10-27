From: Francesco Lavra <francescolavra.fl@gmail.com>
Subject: Re: [PATCH V2 4/6] Thermal: Remove the cooling_cpufreq_list.
Date: Sat, 27 Oct 2012 08:39:15 +0200
Message-ID: <508B8193.5020502@gmail.com>
References: <50898F97.3000202@gmail.com>, <1351235345-13050-1-git-send-email-hongbo.zhang@linaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:61028 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971Ab2J0GhI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 27 Oct 2012 02:37:08 -0400
In-Reply-To: <1351235345-13050-1-git-send-email-hongbo.zhang@linaro.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "hongbo.zhang" <hongbo.zhang@linaro.org>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: STEricsson_nomadik_linux@list.st.com, kernel@igloocommunity.org, linaro-kernel@lists.linaro.org, Patch Tracking <patches@linaro.org>

On Fri, 26 Oct 2012 15:09:05 +0800, Hongbo Zhang wrote:
> From: "hongbo.zhang" <hongbo.zhang at linaro.com>
> 
> Problem of using this list is that the cpufreq_get_max_state callback will be
> called when register cooling device by thermal_cooling_device_register, but
> this list isn't ready at this moment. What's more, there is no need to maintain
> such a list, we can get cpufreq_cooling_device instance by the private
> thermal_cooling_device.devdata.
> 
> Signed-off-by: hongbo.zhang <hongbo.zhang at linaro.com>

FWIW,
Reviewed-by: Francesco Lavra <francescolavra.fl@gmail.com>
