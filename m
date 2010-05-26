From: Florian Mickler <florian@mickler.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Wed, 26 May 2010 12:02:42 +0200
Message-ID: <20100526120242.5c9b73ad__28486.6320355379$1274868307$gmane$org@schatten.dmk.lab>
References: <1274482015-30899-1-git-send-email-arve@android.com>
	<201005242049.18920.rjw@sisk.pl>
	<87wrusvrqe.fsf@deeprootsystems.com>
	<201005250138.16293.rjw@sisk.pl> <1274863655.5882.4875.camel@twins>
	<AANLkTinN6MKvCEhPkbYQRD2gu-mGXdNW9asRsTuKN3_Y@mail.gmail.com>
	<1274867106.5882.5090.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1274867106.5882.5090.camel@twins>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Paul@smtp1.linux-foundation.org, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 26 May 2010 11:45:06 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, 2010-05-26 at 02:41 -0700, Arve Hj=F8nnev=E5g wrote:
> > On Wed, May 26, 2010 at 1:47 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
> > > On Tue, 2010-05-25 at 01:38 +0200, Rafael J. Wysocki wrote:
> > >> > This of course will lead to a scattering of suspend blockers into =
any
> > >> > drivers/subsystems considered "useful", which by looking through c=
urrent
> > >> > Android kernels is many of them.
> > >>
> > >> That depends on the maintainers of these subsystems, who still have =
the power
> > >> to reject requested changes.
> > >
> > > So as a scheduler maintainer I'm going to merge a patch that does a
> > > suspend_blocker when the runqueue's aren't empty... how about that?
> > >
> > =

> > I don't know if you are serious, since the all the runqueues are never
> > empty while suspending, this would disable opportunistic suspend
> > altogether.
> =

> So why again was this such a great scheme? Go fix your userspace to not
> not run when not needed.

Hi Peter!

This was already mentioned in one of these threads. =


The summary is: The device this kernel is running on dosn't want to
(or can) rely on userspace to save power. This is because it is an open
system, without an app-store or the like. Everyone can run what he
wants.

So anything relying on (all) userspace solves a different problem.

Cheers,
Flo




> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> =
