Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com [165.173.180.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4A347D471;
	Sun,  4 Oct 2026 21:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791150781; cv=pass; b=G4wg9GdQdnZpEpVp9+fvdDmXjPbePUXXhvuzmYCwNPYwHnHjnBs3cXK0Ar14gqQvCo/jdQpMN9f2HV935l/ZAjfc0Ie660qq1V+E1doEFXQvKP7+g4M81aTwOwmPeVbbRpyMl+D0rvQxBsh2TsydPL3JSLl+OQBpFHMMdsqexBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791150781; c=relaxed/simple;
	bh=IE68smQ2L2PQgHpk9opEwb0MG7bGZ+Dy8C3nr8HCpNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVS7N1HHNVgXO8QM0I4kWBnmdweabs42nnJec3vSruAvbpw9SPLgPeWXvXDZSy75ZX7Sgh/NwMInwqMswza4H+fqfYq5xxnTd8PQ1Kis4rMDDCBeChbdS32vt3u2am7e8q6nkJbXU0todSp0rfoUn+24+kowjVXK0oMZRc/PSQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=cGV9L5np; arc=pass smtp.client-ip=165.173.180.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="cGV9L5np"
ARC-Seal: i=1; a=rsa-sha256; t=1791150765; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NUSum8dZf4qxvOnLMzaYn16Sy5TMnGYrZ2I/LYDirJGKnt0hwzyNHgib5iWNvPn3Ko2WeKHYzKfcXFhb1a24X+jLsml5q7zoglx9HyjXFrAYH3miJvjQr4gvrYs0Yr69MN3hOQYJINuTWxPsyJqA0bMd3IJcKe3IWv0BqCRJM90=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791150765; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=09Ti0ZRz0+O/gL3CO61Ctfmj7MKudqwom+5ijasagT8=; 
	b=kC8fkCR6v0qETMxAC5O6tOl91IKdl/B2atYF+Qu+1gTm8EY6vBSO4Zp/YnhqcXlnM8x3zH6EQmwOOXpA/hdus0VVQw0sbZqrILSmEAor1QuIbnx46aVREGccbBsYQ8MCnO+W0KWcpvoDoNfr3+plrRBXNT3TbQMi1i/gbXekDlE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791150765;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=09Ti0ZRz0+O/gL3CO61Ctfmj7MKudqwom+5ijasagT8=;
	b=cGV9L5npieVO4nAbUR6pn7t8K8RP7KNVGMLRLrn25oWErgTSJ+WT0j18j2wr7d5i
	5BXha6QIgRVdIgQ3kGq7WNow33hUEz7aI1aNcKnz2pdnE/NeD9+a8ckaKkdRC0ZSJAy
	Ecw9UxV5CIS4kcvzSVZVIk1t2n5LFtXq3qPe4D3A=
Received: by smtp.zohomail.com with SMTPS id 1791150762942153.3763859726323;
	Sun, 4 Oct 2026 14:52:42 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 8D366180951; Sun, 04 Oct 2026 23:52:34 +0200 (CEST)
Date: Sun, 4 Oct 2026 23:52:34 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Han Gao <gaohan@iscas.ac.cn>, Drew Fustini <fustini@kernel.org>, 
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Ulf Hansson <ulfh@kernel.org>, 
	Han Gao <rabenda.cn@gmail.com>, linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: reset: th1520-aon: send RPCs from sleepable
 handlers
Message-ID: <asLJGnsAQIfHr7oj@venus>
References: <20260916-fix-xuantieaon-v1-1-c6dc530a4884@iscas.ac.cn>
 <d081ce3c9f0b319e8d8cc41480c0d2862618eed6.camel@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="syop2w5cyiogqlqp"
Content-Disposition: inline
In-Reply-To: <d081ce3c9f0b319e8d8cc41480c0d2862618eed6.camel@icenowy.me>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/291.146.46
X-ZohoMailClient: External


--syop2w5cyiogqlqp
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] power: reset: th1520-aon: send RPCs from sleepable
 handlers
MIME-Version: 1.0

Hi,

