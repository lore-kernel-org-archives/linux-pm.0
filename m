From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 1/2] cpufreq: tegra: Remove not used header and clean
 up codes
Date: Wed, 11 Sep 2013 13:19:28 -0600
Message-ID: <5230C240.8050602@wwwdotorg.org>
References: <1378898355-31290-1-git-send-email-bilhuang@nvidia.com> <1378898355-31290-2-git-send-email-bilhuang@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1378898355-31290-2-git-send-email-bilhuang-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bill Huang <bilhuang-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: rjw-KKrjLPT3xs0@public.gmane.org, viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 09/11/2013 05:19 AM, Bill Huang wrote:
> Remove inclustion of the not needed header files and remove the logic
> to check the CPU ID to not exceeding the maximum supported CPUs.

> diff --git a/drivers/cpufreq/tegra-cpufreq.c b/drivers/cpufreq/tegra-cpufreq.c

> - * Copyright (C) 2010 Google, Inc.
> + * Copyright (c) 2013, NVIDIA Corporation.
> + * Copyright (C) 2010-2013 Google, Inc.

This is such a trivial patch, I don't think it's appropriate to add an
NVIDIA (c) notice. It may well be appropriate in patch 2/2.

I assume that Google didn't write this patch, so why adjust that (c) notice?
