From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: pm qos and cpufreq interaction [Was: pm qos
	infrastructure and interface]
Date: Thu, 25 Oct 2007 20:54:28 +0200
Message-ID: <20071025185428.GA1692@isilmar.linta.de>
References: <20071004215139.GA20078@linux.intel.com>
	<20071023180343.GA2624@isilmar.linta.de>
	<20071024212150.GA17504@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20071024212150.GA17504@linux.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Gross <mgross@linux.intel.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi Mark,

On Wed, Oct 24, 2007 at 02:21:50PM -0700, Mark Gross wrote:
> > On Thu, Oct 04, 2007 at 02:51:39PM -0700, Mark Gross wrote:
> > What about cpu_throughput{_min,_max}, as being something considered to be
> > proportional to the CPU frequency? This way, the cpufreq policy notifiers
> > might be able to utilize the pm_qos infrastructure; but maybe even also the
> > userspace interface (at least the min freq/max freq one)... Haven't thought
> > this through, but maybe you (or someone else) has.
> 
> I've only thought it though enough to choose to avoid cpufreq
> interactions.  
> 
> Sadly core frequency is not proportional to throughput on X86
> processors.  I don't know how one would reliably quantify cpu throughput
> in this context, other than defining latencies.  

Well it's not exactly throughput, but the CPU frequency surely has an
influence on it and also affects the quality of the service provided...

> I could see something like this to prevent cpufreq throttling at bad
> times, but how common of an issue is this any more?  

Hopefully none :) I was just wondering whether this generalization would
make sense in the big scheme of things (i.e. grand plan of unified power
management)...

> Its good to hear from you.  Will you be at the ELC conference in Linz
> next week?

Unfortunately not.

Best,
	Dominik
