From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [BUG] Strange 1-second pauses during Resume-from-RAM
Date: Sat, 1 Dec 2007 21:54:56 +0100
Message-ID: <20071201205456.GA8231__6161.43816519088$1196542584$gmane$org@elte.hu>
References: <20071115193424.GA31691@elte.hu> <20071115193612.GA751@elte.hu>
	<20071130125628.GA30773@lazybastard.org>
	<20071130133546.GB29679@elte.hu> <20071130134312.GA32273@elte.hu>
	<20071130183510.GA1570@lazybastard.org>
	<20071130184625.GB9928@elte.hu>
	<20071201151650.GA5031@lazybastard.org>
	<20071201183256.GA14052@elte.hu>
	<20071201204747.GA6458@lazybastard.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20071201204747.GA6458@lazybastard.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: J??rn Engel <joern@logfs.org>
Cc: len.brown@intel.com, linux-kernel@vger.kernel.org, Mark Lord <liml@rtr.ca>, Mark Lord <lkml@rtr.ca>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


* J??rn Engel <joern@logfs.org> wrote:

> Almost.  "-serial stdio" was missing.  Much better now.
> 
> stopped custom tracer.
> BUG: spinlock recursion on CPU#0, sh/953
>  lock: c030f280, .magic: dead4ead, .owner: sh/953, .owner_cpu: 0
> Pid: 953, comm: sh Not tainted 2.6.24-rc3-ge1cca7e8-dirty #2
>  [<c0103a04>] show_trace_log_lvl+0x35/0x54
>  [<c010450a>] show_trace+0x2c/0x2e
>  [<c0104e6d>] dump_stack+0x84/0x8a
>  [<c01ded7c>] spin_bug+0xa7/0xae
>  [<c01def14>] _raw_spin_lock+0x45/0xfa
>  [<c02a02b1>] _spin_lock_irqsave+0x68/0x7a
>  [<c01087e7>] pit_read+0x14/0x99
>  [<c0130ee9>] get_monotonic_cycles+0xf/0x2d

ah. You should mark pit_read() function as notrace. PIT clocksource is 
rare. (add the 'notrace' word to the function prototype)

	Ingo
