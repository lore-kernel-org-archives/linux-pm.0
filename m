From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch/rft 2.6.17-rc5-git 1/6] fix broken/dubious
	driver suspend() methods
Date: Tue, 6 Jun 2006 17:53:03 -0700
Message-ID: <200606061753.03220.david-b@pacbell.net>
References: <200604241429.52022.david-b@pacbell.net>
	<200606050936.28224.david-b@pacbell.net>
	<20060530191140.GA4017@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060530191140.GA4017@ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 30 May 2006 12:11 pm, Pavel Machek wrote:
> Hi!
> =

> > Small driver suspend() updates in preparation for the upcoming FREEZE m=
essage;
> > =

> >  - Only compare message events for equality against PM_EVENT_* codes;
> >    not against integers, or using greater/less-than comparisons.
> >    (PM_EVENT_* should really become a __bitwise thing.)
> > =

> >  - Explicitly test for SUSPEND events (rather than not-something-else)
> >    before suspending devices.
> > =

> >  - Removes more of the confusion between a pm_message_t (wraps event co=
de)
> >    and a "state" ... suspend() originally took a target system state.
> > =

> > These updates are correct and appropriate even without new PM_EVENT cod=
es.
> > ---
> >  drivers/ide/ppc/pmac.c                  |   14 ++++++++------
> >  drivers/media/dvb/cinergyT2/cinergyT2.c |    2 +-
> >  drivers/scsi/libata-core.c              |    6 +++---
> >  drivers/scsi/mesh.c                     |    7 ++++---
> >  4 files changed, 16 insertions(+), 13 deletions(-)
> =

> ACK. (You probably want to add s-o-b: header, and not send changelog
> twice.)

I'll forward this to Andrew for 2.6.18 then ... was holding off
on the signed-off-by pending feedback.  Changelog sent twice to
make sure that the linux-pm archives are readable.  :)

- Dave
