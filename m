From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-usb-devel] Re: The evilness of
	=?iso-8859-1?q?struct=09usb=5Fdevice-?=>auto_pm
Date: Thu, 4 Oct 2007 17:36:21 +0200
Message-ID: <200710041736.21789.rjw__24862.4124950313$1191511582$gmane$org@sisk.pl>
References: <200709281712.35721.rjw@sisk.pl>
	<20071004101643.GJ22940@elf.ucw.cz>
	<200710041227.29817.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200710041227.29817.oliver@neukum.org>
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
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-pm@lists.linux-foundation.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

On Thursday, 4 October 2007 12:27, Oliver Neukum wrote:
> Am Donnerstag 04 Oktober 2007 schrieb Pavel Machek:
> > On Thu 2007-10-04 12:05:38, Oliver Neukum wrote:
> > > Am Montag 01 Oktober 2007 schrieb Pavel Machek:
> > > > > > I guess that the SCSI layer is not really autosuspend-aware, =
is it?
> > > > >=20
> > > > > Not yet. =A0I would like it to become autosuspend-aware. =A0Oli=
ver wants to
> > > > > avoid that by keeping all the awareness in usb-storage. =A0(But=
 then what
> > > > > about all the other SCSI host-adapter drivers? =A0Will they eac=
h have
> > > > > their own way of deciding when a SCSI device can be suspended?)
> > > >=20
> > > > I think I'd prefer to have autosuspending in SCSI layer. That way=
, we
> > > > should be able to handle automatic disk spindowns nicely...
> > >=20
> > > OK, so this is the consensus. Then the question arises, how does a
> > > driver learn that all it's children have gone into autosuspend?
> >=20
> > atomic_t variable in the parent, with children updating it and callin=
g
> > parent's callback when it goes to 1->0 and 0->1?
>=20
> That's a viable proposal, but it means moving part of the autosuspend
> code into the generic model. Are you all okay with that?

I am.

Greetings,
Rafael
