From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-usb-devel] Re: The evilness of struct
	usb_device->auto_pm
Date: Thu, 4 Oct 2007 12:16:43 +0200
Message-ID: <20071004101643.GJ22940__42606.376813683$1191493179$gmane$org@elf.ucw.cz>
References: <200709281712.35721.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0709281109170.4062-100000@iolanthe.rowland.org>
	<20071001183524.GA4558@ucw.cz>
	<200710041205.38967.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200710041205.38967.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-pm@lists.linux-foundation.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

On Thu 2007-10-04 12:05:38, Oliver Neukum wrote:
> Am Montag 01 Oktober 2007 schrieb Pavel Machek:
> > > > I guess that the SCSI layer is not really autosuspend-aware, is i=
t?
> > >=20
> > > Not yet. =A0I would like it to become autosuspend-aware. =A0Oliver =
wants to
> > > avoid that by keeping all the awareness in usb-storage. =A0(But the=
n what
> > > about all the other SCSI host-adapter drivers? =A0Will they each ha=
ve
> > > their own way of deciding when a SCSI device can be suspended?)
> >=20
> > I think I'd prefer to have autosuspending in SCSI layer. That way, we
> > should be able to handle automatic disk spindowns nicely...
>=20
> OK, so this is the consensus. Then the question arises, how does a
> driver learn that all it's children have gone into autosuspend?

atomic_t variable in the parent, with children updating it and calling
parent's callback when it goes to 1->0 and 0->1?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html
