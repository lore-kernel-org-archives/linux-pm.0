From: =?utf-8?B?SsO2cm4=?= Engel <joern@logfs.org>
Subject: Re: [BUG] Strange 1-second pauses during Resume-from-RAM
Date: Fri, 30 Nov 2007 13:56:28 +0100
Message-ID: <20071130125628.GA30773__45651.5137375847$1196437011$gmane$org@lazybastard.org>
References: <32209efe0711122242m3a5f081asf1c11a38b24db10c@mail.gmail.com>
	<20071113031553.3c7b5c16.akpm@linux-foundation.org>
	<4739ADA2.4060604@rtr.ca>
	<alpine.LFD.0.9999.0711131521590.3265@localhost.localdomain>
	<4739E347.30406@rtr.ca> <473C7495.40805@rtr.ca>
	<20071115181418.GA6603@ucw.cz> <473C825E.3030307@rtr.ca>
	<20071115193424.GA31691@elte.hu> <20071115193612.GA751@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20071115193612.GA751@elte.hu>
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
Cc: len.brown@intel.com, linux-kernel@vger.kernel.org, Mark Lord <liml@rtr.ca>, Mark Lord <lkml@rtr.ca>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 15 November 2007 20:36:12 +0100, Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
>=20
> > pick up the latest latency tracer patch from:
>=20
> sorry, wrong URLs, the correct links are:
>=20
>    http://redhat.com/~mingo/latency-tracing-patches/latency-tracer-v2.6=
.24-rc2-git5-combo.patch
>    http://redhat.com/~mingo/latency-tracing-patches/trace-cmd.c

Don't seem to work with plain 2.6.23:

kernel/sched.c:3384: warning: =E2=80=98struct prio_array=E2=80=99 declare=
d inside parameter list
kernel/sched.c:3384: warning: its scope is only this definition or declar=
ation, which is probably not what you want
kernel/sched.c: In function =E2=80=98trace_array=E2=80=99:
kernel/sched.c:3391: error: dereferencing pointer to incomplete type
kernel/sched.c:3393: error: dereferencing pointer to incomplete type
kernel/sched.c:3393: error: dereferencing pointer to incomplete type
kernel/sched.c:3396: error: dereferencing pointer to incomplete type
kernel/sched.c:3396: error: dereferencing pointer to incomplete type
kernel/sched.c: In function =E2=80=98trace_all_runnable_tasks=E2=80=99:
kernel/sched.c:3407: error: =E2=80=98struct rq=E2=80=99 has no member nam=
ed =E2=80=98active=E2=80=99
make[1]: *** [kernel/sched.o] Error 1

And I cannot find a definition of struct prio_array in current git
either.  Is another patch needed?

J=C3=B6rn

--=20
Time? What's that? Time is only worth what you do with it.
-- Theo de Raadt
