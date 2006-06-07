From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch/rft 2.6.17-rc5-git 4/6] PM_EVENT_PRETHAW for
	various graphics cards
Date: Tue, 6 Jun 2006 18:24:56 -0700
Message-ID: <200606061824.56755.david-b@pacbell.net>
References: <200604241429.52022.david-b@pacbell.net>
	<200606050938.34988.david-b@pacbell.net>
	<20060530193016.GC4044@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060530193016.GC4044@ucw.cz>
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

On Tuesday 30 May 2006 12:30 pm, Pavel Machek wrote:

> > +	if (mesg.event =3D=3D PM_EVENT_PRETHAW)
> > +		mesg.event =3D PM_EVENT_FREEZE;
> >  ...
> > +	dev->dev.power.power_state =3D mesg;
> =

> If PRETHAW event is sent, we still store FREEZE into power_state. That
> is not consistent with other drivers.

Doesn't matter.  By definition, it's OK for drivers to treat PRETHAW
as FREEZE, when they don't care about that distinction ... plus ISTR
there's no code that _relies_ on that power_state.   Few drivers
even bother setting it ... it's not exactly a useful record.

- Dave
