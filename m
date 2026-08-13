Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF3D20E334;
	Thu, 13 Aug 2026 01:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786583853; cv=none; b=cuYbNLJrnXUPazDtpK41UGW25CvoNoriNU0Vyq7otsImodUhnHC2R1CNZUgWhtBXgoqMk2292LM0Lbz2pJY95qA9AhjX3Z/U3qVXLZhQx48UfXfpatPYjbWCaV0ameCdDExwKpym01iJDzZazvmR6rLojZINlZNyLJhrVG0bA8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786583853; c=relaxed/simple;
	bh=BoAQijyylgl9c8sSNAPJL6Pd0GB60Ydb6KEiTtDKzwA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pySCrZAra6bhqn/SuTB2Fb9spm5QB1pFYtzK1QWzPXsx/BtO2Q1HWbBaRaw5c5MxsgWPGnwhpq7u4d2ggNQnaHqpeDoi8FADdY7kiEbK+n8IpG5kaE+YLB3b+JPb17Qfp0xjzLDfpD32RQkOw6l0KXeJYV7WDXQDEDoakBGuzMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqD/1iKa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqD/1iKa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E581F000E9;
	Thu, 13 Aug 2026 01:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786583852;
	bh=We2rCgMJ7y9Yy2HND4vPUfHIpTeXfWeTJqdY+HyvBsA=;
	h=From:Date:Subject:To:Cc;
	b=AqD/1iKaQKAR85pu1WRpvwrg5fdEu0SR40u1K+Gt86FLKE5qfJ26WCuo1tnQRyNoL
	 mtbS7YQFlF2Ur2C+QxtKTnCLqOVQzST3seQE+eMbzxLJpPbkL3jmDpRDxCxATX9va2
	 781oHEpnvpc4Sb0cgfp2/qOGgJQvOogMIP+wiITWTocIi9o+cRgjiA7AP95qm++0oL
	 JHFfTwG+/YQUSYoDgzCPgIQDG4K21EXEQjxxbz4LmkiXZqq4eoq2r1eMUu7DcKvxWz
	 gvS3g5P3xMTO98suOxyomMPx5e+BA9lh70bw0r3KJRzsjFfVBH9PwcMcWyr+oyYFkf
	 21kvWGTz0IAjA==
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 12 Aug 2026 18:17:22 -0700
Subject: [PATCH linux-next] thermal/drivers/qcom-spmi-mbg-tm: Add module
 namespace import for IIO_CONSUMER
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-qcom-spmi-mbg-tm-ns-modpost-error-v1-1-d849390d2714@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNywrCMBAAf6Xs2YU2oER/RTw0yaaumIfZVAKl/
 27U4zAws4FQYRK4DBsUerNwih2mwwD2PseFkF1nUKM6jXpS+LIpoOTAGMyCNWAUDMnlJBWplFT
 Qz04bUv6sjxZ6Jxfy3H6PKzw5rg0jtQq3v5PVPMjW7wT2/QONPd53kQAAAA==
X-Change-ID: 20260812-qcom-spmi-mbg-tm-ns-modpost-error-fad8be2f985c
To: Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
 linux-iio@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1885; i=nathan@kernel.org;
 h=from:subject:message-id; bh=BoAQijyylgl9c8sSNAPJL6Pd0GB60Ydb6KEiTtDKzwA=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFm10mp5y5S5bgTxL9/1x/vIwslh7/ecv7lEzmxH0mYdd
 d3fBuZ6HaUsDGJcDLJiiizVj1WPGxrOOct449QkmDmsTCBDGLg4BWAiweEMf2UcXReICP82zKo8
 +19JZtKvjH2Rzp/jGDJmvNDbHh7qacrwP813YrUk/y+ekK7Mr2dXXap5Urmq+lyy6JqFKj+FH5c
 cZAIA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Commit ebf1d03dab96 ("iio: inkern: Use namespaced exports") in the iio
tree restricts certain exported core functions that a driver added in
commit c3dce117333c ("thermal/drivers/qcom: Add support for Qualcomm MBG
thermal monitoring") from the thermal tree uses, causing modpost to
warn (or error without CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS):

  ERROR: modpost: drivers/thermal/qcom/qcom-spmi-mbg-tm.ko: module uses symbol 'devm_iio_channel_get' from namespace 'IIO_CONSUMER', but does not import it.
  ERROR: modpost: drivers/thermal/qcom/qcom-spmi-mbg-tm.ko: module uses symbol 'iio_read_channel_processed' from namespace 'IIO_CONSUMER', but does not import it.

Add the IIO_CONSUMER namespace import to clear up the error.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
I am not sure how this should be handled. As far as I can tell, there is
no error if this patch is applied to the thermal tree directly but it
would leave an "orphaned" module namespace import until the iio and
thermal trees are combined, which may not be preferable. Otherwise, it
would need to be applied to whatever merge happens second (hence
including Mark and Jonathan in this conversation).
---
 drivers/thermal/qcom/qcom-spmi-mbg-tm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/qcom/qcom-spmi-mbg-tm.c b/drivers/thermal/qcom/qcom-spmi-mbg-tm.c
index 0492d5eeca01..a05bb444627a 100644
--- a/drivers/thermal/qcom/qcom-spmi-mbg-tm.c
+++ b/drivers/thermal/qcom/qcom-spmi-mbg-tm.c
@@ -254,3 +254,4 @@ module_platform_driver(mbg_tm_driver);
 
 MODULE_DESCRIPTION("PMIC MBG Temperature monitor driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_CONSUMER");

---
base-commit: 28d012efb4327f9c75d5e042a7c91e9a542efa98
change-id: 20260812-qcom-spmi-mbg-tm-ns-modpost-error-fad8be2f985c

Best regards,
--  
Cheers,
Nathan

