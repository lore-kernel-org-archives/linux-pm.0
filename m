From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: designware: Do nothing in system suspend/resume
 when RT suspended
Date: Wed, 19 Apr 2017 20:59:10 +0200
Message-ID: <20170419185909.dl5h6xhkd6f72na3@ninjato>
References: <20170330120444.12499-1-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="c5wxliccl7662yww"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:44515 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967081AbdDSS70 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 19 Apr 2017 14:59:26 -0400
Content-Disposition: inline
In-Reply-To: <20170330120444.12499-1-jarkko.nikula@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, John Stultz <john.stultz@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>


--c5wxliccl7662yww
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 30, 2017 at 03:04:44PM +0300, Jarkko Nikula wrote:
> There is possibility to enter dw_i2c_plat_suspend() callback twice
> during system suspend under certain cases which is causing here warnings
> from clk_core_disable() and clk_core_unprepare() as well as accessing the
> registers that can be power gated.
>=20
> Commit 8503ff166504 ("i2c: designware: Avoid unnecessary resuming during
> system suspend") implemented a prepare callback that checks for runtime
> suspended device which allow PM core to set direct_complete flag and
> skip system suspend and resume callbacks.
>=20
> However it can still happen if nothing resumes the device prior system
> syspend (e.g. acpi_subsys_suspend()) and there is a slave device which
> unsets the direct_complete flag of the parent in __device_suspend() thus
> causing PM code to not skip the system suspend/resume callbacks.
>=20
> Avoid this by checking runtime status in suspend and resume callbacks
> and return directly if device is runtime suspended. This affects only
> system suspend/resume since during runtime suspend/resume runtime status
> is suspending (not suspended) or resuming.
>=20
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
> I'm able to trigger system suspend callback while device is runtime
> suspended by removing the pm_runtime_resume() call from
> drivers/mfd/intel-lpss.c: resume_lpss_device() and having unbound I2C
> slave (ACPI enumerated but doesn't bind due an error in probe function).
> In that case __device_suspend() for that unbound device has NULL suspend
> callback, and thus doesn't cause any runtime resume chain but still unsets
> the parent's direct_complete flag.
> John Stult <john.stultz@linaro.org> has reported he can trigger this on
> HiKey board too.
>=20
> I'm not sure is this the right thing to do. It feels something the PM core
> should do but I'm not sure that either. One alternative could be to resume
> runtime suspended parent in in __device_suspend() right after where
> parent's direct_complete flag is unset.

Because of the last paragraph, I'd like a positive comment or tag from
one of the PM people before I apply this one.

> ---
>  drivers/i2c/busses/i2c-designware-platdrv.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/bu=
sses/i2c-designware-platdrv.c
> index a597ba32de7e..42a9cd09aa64 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -377,6 +377,9 @@ static int dw_i2c_plat_suspend(struct device *dev)
>  	struct platform_device *pdev =3D to_platform_device(dev);
>  	struct dw_i2c_dev *i_dev =3D platform_get_drvdata(pdev);
> =20
> +	if (pm_runtime_suspended(dev))
> +		return 0;
> +
>  	i2c_dw_disable(i_dev);
>  	i2c_dw_plat_prepare_clk(i_dev, false);
> =20
> @@ -388,6 +391,9 @@ static int dw_i2c_plat_resume(struct device *dev)
>  	struct platform_device *pdev =3D to_platform_device(dev);
>  	struct dw_i2c_dev *i_dev =3D platform_get_drvdata(pdev);
> =20
> +	if (pm_runtime_suspended(dev))
> +		return 0;
> +
>  	i2c_dw_plat_prepare_clk(i_dev, true);
>  	i2c_dw_init(i_dev);
> =20
> --=20
> 2.11.0
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--c5wxliccl7662yww
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlj3s30ACgkQFA3kzBSg
KbZP7w//QOFIsFyMdLgXxe/SjuffKpyFFIyQprjCjtKvc7zjTliTzO0qqfDxinlI
zUennoxYK2ilSWFfUkNfyy/OvGI2dd5CsKhYu0iyzGOygDz8jGCds91IIyGb4mOv
KiDdnzm+6jjNx6PmGSP26dn0jWyp7Bc84epmLAey7ZuqYZuLwOZxmtzHhh3afYtz
n6gXthV3YlA/KRJAsgj/LtPZXIQySSRyQPDmM7hWfCBeRC8Xy0zCQ0uRKwZxP33c
KIeFlbOq66REozlcQ2bh5ot8jyxXAKPX259CEQPKrZDdFgHmsMCsycvVZ+HaiVcd
8e0gqdLRud6jvQVW4wYN45qSgonU/t4c8dcEbtjVKsfZvfyaoffcv57GQ7kBRhyW
cUjQoIdGcqQP7lPWDhezJ0+SMppXk+tkzDzjod7USm87EAmd11OVtZOIjkVvPl7e
70mpGt9ZOJa76JCe2r8k5pIVOCaT+bKBuHDlCLzLWbyolkpy0kmCAYmakuOFqJn3
XQY2OFXN/StwzI6uxpeKfdaTYGMjZV+yyyIhhq94W8K++MxuTxqLblFqxM5o/PVW
IXzMejlZu5oeiflQvH9H0VsXcXGw3VTHYXfV3n5aeW9ADCVCFXbnx8nupuXKnRu2
7cnHeMwTKj+NN7cMbnptgkJZ1AYMrNTTufMvyF/XBjxsT1dhLMw=
=APeh
-----END PGP SIGNATURE-----

--c5wxliccl7662yww--
