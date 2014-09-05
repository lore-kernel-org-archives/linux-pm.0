From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] powernv/cpufreq: Set the pstate of the last
 hotplugged out cpu in policy->cpus to minimum
Date: Fri, 5 Sep 2014 12:37:40 +0530
Message-ID: <CAKohpokThCn3ze7KZ0zZNN8zyVCxjdL=pGBhWcAvVr9T23RxSg@mail.gmail.com>
References: <20140905065952.2831.66731.stgit@preeti.in.ibm.com>
	<20140905070134.2831.8175.stgit@preeti.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:55360 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688AbaIEHHk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 5 Sep 2014 03:07:40 -0400
Received: by mail-oi0-f46.google.com with SMTP id h136so7478345oig.5
        for <linux-pm@vger.kernel.org>; Fri, 05 Sep 2014 00:07:40 -0700 (PDT)
In-Reply-To: <20140905070134.2831.8175.stgit@preeti.in.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dirk Brandewie <dirk.j.brandewie@intel.com>, Shreyas Prabhu <shreyas@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Patrick Marlier <patrick.marlier@gmail.com>, Dirk Brandewie <dirk.brandewie@gmail.com>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>

On 5 September 2014 12:31, Preeti U Murthy <preeti@linux.vnet.ibm.com> wrote:

> +       smp_call_function_any(policy->cpus, set_pstate, &freq_data, 1);

We will surely have a single CPU alive at this point, so should we call
this function on policy->cpu directly ?
