From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 00/10] cpufreq: governor: Avoid invalid
 state-transitions
Date: Sat, 20 Jun 2015 08:06:49 +0530
Message-ID: <20150620023649.GC1955@linux>
References: <cover.1434713657.git.viresh.kumar@linaro.org>
 <1603115.1rbxay7kVj@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36463 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753810AbbFTCgx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jun 2015 22:36:53 -0400
Received: by paceq1 with SMTP id eq1so71651770pac.3
        for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2015 19:36:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1603115.1rbxay7kVj@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>, ke.wang@spreadtrum.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org

On 20-06-15, 01:16, Rafael J. Wysocki wrote:
> So as I said before, I'm not regarding this as 4.2 material.

Okay.

> The fact that you manage to send your stuff before the merge window opens
> doesn't automatically mean that it has to go in during that merge window.

Yeah, that wasn't the intention. There were few reasons for me to
hurry up:
- It was related to crashes that we are aware of since few kernel
  releases now. And these aren't new features, but bug fixes, ofcourse
  not for bugs that are introduced in 4.2 material :)
- I wanted Preeti to test this stuff, as she wouldn't be working on
  this stuff anymore after this month.

Anyway, its fine to me even if this goes in the next cycle.

--
viresh
--
To unsubscribe from this list: send the line "unsubscribe linux-pm" in
