From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/3] cpufreq: governor: Fix potential races
Date: Thu, 04 Jun 2015 12:34:51 +0530
Message-ID: <556FF893.3070007@linux.vnet.ibm.com>
References: <cover.1433326032.git.viresh.kumar@linaro.org> <556FDEA8.6090801@linux.vnet.ibm.com> <556FEB4B.1010601@linux.vnet.ibm.com> <20150604061128.GF11325@linux> <556FF201.8080100@linux.vnet.ibm.com> <20150604064202.GI11325@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e17.ny.us.ibm.com ([129.33.205.207]:33616 "EHLO
	e17.ny.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788AbbFDHFZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Jun 2015 03:05:25 -0400
Received: from /spool/local
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Thu, 4 Jun 2015 03:05:24 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
	by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 22536C9003C
	for <linux-pm@vger.kernel.org>; Thu,  4 Jun 2015 02:56:28 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t5475K7P54001912
	for <linux-pm@vger.kernel.org>; Thu, 4 Jun 2015 07:05:20 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t5475Ir5002187
	for <linux-pm@vger.kernel.org>; Thu, 4 Jun 2015 03:05:20 -0400
In-Reply-To: <20150604064202.GI11325@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org

On 06/04/2015 12:12 PM, Viresh Kumar wrote:
> On 04-06-15, 12:06, Preeti U Murthy wrote:
>> Your fix may not be complete and here is why. The reason we see the crash
>> is because we have *only* attempted to serialize calls to cpufreq_governor_dbs()
>> and not attempted to serialize *entire logical sequence of operations*. Let's
>> take a look at what is happening as a consequence.
> 
> You missed my logs (For the first time in my life I wrote them so well).
> This is what I mentioned in 3/3:
> 
> "
> These two issues need to be solved separately and the responsibility
> should be properly divided between cpufreq and governor core.

> 
> The first problem is more about the governor core, as it needs to
> protect its structures properly. And the second problem should be fixed
> in cpufreq core instead of governor, as its all about sequence of
> events.

My point is do we really need to treat them as separate problems ?
Will not serializing sequence of events help solve both issues ?

When we know the problem, why not fix it proper, rather than breaking it
up ?
> 
> This patch is trying to solve only the first problem.
> "
> 
> I NEVER claimed that I solved all the issues.

That is true. My intention was to point out explicitly what still
remains to be solved. It is true that you have mentioned that the
problem in the cpufreq core is about sequencing of events. I intended to
highlight what it was.

I would have restrained from pointing it out had the issues that I am
seeing waned a wee bit, but it has not, which is why I did not see value
in having the third patch as a stand alone patch, with more going in as
series.

Regards
Preeti U Murthy
> 

