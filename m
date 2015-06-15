From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 00/12] cpufreq: Fix governor races - part 2
Date: Tue, 16 Jun 2015 01:29:15 +0200
Message-ID: <2124579.Ezk09YdVq9@vostro.rjw.lan>
References: <cover.1434019473.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:48488 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752116AbbFOXDT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2015 19:03:19 -0400
In-Reply-To: <cover.1434019473.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>, ke.wang@spreadtrum.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org

On Thursday, June 11, 2015 04:21:43 PM Viresh Kumar wrote:
> Hi,
> 
> This is a next step of the earlier work I have posted [1].
> 
> The first 5 patches are minor cleanups, 6th & 7th try to optimize few
> things to make code less complex.
> 
> Patches 8-11 actually solve (or try to solve :)) the synchronization
> problems, or the crashes I was getting.
> 
> And the last one again optimizes code a bit.
> 
> I don't get the crashes anymore and want others to try. At least Preeti
> and Ke Wang (Sorry if I haven't spelled it properly :( ), as you two
> have reported the issues to me.
> 
> This patchset should be rebased over the earlier one [1].
> 
> To make things simple, all these patches are pushed here [2] and are
> rebased over pm/bleeeding-edge because of some recent important changes
> there:
> 
> 
> [1] http://marc.info/?i=cover.1433326032.git.viresh.kumar%40linaro.org
> [2] ssh://git@git.linaro.org/people/viresh.kumar/linux.git cpufreq/gov-locking

Given the Preeti's comments on these patches I don't think they are quite
ready and the 4.2 merge window is next week.  I don't think this series is
4.2 material, so please target it at the next one.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
