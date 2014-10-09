From: "Kasagar, Srinidhi" <srinidhi.kasagar@intel.com>
Subject: Re: [PATCH] cpufreq: Add sfi based cpufreq driver support
Date: Fri, 10 Oct 2014 00:37:48 +0530
Message-ID: <20141009190747.GA31674@intel-desktop>
References: <20141007140734.GB24200@intel-desktop>
 <CAKohpokLcZPcMUjXYNNxDcwHUzsL1ejYBYd0cDmnAHQu+cBYGA@mail.gmail.com>
 <20141008191454.GA6504@intel-desktop>
 <CAKohpom+Ey75QStm_xsVeC7arN_5a3+q_Nf8pvadTxNaLBKCEw@mail.gmail.com>
 <20141009180826.GA32265@intel-desktop>
 <CAKohpok9d4AK4qmERqtnGYBtZx=wnP5fdECOT6t1NFEGfAQ_2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:38051 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751137AbaJILIk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 9 Oct 2014 07:08:40 -0400
Content-Disposition: inline
In-Reply-To: <CAKohpok9d4AK4qmERqtnGYBtZx=wnP5fdECOT6t1NFEGfAQ_2g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Dirk Brandewie <dirk.j.brandewie@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, vishwesh.m.rudramuni@intel.com

On Thu, Oct 09, 2014 at 03:48:08PM +0530, Viresh Kumar wrote:
> On 9 October 2014 23:38, Kasagar, Srinidhi <srinidhi.kasagar@intel.com> wrote:
> > I guess if you offline a cpu and then bring it online, then even though
> > there is no change in frequency, the core calls ->target_index().
> 
> No.
Hmm..I noticed later that I was doing cpumask_copy for my internal experiments.
Even in that case, as you pointed, the ->target_index() was not called
for the onlined CPU, but for the other related CPU. I should have 
debug printed policy->cpu in my ->target() implementation..:(

Anyway, thanks much for it. Will fix that useless check in the next version
of my patch.

Srinidhi 
