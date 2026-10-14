Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863B647F791
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 20:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792009173; cv=none; b=BpUg/O8EbU8LM3OLxw/WTpCM2/6woJS9+lCSpfscTbkkbVt/2uq2EJt5qDpCmOVSMUDznYj86H9A+vQ4bZTNoGszM8ymHwLwOFmxy9r/lNUPv3G6noKTRFFPgfBMRegBo/ePWK8JhZocpZIH39kK52cGwSK4T8j55KIb7Sit0Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792009173; c=relaxed/simple;
	bh=r/2GZax0XDcI6MCY4ePBJtJOHFbaHwbBQrtHdTBpnaQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QA6PvqhY3AQnbBtKli6fqg2JKSW7aGUCgtiWzxpNxJVHSDOgoIg1h7VmjNzQvWe1KFqqjGvJXx8PxeTqVEdoZX0DwW53neFnq9w7dRCIi0QJnR/faekAkPfiLojaP28C9KiA30DhBiqMi/ERV8DHIQKmFUWCH1yAd/vBbXNnVtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tb8IRWJS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dRE7r9o1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tb8IRWJS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dRE7r9o1"
Date: Wed, 14 Oct 2026 20:19:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792009170;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MPdz/Aa0av1a6HfnqhC9jqgCp53fNI6yFO6Y6XCgga4=;
	b=tb8IRWJSgSZUV+weC64dVmvMq4asfkVqNAElsp/tI5SwHvB34q0kD82i/paa3lIb1TY2Kv
	AnO/SKbn/DZbKJ3QnnOHNPwpZwczeVuMMCY0Ksjvz4aW0V5hwWUMCVsYwddPvSbV+5Esws
	J+zQl8QaOpBf6RE+OiIu2mlSrr0drYST5feMq96T9QYYhh2Bv/sy88vrpQVFA98uP3KFPi
	Q5blMtjZBfSxUvzkhZN6Jdtyv4Vf27XgpMkGLzUEs0psxE3NdupyXNrRwA9QCN6zNIlvKb
	jJU/g3HRXR1+UlmHoMJXiRS8a/Cg+d6LHMx5wB4hGrdv9M7jip5uAA+awxtB6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792009170;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MPdz/Aa0av1a6HfnqhC9jqgCp53fNI6yFO6Y6XCgga4=;
	b=dRE7r9o142gqX9eZyzDn5OzIAbAFPoWfv1VZZQabAS79I35B+Kn9GDqft9Pb+w4f7uNJYb
	XraN11d6jVvHkYAw==
From: "thermal-bot for Muzaffer Kadir" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] thermal/qcom/tsens: Add support for
 MSM8952 tsens
Cc: Muzaffer Kadir <muzafferkadir@mainlining.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 daniel.lezcano@oss.qualcomm.com
In-Reply-To:
 <20261011-msm8952-initial-support-v5-4-1857074992ec@mainlining.org>
References:
 <20261011-msm8952-initial-support-v5-4-1857074992ec@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179200916882.2666337.18176100885162191316.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     8951eb8a781ea4704898ea61bbf52435ff1ee3a4
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//8951eb8a781ea4704898ea61bbf52435ff1ee3a4
Author:        Muzaffer Kadir <muzafferkadir@mainlining.org>
AuthorDate:    Sun, 11 Oct 2026 19:51:26 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Wed, 14 Oct 2026 09:45:41 +02:00

thermal/qcom/tsens: Add support for MSM8952 tsens

Add support for tsens v1 block that exists on MSM8952 with
11 tsens sensors. Sensor Offsets are taken from downstream.

Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Link: https://android.googlesource.com/kernel/msm.git/+/refs/tags/android-wea=
r-7.0.0_r0.3/drivers/thermal/msm-tsens.c#1621
Link: https://patch.msgid.link/20261011-msm8952-initial-support-v5-4-18570749=
92ec@mainlining.org
---
 drivers/thermal/qcom/tsens-v1.c | 41 ++++++++++++++++++++++++++++++++-
 drivers/thermal/qcom/tsens.c    |  3 ++-
 drivers/thermal/qcom/tsens.h    |  2 +-
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
index faa5d00..7bda8e6 100644
--- a/drivers/thermal/qcom/tsens-v1.c
+++ b/drivers/thermal/qcom/tsens-v1.c
@@ -145,6 +145,34 @@ static const struct reg_field tsens_v1_regfields[MAX_REG=
FIELDS] =3D {
 	[TRDY] =3D REG_FIELD(TM_TRDY_OFF, 0, 0),
 };
