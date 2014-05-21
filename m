From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3] cpufreq: Catch double invocations of cpufreq_freq_transition_begin/end
Date: Wed, 21 May 2014 15:01:26 +0200
Message-ID: <6424313.K1VhKnAUr2@vostro.rjw.lan>
References: <20140505072129.14454.25747.stgit@srivatsabhat.in.ibm.com> <5367553C.1040701@linux.vnet.ibm.com> <537C9CF3.60503@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53652 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751940AbaEUMoa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 21 May 2014 08:44:30 -0400
In-Reply-To: <537C9CF3.60503@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: Meelis Roos <mroos@linux.ee>, viresh.kumar@linaro.org, ego@linux.vnet.ibm.com, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday, May 21, 2014 06:02:51 PM Srivatsa S. Bhat wrote:
> On 05/05/2014 02:39 PM, Srivatsa S. Bhat wrote:
> > On 05/05/2014 02:23 PM, Meelis Roos wrote:
> >>>
> >>> Changes in v3:
> >>> Expanded the comment in the code to briefly mention why ASYNC_NOTIFICATION
> >>> drivers are left out from the check, as suggested by Gautham R. Shenoy.
> >>> No code changes in this version.
> >>>
> >>> v2: https://lkml.org/lkml/2014/4/29/283
> >>> v1: https://lkml.org/lkml/2014/4/28/469
> >>
> >> Seems to work on VIA EPIA with 3.15-rc2 (no other cpufreq fixes):
> >>
> > 
> > Great! Thanks a lot for testing this!
> > 
> > Rafael/Viresh, can you please add Meelis' Tested-by while taking
> > this patch?
> 
> Rafael, any thoughts on this patch?
> 
> It has been Acked by Viresh and tested by Meelis. Hope you'll consider
> picking up this patch for 3.16.

It should be in linux-next today AFAICS.

Rafael

