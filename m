From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RFC PATCH 2/4] ARM: tegra: Add Tegra124 EMC support
Date: Wed, 18 Jun 2014 00:38:00 +0200
Message-ID: <20140617223759.GB25309@mithrandir>
References: <1402925713-25426-1-git-send-email-tomeu.vizoso@collabora.com>
 <1402925713-25426-3-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0678171553=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1402925713-25426-3-git-send-email-tomeu.vizoso@collabora.com>
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


--===============0678171553==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hQiwHBbRI9kgIhsi"
Content-Disposition: inline


--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 16, 2014 at 03:35:11PM +0200, Tomeu Vizoso wrote:
[...]
> +	memory-controller@7001b000 {
> +		compatible = "nvidia,tegra124-emc";
> +		reg = <0x00 0x7001b000 0x00 0x1000>;

For consistency, perhaps s/0x00/0x0/?

> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clocks = <&tegra_car 57>;

TEGRA124_CLK_EMC?

Thierry

--hQiwHBbRI9kgIhsi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJToMNHAAoJEN0jrNd/PrOh4J0P/2Ajb9j2ajRa6Cndcx1T4twP
XFlb1dyeZaiRslwkbckA8g5g/ZkNuyrsKOth9Q8a5U1r32o38IZCHBt8yKBKOgyc
d/Gspq5rP7zWKZ94ixCtCt4CBx54ZEeZ7t8dFV2ybnR6YXYM9+lGrKkM2KQ1vg6v
QhfQWVU5WHuRaxQGofbq/NWgznUp+IwXeYP5ci0sbekFeO0qKUkAs4zb5EtiDL3r
dESbUFRYOezLR1JWQis4eD9lGB5CckcZ/bJ7k3LDcDcgQwAk7X7m/lH/vPxQZNZT
VxtHYBlkjrt1GNHdzWSMiPjxE7FqZyX+TQQFO2IAli1CxrJQ6CbpiqzvVg3+clHU
lIgcvOd1buTbjWu8KgS8zbociQ3gRjmmzum11sFLqrTmc90mqf+HnASxwCGKCqsA
pjObfqdnG7+t/pJJyqjW5KcqOtna77X9HfUHLHe5+upeFqZueOHybbRS6OVcCdat
dKfskedRd9e9thxDK4FJX6B7cXCg5Ttn0Uji2Aj5Ri+8gam+2ZYmiHNa3GRnk4uO
9tUoNZh8eRx7hmT0KSyI5Pr+ieS/5m52HJqXoctkmZMpwDjVODim7z8sw3xBkNcn
/eBcNh1KfLWrwm6rxZBJFyRcRNMDCC+UhAIOuWGIaILkGNw+puj+9xsOmjBxHmXN
N9qMcdNIsyz/DqE1FA55
=eL70
-----END PGP SIGNATURE-----

--hQiwHBbRI9kgIhsi--

--===============0678171553==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/dri-devel

--===============0678171553==--
