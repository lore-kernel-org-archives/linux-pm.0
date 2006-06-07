From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch/rft 2.6.17-rc5-git 3/6] PM_EVENT_PRETHAW,
	handle in IDE and PCI
Date: Tue, 6 Jun 2006 17:51:26 -0700
Message-ID: <200606061751.26856.david-b@pacbell.net>
References: <200604241429.52022.david-b@pacbell.net>
	<200606050938.23356.david-b@pacbell.net>
	<20060530192108.GA4044@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060530192108.GA4044@ucw.cz>
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
To: linux-pm@lists.osdl.org
Cc: Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Tuesday 30 May 2006 12:21 pm, Pavel Machek wrote:
> Hi!
> =

> > @@ -1227,7 +1227,9 @@ static int generic_ide_suspend(struct de
> >  	rq.special =3D &args;
> >  	rq.pm =3D &rqpm;
> >  	rqpm.pm_step =3D ide_pm_state_start_suspend;
> > -	rqpm.pm_state =3D state.event;
> > +	if (mesg.event =3D=3D PM_EVENT_PRETHAW)
> > +		mesg.event =3D PM_EVENT_FREEZE;
> > +	rqpm.pm_state =3D mesg.event;
> > =

> =

> Actually it would be nicer not to modify mesg.event... And perhaps I'd =

> move this check lower -- to be consistent with 'low level driver gets
> full info' idea.

Instead, it's consistent with the "smallest obviously correct patch"
principle.  Didn't want to end up overhauling IDE, especially since it
doesn't seem to be a class  where resume() does anything interesting.


> (Or is it checked at too many places?) =


Notice that "rqpm.pm_state" confusion ... it's checked indirectly
from there.  Event codes are not states. =
