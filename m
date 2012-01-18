From: mark gross <markgross@thegnar.org>
Subject: Re: [PATCH v2 0/8] RFC: CPU frequency min/max as PM QoS
 params
Date: Tue, 17 Jan 2012 19:13:19 -0800
Message-ID: <20120118031319.GB27153@mgross-G62>
References: <1326697201-32406-1-git-send-email-amiettinen@nvidia.com>
	<201201162238.57556.rjw@sisk.pl>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201201162238.57556.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Antti P Miettinen <amiettinen@nvidia.com>, cpufreq@vger.kernel.org, mark gross <markgross@thegnar.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Jan 16, 2012 at 10:38:57PM +0100, Rafael J. Wysocki wrote:
> Hi,
> 
> On Monday, January 16, 2012, Antti P Miettinen wrote:
> > [did not reach linux-pm as I sent to wrong address, sorry for
> > duplicates]
> > 
> > The inspiration for this patch series is the N9 CPU frequency boost
> > upon input events:
> > 
> > http://www.spinics.net/lists/cpufreq/msg00667.html
> > 
> > and the related changes in git://codeaurora.org/kernel/msm.git tree.
> > Those patches modify the ondemand cpufreq governor. This patch series
> > adds minimum and maximum CPU frequency as PM QoS parameters and
> > modifies the cpufreq core to enforce the PM QoS limits.
> 
> If that hasn't been clear enough so far, I'm still not convinced that using
> PM QoS for that is a good idea.
> 
> First off, frequency as a unit of throughput is questionable to say the least,
> because it isn't portable from one system to another.  Moreover, even on a
> given system it isn't particularly clear what the exact correspondence
> between frequency and throughput actually is.

You are right.  The notion of throughput of a CPU is really hard to
quantify.  Perhaps not using the term "throughput" would help?

The base issue I see, the Intel platform, is needing is that sometimes
we need to block the lowest P-states that the ondemand governor goes for
because those P-states result in media / graphics workloads dropping
frames.  However; GPU intensive workloads do not stress the CPU so the
ondemand governor goes for the low p-state.

I could use some way of constraining the PM-throttling of the
cpu-freq that can be hit from kernel or user mode.  So the graphics
driver can dynamically adjust the constraint request on the cpufreq
subsystem.

It is problematic that any driver requesting a given frequency request
is not portable across ISA's or even processor families in the same ISA.
But, maybe such a driver should use a module parameter to work around
this lack of portability?

> Second, it's not particularly clear what the meaning of the "min" frequency
> is supposed to be in terms of throughput.

It should mean "please cpufreq do not put the cpu into a state where its
clock runs slower than min".  I don't think we should talk about it as
throughput because thats not what the cpufreq controls.

> 
> Moreover, you make cpufreq export user_policy.min and user_policy.max
> regardless of the new PM QoS parameters, so it looks like you could use those
> new attributes to set the min/max as well.

I'm not a big fan of the cpufreq seamanly redundant export either.
Doesn't the equivalent data get exported under
/sys/devices/system/cpu/cpu?/cpufreq/ ?
 
my 2 cents.

 --mark
