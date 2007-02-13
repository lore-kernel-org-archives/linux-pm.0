From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] power management: no valid states w/o	pm_ops
	+ docs
Date: Tue, 13 Feb 2007 18:36:24 +0100
Message-ID: <1171388184.10344.55.camel@johannes.berg>
References: <1171383980.10344.39.camel@johannes.berg>
	<20070213092357.7ea02880.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0381324702=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20070213092357.7ea02880.randy.dunlap@oracle.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-pm <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


--===============0381324702==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-nd1TVbx/IDf1/923b3JP"


--=-nd1TVbx/IDf1/923b3JP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-02-13 at 09:23 -0800, Randy Dunlap wrote:
> On Tue, 13 Feb 2007 17:26:20 +0100 Johannes Berg wrote:
>=20
> > This patch changes /sys/power/state to not advertise any valid states
> > (except for disk if SOFTWARE_SUSPEND is enabled) when no pm_ops have be=
en
> > set so userspace can easily discover what states should be available.
> >=20
> > Also, because the pm ops in powermac are obviously not using them as
> > intended, I added documentation for it in kernel-doc format.
>=20
> Thanks... but it's not quite in kernel-doc format.

Hmm ok :)

> Did you test it?

Yes! The output (in html) looked fine to me.

> > +/**
> > + * struct pm_ops
> > + *
> > + * Callbacks for managing platform dependent suspend states.
> > + *
>=20
>  * struct pm_ops - callbacks for managing platform-dependent suspend stat=
es

But then the description "callbacks for ..." disappears completely in
the HTML output! Should I duplicate it or something?

> > + * @valid: Callback to determine whether the given state can be entere=
d.
> > + *         If %CONFIG_SOFTWARE_SUSPEND is set then %PM_SUSPEND_DISK is
> > + *         always valid and never passed to this call.
> > + *         If not assigned, all suspend states are advertised as valid
> > + *         in /sys/power/state (but can still be rejected by prepare o=
r enter.)
> > + * @prepare: Prepare the platform for the given suspend state. Can ret=
urn a
> > + *           negative error code if necessary.
> > + * @enter: Enter the given suspend state, must be assigned. Can return=
 a
> > + *         negative error code if necessary.
> > + * @finish: Called when the system has left the given state and all de=
vices
> > + *          are resumed. The return value is ignored.
> > + * @pm_disk_mode: Set to the disk method that the user should be able =
to
> > + *                configure for suspend-to-disk. Since %PM_DISK_SHUTDO=
WN,
> > + *                %PM_DISK_REBOOT, %PM_DISK_TEST and %PM_DISK_TESTPROC
> > + *                are always allowed, currently only %PM_DISK_PLATFORM
> > + *                makes sense. If the user then choses %PM_DISK_PLATFO=
RM,
> > + *                the @prepare call will be called before suspending t=
o disk
> > + *                (if present), the @enter call should be present and =
will
> > + *                be called after all state has been saved and the mac=
hine
> > + *                is ready to be shut down/suspended/..., and the @fin=
ish
> > + *                callback is called after state has been restored. Al=
l
> > + *                these calls are called with %PM_SUSPEND_DISK as the =
state.
>=20
> We usually just indent the following lines the same for all function
> parameters or struct members.

So I should indent them to the deepest indent I have like this?

 @x:         description for x
             in two lines
 @verylong:  description for verylong
             in two lines

Thanks,
Johannes

--=-nd1TVbx/IDf1/923b3JP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBF0fcX/ETPhpq3jKURApI7AKCd7mQk6F4V65JreDHpCHrtSWmkvACgo7lM
GQYBhLwmf5I4zZzlmyvvtX4=
=MlXB
-----END PGP SIGNATURE-----

--=-nd1TVbx/IDf1/923b3JP--


--===============0381324702==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0381324702==--
