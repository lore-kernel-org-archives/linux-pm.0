From: "Kasagar, Srinidhi" <srinidhi.kasagar@intel.com>
Subject: Re: [PATCH] cpufreq: Add sfi based cpufreq driver support
Date: Fri, 10 Oct 2014 22:21:27 +0530
Message-ID: <20141010165126.GA14463@intel-desktop>
References: <20141007140734.GB24200@intel-desktop>
 <CAKohpokLcZPcMUjXYNNxDcwHUzsL1ejYBYd0cDmnAHQu+cBYGA@mail.gmail.com>
 <20141008191454.GA6504@intel-desktop>
 <CAKohpom+Ey75QStm_xsVeC7arN_5a3+q_Nf8pvadTxNaLBKCEw@mail.gmail.com>
 <20141009180826.GA32265@intel-desktop>
 <CAKohpok9d4AK4qmERqtnGYBtZx=wnP5fdECOT6t1NFEGfAQ_2g@mail.gmail.com>
 <20141009190747.GA31674@intel-desktop>
 <CAKohponaW8i1as_w-cyrFoyY8PN7VwiRr=mE454Xhhe1C48mng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:1218 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751727AbaJJIw5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 10 Oct 2014 04:52:57 -0400
Content-Disposition: inline
In-Reply-To: <CAKohponaW8i1as_w-cyrFoyY8PN7VwiRr=mE454Xhhe1C48mng@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Dirk Brandewie <dirk.j.brandewie@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, vishwesh.m.rudramuni@intel.com

On Thu, Oct 09, 2014 at 04:45:01PM +0530, Viresh Kumar wrote:
> On 10 October 2014 00:37, Kasagar, Srinidhi <srinidhi.kasagar@intel.com> wrote:
> > Hmm..I noticed later that I was doing cpumask_copy for my internal experiments.
> > Even in that case, as you pointed, the ->target_index() was not called
> > for the onlined CPU, but for the other related CPU.
> 
> But why is it getting called for even that ?
I have not debugged that. However, to double check the same I have rebased to the
clean upstream tree and I don't see ->target_index() is called for any
other CPUs during the offline-online path..

Srinidhi
