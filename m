From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] powernv/cpufreq: Set the pstate of the last hotplugged
 out cpu in policy->cpus to minimum
Date: Fri, 05 Sep 2014 12:48:30 +0530
Message-ID: <540963C6.8010702@linux.vnet.ibm.com>
References: <20140905065952.2831.66731.stgit@preeti.in.ibm.com> <20140905070134.2831.8175.stgit@preeti.in.ibm.com> <CAKohpokThCn3ze7KZ0zZNN8zyVCxjdL=pGBhWcAvVr9T23RxSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e9.ny.us.ibm.com ([32.97.182.139]:47250 "EHLO e9.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751688AbaIEHSl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 5 Sep 2014 03:18:41 -0400
Received: from /spool/local
	by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Fri, 5 Sep 2014 03:18:40 -0400
In-Reply-To: <CAKohpokThCn3ze7KZ0zZNN8zyVCxjdL=pGBhWcAvVr9T23RxSg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dirk Brandewie <dirk.j.brandewie@intel.com>, Shreyas Prabhu <shreyas@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Patrick Marlier <patrick.marlier@gmail.com>, Dirk Brandewie <dirk.brandewie@gmail.com>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>

On 09/05/2014 12:37 PM, Viresh Kumar wrote:
> On 5 September 2014 12:31, Preeti U Murthy <preeti@linux.vnet.ibm.com> wrote:
> 
>> +       smp_call_function_any(policy->cpus, set_pstate, &freq_data, 1);
> 
> We will surely have a single CPU alive at this point, so should we call
> this function on policy->cpu directly ?
> 
Yes that is better. Let me send out an updated version of this patch.

Regards
Preeti U Murthy

