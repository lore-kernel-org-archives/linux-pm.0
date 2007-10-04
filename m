From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [linux-usb-devel] Re: The evilness of struct
	usb_device->auto_pm
Date: Thu, 4 Oct 2007 12:05:38 +0200
Message-ID: <200710041205.38967.oliver__11361.0288048678$1191492446$gmane$org@neukum.org>
References: <200709281712.35721.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0709281109170.4062-100000@iolanthe.rowland.org>
	<20071001183524.GA4558@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20071001183524.GA4558@ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.linux-foundation.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

Am Montag 01 Oktober 2007 schrieb Pavel Machek:
> > > I guess that the SCSI layer is not really autosuspend-aware, is it?
> >=20
> > Not yet. =A0I would like it to become autosuspend-aware. =A0Oliver wa=
nts to
> > avoid that by keeping all the awareness in usb-storage. =A0(But then =
what
> > about all the other SCSI host-adapter drivers? =A0Will they each have
> > their own way of deciding when a SCSI device can be suspended?)
>=20
> I think I'd prefer to have autosuspending in SCSI layer. That way, we
> should be able to handle automatic disk spindowns nicely...

OK, so this is the consensus. Then the question arises, how does a
driver learn that all it's children have gone into autosuspend?

	Regards
		Oliver
