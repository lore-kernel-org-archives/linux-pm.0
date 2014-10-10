From: "Kasagar, Srinidhi" <srinidhi.kasagar@intel.com>
Subject: Re: [PATCH] cpufreq: Add sfi based cpufreq driver support
Date: Fri, 10 Oct 2014 16:17:56 +0530
Message-ID: <20141010104756.GA11415@intel-desktop>
References: <20141008191454.GA6504@intel-desktop>
 <CAKohpom+Ey75QStm_xsVeC7arN_5a3+q_Nf8pvadTxNaLBKCEw@mail.gmail.com>
 <20141009180826.GA32265@intel-desktop>
 <CAKohpok9d4AK4qmERqtnGYBtZx=wnP5fdECOT6t1NFEGfAQ_2g@mail.gmail.com>
 <20141009190747.GA31674@intel-desktop>
 <CAKohponaW8i1as_w-cyrFoyY8PN7VwiRr=mE454Xhhe1C48mng@mail.gmail.com>
 <20141010165126.GA14463@intel-desktop>
 <CAKohponh_1zBPZ9PxNACUZ-3WzPnbkpQCwmCmiTDEwGEW5D=Rg@mail.gmail.com>
 <20141010171401.GA27359@intel-desktop>
 <CAKohpo=feG4cgKU265X6bVBXTbPX7sAvTbqj=Q1WNF=rehCKEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:63632 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750950AbaJJKsi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 10 Oct 2014 06:48:38 -0400
Content-Disposition: inline
In-Reply-To: <CAKohpo=feG4cgKU265X6bVBXTbPX7sAvTbqj=Q1WNF=rehCKEg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Brandewie, Dirk J" <dirk.j.brandewie@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rudramuni, Vishwesh M" <vishwesh.m.rudramuni@intel.com>

On Fri, Oct 10, 2014 at 02:57:42PM +0530, Viresh Kumar wrote:
> On 10 October 2014 22:44, Kasagar, Srinidhi <srinidhi.kasagar@intel.com> wrote:
> > It was called for the sibling cpu of the onlined one.
> 
> Still not clear. Can you give me output of this:
> 
> cat /sys/devices/system/cpu/cpu*/cpufreq/affected_cpus and
> cat /sys/devices/system/cpu/cpu*/cpufreq/related_cpus

# cat /sys/devices/system/cpu/cpu*/cpufreq/affected_cpus      
0 1
0 1
2 3
2 3

# cat /sys/devices/system/cpu/cpu*/cpufreq/related_cpus
0 1
0 1
2 3
2 3

> 
> And then also tell me which CPU are you trying to remove ?

cpu1

BTW, I had to switch to my own tree to get the issue back (where
I have my legacy custom cpufreq/core changes. So I suspect my changes
not the upstream tree)

Srinidhi
