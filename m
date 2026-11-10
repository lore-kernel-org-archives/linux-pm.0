Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794270010;
	b=BT2MjeBxaJTLe2xA2W/kFSV61dVKedXew4k9pAdLBPdnsJ5ElTEJzJ1XPbe8HGcrq5Vz
	 TEYzU+7y/DeZ6AfnEhmaa6hHWxhfyrhXGhyw/hNxl2PCAmOPoMzx77khBWuKm5Js0Bv0X
	 0vedSJmNDjQPTkRIZ/Qe30d/3G4Q0KRK9gn+rkcX8gU4Qc2U54owHZJa+qRtz7B9r80dF
	 RQV8W82D0NTCQv262fxUXJrN3MmUbZxorV5MBxoMmFGs8fAG6H8+xkCvtZiB3X9vQ12QA
	 bQMzHvzsjFP8/GQnYb9m2AJnf/nKE3EKLvgtejQpggxX9g1C+5QuongiDJNzGhg6mAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794270010;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=7qBHkYihiGAtuCcDFhccjhcU0REzwNx/DK8DtfAXOJY=;
	b=dVa1kflVm5zMKS4aJut0WElWbuh9NhzJ7yno4xpf7OvV8TY28VK7hlPtCMs8cGruIsHs
	 VpTXIyrYtZ8ftdQFsZNYceCvrY29tmeb109IhY4MmUCbWt9NIZd/De1sf5Q02m1IpJquL
	 fRRndsxhBVdNiPuL4cszVgr4oIk/9EjWGKbMXCZROg9yfK7mJAeZzIgi+rcEMqkQMiJoG
	 nO/Ilr9eTjwNu2P8r5sec6s46czbPhmHhIZMfQu7h2jBrnr/J0lnEO2DltARwxfn+iq4V
	 pL8N1xNsMOHlfYzNrxJuEGzEzXKPDwndPFVipW2Xzm7i0C3G42ajS2hZI+241OylO6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=YkpGNZ+s;
	arc=none smtp.remote-ip=212.227.15.18
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E3D60A3839;
	Tue, 10 Nov 2026 00:20:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30E3D60A3839
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=YkpGNZ+s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1794269994; x=1794874794; i=w_armin@gmx.de;
	bh=7qBHkYihiGAtuCcDFhccjhcU0REzwNx/DK8DtfAXOJY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YkpGNZ+s+tQvOw65HJrNvYI1BG7UZcFSuHIwHMnQ9/BsItwu21JosEUW8b7ktc/E
	 K843INgb3k8+58dSMlSJyR/BRE7Brs4tcIyV3Y6RLQvCB4B+N7ct+aR8EsaPJY0z5
	 1TKE2l1lMmFjBWCPaeBaCm3abF7uq7sAXMMLOfEt/S1qMGWNUo2L7n+ptZGwximWz
	 xGIiFvSs30fy0lRWnHWNAaJmAFO36o2yQkLoVzrM420YoYvIpx8eYWLwyax/yXajK
	 jCz3hd4Aa5v/EGdK8xd4W5t5o7rZYKN72Bp3Dd6aAoLL234CC8yuxIIoxwHP6k6w4
	 43yLwoL5kAy9gX474Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MsYqv-1wbmBV072p-01598w; Tue, 10
 Nov 2026 01:19:54 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bifangknt@qq.com,
	nicokessler@icloud.com,
	sre@kernel.org,
	linux-pm@vger.kernel.org,
	wse@tuxedocomputers.com
Subject: [PATCH 8/9] platform/x86: uniwill-laptop: Add MECHREVO JIAOLONG Series-X6xR55xK
Date: Tue, 10 Nov 2026 01:06:50 +0100
Message-ID: <20261110001725.851443-9-W_Armin@gmx.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110001725.851443-1-W_Armin@gmx.de>
References: <20261110001725.851443-1-W_Armin@gmx.de>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yYS4A0L4+6cn23ANMbhrZVs1L19h6uo19c4S8yyPndPH02ZPFIB
 cIF6MI0HJlT7F5FWffMQKWFgoqdapG5a1K+4CKa7vDhBUJu/4+S5wjc5O1LDiXlhDSfhGVx
 DHZOmBzt/Z+rJNcaURIBJrOnQc7cwxlAm1EWaTFFPMcRBtvIvAtfj9gHgi7jzxyZFwAeFns
 pncTOHiwivpmd6kBezTtA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OSE8O6IfEqg=;dRNHAzk+lYqMiMVf4ZxBWVtSL+N
 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
 dr3jIjGBRaixKD/uH42oD5pkSjg==

The MECHREVO JIAOLONG Series-X6xR55xK is similar to the TUXEDO
Stellaris 16 Gen7, but also supports RGB keyboard backlight. Add
the necessary device descriptor for it.

Closes: https://github.com/Wer-Wolf/uniwill-laptop/issues/20
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/uniwill/uniwill-acpi.c | 24 +++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/platform/x86/uniwill/uniwill-acpi.c b/drivers/platfor=
m/x86/uniwill/uniwill-acpi.c
index 10c26822a607..6b0138246599 100644
=2D-- a/drivers/platform/x86/uniwill/uniwill-acpi.c
+++ b/drivers/platform/x86/uniwill/uniwill-acpi.c
@@ -2797,6 +2797,22 @@ static struct uniwill_device_descriptor mechrevo_yi=
long15pro_descriptor __initda
 	.kbd_led_max_brightness =3D 4,
 };
=20
+static struct uniwill_device_descriptor mechrevo_jiaolong_series_x6xr55xk=
 __initdata =3D {
+	.features =3D UNIWILL_FEATURE_FN_LOCK |
+		    UNIWILL_FEATURE_SUPER_KEY |
+		    UNIWILL_FEATURE_BATTERY_CHARGE_MODES |
+		    UNIWILL_FEATURE_CPU_TEMP |
+		    UNIWILL_FEATURE_GPU_TEMP |
+		    UNIWILL_FEATURE_PRIMARY_FAN |
+		    UNIWILL_FEATURE_SECONDARY_FAN |
+		    UNIWILL_FEATURE_NVIDIA_CTGP_CONTROL |
+		    UNIWILL_FEATURE_KEYBOARD_BACKLIGHT |
+		    UNIWILL_FEATURE_AC_AUTO_BOOT |
+		    UNIWILL_FEATURE_USB_POWERSHARE,
+	.kbd_led_single_color =3D false,
+	.kbd_led_max_brightness =3D 4,
+};
+
 static struct uniwill_device_descriptor lapqc71a_lapqc71b_descriptor __in=
itdata =3D {
 	.features =3D UNIWILL_FEATURE_SUPER_KEY |
 		    UNIWILL_FEATURE_LIGHTBAR |
@@ -3158,6 +3174,14 @@ static const struct dmi_system_id uniwill_dmi_table=
[] __initconst =3D {
 		},
 		.driver_data =3D &mechrevo_yilong15pro_descriptor,
 	},
+	{
+		.ident =3D "MECHREVO JIAOLONG Series-X6xR55xK",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "MECHREVO"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "JIAOLONG Series-X6xR55xK"),
+		},
+		.driver_data =3D &mechrevo_jiaolong_series_x6xr55xk,
+	},
 	{
 		.ident =3D "XMG FUSION 15 (L19)",
 		.matches =3D {
=2D-=20
2.56.0

