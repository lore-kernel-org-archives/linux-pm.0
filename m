From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 0/2] cpufreq: ondemand: add AMD specific powersave bias
Date: Fri, 29 Mar 2013 08:18:54 +0530
Message-ID: <CAKohpokHs3pxnYx3QraEYhxqGs8KdTiomPpcbEDNgChaZDWK4A@mail.gmail.com>
References: <1364495057-14939-1-git-send-email-jacob.shin@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f41.google.com ([209.85.219.41]:53394 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753093Ab3C2Csz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Mar 2013 22:48:55 -0400
Received: by mail-oa0-f41.google.com with SMTP id f4so135489oah.28
        for <linux-pm@vger.kernel.org>; Thu, 28 Mar 2013 19:48:55 -0700 (PDT)
In-Reply-To: <1364495057-14939-1-git-send-email-jacob.shin@amd.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Shin <jacob.shin@amd.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 28 March 2013 23:54, Jacob Shin <jacob.shin@amd.com> wrote:
> This patchset adds AMD specific powersave bias function to the ondemand
> governor; which can be used to help ondemand governor make more power conscious
> frequency change decisions based on feedback from hardware (availble on AMD
> Family 16h and above).
>
> Hardware feedback tells software how "sensitive" to frequency changes the
> workloads are. CPU-bound workloads will be more sensitive -- they will
> perform better as frequency increases. Memory/IO-bound workloads will be less
> sensitive -- they will not necessarily perform better as frequnecy increases.
>
> This patchset was compared against ondemand governor without powersave bias
> and did not show any performance degradation on CPU-bound workloads such as
> kernbench and unixbench. While saving power on Memory-bound workloads such as
> stream.
>
> This applies to linux-pm's linux-next branch, on top of Viresh's 'Implement
> per policy instance of governor' V4 patchset:
>
> https://lkml.org/lkml/2013/3/27/348
>
> V2:
> * Added proper include files to amd_freq_sensitivity.c
> * Only register powersave_bias_target function pointer and not the entire
>   od_ops.
>
> Jacob Shin (2):
>   cpufreq: ondemand: allow custom powersave_bias_target function to be
>     registered
>   cpufreq: AMD "frequency sensitivity feedback" powersave bias for
>     ondemand governor
>
>  arch/x86/include/uapi/asm/msr-index.h  |    1 +
>  drivers/cpufreq/Kconfig.x86            |   10 +++
>  drivers/cpufreq/Makefile               |    1 +
>  drivers/cpufreq/amd_freq_sensitivity.c |  147 ++++++++++++++++++++++++++++++++
>  drivers/cpufreq/cpufreq_governor.h     |    3 +
>  drivers/cpufreq/cpufreq_ondemand.c     |   22 ++++-
>  6 files changed, 181 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/cpufreq/amd_freq_sensitivity.c

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
