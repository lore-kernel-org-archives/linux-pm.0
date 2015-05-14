From: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Subject: Re: [PATCH v9 00/17] Tegra124 CL-DVFS / DFLL clocksource + cpufreq
Date: Thu, 14 May 2015 09:15:11 +0300
Message-ID: <55543D6F.2040704@kapsi.fi>
References: <1431529131-16710-1-git-send-email-mikko.perttunen@kapsi.fi> <2216026.DiZ8MPKfdF@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2216026.DiZ8MPKfdF@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: swarren@wwwdotorg.org, thierry.reding@gmail.com, gnurou@gmail.com, pdeschrijver@nvidia.com, viresh.kumar@linaro.org, mturquette@linaro.org, pwalmsley@nvidia.com, vinceh@nvidia.com, pgaikwad@nvidia.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tuomas.tynkkynen@iki.fi
List-Id: linux-pm@vger.kernel.org

On 05/14/2015 01:47 AM, Rafael J. Wysocki wrote:
 > ...
>
> If I'm supposed to apply this, I need ACKs from the appropriate people on
> all the patches where they are still missing.  Thanks!
>
>

I believe Thierry Reding will apply the series; your ACK as cpufreq 
maintainer for patch 13, and maybe also 12, would be welcome, though :)

Patch 13 just renames the old tegra-cpufreq driver that only applies to 
Tegra20 chips to tegra20-cpufreq.

Patch 12 adds device tree bindings. Maybe these can also be acked by 
Thierry? I'm not completely sure what's the convention.

Thanks,
Mikko.
