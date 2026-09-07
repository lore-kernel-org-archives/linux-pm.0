Received: from mail-106120.protonmail.ch (mail-106120.protonmail.ch [79.135.106.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50784514762
	for <linux-pm@vger.kernel.org>; Mon,  7 Sep 2026 16:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788799478; cv=none; b=rNKWIfrZ69EsQ5WT5HMsY8h2glfuxRFg4iwhrIh9Yp8OznjsKDsHM1r15Hc6wI5A4UTODTpluRMpqIxJLNJbctoTrrPi52x+x2HyXZkr7M4bbAn+4z96BpCMLnOQoqDOx/hQC19yQcx7ykN7VD5mjYWVfUAp2Ub2Xz6ITZ2mzDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788799478; c=relaxed/simple;
	bh=UG+NTlO6bUfJVab3dSfPJecAZRaEA6aV3rDDEgv9yOs=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=GQhrOFCsGKOqhMybR++DDhZpweUp0nF6LbHz8H2uaRD9cMPLNeMwKzF9TAbdz1gRAwjBN1ntQbCz6dqFwLJbgDdvIt7AYa5YU9QVbTqgnAbh/gGEl0fja/DIniUO821sF3dciAPwbVHB4MBGXyupmyHsvKPu/OUNNQaT/qt/Wdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=CbqGtB1f; arc=none smtp.client-ip=79.135.106.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="CbqGtB1f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1788799474; x=1789058674;
	bh=UG+NTlO6bUfJVab3dSfPJecAZRaEA6aV3rDDEgv9yOs=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=CbqGtB1fS+Fz6xQFhTkDeXE8iaOTSwPZe6XDPzqe0PLQM9FxD63F6lpBlEDg6NPJi
	 d70QfWhe4bbspB0jnSdOMdBm+7blEx4gXtM1x44HAk3qZr/zEtrPM4VS7RPmUzZAdA
	 pjNsqqoSB9jGaeaCV3RlGxlrSZw+8ur89fxSoLZZhSRKq0zt9MbEk3w7ZKG55hchfG
	 RykqJNxOsbkRJpWZQB5rc4LUfhZRfmUTQ+8KM9BA0e7SqzOerIam1Rj6fV7ViLx1iz
	 9/nT2/uClaNWUO3ErZvhVtZOa75E/6bhSxT9Eudsyi7p7ZIBlF4BIJweClOxCzj/Xo
	 /0i8UPVAcTAkw==
Date: Mon, 07 Sep 2026 16:44:29 +0000
To: Sebastian Reichel <sre@kernel.org>
From: Alexander Koskovich <akoskovich@pm.me>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Alexander Koskovich <akoskovich@pm.me>
Subject: [PATCH RFC] power: reset: qcom-pon: Drop reason shift for PMK8350
Message-ID: <20260907-pon-pbs-v1-1-cff2f5810769@pm.me>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: 3422ff4c0557efb5834518b60b9bf6e8dc934dcf
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On the PMK8350 the SOFT_RB_SPARE register does not exist, the reset
reason is instead kept in SDAM and written through the reboot-reason
nvmem cell.

Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
---
Would like some feedback on this as I'm seeing conflicting results,
SOFT_RB_SPARE does not exist on HLOS but it looks like the downstream
qpnp-power-on driver writes to XVDD_RB_SPARE2 for GEN3, which is on PBS.

Though, targets like waipio don't seem to have access to write to PBS
from HLOS? Get SPMI errors when I try. Didn't have an issue doing so on
milos though.

Besides, the bindings doesn't allow reboot modes on PMK8350 so maybe
setting no reason shift is correct regardless so it gets skipped?
---
 drivers/power/reset/qcom-pon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-pon.=
c
index 7e108982a582..9cd55f5536b4 100644
--- a/drivers/power/reset/qcom-pon.c
+++ b/drivers/power/reset/qcom-pon.c
@@ -90,7 +90,7 @@ static const struct of_device_id qcom_pon_id_table[] =3D =
{
 =09{ .compatible =3D "qcom,pm8941-pon", .data =3D (void *)NO_REASON_SHIFT =
},
 =09{ .compatible =3D "qcom,pms405-pon", .data =3D (void *)GEN1_REASON_SHIF=
T },
 =09{ .compatible =3D "qcom,pm8998-pon", .data =3D (void *)GEN2_REASON_SHIF=
T },
-=09{ .compatible =3D "qcom,pmk8350-pon", .data =3D (void *)GEN2_REASON_SHI=
FT },
+=09{ .compatible =3D "qcom,pmk8350-pon", .data =3D (void *)NO_REASON_SHIFT=
 },
 =09{ }
 };
 MODULE_DEVICE_TABLE(of, qcom_pon_id_table);

---
base-commit: 944a035ecca915ae947905dcfb03f2b9dc6d032c
change-id: 20260907-pon-pbs-76b7ecaafe33

Best regards,
--=20
Alexander Koskovich <akoskovich@pm.me>


