From: Dirk Brandewie <dirk.brandewie@gmail.com>
Subject: Re: [PATCH 0/4] intel_pstate updates
Date: Mon, 21 Oct 2013 09:29:58 -0700
Message-ID: <52655686.7000406@intel.com>
References: <1382372435-29778-1-git-send-email-dirk.j.brandewie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:46385 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305Ab3JUQaA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Oct 2013 12:30:00 -0400
Received: by mail-pb0-f54.google.com with SMTP id ro12so7284817pbb.27
        for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2013 09:30:00 -0700 (PDT)
In-Reply-To: <1382372435-29778-1-git-send-email-dirk.j.brandewie@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: dirk.brandewie@gmail.com, linux-pm@vger.kernel.org, rjw@rjwysocki.net

Forgot to add this patch set is based on linux-pm/bleeding-edge
commit 1a1da369261c3ee2c3caa078b6ace46adcdffbb6

On 10/21/2013 09:20 AM, dirk.brandewie@gmail.com wrote:
> From: Dirk Brandewie <dirk.j.brandewie@intel.com>
>
> Patches 1-2 are bugfixes
>
> Patch 3 refactors the driver to support per-CPUID accessor functions
> to enable supporting CPUs that have different methods/MSRs for
> enumerating and setting the requested P state.
>
> Patch 4 Adds support for the Baytrail-M CPU
>
>
> Brennan Shacklett (1):
>    cpufreq: intel_pstate: Improve accuracy by not truncating until final
>      result
>
> Dirk Brandewie (3):
>    cpufreq/intel_pstate:  Correct calculation of min pstate value
>    cpufreq/intel_pstate: Refactor driver to support CPUs with different
>      MSR layouts
>    cpufreq/intel_pstate: Add Baytrail support
>
>   drivers/cpufreq/intel_pstate.c | 215 ++++++++++++++++++++++++++++-------------
>   1 file changed, 150 insertions(+), 65 deletions(-)
>

