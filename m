From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: /sys/power/state contents
Date: Tue, 02 May 2006 10:02:35 +0200
Message-ID: <1146556955.27351.68.camel@localhost>
References: <1146300258.5019.16.camel@localhost>
	<200605011531.00656.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============71394862292073835=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200605011531.00656.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


--===============71394862292073835==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-20ZeTWBAMjYk9iSln2ze"


--=-20ZeTWBAMjYk9iSln2ze
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-05-01 at 15:31 -0700, David Brownell wrote:
> > and not use the ->valid call to limit what is displayed to what can be
> > entered?
>=20
> You mean, exactly like the valid_state() function already does??

Eh, my apologies. I had indeed missed the call in the if there. Sorry.

johannes

--=-20ZeTWBAMjYk9iSln2ze
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARFcSGqVg1VMiehFYAQJokQ/9E62sneu8H2d6n+2n11CBjCujK0Osk5h9
NO4pkH9uF3vgRlexQtP6JI99EfG7TUNZgTbQUGmWuKXecXHXHkUX5pwysk9vSj5C
xfTluZ6bNRTw9DjN53RawF64BSpNcIBDxxF6rqa8ROtJf9gpuG+XEjDAh7WFfwY5
LQpmqqtVQNxiwmzC+srft8ItNV5HubJ5ykQa40AGmIZ7J71Q6eFIqu2BEiwbn5BR
o+R81JK0BWP5MGS7esLn3LM+S7nnnlIRKpXH0xxOskQzvB/1qmr/Ie4HJrZjAmco
6QiM4WcgVdphfUjuVskPkfy8bZNQJ+FVZp0AIjAPeI/Vk6r1mhgiJE1wyFN+CM+K
kambO8dtk+kOsenxHxzWdlMxSfehD8DntdpEuj2bsW3OHXqZOUBE1fR1dVqfiJG6
RrjK7ROumJGyNzXjhZ3Tpejj+f0Puo+uidKcqMEQohSNASbUxIiblFixnRwM0cZq
1YzufwhKo2MaXzdP0H2kjh76kYuaZGjw7NB0cAe7PrgxmOq/mvCVGwHj68nLMLQZ
AuemRc0aARVen5+DsRzKwokGuTT/b/akSWn/lY2/5GO2z4mbvt1qmtSizpSFINtV
CPoIR7f5ktPXkPyMUoy/eBXvlbnMdAO6vXdBSTqEparg+VcSC7yhP9h0YjF9y76H
h8imB7jcJgI=
=r0rW
-----END PGP SIGNATURE-----

--=-20ZeTWBAMjYk9iSln2ze--


--===============71394862292073835==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============71394862292073835==--
