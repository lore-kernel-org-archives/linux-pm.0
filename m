From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v7] cpufreq: Add SFI based cpufreq driver support
Date: Thu, 11 Dec 2014 13:52:33 +0530
Message-ID: <CAKohpomraR_9pywLSM+sRtAS7i31=KwWSTsbW3fSZ6pDDADAoA@mail.gmail.com>
References: <20141211081438.GA2885@intel-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:52535 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932311AbaLKIWe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Dec 2014 03:22:34 -0500
Received: by mail-ob0-f178.google.com with SMTP id gq1so1913065obb.9
        for <linux-pm@vger.kernel.org>; Thu, 11 Dec 2014 00:22:34 -0800 (PST)
In-Reply-To: <20141211081438.GA2885@intel-desktop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinidhi Kasagar <srinidhi.kasagar@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rudramuni, Vishwesh M" <vishwesh.m.rudramuni@intel.com>

On 11 December 2014 at 13:44, Srinidhi Kasagar
<srinidhi.kasagar@intel.com> wrote:
> diff --git a/drivers/cpufreq/sfi-cpufreq.c b/drivers/cpufreq/sfi-cpufreq.c

> +static DEFINE_PER_CPU(struct cpufreq_frequency_table *, drv_data);

You don't need to store this information anywhere, its already present
in policy->freq_table; Just use that and get rid of the per-cpu stuff..

Other than that, Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
