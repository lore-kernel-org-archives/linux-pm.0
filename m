From: Andrey Rahmatullin <wrar-Bxt/JK/G85ezQB+pC5nmwQ@public.gmane.org>
Subject: Re: [linux-pm] ehci_hcd related S3 lockup on ASUS laptops, again
Date: Sun, 22 Apr 2012 03:54:59 +0600
Message-ID: <20120421215459.GB4772@belkar.wrar.name>
References: <25d7d7b05dd22d5f6e78323c1a1579b1@webmail.wrar.name>
 <Pine.LNX.4.44L0.1204211712430.3981-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1204211712430.3981-100000-pYrvlCTfrz9XsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 21, 2012 at 05:15:14PM -0400, Alan Stern wrote:
> > > Okay, that's good.  I assume the device you plugged in then=20
> > > functioned
> > > properly?
> >=20
> > Yes.
>=20
> All right.  Maybe you posted this information earlier in the thread,=20
> but it's easier to ask again than try to find it.  What output do you=20
> get from "lspci -nv -s 1a.0"?
00:1a.0 0c03: 8086:1c2d (rev 05) (prog-if 20 [EHCI])
        Subsystem: 1043:1147
        Flags: bus master, medium devsel, latency 0, IRQ 16
        Memory at dfe08000 (32-bit, non-prefetchable) [size=3D1K]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] Debug port: BAR=3D1 offset=3D00a0
        Capabilities: [98] PCI Advanced Features
        Kernel driver in use: ehci_hcd

--=20
WBR, wRAR

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPkyyzAAoJEDNi9wMaSZLhEwsP/2ndoEjkdxs0sMbkMAmYkbBZ
SmAXZoG0vIvLlaR2kzKs37ndeUPrDrLXnkvDZpURP2AZsdcb8TE8KL1RM6Prh2zL
h+Y/61U9lV1fEFID9M6sk3HJWMdtwN0BaWeAstV9WUMeJVt1E0e1Sa5mLMgPAlsr
OUSlAbOuqOJaPSuACg+DCH4iJoIMEgU2on/DjwBBfRhSZV899JL19toSkUs9u4Y1
b4/Vjb1yQwj6Ziz8jLBsE9Lltdzj34g9Ul0XG3or+qiXdqA8UY6T1gUSoNzyKDvl
YWONlomtDMH8fqivYh9rSjEiFhK2F5/TUBN1SFF1wAkPRf+taki5HeVDiw45/uMa
hIUwY7in5eWg8VG0euNlaWKk6ZWVKvIlf6f/ceOGLU6+99Kcn8R5xaZ/2qK84PuZ
1F9/IXesAjvg0c9PFQ95dHHQX24wKIq931rgkSwMqKSM+nLsh15SOyQYjsBNGHAb
8bS/9FUVuErjodpHAvKa7lGxgcyMP+2oskzVvTOtf+8OAAuqRbVaro7U8vnFS8gN
bWO/62SkKq9Fzn1ZCL4Jx5ceMrLPshajo3vty2bQXUjX/fu2a2K/6HT09Kird8X6
NR47lP18R6uCJGHc5TW3h35wY9fRHVYEQeYuzgIzcIQuS0idwuGHFHWTTmZHiN6w
FuqaEZUKVsXrN9JWyGfH
=PM3z
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
