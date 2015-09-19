From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/5] regulator: smd: Add floor and corner operations
Date: Sat, 19 Sep 2015 09:57:13 -0700
Message-ID: <20150919165712.GH30445@sirena.org.uk>
References: <1442623929-4507-1-git-send-email-sboyd@codeaurora.org>
 <1442623929-4507-2-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0536376546321097136=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1442623929-4507-2-git-send-email-sboyd@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Nishanth Menon <nm@ti.com>, David Collins <collinsd@codeaurora.org>, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, Andy Gross <agross@codeaurora.org>, linux-kernel@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Georgi Djakov <georgi.djakov@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


--===============0536376546321097136==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jaoouwwPWoQSJZYp"
Content-Disposition: inline


--jaoouwwPWoQSJZYp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 18, 2015 at 05:52:05PM -0700, Stephen Boyd wrote:

> +EXPORT_SYMBOL(qcom_rpm_set_floor);

The entire regulator API is EXPORT_SYMBOL_GPL(), adding plain
EXPORT_SYMBOL() exports is not good.

--jaoouwwPWoQSJZYp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV/ZPoAAoJECTWi3JdVIfQxjQH/AiDSrAK+P5mMDHbJuQ+uwaG
CMngt+9tquBjYh16ECDiqDR4cgAmfKEqF3sjUe+V5Il8Yc+qd/Y8ZzdqRc8nGvVN
M4epyR+tzyUOCL4nMT0RPlCPM21czIF71GtDjRA6WTeSYS1CbE+QT7sJEpQiMdTW
PCyLk4Ef/0tKXsgL+I8re7uxlHHHrL7mtv7GrXrj+oVTBCK5v5hkRZTIshRfZQ62
K96dMqRwP4A2ptivJzcR/6i2oZC+T8nRnwRw+VdE/n6MsAKt8QAcjash2Q9/9ki/
covareyMqYbxPx9Zrrs8RIh8c2LGhDYdjegZSUmDvqP0HzG0NHCXee8WMK5KBfs=
=uuSh
-----END PGP SIGNATURE-----

--jaoouwwPWoQSJZYp--


--===============0536376546321097136==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0536376546321097136==--
