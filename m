Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794270001;
	b=A4J6JdyZyBYrLxK+fxRd27SqIv0sxpq5IZz9KJCTXfCE6lazpqpsAoqNzL0szVbl4aUh
	 Zi3jtK/3fhtQNqkcuDA3TPn7vD5vxceiKCFnPnSRnj/KqL/PS/6UJ01okT8n4Yg+Woagk
	 60tbs1oFeGeJAgh3IZkrFQtzr3/ECln4eL/sBC4inOSy5j8l1NKYARaq5ysyz36Vr+yjz
	 ng47RkN0gLI0EM5zOIOGg147X7WadTSJx3J7dJrjzAxdYUxsXbFgW8cFioNpF3m9TrKOl
	 HfhLaSEUNhy+YXhCFexfptjPAA0duqCDEDDEJgLdpCMMfUeybSdyaXd+YtW3GUmp0jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794270001;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=dlRfBA5nugtZF4CjcAuAY3LOFujUJ/XbPAFulql6U1M=;
	b=jNBczyC9iWNSK44qfUaN5QrrfRmz9IdFQFheoKdYakeFq8BiJqOQ91YLVAGHfYodiJcM
	 KKv/PExjrgZq1d6VpP+zb0Wcbn+44+VDaXcc8sxWIJAx3PWQo00x/CBjETg8JJnfXH/Tv
	 Gcqc1/5XqM6wId8Z8Vn4nmqjJQbJ8C2gJq1crmzLHD7LRmKck0CSpuyjFUQmiJpbvxiHo
	 euz2lISDUNiolAkdgj4nsXJpzzeK2xk0mZg8b9GTaM01xhtraxpcnP97yDdjM9Z/VvwVi
	 GGtx//zMuwSYUhSsL2XWgo/m1mp59ICNAZ7ByHVjLlVVtfisdz1QFsvdef2DB+ctG9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b="L/R4YDDg";
	arc=none smtp.remote-ip=212.227.15.19
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E39060A260A;
	Tue, 10 Nov 2026 00:19:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E39060A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=L/R4YDDg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1794269992; x=1794874792; i=w_armin@gmx.de;
	bh=dlRfBA5nugtZF4CjcAuAY3LOFujUJ/XbPAFulql6U1M=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=L/R4YDDgDuFTi5001/djY6jam66vGdnyU97a07OdvtgxSeNWPz5hQQdJHug0Oq6T
	 wMJuZvJLQRzT7C5dmyMMDv9gcX4MTeuYV4TzzoMNpVcM4oizWXRdoUWsiKce5UpY9
	 n45u+KdchrHaU7E68HbqX5Xint441cHmtZCGG5bCdTrkBRAj89LeYMLINu0zxO2G3
	 eVVxIE4A7GmrrDX+eG4OUZNaevdfC6k52BDc1mvpNp/1+5plAtOJBjxLeUnCkFvuF
	 O5j8QiNRqQeUTFBshht1pYRRunPKximLFtCuncgoOhtIJq9V6gvp3j3CKEvc+rFxu
	 wvi6kmqok6YtIc4b9g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mi2Jn-1wnP9l1AMT-00lxbc; Tue, 10
 Nov 2026 01:19:52 +0100
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
Subject: [PATCH 7/9] platform/x86: uniwill-laptop: Add support for MECHREVO Yilong15Pro
Date: Tue, 10 Nov 2026 01:06:49 +0100
Message-ID: <20261110001725.851443-8-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:MOdfCoIqhhpWfoxcu/CaY/OS/kVL2clmmoYh1E0W/ObTSL2OgmJ
 pCe/TNO+oq+E+LQmapx+EdOM43ymt1JnwN0bTGbqs2KfAoTz8Vz3UfN0/P5Dq7xjbepHZAv
 1h2Ngf7rMBAxkkWmV1uvnPKF1dR4zP1/7uh9pKiJxSnIVsQkmieV8Xn6zO/1A35vJ4H7zI9
 128DxmD6ZfQvQNnZXCAIA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1pooDj5r1TQ=;B71XWzMmFfimNGawqpJQv/SiOzt
 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

A user reported that the MECHREVO Yilong15Pro works with this driver.
Add it to the DMI whitelist to let the driver automatically load on
this device.

Reported-by: Bi Fang <bifangknt@qq.com>
Closes: https://lore.kernel.org/platform-driver-x86/tencent_D521DAA244039D=
BFC3919D4EFD176E383607@qq.com
Tested-by: Bi Fang <bifangknt@qq.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/uniwill/uniwill-acpi.c | 24 +++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/platform/x86/uniwill/uniwill-acpi.c b/drivers/platfor=
m/x86/uniwill/uniwill-acpi.c
index a987fb310b81..10c26822a607 100644
=2D-- a/drivers/platform/x86/uniwill/uniwill-acpi.c
+++ b/drivers/platform/x86/uniwill/uniwill-acpi.c
@@ -2781,6 +2781,22 @@ static struct uniwill_device_descriptor machenike_l=
16p_descriptor __initdata =3D {
 	.kbd_led_max_brightness =3D 4,
 };
=20
+static struct uniwill_device_descriptor mechrevo_yilong15pro_descriptor _=
_initdata =3D {
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
@@ -3134,6 +3150,14 @@ static const struct dmi_system_id uniwill_dmi_table=
[] __initconst =3D {
 		},
 		.driver_data =3D &machenike_l16p_descriptor,
 	},
+	{
+		.ident =3D "MECHREVO Yilong15Pro",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "MECHREVO"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "GM5HG0A"),
+		},
+		.driver_data =3D &mechrevo_yilong15pro_descriptor,
+	},
 	{
 		.ident =3D "XMG FUSION 15 (L19)",
 		.matches =3D {
=2D-=20
2.56.0

