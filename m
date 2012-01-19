From: mark gross <markgross@thegnar.org>
Subject: Re: [linux-pm] [PATCH v2 0/8] RFC: CPU frequency min/max as PM QoS
 params
Date: Thu, 19 Jan 2012 08:41:44 -0800
Message-ID: <20120119164144.GA8757@mgross-G62>
References: <1326697201-32406-1-git-send-email-amiettinen@nvidia.com>
 <201201162238.57556.rjw@sisk.pl>
 <20120118031319.GB27153@mgross-G62>
 <201201190024.27022.rjw@sisk.pl>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201201190024.27022.rjw@sisk.pl>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: markgross@thegnar.org, linux-pm@lists.linux-foundation.org, Antti P Miettinen <amiettinen@nvidia.com>, cpufreq@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 19, 2012 at 12:24:26AM +0100, Rafael J. Wysocki wrote:
> On Wednesday, January 18, 2012, mark gross wrote:
> > On Mon, Jan 16, 2012 at 10:38:57PM +0100, Rafael J. Wysocki wrote:
> > > Hi,
> > > 
> > > On Monday, January 16, 2012, Antti P Miettinen wrote:
> > > > [did not reach linux-pm as I sent to wrong address, sorry for
> > > > duplicates]
> > > > 
> > > > The inspiration for this patch series is the N9 CPU frequency boost
> > > > upon input events:
> > > > 
> > > > http://www.spinics.net/lists/cpufreq/msg00667.html
> > > > 
> > > > and the related changes in git://codeaurora.org/kernel/msm.git tree.
> > > > Those patches modify the ondemand cpufreq governor. This patch series
> > > > adds minimum and maximum CPU frequency as PM QoS parameters and
> > > > modifies the cpufreq core to enforce the PM QoS limits.
> > > 
> > > If that hasn't been clear enough so far, I'm still not convinced that using
> > > PM QoS for that is a good idea.
> > > 
> > > First off, frequency as a unit of throughput is questionable to say the least,
> > > because it isn't portable from one system to another.  Moreover, even on a
> > > given system it isn't particularly clear what the exact correspondence
> > > between frequency and throughput actually is.
> > 
> > You are right.  The notion of throughput of a CPU is really hard to
> > quantify.  Perhaps not using the term "throughput" would help?
> 
> Yes, it would.
> 
> > The base issue I see, the Intel platform, is needing is that sometimes
> > we need to block the lowest P-states that the ondemand governor goes for
> > because those P-states result in media / graphics workloads dropping
> > frames.  However; GPU intensive workloads do not stress the CPU so the
> > ondemand governor goes for the low p-state.
> > 
> > I could use some way of constraining the PM-throttling of the
> > cpu-freq that can be hit from kernel or user mode.  So the graphics
> > driver can dynamically adjust the constraint request on the cpufreq
> > subsystem.
> > 
> > It is problematic that any driver requesting a given frequency request
> > is not portable across ISA's or even processor families in the same ISA.
> > But, maybe such a driver should use a module parameter to work around
> > this lack of portability?
> 
> Well, it seems to me that we're trying to add a backdoor to the (apparently
> inadequate) governors here.  Arguably, the governors should be able to
> make the right decisions on the basis of the information they receive
> through their own interfaces.

the failings of governors to have the information needed is why pm_qos
was created in the first place.  It can be seen as a limitation on the
governor from some perspectives.  But, I like to think of if as updating
existing governors to account for new use case requirements as hardware
get bigger power management / performance dynamic ranges.


> > > Second, it's not particularly clear what the meaning of the "min" frequency
> > > is supposed to be in terms of throughput.
> > 
> > It should mean "please cpufreq do not put the cpu into a state where its
> > clock runs slower than min".  I don't think we should talk about it as
> > throughput because thats not what the cpufreq controls.
> 
> Perhaps we need a new cpufreq governor that would take use PM QoS internally
> to store requests from different sources, but that would work on a per-CPU
> basis (not globally) and would provide a new interface for user space?
> 

I don' think we need a new cpufreq governor, the parts of this patchset
that I agree with evolve the governor to account for pm-qos requests
but, globally for all cpu's.

Hmm, your right this patch set is global in its request and not
"per-cpu".  I need to think on that.  Making it per-cpu would likely
infer we need to make the qos request per cpu as well.  

Do you think it needs to be per-cpu?  (I'm starting to think "yes" it
does)

How do we scale the pm_qos ABI to support per/cpu?  (maybe we don't
export those types of qos classes to the user mode?)

--mark

