From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [BUG] Strange 1-second pauses during Resume-from-RAM
Date: Tue, 4 Dec 2007 10:34:51 +0100
Message-ID: <20071204093451.GA4541__25456.7509437495$1196760997$gmane$org@elte.hu>
References: <20071202141117.GB9516@lazybastard.org>
	<20071202154746.GA27069@elte.hu>
	<20071202195501.GB10657@lazybastard.org>
	<20071202200722.GA12101@elte.hu>
	<20071202203016.GC10657@lazybastard.org>
	<20071202204559.GA28550@elte.hu>
	<20071202211026.GB11522@lazybastard.org>
	<20071202211900.GB7439@elte.hu>
	<20071203005702.GA12215@lazybastard.org>
	<20071204000655.GA17212@lazybastard.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20071204000655.GA17212@lazybastard.org>
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

> On Mon, 3 December 2007 01:57:02 +0100, J=F6rn Engel wrote:
> >=20
> > After an eternity of compile time, this config does generate some use=
ful
> > output.  qemu is not to blame.
>=20
> Or is it?  The output definitely looks suspicious.  Large amounts of=20
> code get processed within a microsecond, while update_wall_time()=20
> appears to cause huge delays every time it is called:=20
> http://logfs.org/~joern/trace
>=20
> Does this output make sense or does it rather indicate some sloppiness=20
> wrt. time in the qemu virtual machine?

not sure. It could be qemu being scheduled away? You could try to run=20
qemu with nice -20 or so, to avoid getting preempted. If time lapses=20
like this still show up:

 trace-cm 434   0D.h. 1008us!: do_timer (tick_periodic)
 trace-cm 434   0D.h. 1972us+: update_wall_time (do_timer)

 trace-cm 434   0D.h. 1008us!: do_timer (tick_periodic)
 trace-cm 434   0D.h. 1972us+: update_wall_time (do_timer)

then that could indicate a timekeeping weirdness, OR it could mean that=20
qemu is simply very slow. (there could be timer hw access between those=20
two function calls)

	Ingo
