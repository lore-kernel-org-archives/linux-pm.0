From: =?utf-8?B?SsO2cm4=?= Engel <joern@logfs.org>
Subject: Re: [BUG] Strange 1-second pauses during Resume-from-RAM
Date: Sat, 1 Dec 2007 16:16:50 +0100
Message-ID: <20071201151650.GA5031__42489.0662231066$1196531473$gmane$org@lazybastard.org>
References: <473C7495.40805@rtr.ca> <20071115181418.GA6603@ucw.cz>
	<473C825E.3030307@rtr.ca> <20071115193424.GA31691@elte.hu>
	<20071115193612.GA751@elte.hu>
	<20071130125628.GA30773@lazybastard.org>
	<20071130133546.GB29679@elte.hu> <20071130134312.GA32273@elte.hu>
	<20071130183510.GA1570@lazybastard.org>
	<20071130184625.GB9928@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20071130184625.GB9928@elte.hu>
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
Cc: len.brown@intel.com, =?utf-8?B?SsO2cm4=?= Engel <joern@logfs.org>, linux-kernel@vger.kernel.org, Mark Lord <liml@rtr.ca>, Mark Lord <lkml@rtr.ca>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 30 November 2007 19:46:25 +0100, Ingo Molnar wrote:
> * J=C3=B6rn Engel <joern@logfs.org> wrote:
> >=20
> > It compiles.  It boots with a 512M RAM (384M was too little with all
> > the other debug options on).  But it seems to lock up when running
> > trace-cmd.  On a rerun it locks up again, but with different output.
>=20
> hm, you should decrease MAX_TRACE in kernel/latency_tracing.c from 1=20
> million to 16K or so. 1 million entries probably depletes lowmem quite=20
> seriously.

That's ok.  RAM is cheap.

> > Rerun was captured:
> > http://logfs.org/~joern/trace1.jpg
>=20
> hm, that looks weird. if you disable CONFIG_PROVE_LOCKING, does that=20
> improve things? (or just turns a noisy lockup into a silent lockup?)

Not much, although the dumps look different now:
http://logfs.org/~joern/trace3.jpg
http://logfs.org/~joern/trace4.jpg

I have to change my qemu setup a little to see the top of those
dumps...

> > I should do a couple of runs, but my girlfriend claims realtime=20
> > priority for the evening.
>=20
> yeah, SCHED_IDLE is not generally well received by them.

...as soon as more urgent tasks has finished (weekend is over).

J=C3=B6rn

--=20
It does not matter how slowly you go, so long as you do not stop.
-- Confucius
