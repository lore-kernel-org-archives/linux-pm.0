From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] remove software_suspend() and fix compile w/
	SOFTWARE_SUSPEND disabled
Date: Sun, 25 Mar 2007 21:53:09 +0200
Message-ID: <20070325195309.GA16378@elf.ucw.cz>
References: <1174571192.32051.5.camel@johannes.berg>
	<20070325163417.GB9958@ucw.cz>
	<1174846713.20440.32.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1174846713.20440.32.camel@johannes.berg>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > > @@ -60,7 +60,7 @@ acpi_system_write_sleep(struct file *fil
> > >  	state =3D simple_strtoul(str, NULL, 0);
> > >  #ifdef CONFIG_SOFTWARE_SUSPEND
> > >  	if (state =3D=3D 4) {
> > > -		error =3D software_suspend();
> > > +		error =3D pm_suspend(PM_SUSPEND_DISK);
> > >  		goto Done;
> > >  	}
> > =

> > Is enter_state and pm_suspend equivalent? Why the change?
> =

> Yeah, except that enter_state() has more argument checking. The change
> was just because I didn't see much point in having two entry points for
> the same thing and killed off software_suspend() completely. Don't
> really care.

Okay, then. ACK.
								Pavel

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
