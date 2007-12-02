From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [BUG] Strange 1-second pauses during Resume-from-RAM
Date: Sun, 2 Dec 2007 21:45:59 +0100
Message-ID: <20071202204559.GA28550@elte.hu>
References: <20071201205456.GA8231@elte.hu>
	<20071201234112.GA7209@lazybastard.org>
	<20071202085607.GA28966@elte.hu>
	<20071202113143.GA9378@lazybastard.org>
	<20071202135711.GA20434@elte.hu>
	<20071202141117.GB9516@lazybastard.org>
	<20071202154746.GA27069@elte.hu>
	<20071202195501.GB10657@lazybastard.org>
	<20071202200722.GA12101@elte.hu>
	<20071202203016.GC10657@lazybastard.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20071202203016.GC10657@lazybastard.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@logfs.org>
Cc: len.brown@intel.com, linux-kernel@vger.kernel.org, Mark Lord <liml@rtr.ca>, Mark Lord <lkml@rtr.ca>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


* J=F6rn Engel <joern@logfs.org> wrote:

> > oprofile helps if you can reliably reproduce the slowdown in a loop=20
> > or for a long amount of time, with lots of CPU utilization - and=20
> > then it's also lower overhead. The tracer can be used to capture=20
> > rare or complex events, and gives the full flow control and what is=20
> > happening within the kernel.
>=20
> Such a trace would be useful indeed.  But so far the patch has only=20
> given me grief and nothing remotely like useful output.  Maybe I=20
> should simply use the complete -rt patch instead of debugging the=20
> broken-out latency-tracer patch.

to capture that trace i did not use -rt, i just patched latest -git=20
with:

  http://people.redhat.com/mingo/latency-tracing-patches/latency-tracing-=
v2.6.24-rc3.combo.patch

(this has your fixes included already)

have done:

  echo 1 > /proc/sys/kernel/mcount_enabled

and have run:

  ./trace-cmd sleep 1 > trace.txt

  http://people.redhat.com/mingo/latency-tracing-patches/trace-cmd.c

to capture a 1 second trace of what the system is doing. I think your=20
troubles are due to running it within a qemu guest - that is not a=20
typical utilization so you are on unchartered waters.

	Ingo
