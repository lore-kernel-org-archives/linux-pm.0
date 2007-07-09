From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Mon, 9 Jul 2007 08:47:42 +0200
Message-ID: <200707090847.43378.oliver__43894.3689609461$1183963897$gmane$org@neukum.org>
References: <Pine.LNX.4.44L0.0707081517540.11049-100000@netrider.rowland.org>
	<1183929611.3388.303.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1183929611.3388.303.camel@localhost.localdomain>
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

Am Sonntag, 8. Juli 2007 schrieb Benjamin Herrenschmidt:
> > But I'm not sure it's a good idea in the long run. =C2=A0Think of a p=
rinter=20
> > daemon, for example. =C2=A0It shouldn't have to experience unexpected=
 I/O=20
> > problems merely because someone has decided to put the system to slee=
p.
>=20
> Why not ? Printer is offline when machine is asleep... trying to print

Not necessarily. The machine must survive going to sleep while you are
printing. Any other error return than -ERESTARTSYS is not an option.
We can't simply change the ABI.

	Regards
		Oliver
