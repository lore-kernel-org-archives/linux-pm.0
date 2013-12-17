From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2 2/2] cpufreq: imx6q: correct VDDSOC/PU voltage scaling
 when cpufreq is changed
Date: Tue, 17 Dec 2013 13:23:12 +0000
Message-ID: <20131217132312.GB3185@sirena.org.uk>
References: <1387318102-11070-1-git-send-email-b20788@freescale.com>
 <1387318102-11070-2-git-send-email-b20788@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0050612042845383957=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1387318102-11070-2-git-send-email-b20788@freescale.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Anson Huang <b20788@freescale.com>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, viresh.kumar@linaro.org, rjw@rjwysocki.net, cpufreq@vger.kernel.org, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


--===============0050612042845383957==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uf7EosKxohYIlF4L"
Content-Disposition: inline


--uf7EosKxohYIlF4L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 17, 2013 at 05:08:22PM -0500, Anson Huang wrote:

>  	if (new_freq > old_freq) {
> +		if (regulator_is_enabled(pu_reg)) {
> +			ret = regulator_set_voltage_tol(pu_reg, imx6_soc_volt[index], 0);

As I pointed out while reviewing the regulator driver this is racy,
nothing stops the regulator state being changed after you read it and if
you skip setting the voltage then when something comes along and enables
the regulator later it will be enabled with a possibly incorrect
voltage.

--uf7EosKxohYIlF4L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSsFA9AAoJELSic+t+oim9GAAP/2mwH2GL+qJP70GPgSbNubmL
TCOHbPjC0tlbpk0DtxYM0If5pSzR7i0aQNWYrC7arkBGfRFFZJRUUjd3SADN2xy0
TWWQJ8rlb0jyE3YBAIJI5JUKdM/zgBD6ovwTXPYrfwbnjXAQQOjnsW6rCg2RtnJI
hZ0+sQdZoAj//GntFRGJErUxv2QU2JsN+OcuQGIl4wKnpTv89ExTxN0PPJmPnmxy
y4jJOuWRrls2z8eksmYmlyPCMkdQGYhEJv7nUrYiPrRtGNkGZo6jGfc8v9fIKoIU
bARF+6DfW6J/q94N0aVwSFgCKkkHw3qj49brSzwOAj4kIg+cw6cWaJbegaje0PWZ
FPU7wQn6LzTT76NkTLI85jAJel1d9hM9sc3aywI8pQJQgmyw9WvEVj9Am6aCOypY
3DXOaYh6l5LteZjJ7K7HN9Ju1EGhM3mc5Gi4fvJ324L/ftSnCSIcWqp+cITW63bh
M7Jdf99PFMSPBY2lWFXssjO07s4OvODhQcsA3ADtp/wUseZQQVIAD6+9ptek12nb
ZN1t04TQog9AgGbbtK7Ul19y6jDlrQXgvpzyexzmgtTKMWNlh2ew+r0hQj5TPkOt
cmophcXvtPe9Dp3PQ+TJPADFE9cdh8avjmWxpiAAkiBEGvy28t2qUGKgjYM7Px/S
Pe+RisjCp7sihTw/sqS6
=ctb0
-----END PGP SIGNATURE-----

--uf7EosKxohYIlF4L--


--===============0050612042845383957==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0050612042845383957==--
