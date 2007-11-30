From: =?utf-8?B?SsO2cm4=?= Engel <joern@logfs.org>
Subject: Re: [BUG] Strange 1-second pauses during Resume-from-RAM
Date: Fri, 30 Nov 2007 16:49:37 +0100
Message-ID: <20071130154936.GB30773__29153.9062899121$1196438263$gmane$org@lazybastard.org>
References: <4739ADA2.4060604@rtr.ca>
	<alpine.LFD.0.9999.0711131521590.3265@localhost.localdomain>
	<4739E347.30406@rtr.ca> <473C7495.40805@rtr.ca>
	<20071115181418.GA6603@ucw.cz> <473C825E.3030307@rtr.ca>
	<20071115193424.GA31691@elte.hu> <20071115193612.GA751@elte.hu>
	<20071130125628.GA30773@lazybastard.org>
	<20071130133546.GB29679@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20071130133546.GB29679@elte.hu>
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

On Fri, 30 November 2007 14:35:46 +0100, Ingo Molnar wrote:
> * J=C3=B6rn Engel <joern@logfs.org> wrote:
> >=20
> > kernel/sched.c:3384: warning: =E2=80=98struct prio_array=E2=80=99 dec=
lared inside parameter list
> > kernel/sched.c:3384: warning: its scope is only this definition or de=
claration, which is probably not what you want
> > kernel/sched.c: In function =E2=80=98trace_array=E2=80=99:
> > kernel/sched.c:3391: error: dereferencing pointer to incomplete type
> > kernel/sched.c:3393: error: dereferencing pointer to incomplete type
> > kernel/sched.c:3393: error: dereferencing pointer to incomplete type
> > kernel/sched.c:3396: error: dereferencing pointer to incomplete type
> > kernel/sched.c:3396: error: dereferencing pointer to incomplete type
> > kernel/sched.c: In function =E2=80=98trace_all_runnable_tasks=E2=80=99=
:
> > kernel/sched.c:3407: error: =E2=80=98struct rq=E2=80=99 has no member=
 named =E2=80=98active=E2=80=99
> > make[1]: *** [kernel/sched.o] Error 1
> >=20
> > And I cannot find a definition of struct prio_array in current git
> > either.  Is another patch needed?
>=20
> change that to rt_prio_array in the code.

Solves the prio_array problem, but leaves the non-existing member
active.  I've upgraded to -rc3 and will give your latest patch a whirl.

J=C3=B6rn

--=20
Write programs that do one thing and do it well. Write programs to work
together. Write programs to handle text streams, because that is a
universal interface.
-- Doug MacIlroy
