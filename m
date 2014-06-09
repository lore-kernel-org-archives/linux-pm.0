From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3] cpufreq: governor: Be friendly towards
 latency-sensitive bursty workloads
Date: Mon, 9 Jun 2014 10:35:39 +0530
Message-ID: <CAKohpo=OSQ0MQuRUPYe39u19_+jGFYH0mqziPvMKx1GcTHB92g@mail.gmail.com>
References: <20140607204114.25673.87194.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:55283 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbaFIFFk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 9 Jun 2014 01:05:40 -0400
Received: by mail-ob0-f182.google.com with SMTP id wn1so5338816obc.41
        for <linux-pm@vger.kernel.org>; Sun, 08 Jun 2014 22:05:39 -0700 (PDT)
In-Reply-To: <20140607204114.25673.87194.stgit@srivatsabhat.in.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, "ego@linux.vnet.ibm.com" <ego@linux.vnet.ibm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 8 June 2014 02:11, Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com> wrote:
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c

> +               if (unlikely(wall_time > (2 * sampling_rate)) &&
> +                                               j_cdbs->copy_prev_load) {
> +                       load = j_cdbs->prev_load;
> +                       j_cdbs->copy_prev_load = false;
> +               } else {
> +                       load = 100 * (wall_time - idle_time) / wall_time;
> +                       j_cdbs->prev_load = load;
> +                       j_cdbs->copy_prev_load = true;
> +               }

Hmm, slight modifications over the weekend :) ..
What do you think about removing this extra variable and using prev_load
only, i.e. make it zero in the else part? Also adding a comment for this would
be helpful ?

I will try a patch before you come to office :)
