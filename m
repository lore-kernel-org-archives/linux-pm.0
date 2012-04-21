From: Andrey Rahmatullin <wrar@wrar.name>
Subject: Re: ehci_hcd related S3 lockup on ASUS laptops, again
Date: Sat, 21 Apr 2012 14:37:51 +0600
Message-ID: <20120421083751.GA4570@belkar.wrar.name>
References: <20120419214856.GC11484@belkar.wrar.name>
	<Pine.LNX.4.44L0.1204202037570.19313-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5434946074572758072=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1204202037570.19313-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: jrnieder@gmail.com, linux-pm@lists.linux-foundation.org, USB list <linux-usb@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-pm@vger.kernel.org


--===============5434946074572758072==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 20, 2012 at 08:42:03PM -0400, Alan Stern wrote:
> > > I'd like to see the dmesg log for the complete suspend/resume cycle=
=20
> > > (naturally you'll have to resume the system by hand after plugging in=
=20
> > > the USB device).  Make sure that CONFIG_USB_DEBUG is enabled.
> > Attached.
>=20
> It looks quite normal.  Evidently USB wakeup does _not_ work on your=20
> system when the controller isn't in D3 -- and the system crashes during=
=20
> suspend if the controller _is_ in D3!
>=20
> (Does anybody know if USB wakeup works on these machines under
> Windows?)
Out of the box it doesn't work and "Allow this device to wake up the
computer" checkboxes on both root hubs are unchecked and grayed out.

> What about runtime wakeup?  You can test it easily enough.  Write=20
> "auto" to the power/control attribute for the two controllers.  This=20
> should cause the controllers (or at least one of them) to go into=20
> runtime suspend.  Does it then wake up when you plug in a USB device?
I wrote 'auto' to both power/control, both power/runtime_status became
'suspended', I plugged in a device, one of power/runtime_status became
'active'.

--=20
WBR, wRAR

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPknHaAAoJEDNi9wMaSZLhSEEQAJ1ewoBInL+pTeg4yz7031xL
+8vTkkoJuLUHxxgYF/p9D1pYobKIVrvNPMXFddHsnF+vUhz6mv8P7QIUWUuCy7mf
B4SwP+46BFuhs89z5xphGQxuZVebi3Pa3I1MB39ebbYaIKWnDyCvEl5MnS74svL2
RQvUAp2V4p3tCOnc3ET+vySOYaYMMOe2fJ/xZRy5jBL5r9+5sfMv2exvOYhX/h4P
9ifT+UX46bVDbd8l6NsYJVAhp8QFaSHVphp2+Gsl+iVOD0JRndS2/gP4ubE9ThNA
LDWeOb02JSkIyMNp2f8ad4Vw2/BaHAvwPB6aMLA5ZebirrvlpRvaZR7O0lsQxgwX
aDI0Dt/mUxHs7Pcu/619whRjxPdRtU+Xv50HwZssBNWT+3y6BvGFlHStu98BJI14
XhVsmEcPJOIqeCdOTGVJW+q62oaeB9n1QtLh9y1C+ERhTmsBF+5iEcq2nj7/Pm5O
QQ7/vFRjZ4MwbnZuX1ILlX9n3JvD3Rrr1pk3cjVe0QtFS6jamSrBFLFpAZk9QwYl
+Atzw7sugqXmw0mO1HblrnllF5b8p22hm5aUXqHlt/WVzuVDWa7A6ZtqKC7pMLcj
RpSOY4WOjrqr+Jwt2B1lh+RlxSTeVGgNdjWE8POCLKDzt58U6sap4Ec6BjBqzAC8
iQD3WPUmFIC7i5YxAU1L
=fmCX
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--

--===============5434946074572758072==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5434946074572758072==--
