From: Mark Gross <mgross@linux.intel.com>
Subject: Re: pm qos and cpufreq interaction [Was: pm qos
	infrastructure and interface]
Date: Thu, 25 Oct 2007 13:53:47 -0700
Message-ID: <20071025205347.GA21681@linux.intel.com>
References: <20071004215139.GA20078@linux.intel.com>
	<20071023180343.GA2624@isilmar.linta.de>
	<20071024212150.GA17504@linux.intel.com>
	<20071025185428.GA1692@isilmar.linta.de>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20071025185428.GA1692@isilmar.linta.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 25, 2007 at 08:54:28PM +0200, Dominik Brodowski wrote:
> Hi Mark,
> 
> On Wed, Oct 24, 2007 at 02:21:50PM -0700, Mark Gross wrote:
> > > On Thu, Oct 04, 2007 at 02:51:39PM -0700, Mark Gross wrote:
> > > What about cpu_throughput{_min,_max}, as being something considered to be
> > > proportional to the CPU frequency? This way, the cpufreq policy notifiers
> > > might be able to utilize the pm_qos infrastructure; but maybe even also the
> > > userspace interface (at least the min freq/max freq one)... Haven't thought
> > > this through, but maybe you (or someone else) has.
> > 
> > I've only thought it though enough to choose to avoid cpufreq
> > interactions.  
> > 
> > Sadly core frequency is not proportional to throughput on X86
> > processors.  I don't know how one would reliably quantify cpu throughput
> > in this context, other than defining latencies.  
> 
> Well it's not exactly throughput, but the CPU frequency surely has an
> influence on it and also affects the quality of the service provided...

This is true.  I just worry going down this path would be a rat-hole.

FWIW I suppose one could use define bogo-mips as the throughput
parameter and use that as away for a CPUFREQ driver to use a way to
constrain the throttling.  This way if an application that knows it
needs higher throughputs and can't deal with the latencies of the
governor changing core voltage and frequencies, it could register itself
to PM_QOS.

In theory this could open a window to more aggressive governor policies
for saving power.   I can see how that could work well for specific
workloads but not so much for desktop / general purpose workloads..  

> 
> > I could see something like this to prevent cpufreq throttling at bad
> > times, but how common of an issue is this any more?  
> 
> Hopefully none :) I was just wondering whether this generalization would
> make sense in the big scheme of things (i.e. grand plan of unified power
> management)...
> 

Maybe you are right. 

Is there interest in anyone creating a new, or enhanced CPUFREQ governor
that takes advantage of a PM_QOS bogo-mips throughput parameter to limit
how low of a P-state to drop into?

If so I'd be happy to work with you to see what we can accomplish.


--mgross
