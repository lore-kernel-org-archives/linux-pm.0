From: Mark Gross <mgross@linux.intel.com>
Subject: Re: pm qos and cpufreq interaction [Was: pm qos
	infrastructure and interface]
Date: Wed, 24 Oct 2007 14:21:50 -0700
Message-ID: <20071024212150.GA17504@linux.intel.com>
References: <20071004215139.GA20078@linux.intel.com>
	<20071023180343.GA2624@isilmar.linta.de>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20071023180343.GA2624@isilmar.linta.de>
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

On Tue, Oct 23, 2007 at 08:03:43PM +0200, Dominik Brodowski wrote:
> Hi Mark,
>

Its good to hear from you.  Will you be at the ELC conference in Linz
next week?

> On Thu, Oct 04, 2007 at 02:51:39PM -0700, Mark Gross wrote:
> > Currently we have {cpu_dma_latency, network_latency, network_throughput}
> > as the initial set of pm_qos parameters.
> 
> What about cpu_throughput{_min,_max}, as being something considered to be
> proportional to the CPU frequency? This way, the cpufreq policy notifiers
> might be able to utilize the pm_qos infrastructure; but maybe even also the
> userspace interface (at least the min freq/max freq one)... Haven't thought
> this through, but maybe you (or someone else) has.

I've only thought it though enough to choose to avoid cpufreq
interactions.  

Sadly core frequency is not proportional to throughput on X86
processors.  I don't know how one would reliably quantify cpu throughput
in this context, other than defining latencies.  

I could see something like this to prevent cpufreq throttling at bad
times, but how common of an issue is this any more?  

Are we wasting watts without such information?  Is CPUFREQ still making
some applications behave poorly?  Ondemand and cpufreq are fairly mature
now and I don't hear of such issues any more.  

--mgross
