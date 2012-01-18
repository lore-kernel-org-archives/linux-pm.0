From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2 0/8] RFC: CPU frequency min/max as PM QoS
	params
Date: Thu, 19 Jan 2012 00:24:26 +0100
Message-ID: <201201190024.27022.rjw@sisk.pl>
References: <1326697201-32406-1-git-send-email-amiettinen@nvidia.com>
	<201201162238.57556.rjw@sisk.pl>
	<20120118031319.GB27153@mgross-G62>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20120118031319.GB27153@mgross-G62>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: markgross@thegnar.org
Cc: linux-pm@lists.linux-foundation.org, Antti P Miettinen <amiettinen@nvidia.com>, cpufreq@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, January 18, 2012, mark gross wrote:
> On Mon, Jan 16, 2012 at 10:38:57PM +0100, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > On Monday, January 16, 2012, Antti P Miettinen wrote:
> > > [did not reach linux-pm as I sent to wrong address, sorry for
> > > duplicates]
> > > 
> > > The inspiration for this patch series is the N9 CPU frequency boost
> > > upon input events:
> > > 
> > > http://www.spinics.net/lists/cpufreq/msg00667.html
> > > 
> > > and the related changes in git://codeaurora.org/kernel/msm.git tree.
> > > Those patches modify the ondemand cpufreq governor. This patch series
> > > adds minimum and maximum CPU frequency as PM QoS parameters and
> > > modifies the cpufreq core to enforce the PM QoS limits.
> > 
> > If that hasn't been clear enough so far, I'm still not convinced that using
> > PM QoS for that is a good idea.
> > 
> > First off, frequency as a unit of throughput is questionable to say the least,
> > because it isn't portable from one system to another.  Moreover, even on a
> > given system it isn't particularly clear what the exact correspondence
> > between frequency and throughput actually is.
> 
> You are right.  The notion of throughput of a CPU is really hard to
> quantify.  Perhaps not using the term "throughput" would help?

Yes, it would.

> The base issue I see, the Intel platform, is needing is that sometimes
> we need to block the lowest P-states that the ondemand governor goes for
> because those P-states result in media / graphics workloads dropping
> frames.  However; GPU intensive workloads do not stress the CPU so the
> ondemand governor goes for the low p-state.
> 
> I could use some way of constraining the PM-throttling of the
> cpu-freq that can be hit from kernel or user mode.  So the graphics
> driver can dynamically adjust the constraint request on the cpufreq
> subsystem.
> 
> It is problematic that any driver requesting a given frequency request
> is not portable across ISA's or even processor families in the same ISA.
> But, maybe such a driver should use a module parameter to work around
> this lack of portability?

Well, it seems to me that we're trying to add a backdoor to the (apparently
inadequate) governors here.  Arguably, the governors should be able to
make the right decisions on the basis of the information they receive
through their own interfaces.

> > Second, it's not particularly clear what the meaning of the "min" frequency
> > is supposed to be in terms of throughput.
> 
> It should mean "please cpufreq do not put the cpu into a state where its
> clock runs slower than min".  I don't think we should talk about it as
> throughput because thats not what the cpufreq controls.

Perhaps we need a new cpufreq governor that would take use PM QoS internally
to store requests from different sources, but that would work on a per-CPU
basis (not globally) and would provide a new interface for user space?

Rafael
