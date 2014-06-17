From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RFC PATCH 1/4] memory: tegra124-emc: Add EMC driver
Date: Wed, 18 Jun 2014 00:35:27 +0200
Message-ID: <20140617223518.GA25309@mithrandir>
References: <1402925713-25426-1-git-send-email-tomeu.vizoso@collabora.com>
 <1402925713-25426-2-git-send-email-tomeu.vizoso@collabora.com>
 <539F4D44.3070309@wwwdotorg.org> <53A03186.3040703@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0188949733=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <53A03186.3040703@collabora.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: devicetree@vger.kernel.org, Mike Turquette <mturquette@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, kyungmin.park@samsung.com, myungjoo.ham@samsung.com, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


--===============0188949733==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2014 at 02:16:06PM +0200, Tomeu Vizoso wrote:
> On 06/16/2014 10:02 PM, Stephen Warren wrote:
> >On 06/16/2014 07:35 AM, Tomeu Vizoso wrote:
> >>+
> >>+Child device nodes describe the memory settings for different configur=
ations and
> >>+clock rates.
> >
> >How do the child nodes do that? The binding needs to specify the format
> >of the child node.
>=20
> Sorry, that file was sent before I had finished removing the bits from
> downstream that aren't needed yet. There's no current need for any child
> nodes.
>=20
> >This binding looks quite anaemic vs.
> >Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt; I
> >would expect that this binding needs all the EMC register data from the
> >tegra20-emc binding too. Can the two bindings be identical?
>=20
> There's even less stuff needed right now, as all what ultimately the EMC
> driver does is call clk_set_rate on the EMC clock. As the T124 EMC driver
> gains more features, they should get more similar.
>=20
> >Can you explain what the nvidia,mc and nvidia,pmc references are needed
> >for? Hopefully, this driver isn't going to reach into those devices and
> >touch their registers directly.
>=20
> Not really needed, see above.

I've been working on a prototype driver for the memory controller. Part
of what I've added is programming of the latency allowance registers (it
doesn't yet expose an API to do so yet, though). I think that needs to
eventually take into account the EMC frequency (and needs to be notified
of changes to the same).

Without having thought this through very thoroughly, I suspect that
rather than referencing the MC from the EMC it might be better to have
the MC register with the EMC for notifications.

But perhaps there are other services from MC that EMC needs to work?

Thierry

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJToMKmAAoJEN0jrNd/PrOh7tsP/1iiyCvf+gToYFTC5Oa277pT
PsNiluavHj05CCD6ospTQ7adIPHx9jHBDVl7Wxcevo3VmWPVAX27dbhqHFNyHFtz
wNi4JFOsbS1FzNoGFcgE/G8BnrsbBnjFTIp+ftzKoMWvS+yO09VEhbW5VOkfuDFY
JX8usGCJznyj0kYFJEXLfh2dU+oy6y6TUcva3k2KGaPhzJw3071VIUqbpqq5ueCr
+XwNefsZniVILBrIT1FX3IxHHOgrDBnI1W5Giv8Ui/0gJcFt/qbpkZiIKq94F9sN
ZKqXTePJdPcYMr9lavezD3K77XnIbQe4//HgiQ6PQXmSO7L4utu2Da/UFA5ZDPFi
eTUkQVooBGbbGa6igJYsl1/A79ZBHiOs+46B0/USCnFNH56JjGlABinCA1Jd5Gdc
ghZ3iA4zFczm5RudD6JkZyLsG6xOxaaPGGnXyAnIG8MINWnEWUZkkNbsQLFnarpf
4rfJT2JK47LAfUo/H9PfN9ld/MnV1A65dJLHNcEAYmaFE/rD2Rfnv3HRYtDNo/gE
SEkRuHdNFT1MQnadRYz0p3c4G54qrPo+Kjb9simhOF1EFMu23BJL4krukv7DJsrb
6bX8sya1NbmwaKYgunVht4NV3I5KqUHHmJ9vFLDqW2iMJtmL+squ4LuCqwzixs/d
1x26cvcn6f2LCl1QxfPZ
=evRg
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--

--===============0188949733==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/dri-devel

--===============0188949733==--
