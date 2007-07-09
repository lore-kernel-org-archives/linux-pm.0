From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Mon, 9 Jul 2007 11:23:56 +0200
Message-ID: <200707091123.57400.oliver__34526.5975491658$1183973179$gmane$org@neukum.org>
References: <Pine.LNX.4.44L0.0707081517540.11049-100000@netrider.rowland.org>
	<200707090847.43378.oliver@neukum.org>
	<1183972420.5961.26.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1183972420.5961.26.camel@localhost.localdomain>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org, Kyle Moffett <mrmacman_g4@mac.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Am Montag, 9. Juli 2007 schrieb Benjamin Herrenschmidt:
> On Mon, 2007-07-09 at 08:47 +0200, Oliver Neukum wrote:
> > Am Sonntag, 8. Juli 2007 schrieb Benjamin Herrenschmidt:
> > > > But I'm not sure it's a good idea in the long run. =C2=A0Think of=
 a printer=20
> > > > daemon, for example. =C2=A0It shouldn't have to experience unexpe=
cted I/O=20
> > > > problems merely because someone has decided to put the system to =
sleep.
> > >=20
> > > Why not ? Printer is offline when machine is asleep... trying to pr=
int
> >=20
> > Not necessarily. The machine must survive going to sleep while you ar=
e
> > printing. Any other error return than -ERESTARTSYS is not an option.
> > We can't simply change the ABI.
>=20
> Ugh ? Why returning an error from the printer driver to the userland
> print server/daemon would prevent the machine from "surviving" ? I woul=
d
> be happy with -EIO personally :-)

Surviving is a bit strongly worded.

Suspension is to be transparent. Apart from a jump in the system clock
user space must not notice, thus returning errors due to suspension is
not an option.

	Regards
		Oliver
