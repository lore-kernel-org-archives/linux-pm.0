From: Andrey Rahmatullin <wrar-Bxt/JK/G85ezQB+pC5nmwQ@public.gmane.org>
Subject: Re: [linux-pm] ehci_hcd related S3 lockup on ASUS laptops, again
Date: Wed, 18 Apr 2012 00:51:49 +0600
Message-ID: <20120417185149.GO11484@belkar.wrar.name>
References: <20120417175122.GM11484@belkar.wrar.name>
 <Pine.LNX.4.44L0.1204171423310.1163-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TRkqPRiqIDKgfg/F"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1204171423310.1163-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>, jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--TRkqPRiqIDKgfg/F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 17, 2012 at 02:26:24PM -0400, Alan Stern wrote:
> > > If you manage to reach the end of this list, you'll essentially be
> > > doing a normal suspend (except for the PCI_UNKNOWN part).
> > It works without changes #2..8. I'm attaching the resulting patch.
>=20
> Wow.  Okay, I have boiled this down to a single patch.  You should=20
> try this both with and without unbinding ehci-hcd, and post the dmesg=20
> log output that it generates in the two cases.

Unbound:

pci 0000:00:1d.0: wake-up capability enabled by ACPI
pci 0000:00:1d.0: Refused to change power state, currently in D0
pci 0000:00:1d.0: cur 5 target 3 error 0
pci 0000:00:1a.0: wake-up capability enabled by ACPI
pci 0000:00:1a.0: Refused to change power state, currently in D0
pci 0000:00:1a.0: cur 5 target 3 error 0

Bound:

ehci_hcd 0000:00:1d.0: wake-up capability enabled by ACPI
ehci_hcd 0000:00:1d.0: Refused to change power state, currently in D0
ehci_hcd 0000:00:1d.0: cur 5 target 3 error 0
ehci_hcd 0000:00:1a.0: wake-up capability enabled by ACPI
ehci_hcd 0000:00:1a.0: Refused to change power state, currently in D0
ehci_hcd 0000:00:1a.0: cur 5 target 3 error 0

--=20
WBR, wRAR

--TRkqPRiqIDKgfg/F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPjbvFAAoJEDNi9wMaSZLhQcQP/i2bd8Ihv6Foch8s27OhO8pq
2oXM15nqCRlHDIvRo4rWQ0T+yE5gCezv2V17YYfMdVdksg0m79xJvFEfyhHKXD5E
esTVi96KrLWFSAjD8QkfN6m7QrD+pjqcqsRUfifV/lyRBaUFnZzIFrUnZ84Rg8Ao
w+axSuUKwLZe+pBP0kXxiWmSbDhChB4t/nwh/qEpt3nIgd0tO/q3119ajL3iKP/2
dw+2dSdCuRs7+f21je5exkv6Nm6PJ6jzkDTFjtLQOFAWH2A3wSzUSFRWFYjN5a1h
8JdjPP4O2XLuQVVs8S1cFQcWNUP3UN+6ndQZPHaPTVBoYD52uWA1EEviFvwVJ/tL
P4Xb6th8JHkQ2TAggjAVDRYCyxPzNIqy1Yq4Y2bgA6Rh0fpIvd5iudUNBYgFtdR3
AXpuzodirTB13iaMpnk2tmvZApAv8cwWPTf9kxuZ02r4TKQJHVB2+/8LyIQIsXs1
aNug7BXTqkTLV7NexVHw4h1zeSZX99eGCRXewAZP5PVU/qzGPczFDRyQTrTiVAn9
vwG4Ic1WWQoCchV3QAA+HRXj1+K24KOosjojpbDcOJx6boTOd1eTcBaLd+GAypn+
ZTmBz7Mn8TUEPaW0L6iU8EhXobVKxsQsJVPUbfaOnkZ4zRAKzb7hcYfe7eYy7KzF
b1NOTQUwfb4L42iywSRm
=IIde
-----END PGP SIGNATURE-----

--TRkqPRiqIDKgfg/F--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
