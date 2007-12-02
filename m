From: =?utf-8?B?SsO2cm4=?= Engel <joern@logfs.org>
Subject: Re: [BUG] Strange 1-second pauses during Resume-from-RAM
Date: Sun, 2 Dec 2007 21:30:16 +0100
Message-ID: <20071202203016.GC10657__32243.2617344477$1196627816$gmane$org@lazybastard.org>
References: <20071201204747.GA6458@lazybastard.org>
	<20071201205456.GA8231@elte.hu>
	<20071201234112.GA7209@lazybastard.org>
	<20071202085607.GA28966@elte.hu>
	<20071202113143.GA9378@lazybastard.org>
	<20071202135711.GA20434@elte.hu>
	<20071202141117.GB9516@lazybastard.org>
	<20071202154746.GA27069@elte.hu>
	<20071202195501.GB10657@lazybastard.org>
	<20071202200722.GA12101@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20071202200722.GA12101@elte.hu>
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

On Sun, 2 December 2007 21:07:22 +0100, Ingo Molnar wrote:
> * J=C3=B6rn Engel <joern@logfs.org> wrote:
>=20
> > Result looked like a livelock and finally convinced me to abandon the=
=20
> > latency tracer.  Sorry, but it appears to be the right tool for the=20
> > wrong job.
>=20
> hm, we routinely use it in -rt to capture "what on earth is happening"=20
> incidents. The snippet below is a random snipped from a trace that i've=
=20
> just captured, with mcount enabled. It seems to work fine here, with an=
d=20
> without mcount. (pit clocksource is almost never used, that's why you=20
> had those early problems.)
>=20
> oprofile helps if you can reliably reproduce the slowdown in a loop or=20
> for a long amount of time, with lots of CPU utilization - and then it's=
=20
> also lower overhead. The tracer can be used to capture rare or complex=20
> events, and gives the full flow control and what is happening within th=
e=20
> kernel.

Such a trace would be useful indeed.  But so far the patch has only
given me grief and nothing remotely like useful output.  Maybe I should
simply use the complete -rt patch instead of debugging the broken-out
latency-tracer patch.

J=C3=B6rn

--=20
Mundie uses a textbook tactic of manipulation: start with some
reasonable talk, and lead the audience to an unreasonable conclusion.
-- Bruce Perens
