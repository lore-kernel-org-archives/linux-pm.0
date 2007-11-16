From: Mark Lord <lkml@rtr.ca>
Subject: Re: [BUG] Strange 1-second pauses during Resume-from-RAM
Date: Fri, 16 Nov 2007 14:06:50 -0500
Message-ID: <473DEA4A.2030606__1270.1369626031$1195240090$gmane$org@rtr.ca>
References: <4739ADA2.4060604@rtr.ca>
	<alpine.LFD.0.9999.0711131521590.3265@localhost.localdomain>
	<4739E347.30406@rtr.ca> <473C7495.40805@rtr.ca>
	<20071115181418.GA6603@ucw.cz> <473C825E.3030307@rtr.ca>
	<20071115193424.GA31691@elte.hu> <20071115193612.GA751@elte.hu>
	<473CC6D4.2010909@rtr.ca> <20071116055531.GA16273@elte.hu>
	<20071116071522.GA1453@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20071116071522.GA1453@elte.hu>
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
Cc: len.brown@intel.com, linux-kernel@vger.kernel.org, Mark Lord <liml@rtr.ca>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
>>> Is there a version of these that works with 2.6.23.1 ?
>> yes, i've backported it and have uploaded the v2.6.23 version to:
>>
>>   http://redhat.com/~mingo/latency-tracing-patches/latency-tracer-v2.6.23.1-combo.patch
..

> ok, i experimented around with the latency tracer, trying to capture the 
> trace of a full suspend+resume cycle, and it needed the tracer fix below 
> (GTOD clocksource suspend/resume would otherwise confuse the tracer and 
> you'd get no trace output as a result).
> 
> once that tracer bug was fixed, the best method to generate a trace was 
> to do this:
> 
>    echo 1 > /proc/sys/kernel/stackframe_tracing
>    echo 1 > /proc/sys/kernel/syscall_tracing
>    ./trace-cmd bash -c "echo mem > /sys/power/state" > trace.txt
..

I've applied the tracer for 2.6.23.1 patch, plus the bugfix,
and now I just get blinking-LEDs (black screen of death) on resume.

Cheers
