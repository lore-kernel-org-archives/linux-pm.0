From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [BUG] Strange 1-second pauses during Resume-from-RAM
Date: Thu, 15 Nov 2007 20:34:24 +0100
Message-ID: <20071115193424.GA31691__8655.58968293971$1195168413$gmane$org@elte.hu>
References: <32209efe0711122242m3a5f081asf1c11a38b24db10c@mail.gmail.com>
	<20071113031553.3c7b5c16.akpm@linux-foundation.org>
	<4739ADA2.4060604@rtr.ca>
	<alpine.LFD.0.9999.0711131521590.3265@localhost.localdomain>
	<4739E347.30406@rtr.ca> <473C7495.40805@rtr.ca>
	<20071115181418.GA6603@ucw.cz> <473C825E.3030307@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <473C825E.3030307@rtr.ca>
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


* Mark Lord <lkml@rtr.ca> wrote:

>> Can you try nohz=off highres=off? Strange stuff is happening with 
>> nohz.
>
> (added Ingo to CC: list: maybe this is some weird interaction with CFS 
> and jiffies being reset to 0 on resume ??)

hm, CFS should have no impact here. To see what's happening you could 
try to use the latency tracer of the -rt patch and do a cross-resume 
trace.

pick up the latest latency tracer patch from:

  http://redhat.com/~mingo/private/latency-tracer-v2.6.24-rc2-git5-combo.patch

apply it and enable CONFIG_FUNCTION_TRACING, then pick up trace-cmd.c:

  http://redhat.com/~mingo/private/trace-cmd.c

and do something like:

  ./trace-cmd pm-suspend > trace.txt

or:

  ./trace-cmd /bin/bash -c "echo ram > /sys/power/state" > trace.txt

this should trigger suspend - then you should do the resume. If 
everything goes well then trace.txt should contain a pretty large trace 
of all the stuff we do during a suspend+resume.

and wait for such a pause and send us the resulting trace.txt.

if it's an SMP box then first do:

  echo 1 > /proc/sys/kernel/trace_all_cpus

to get a global trace. Let me know if something doesnt work with this 
scheme.

	Ingo
