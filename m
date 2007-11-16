From: Mike Galbraith <efault@gmx.de>
Subject: Re: [BUG] Strange 1-second pauses during Resume-from-RAM
Date: Fri, 16 Nov 2007 06:53:13 -0500
Message-ID: <1195213993.4037.21.camel__32091.9859376319$1195226771$gmane$org@Knoppix>
References: <4739E347.30406@rtr.ca> <473C7495.40805@rtr.ca>
	<20071115181418.GA6603@ucw.cz> <473C825E.3030307@rtr.ca>
	<20071115193424.GA31691@elte.hu> <20071115193612.GA751@elte.hu>
	<473CC6D4.2010909@rtr.ca> <20071116055531.GA16273@elte.hu>
	<20071116071522.GA1453@elte.hu> <20071116082146.GA14685@elte.hu>
	<20071116112317.GA12724@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20071116112317.GA12724@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: len.brown@intel.com, linux-kernel@vger.kernel.org, Mark Lord <liml@rtr.ca>, Mark Lord <lkml@rtr.ca>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 2007-11-16 at 12:23 +0100, Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > once that tracer bug was fixed, the best method to generate a trace 
> > was to do this:
> > 
> >    echo 1 > /proc/sys/kernel/stackframe_tracing
> >    echo 1 > /proc/sys/kernel/syscall_tracing
> >    ./trace-cmd bash -c "echo mem > /sys/power/state" > trace.txt
> 
> so here's an UP suspend+resume trace i did:
> 
>   http://redhat.com/~mingo/latency-tracing-patches/misc/trace-suspend-long.txt.bz2
> 
> tons of detail - which might be interesting to other folks as well. Fact 
> is, our suspend-to-RAM+resume cycle is very, very slow, even on fast 
> hardware - and this trace shows all the reasons why.
> 
> This was a fully cached system - i.e. i've done a suspend+resume before 
> to warm up the caches. (not that suspend+resume does much IO normally.)
> 
> The trace shows that a suspend+resume cycle is 7.95 seconds long 
> (without counting the time the box spent suspended) - ouch! This was a 
> T60 with Core2Duo 1.83GHz.

Ouch?  That's an order of magnitude faster than my 3GHz P4 :)

	-Mike
