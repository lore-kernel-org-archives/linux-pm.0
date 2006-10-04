From: "Scott E. Preece" <preece@motorola.com>
Subject: Re: [RFC] OMAP1 PM Core, PM Core  Implementation 2/2
Date: Wed, 4 Oct 2006 16:33:46 -0500 (CDT)
Message-ID: <200610042133.k94LXkDq016761@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-reply-to: Pavel Machek's message of Wed, 4 Oct 2006 23:25:45 +0200
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: pavel@ucw.cz
Cc: shd@zakalwe.fi, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, ext-Tuukka.Tikkanen@nokia.com
List-Id: linux-pm@vger.kernel.org


| From: Pavel Machek<pavel@ucw.cz>
| =

| Hi!
| =

| > | > > > +static long =

| > | > > > +get_vtg(const char *vdomain)
| > | > > > +{
| > | > > > +	long ret =3D 0;
| > | > > =

| > | > > Unnecessary initialisation.
| > | > =

| > | > No, sorry.
| > | =

| > | In get_vtg(), if VOLTAGE_FRAMEWORK is defined then
| > | =

| > | 	ret =3D vtg_get_voltage(v);
| > | =

| > | is the first user. If VOLTAGE_FRAMEWORK is not defined, the first use=
r is:
| > | =

| > | 	ret =3D vtg_get_voltage(&vhandle);
| > | =

| > | Then "return ret;" follows. I cannot see a path where =

| > | pre-initialisation of ret does anything useful. If someone removed the
| > | #else part, the compiler would bark.
| > ---
| > =

| > True, but a good compiler should remove the dead initialization...
| =

| True, but efficient code is only one of constraints. Code should be
| easy to read, too.
| 								Pavel
| -- =

| (english) http://www.livejournal.com/~pavelmachek
| (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html

[Ironically, I was going to say "I think this dead horse has been
sufficiently beaten, but then I saw the picture reference in Pavel's
signature and decided that would be rude!]

I agree - the initialization is unneeded. However, it's also mostly
harmless...

scott

-- =

scott preece
motorola mobile devices, il67, 1800 s. oak st., champaign, il  61820  =

e-mail:	preece@motorola.com	fax:	+1-217-384-8550
phone:	+1-217-384-8589	cell: +1-217-433-6114	pager: 2174336114@vtext.com
