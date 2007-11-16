From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [BUG] Strange 1-second pauses during Resume-from-RAM
Date: Fri, 16 Nov 2007 08:15:22 +0100
Message-ID: <20071116071522.GA1453__40987.2496886694$1195197511$gmane$org@elte.hu>
References: <4739ADA2.4060604@rtr.ca>
	<alpine.LFD.0.9999.0711131521590.3265@localhost.localdomain>
	<4739E347.30406@rtr.ca> <473C7495.40805@rtr.ca>
	<20071115181418.GA6603@ucw.cz> <473C825E.3030307@rtr.ca>
	<20071115193424.GA31691@elte.hu> <20071115193612.GA751@elte.hu>
	<473CC6D4.2010909@rtr.ca> <20071116055531.GA16273@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20071116055531.GA16273@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Lord <lkml@rtr.ca>
Cc: len.brown@intel.com, linux-kernel@vger.kernel.org, Mark Lord <liml@rtr.ca>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> > Is there a version of these that works with 2.6.23.1 ?
> 
> yes, i've backported it and have uploaded the v2.6.23 version to:
> 
>   http://redhat.com/~mingo/latency-tracing-patches/latency-tracer-v2.6.23.1-combo.patch

btw., if the trace is too large and the interesting section of suspend 
does not fit into it then you can narrow it down to the most important 
events only by changing this in trace-cmd.c:

        system("echo 1 > /proc/sys/kernel/mcount_enabled");

to:

        system("echo 0 > /proc/sys/kernel/mcount_enabled");

that way we'll still trace IRQs and scheduling events, which is enough 
to see roughly where the delay is happening. To include symbolic 
backtraces in the trace, do this:

	echo 1 > /proc/sys/kernel/stackframe_tracing

to get such trace entries:

      ls 3688  1D..3 4642us+: deactivate_task <ls 3688> (0 0)
      ls 3688  1D..3 4644us+: schedule()<-do_exit()<-sys_exit_group()<-sys_exit_group()
      ls 3688  1D..3 4647us+: sysenter_past_esp()<-(   -1)()<-(    0)()<-(    0)()
  <idle> 0     1D..2 4652us : schedule <ls 3688> (0 20)

this way we can see why a task goes to sleep and which exact kernel 
codepath is waking it up.

	Ingo
