From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power_supply: Adjust devm usage
Date: Fri, 24 Jul 2015 15:38:44 +0200
Message-ID: <20150724133843.GA27569@earth>
References: <20150724115813.GA3004@vaishali-Ideapad-Z570>
 <20150724122622.GA22105@earth>
 <CAK-LDbKk5wYAKVJ9eE5Kr6iOW1ah6VxAxBWcZjbufHp8WZXW=g@mail.gmail.com>
 <20150724125951.GA25447@earth>
 <CAK-LDbJQ07fi3YOEOJ+8Qwm3jbqA7L8tFNF9U9=_QO0B0gg_UA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK-LDbJQ07fi3YOEOJ+8Qwm3jbqA7L8tFNF9U9=_QO0B0gg_UA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vaishali Thakkar <vthakkar1994@gmail.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Frans Klaver <fransklaver@gmail.com>
List-Id: linux-pm@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 24, 2015 at 06:44:41PM +0530, Vaishali Thakkar wrote:
> [...]
>=20
> This makes sense. Thanks for explanation and review :)
> So, can I send all changes along with getting rid of remove
> function here in a single patch?

A single patch is fine for me. Use something like the
following patch subject then:

"power_supply: bq24735: Convert to using managed resources"

-- Sebastian

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVsj/hAAoJENju1/PIO/qakNAQAJumku4Gwsf4ijkg4k+MTstJ
BvCc6ybbhnWgWB8gbOb9Zh2Pf7Mxh4yKXODnHuW/t1Gcaux2OKrscfYPZBPZys88
74Hd+Rw7NlUX6D/Pf2wz2WMGTvA/qd37cEx/7VlVuroWU8gIgwau49m0ZNf1l0ZD
fKbk6pr9FwBzIvUjHllntCurHWLsLSY73Fv1I6dwKv0zchtlxK1HakupAifoQ2dV
FZMJKB7ue3h86aQvb6n5uv6mwAiyjqkAxLaQHLOivYZnG7iMPTXXDb4PZeGpwasD
PzoFjXXdMPF/LsDbzlAfVWZCpolwQyzDT0psvzeUe/MSDa4XSfVvEUdM91+Bt3h9
JLVc56sJ/TYjuudrpawztt0hagRkxwmD4zLAK6TUme2fVHPcYyJhoVgdM3YH/eIn
zoee7R3SdJFWjXMqSP+i9nan1mb4GKY5SeQX/cpFaiGl/OKm4HsTeY0ROtcsuu4G
m73SPaVMCNEY6HNdeVd0XWkvN4OLoJ9oTIOk+6S+HGhhmN3Rm3J8Hf8QWYHJpw+i
nk2PjJAgszKFcwHQSb+uAX+LHzLyr+wbzKr1TWWp7FEUHf7GFQ9rBGIH+fAXCg5M
GKRJl+vj+d+oMRN4nMPnuLVWWIHcQ3S9Bq3y7Xjt43CEVq1jeMgDKlPDFLXMglZH
LHIiVyhKZccVp73jqcv1
=zX0k
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
