From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 0/6] powernv: cpufreq: Report frequency throttle by OCC
Date: Fri, 8 May 2015 10:42:34 +0530
Message-ID: <CAKohpokZcJeCEaKnfQC-78s2KKCJ9a7UqSA_R8VbjEX2HUGVNQ@mail.gmail.com>
References: <1430729652-14813-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:36728 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752413AbbEHFMf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2015 01:12:35 -0400
Received: by oift201 with SMTP id t201so50691130oif.3
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2015 22:12:35 -0700 (PDT)
In-Reply-To: <1430729652-14813-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 4 May 2015 at 14:24, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com> wrote:
> This patchset intends to add frequency throttle reporting mechanism
> to powernv-cpufreq driver when OCC throttles the frequency. OCC is an
> On-Chip-Controller which takes care of the power and thermal safety of
> the chip. The CPU frequency can be throttled during an OCC reset or
> when OCC tries to limit the max allowed frequency. The patchset will
> report such conditions so as to keep the user informed about reason
> for the drop in performance of workloads when frequency is throttled.
>
> Changes from v2:
> - Split into multiple patches
> - Semantic fixes
>
> Shilpasri G Bhat (6):
>   cpufreq: poowernv: Handle throttling due to Pmax capping at chip level
>   powerpc/powernv: Add definition of OPAL_MSG_OCC message type
>   cpufreq: powernv: Register for OCC related opal_message notification
>   cpufreq: powernv: Call throttle_check() on receiving OCC_THROTTLE
>   cpufreq: powernv: Report Psafe only if PMSR.psafe_mode_active bit is
>     set
>   cpufreq: powernv: Restore cpu frequency to policy->cur on unthrottling
>
>  arch/powerpc/include/asm/opal-api.h |   8 ++
>  drivers/cpufreq/powernv-cpufreq.c   | 199 +++++++++++++++++++++++++++++++++---
>  2 files changed, 192 insertions(+), 15 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
