From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [BUG] Strange 1-second pauses during Resume-from-RAM
Date: Sun, 2 Dec 2007 16:47:46 +0100
Message-ID: <20071202154746.GA27069__14690.5421898284$1196610555$gmane$org@elte.hu>
References: <20071130184625.GB9928@elte.hu>
	<20071201151650.GA5031@lazybastard.org>
	<20071201183256.GA14052@elte.hu>
	<20071201204747.GA6458@lazybastard.org>
	<20071201205456.GA8231@elte.hu>
	<20071201234112.GA7209@lazybastard.org>
	<20071202085607.GA28966@elte.hu>
	<20071202113143.GA9378@lazybastard.org>
	<20071202135711.GA20434@elte.hu>
	<20071202141117.GB9516@lazybastard.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20071202141117.GB9516@lazybastard.org>
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

> I do.  Went through 10odd runs and annotated the function right below=20
> mcount each time.  Seems to work now.
>=20
> Trouble is that it doesn't solve my real problem at hand.  Something=20
> is causing significant delays when writing to logfs.  Core logfs code=20
> is not running, but may cause whatever other code is running and=20
> burning up all the cpu time.  Wasting 100ms of "qemu-time" to write a=20
> single page happens fairly frequently.
>=20
> With the latency tracer the problem appears to have become worse.  Now=20
> the loftlockup code triggers quite frequently.  Which makes a bit of=20
> sense, as the problem is a busy CPU, rather than an idle one.

well what does the trace say, where do the delays come from? To get a=20
quick overview you can make tracing lighter weight by doing:

 echo 0 > /proc/sys/kernel/mcount_enabled
 echo 1 > /proc/sys/kernel/trace_syscalls

(this turns the latency tracer into a "global strace" kind of tracer)

	Ingo
