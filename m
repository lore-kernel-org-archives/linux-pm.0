From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [BUG] Strange 1-second pauses during Resume-from-RAM
Date: Sun, 2 Dec 2007 14:57:11 +0100
Message-ID: <20071202135711.GA20434__25933.5643997931$1196603929$gmane$org@elte.hu>
References: <20071130134312.GA32273@elte.hu>
	<20071130183510.GA1570@lazybastard.org>
	<20071130184625.GB9928@elte.hu>
	<20071201151650.GA5031@lazybastard.org>
	<20071201183256.GA14052@elte.hu>
	<20071201204747.GA6458@lazybastard.org>
	<20071201205456.GA8231@elte.hu>
	<20071201234112.GA7209@lazybastard.org>
	<20071202085607.GA28966@elte.hu>
	<20071202113143.GA9378@lazybastard.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20071202113143.GA9378@lazybastard.org>
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

> On Sun, 2 December 2007 09:56:08 +0100, Ingo Molnar wrote:
> > * J=F6rn Engel <joern@logfs.org> wrote:
> >=20
> > > > ah. You should mark pit_read() function as notrace. PIT clocksour=
ce=20
> > > > is rare. (add the 'notrace' word to the function prototype)
> > >=20
> > > Hardly a change at all.  Apart from some offsets, this dump is=20
> > > identical.
> > >=20
> > > stopped custom tracer.
> > > BUG: spinlock recursion on CPU#0, sh/954
> > >  lock: c030f280, .magic: dead4ead, .owner: sh/954, .owner_cpu: 0
> > > Pid: 954, comm: sh Not tainted 2.6.24-rc3-ge1cca7e8-dirty #3
> > >  [<c0103a04>] show_trace_log_lvl+0x35/0x54
> > >  [<c010450a>] show_trace+0x2c/0x2e
> > >  [<c0104e6d>] dump_stack+0x84/0x8a
> > >  [<c01ded7c>] spin_bug+0xa7/0xae
> > >  [<c01def14>] _raw_spin_lock+0x45/0xfa
> > >  [<c02a02b1>] _spin_lock_irqsave+0x68/0x7a
> > >  [<c01087e2>] pit_read+0xf/0x91
> > >  [<c0130ee1>] get_monotonic_cycles+0xf/0x2d
> > >  [<c013c0e7>] now+0x2a/0x7c
> > >  [<c013c333>] ____trace+0x4d/0x1e8
> > >  [<c013dbeb>] __mcount+0x95/0xa6
> > >  [<c010d354>] mcount+0x14/0x18
> > >  [<c0135a3c>] lock_acquired+0xe/0x1d7
> > >  [<c02a02b9>] _spin_lock_irqsave+0x70/0x7a
> > >  [<c01087e2>] pit_read+0xf/0x91
> >=20
> > hm, it seems lock_acquired() [in kernel/lockdep.c] needs to be marked=
=20
> > 'notrace' too - otherwise we recurse back into pit_read().
>=20
> This time not even the offsets have changed.  Dump is identical.

hm, do you have CONFIG_FRAME_POINTERS=3Dy, i.e. are the dumps reliable?

	Ingo