=20
+static int __init init_8952(struct tsens_priv *priv)
+{
+	priv->sensor[0].p1_calib_offset =3D 2;
+	priv->sensor[0].p2_calib_offset =3D -1;
+	priv->sensor[1].p1_calib_offset =3D -4;
+	priv->sensor[1].p2_calib_offset =3D -4;
+	priv->sensor[2].p1_calib_offset =3D 4;
+	priv->sensor[2].p2_calib_offset =3D 5;
+	priv->sensor[3].p1_calib_offset =3D 1;
+	priv->sensor[3].p2_calib_offset =3D 1;
+	priv->sensor[4].p1_calib_offset =3D 2;
+	priv->sensor[4].p2_calib_offset =3D 3;
+	priv->sensor[5].p1_calib_offset =3D -1;
+	priv->sensor[5].p2_calib_offset =3D -1;
+	priv->sensor[6].p1_calib_offset =3D 0;
+	priv->sensor[6].p2_calib_offset =3D -1;
+	priv->sensor[7].p1_calib_offset =3D 3;
+	priv->sensor[7].p2_calib_offset =3D 4;
+	priv->sensor[8].p1_calib_offset =3D 2;
+	priv->sensor[8].p2_calib_offset =3D 4;
+	priv->sensor[9].p1_calib_offset =3D 0;
+	priv->sensor[9].p2_calib_offset =3D 0;
+	priv->sensor[10].p1_calib_offset =3D -3;
+	priv->sensor[10].p2_calib_offset =3D -2;
+
+	return init_common(priv);
+}
+
 static int __init init_8956(struct tsens_priv *priv) {
 	priv->sensor[0].slope =3D 3313;
 	priv->sensor[1].slope =3D 3275;
@@ -223,6 +251,19 @@ struct tsens_plat_data data_8937 =3D {
 	.fields		=3D tsens_v1_regfields,
 };
=20
+static const struct tsens_ops ops_8952 =3D {
+	.init		=3D init_8952,
+	.calibrate	=3D tsens_calibrate_common,
+	.get_temp	=3D get_temp_tsens_valid,
+};
+
+struct tsens_plat_data data_8952 =3D {
+	.num_sensors	=3D 11,
+	.ops		=3D &ops_8952,
+	.feat		=3D &tsens_v1_feat,
+	.fields		=3D tsens_v1_regfields,
+};
+
 static const struct tsens_ops ops_8956 =3D {
 	.init		=3D init_8956,
 	.calibrate	=3D tsens_calibrate_common,
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index b5ec702..4d7013f 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -1192,6 +1192,9 @@ static const struct of_device_id tsens_table[] =3D {
 		.compatible =3D "qcom,msm8939-tsens",
 		.data =3D &data_8939,
 	}, {
+		.compatible =3D "qcom,msm8952-tsens",
+		.data =3D &data_8952,
+	}, {
 		.compatible =3D "qcom,msm8956-tsens",
 		.data =3D &data_8956,
 	}, {
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index e8376ac..a35b153 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -669,7 +669,7 @@ extern struct tsens_plat_data data_8960;
 extern struct tsens_plat_data data_8226, data_8909, data_8916, data_8939, da=
ta_8974, data_9607;
=20
 /* TSENS v1 targets */
-extern struct tsens_plat_data data_tsens_v1, data_8937, data_8976, data_8956;
+extern struct tsens_plat_data data_tsens_v1, data_8937, data_8952, data_8976=
, data_8956;
=20
 /* TSENS v1 with no RPM targets */
 extern const struct tsens_plat_data data_ipq5018;
