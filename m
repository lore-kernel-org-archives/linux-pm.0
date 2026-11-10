Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329619;
	b=Gx9r++2UJvSVdYZTafGCfcRk4yYTi+UpPmOeORB/jz3JwrCuvToxB5vClkborKVImjpO
	 pKHS3ycnAfKv9x2rmwJiMkYC12wUaUUVlxJ5+Q6jGCW0Lnn2Zv6ifoirv6LVHBXmH7YJ0
	 C6omBzgo7P352IqmQzF9D8wE7S1pLuZw4uHnp6B730LiTGSX06d5RZ3Gn1Xg8QMwHfwZF
	 CED8r/+UljS32SwQDQiSpbuKPzsiQSKcvsBUWxX5ImJQhgSj0TY5E55YRMTGtQxufukbH
	 fMUXblnPxI1nSQA+0GoXEW0lnIvM0uR2SY7nVrk3pg4qRGY6ZH/diqQsnG0dGZ2AWkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329619;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=erlZlWa+HFGwWJPpBP+AS+peWRxfW9Jks2BR3ww/OOM=;
	b=hsLrGRW0mET2/yIjN3UOqqDFMFmj7AWwCr1Vfe+DXJ4JWsyAxv5Bw0A+UrjdgRvJ42ya
	 M/Rvi243fSuBvpqWznLvp/02EE0kglWvFc1runOSpJPn+sq9gLqbC6EDI6gLNKrQ9ElRD
	 xqEMJTR7DgyBpzPbdsnoF9EOLtcbIS+lQzAZ7pQJIerGYFZ3GzOAGbjNKw+gCiTOAz0NG
	 YG/5B8CW1J44YVp/xcRMoeoeIldR5YqxU+3mS6XtGHRpdJ2LkgXLErk3qijJy6dYW8FkI
	 nLwYXnFHG/eakknTWcajaEig/8H3silx1YtAMv9MlYIMu4flFnpbGSVz/OEGIaCoKcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=J7hwwlXy;
	arc=none smtp.remote-ip=212.227.17.20
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CF060A6F44
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 16:53:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64CF060A6F44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=J7hwwlXy
DKIM2-Signature:  i=1; m=1; t=1794329616;
 mf=PFdfQXJtaW5AZ214LmRlPg==;
 rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
 d=gmx.de;
 s=s31663417:rsa-sha256:h/yGaaD7g+zLov0MaBqGO1eXSHv4
   OEyaiJuIKRyE+PejlpUuo+UJQtKcPeW2ScAiY44HITeOhwlQGkEsR5fBZqkhhfeg2a8S5i/yL6e
   wslggkwfgA+pL0YFuyCl01v4J4/44+AQ6tZVSel2ZVg5zK5VW2EatdEFHAyBsXm8Nh5gIrZ/GsM
   XmhawJdEHw0hI+4FIy1ZXmVwG4ZY9VnTxZje3teDPK/Xi/1jCucO6VC6hNrp6CNg9GMPIVz+UUY
   /A3T3jYz1L6oSl9shyuQ2/44hH3DJVnjXs/MC7jMUrI4blKLNYYFQMLRJNOj3e6zyxH4P4FAmiH
   7xyFsJry+mlp6Q==;
Message-Instance:  m=1;
 h=sha256:
   I/yfTcD84RmWS4h/VWRaIMhwrhZxW9CADoXFxg4MGpY=:
   awVMq4efwsm+ea30u5hUwXmVvq0XUAjEmEzfPZuLV3w=,
  sha512:
   sDRlxUnz5AusXTBh7X4LqqWJATGxyScWJRT+ak6xKd83cW664TVblNu0aHE2u1SCSp2xsbe5ezWYfi3llomvZQ==:
   aUKtAZTVoT0mDgRzvs44uLjHtExmzhP00s8oTBwENn9yndYhAAwcQcNgbxngMq/8y9BVVSHHBU/yZCfxLtrazQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1794329613; x=1794934413; i=w_armin@gmx.de;
	bh=erlZlWa+HFGwWJPpBP+AS+peWRxfW9Jks2BR3ww/OOM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=J7hwwlXyPbWYB0wzJi084dc1VFwNT4Dhm+OvypUGw+l/kQ/tzkErG3vqH3SrK6X+
	 d5QMG7mvo5UxiWnP2umRNHBdb+Hac/PlmNOHheroW9Zln1AvIipfoz2Pf7j6sbgis
	 +JtZmEiDNjZ8WsM4ioQjqP3oshjEz46pLIYgPrQ4gLtn/0dFs3ttpE/4s2hgZ6Pha
	 /S7RiHR0eCQciEaE3iP5vjhDYjyurJ+E5FdK/sYednjL59qurCL5ZrMi9zEizluBJ
	 U5ih0oUUDRQASQ6mtjfrSLwMY5ug7Bihi5SVH6vUb/tVW7eyAc6jrJZfuM8W+x3f5
	 WRy/SZga7v6lhK3BuQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M4s0t-1xR6553NRv-00CvJC; Tue, 10
 Nov 2026 17:53:32 +0100
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
Subject: [PATCH v2 8/9] platform/x86: uniwill-laptop: Add MECHREVO JIAOLONG Series-X6xR55xK
Date: Tue, 10 Nov 2026 17:50:09 +0100
Message-ID: <20261110165318.631010-9-W_Armin@gmx.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110165318.631010-1-W_Armin@gmx.de>
References: <20261110165318.631010-1-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:5GWw/QgIzCT0M+55YRHb2uIoml9GfCCBmAehhDMHCcXaWUI7kFF
 Th0Sh49OQZORfYqyD4UwJtfYh0Du6T5UjrDQg41asHCoV0tdGF0Vu5uq7R7b/6CE6u3t26y
 omkVwg3cFNX7kZBglcuzCIa4JwOejqzuXh3mjGMZQHOuvFOrFEKMteaKtnKpEUENOH+Q7Ls
 DlHVI8fs0xPMSea/D8aew==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/s9j0wHfCxk=;0AGec6raO3uuk003pOL4Vh4PyTI
 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
 BIS5mV7SIu+WDT6QlLaMlX3tEYg==

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
index b71e7a73b4ff..ab02cd002194 100644
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

