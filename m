From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [v3 PATCH 2/3] powernv-cpufreq: Fix pstate_to_idx() to handle
 non-continguous pstates
Date: Mon, 18 Dec 2017 14:08:20 +0530
Message-ID: <20171218083820.GA28881@in.ibm.com>
References: <1513148261-21097-1-git-send-email-ego@linux.vnet.ibm.com>
 <1513148261-21097-3-git-send-email-ego@linux.vnet.ibm.com>
 <CAKTCnz=jrvbizrzUx1tDxMg__4coJHoxSXOS+K+zXQVAM=WF-g@mail.gmail.com>
Reply-To: ego@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKTCnz=jrvbizrzUx1tDxMg__4coJHoxSXOS+K+zXQVAM=WF-g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Balbir Singh <bsingharora@gmail.com>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, huntbag@linux.vnet.ibm.com, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>
List-Id: linux-pm@vger.kernel.org

Hi Balbir,

On Sun, Dec 17, 2017 at 02:15:25PM +1100, Balbir Singh wrote:
> On Wed, Dec 13, 2017 at 5:57 PM, Gautham R. Shenoy
> <ego@linux.vnet.ibm.com> wrote:
> > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> >
> > The code in powernv-cpufreq, makes the following two assumptions which
> > are not guaranteed by the device-tree bindings:
> >
> >     1) Pstate ids are continguous: This is used in pstate_to_idx() to
> >        obtain the reverse map from a pstate to it's corresponding
> >        entry into the cpufreq frequency table.
> >
> >     2) Every Pstate should always lie between the max and the min
> >        pstates that are explicitly reported in the device tree: This
> >        is used to determine whether a pstate reported by the PMSR is
> >        out of bounds.
> >
> > Both these assumptions are unwarranted and can change on future
> > platforms.
> 
> While this is a good thing, I wonder if it is worth the complexity. Pstates
> are contiguous because they define transitions in incremental value
> of change in frequency and I can't see how this can be broken in the
> future?

In the future, we can have the OPAL firmware give us a smaller set of
pstates instead of expose every one of them. As it stands today, for
most of the workloads, we will need at best 20-30 pstates and not
beyond that.


> 
> Balbir Singh.
> 

--
Thanks and Regards
gautham.