On Wed, Sep 16, 2026 at 03:45:52PM +0800, Icenowy Zheng wrote:
> =E5=9C=A8 2026-09-16=E4=B8=89=E7=9A=84 14:55 +0800=EF=BC=8CHan Gao=E5=86=
=99=E9=81=93=EF=BC=9A
> > The AON RPC takes a mutex and waits for mailbox interrupts. The final
> > sys-off handlers run on atomic notifier chains, where this can sleep
> > with interrupts disabled.
> >=20
> > Send the requests from the preparation handlers before syscore
> > shutdown.
> > Retain a final power-off handler to advertise capability and report
> > failure without issuing another RPC. Let other providers handle
> > fallback.
> >=20
> > Report RPC errors and allow one second after a successful return for
> > the
> > asynchronous operation to take effect. This is a software fallback
> > timeout, not a hardware timing requirement.
> >=20
> > Fixes: 2d81a24a74e5 ("driver: reset: th1520-aon: add driver for
> > poweroff/reboot via AON FW")
> > Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
> > ---
> > =C2=A0drivers/power/reset/th1520-aon-reboot.c | 49
> > +++++++++++++++++++++++----------
> > =C2=A01 file changed, 34 insertions(+), 15 deletions(-)
> >=20
> > diff --git a/drivers/power/reset/th1520-aon-reboot.c
> > b/drivers/power/reset/th1520-aon-reboot.c
> > index
> > ec249667a0ffd74829357d57b9e63c3524ea3759..ace70491834dc9a63ed543427e4
> > 0e4cbc0a9388f 100644
> > --- a/drivers/power/reset/th1520-aon-reboot.c
> > +++ b/drivers/power/reset/th1520-aon-reboot.c
> > @@ -6,6 +6,7 @@
> > =C2=A0 */
> > =C2=A0
> > =C2=A0#include <linux/auxiliary_bus.h>
> > +#include <linux/delay.h>
> > =C2=A0#include <linux/firmware/thead/thead,th1520-aon.h>
> > =C2=A0#include <linux/module.h>
> > =C2=A0#include <linux/notifier.h>
> > @@ -14,37 +15,46 @@
> > =C2=A0#include <linux/slab.h>
> > =C2=A0
> > =C2=A0#define TH1520_AON_REBOOT_PRIORITY 200
> > +/* Allow an accepted asynchronous command to take effect before
> > fallback. */
> > +#define TH1520_AON_REBOOT_TIMEOUT_MS 1000
> > =C2=A0
> > =C2=A0struct th1520_aon_msg_empty_body {
> > =C2=A0	struct th1520_aon_rpc_msg_hdr hdr;
> > =C2=A0	u16 reserved[12];
> > =C2=A0} __packed __aligned(1);
> > =C2=A0
> > -static int th1520_aon_pwroff_handler(struct sys_off_data *data)
> > +static int th1520_aon_reboot_request(struct sys_off_data *data, u8
> > func)
> > =C2=A0{
> > =C2=A0	struct th1520_aon_chan *aon_chan =3D data->cb_data;
> > =C2=A0	struct th1520_aon_msg_empty_body msg =3D {};
> > +	int ret;
> > =C2=A0
> > =C2=A0	msg.hdr.svc =3D TH1520_AON_RPC_SVC_WDG;
> > -	msg.hdr.func =3D TH1520_AON_WDG_FUNC_POWER_OFF;
> > +	msg.hdr.func =3D func;
> > =C2=A0	msg.hdr.size =3D TH1520_AON_RPC_MSG_NUM;
> > =C2=A0
> > -	th1520_aon_call_rpc(aon_chan, &msg);
> > +	ret =3D th1520_aon_call_rpc(aon_chan, &msg);
> > +	if (ret)
> > +		dev_err(data->dev, "AON WDG command %u failed:
> > %d\n", func, ret);
> > +	else
> > +		msleep(TH1520_AON_REBOOT_TIMEOUT_MS);
> > =C2=A0
> > =C2=A0	return NOTIFY_DONE;
> > =C2=A0}
> > =C2=A0
> > -static int th1520_aon_restart_handler(struct sys_off_data *data)
> > +static int th1520_aon_pwroff_handler(struct sys_off_data *data)
> > =C2=A0{
> > -	struct th1520_aon_chan *aon_chan =3D data->cb_data;
> > -	struct th1520_aon_msg_empty_body msg =3D {};
> > -
> > -	msg.hdr.svc =3D TH1520_AON_RPC_SVC_WDG;
> > -	msg.hdr.func =3D TH1520_AON_WDG_FUNC_RESTART;
> > -	msg.hdr.size =3D TH1520_AON_RPC_MSG_NUM;
> > +	return th1520_aon_reboot_request(data,
> > TH1520_AON_WDG_FUNC_POWER_OFF);
> > +}
> > =C2=A0
> > -	th1520_aon_call_rpc(aon_chan, &msg);
> > +static int th1520_aon_restart_handler(struct sys_off_data *data)
> > +{
> > +	return th1520_aon_reboot_request(data,
> > TH1520_AON_WDG_FUNC_RESTART);
> > +}
> > =C2=A0
> > +static int th1520_aon_pwroff_failed(struct sys_off_data *data)
> > +{
> > +	dev_err(data->dev, "AON did not power off the system\n");
> > =C2=A0	return NOTIFY_DONE;
> > =C2=A0}
> > =C2=A0
> > @@ -54,8 +64,11 @@ static int th1520_aon_reboot_probe(struct
> > auxiliary_device *adev,
> > =C2=A0	struct device *dev =3D &adev->dev;
> > =C2=A0	int ret;
> > =C2=A0
> > -	/* Expect struct th1520_aon_chan to be passed via
> > platform_data */
> > -	ret =3D devm_register_sys_off_handler(dev,
> > SYS_OFF_MODE_POWER_OFF,
> > +	/*
> > +	 * RPC takes a mutex and waits for mailbox interrupts. Send
> > after device
> > +	 * shutdown, but before syscore shutdown and the final
> > atomic callbacks.
> > +	 */
> > +	ret =3D devm_register_sys_off_handler(dev,
> > SYS_OFF_MODE_POWER_OFF_PREPARE,
>=20
> Interestingly I tried to find usage of this key in the kernel, and
> found that the macsmc-reboot driver has a "enter_atomic" operation.
>=20
> I don't know whether it's a overdesign.
>=20
> The imx_rproc driver even creates its own PREPARE handler that "setup
> mailbox to non-blocking mode".
>=20
> Maybe it's better to replicate the behavior of macsmc / imx_rproc in
> the AON driver?
>=20
> > =C2=A0					=C2=A0=C2=A0=C2=A0
> > TH1520_AON_REBOOT_PRIORITY,
> > =C2=A0					=C2=A0=C2=A0=C2=A0
> > th1520_aon_pwroff_handler,
> > =C2=A0					=C2=A0=C2=A0=C2=A0 adev-
> > >dev.platform_data);
> > @@ -65,7 +78,7 @@ static int th1520_aon_reboot_probe(struct
> > auxiliary_device *adev,
> > =C2=A0		return ret;
> > =C2=A0	}
> > =C2=A0
> > -	ret =3D devm_register_sys_off_handler(dev,
> > SYS_OFF_MODE_RESTART,
> > +	ret =3D devm_register_sys_off_handler(dev,
> > SYS_OFF_MODE_RESTART_PREPARE,
> > =C2=A0					=C2=A0=C2=A0=C2=A0
> > TH1520_AON_REBOOT_PRIORITY,
> > =C2=A0					=C2=A0=C2=A0=C2=A0
> > th1520_aon_restart_handler,
> > =C2=A0					=C2=A0=C2=A0=C2=A0 adev-
> > >dev.platform_data);
> > @@ -75,7 +88,13 @@ static int th1520_aon_reboot_probe(struct
> > auxiliary_device *adev,
> > =C2=A0		return ret;
> > =C2=A0	}
> > =C2=A0
> > -	return 0;
> > +	/*
> > +	 * Advertise power-off capability to kernel_can_power_off().
> > This final
> > +	 * callback must not send RPCs; let other providers try if
> > AON failed.
> > +	 */
> > +	return devm_register_sys_off_handler(dev,
> > SYS_OFF_MODE_POWER_OFF,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0
> > TH1520_AON_REBOOT_PRIORITY,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0
> > th1520_aon_pwroff_failed, dev_get_platdata(dev));
>=20
> I don't know whether such a handler is necessary when the real power
> operation is done in PREPARE handler. The odroid-go-ultra-poweroff
> driver, which also (ab?)uses PREPARE handler for powering off, doesn't
> register a non-PREPARE handler.

The real operation shouldn't be done in the PREPARE handler as that
results in the machine loosing power before it went through the
whole shutdown/reboot process.

Greetings,

-- Sebastian

--syop2w5cyiogqlqp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmrCyp8ACgkQ2O7X88g7
+pp3ThAAooDlRfqsOZDlPAwJ5LVwvZgn2Kcfrt6wweJEbOy7kJibjB8QQcoWGHI0
RmJL12+QFzyGa2bFXMuBmmRm4M38eQPj2L5t14mRtCf8WjK3t+tsrUSqumDzKzI1
YeaAVxhssCt0zFAIabFnk1Ui4aTtlpScQpbg6iggRGIYKwyVok5NBM+AkRITom7N
C8Y/gI3HTEWnHZVikEvlFmz0/q3tAvnNf/y5g+cwjYFGTYOdQNAePdYeRviZXH+u
8PwTH7NUNigrY1lNM3wZzBy8Ewbj50Hn/SadcIdDAWLbKPY0XGV1T2fWmiJDbDIS
cplQ0frHXhC6Lytu6MgLUro5sfjXOgIro85Gscz6YYa2ppCyEVcGLKqcq6z5S7dW
r7UVvmfbvRhDP/om4wuCqtDVX8U9fnnZaOe0Vu5locWV0GKRizP/zkLQIsr/5qEi
Nl+Qipi86pr8F3jHqukRVBDFLavfG6Y2NEFnZGktic5Y4U16T6jXBGuig97tbtmo
nxAiALIbAXK3IBMM4zqQzlbvZPah3qsw6CwdZeJqHh+OqpaFGTntZaXs24YWwF/L
l76+TBbCF1nuqD2P8Vjknyv69i63cmMnFhRoJoBOWAIoKd7pxe3yUECtLr/dAq65
QegbVk+o88XoY/Sh9H3V4f8yXYqnTg8V1D4azjCmHJtHJyqMRk8=
=raOf
-----END PGP SIGNATURE-----

--syop2w5cyiogqlqp--
