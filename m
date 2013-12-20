From: bilhuang <bilhuang@nvidia.com>
Subject: Re: [PATCH v5 1/1] cpufreq: tegra: Re-model Tegra20 cpufreq driver
Date: Fri, 20 Dec 2013 18:42:35 +0800
Message-ID: <52B41F1B.3030005@nvidia.com>
References: <1387451926-21373-1-git-send-email-bilhuang@nvidia.com>	<CAKohpomCPJYd+d_NnM9gxwQ7bH6C6=iLxbiWZbfNcjZ8Bi+2wA@mail.gmail.com>	<52B41B18.30302@nvidia.com> <CAKohpontQwTc4KP7XMvtkvS2sQTyF+ngXnXfbJ1ev+MLEp-H0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:5525 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755388Ab3LTKmM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 Dec 2013 05:42:12 -0500
In-Reply-To: <CAKohpontQwTc4KP7XMvtkvS2sQTyF+ngXnXfbJ1ev+MLEp-H0g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>

On 12/20/2013 06:33 PM, Viresh Kumar wrote:
> On 20 December 2013 15:55, bilhuang <bilhuang@nvidia.com> wrote:
>> Don't you think it worth creating a file here so this can be shared to
>> arm64?
>
> We will see how to handle virtual devices when we will start getting
> arm64 SoCs. Probably we might end up writing a single file in cpufreq,
> if required, that will create virtual devices for every arm64 platform..
>
> So, some people might use it and others wouldn't.. But no platform
> specific files for such stuff. So, the best we can do for now is to move
> these to platform code as we are talking about arm32 SoC's for now
> which do have a mach-* directory..
>
OK thanks, this is suggested by Stephen earlier, I'll let him comment in 
case he might think otherwise.
