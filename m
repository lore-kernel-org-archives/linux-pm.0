From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [BUG] Strange 1-second pauses during Resume-from-RAM
Date: Fri, 30 Nov 2007 19:46:25 +0100
Message-ID: <20071130184625.GB9928__41470.5875715756$1196448585$gmane$org@elte.hu>
References: <4739E347.30406@rtr.ca> <473C7495.40805@rtr.ca>
	<20071115181418.GA6603@ucw.cz> <473C825E.3030307@rtr.ca>
	<20071115193424.GA31691@elte.hu> <20071115193612.GA751@elte.hu>
	<20071130125628.GA30773@lazybastard.org>
	<20071130133546.GB29679@elte.hu> <20071130134312.GA32273@elte.hu>
	<20071130183510.GA1570@lazybastard.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20071130183510.GA1570@lazybastard.org>
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

> On Fri, 30 November 2007 14:43:12 +0100, Ingo Molnar wrote:
> >=20
> >   http://redhat.com/~mingo/latency-tracing-patches/latency-tracing-v2=
.6.24-rc3.combo.patch
> >=20
> > does it work any better?
>=20
> It compiles.  It boots with a 512M RAM (384M was too little with all
> the other debug options on).  But it seems to lock up when running
> trace-cmd.  On a rerun it locks up again, but with different output.

hm, you should decrease MAX_TRACE in kernel/latency_tracing.c from 1=20
million to 16K or so. 1 million entries probably depletes lowmem quite=20
seriously.

> Rerun was captured:
> http://logfs.org/~joern/trace1.jpg

hm, that looks weird. if you disable CONFIG_PROVE_LOCKING, does that=20
improve things? (or just turns a noisy lockup into a silent lockup?)

> I should do a couple of runs, but my girlfriend claims realtime=20
> priority for the evening.

yeah, SCHED_IDLE is not generally well received by them.

	Ingo
