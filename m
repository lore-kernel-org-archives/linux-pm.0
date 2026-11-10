Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329611;
	b=Ft2O1QCAue7wwU/wF0NPgb90hTz5NOrffk9vw16Sh3wlPqBGlkAaaas8dmrtuLEeNZgy
	 L38ZHMsaXnhuAvt/6gbUuFmvScTx5fi/SM9QMirPdUN2QrHL8/4VClK/sAx2SSQPKb0pr
	 B5veN9OAwG/vf1tmKPAL3xlExvH5L8xkpE0IqU0JiIU0GkeyvGVV6lFRSqO/LcgDxhG/z
	 Gl/YspHKVJa5dz8F79gE1oTR6gGtWfQoMimEfcWhrIPcN1mQ3CrWQh7Bvr+2F5ZarMOzP
	 RD3n60GuHikMyOkq9zZZK1Yhkicbl+0SfqOFFq45B3+NSJZNQlTHkcyAx+fjAGHa5zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329611;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=S9BGB4PMADB0aBjp0wYCxbN962ZBvNoG56LesM6ShLU=;
	b=uQ901W7IJJYWVaSOklhOB3cf58M1ixoSXDgQoMFzg8Ub3bytUOkdWEQOt9CQ7ZuQkPE/
	 HYzGRo69J9oY61lCyJkV6DCCr/ViRUMOdakWOG/zSxNt79Pjzt/2gESg/FQW2Pv4j9kgy
	 zG4US/Jr5GBt3fA3FrTH3VF8AnitnViWJyE00cTk6pmHHbuBB2TI7rCjm7/CH0gMWW5g2
	 1CxchJ5+Q2FR7uOp8oK3uxMshA6fBPBsA6tKUEoN4pTNA0OHYYw9L+9zbyKJwZbM5N+8f
	 i8j1/SH3focsqcs/tAqFZdjTBST+bjv1xqbdDrlG3HJbgY4bJoGTxPZrrU5P/kD24Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b="OD+K/1tT";
	arc=none smtp.remote-ip=212.227.17.20
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27B760A3802
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 16:53:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C27B760A3802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=OD+K/1tT
DKIM2-Signature:  i=1; m=1; t=1794329608;
 mf=PFdfQXJtaW5AZ214LmRlPg==;
 rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
 d=gmx.de;
 s=s31663417:rsa-sha256:Cj+xhJTIdk76ixL2xNapN5h5+YmY
   EuUigoZoTw5IjHYW7hPNbe93chw3+FFHE5TSRJuSU8/l3stOUq2XGykK8pcB+R9BkJYDuy2qHpf
   B3xMe7A1YkhfH8RD1WYwGF8PwJEKmMLKt2jtK74bGLSDCCtFnAaGhiTheu1+/aeXInZct5mt7As
   nlfneDkshmBpMge5N6YFSAYWR2SpDWle67RaSPyZymyZM6f8Ex2i+iHlPLFjYdR1zpmYDOKPuvp
   omhZEKM+isX4cbUbNNz/Cjov/+iP5vHYvHZUWEQw//gsUV0u9g2MiJC3eAeV+Qwyf6JvammzVTv
   Jn7QHoY4ufwwSg==;
Message-Instance:  m=1;
 h=sha256:
   U9Y8/NIAQALOxeAbWUX6X6/Th8BD1JgQQq/26QCKPVU=:
   SNI28VtedYCB1M+rhu8/WwGK3HHuOb89rKr9XQRCRyo=,
  sha512:
   0xB7bQD7Y4YWLpRckMoymJ62ryLQ5Y4JuK+tDEzVvP9u/UEdtFwWog62gcoAPs93zoEykf0MCSqVTc5DXHLpvQ==:
   zFPPhHwEABjC8fjphETf1Z0rJvdT4WKvQOjTTUuSP0nSTlkQoHjwInfBB7DHaEg/PLXCY8I9diS41fh5fKiigQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1794329605; x=1794934405; i=w_armin@gmx.de;
	bh=S9BGB4PMADB0aBjp0wYCxbN962ZBvNoG56LesM6ShLU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OD+K/1tTqIUobycctieq//F3x99J0i6aJPsU7TZtI+TDh/3QrFtNzzg4EmGtgCE5
	 l5nam5dtfIyerg6AxV51r3svsx/tGti3nSgW53mNxlDn28z5qVILE1la12HCaKHEa
	 urKAY2iQobs4lL/VbK+zXDAbGZ/SD7V51C3zpXiX9J35vmCzZT7PGOVwRrQAMI4/f
	 lPs04xRuKvGPpu/y0iN7Kd8/Hm/i3Y0EzXSNUZLk+u9s1ObaEIW572DKFVcP6/n4b
	 cVJD9NbZ/3YxTV1bDmDol1weDJFYxeS4TKy+7QKkFNubGhPtoUEqdmskg8D3ZfHhr
	 BF7fxD9125idS2mWfA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxDou-1wXuAO3tCi-014EWM; Tue, 10
 Nov 2026 17:53:25 +0100
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
Subject: [PATCH v2 1/9] power: supply: core: Add power_supply_has_property_direct()
Date: Tue, 10 Nov 2026 17:50:02 +0100
Message-ID: <20261110165318.631010-2-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:naKnM1oc3qiA5O/pH3UUWDoJkKSYroXHBCUWKwDWjPSlMe3frxu
 iMeB0UNxdhgZyygNAovbila9rDntYq70P4ZzPo8h2dvyYRnU27xKxb9YyrHaevZKLT6JChK
 OqvJFV/BdDEQSrPTXZ+hmhTUW1fDfFNxTALSwMSLfl6VNpRuWE2ZMv02eA4E2iSiltCyPJb
 uOtIQSyDq7PvzfQEZC/cQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:R80TtX9J5Bs=;APFKe0ApkqWwKXuYKtDPR3SoKoJ
 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
 5j5dp0c/3wqfwI3HrfnkAHq44ckMozJijbrA==

Providers of power supply extensions might want to check if a given
power supply supports a given property in order to select a suitable
extension to load.

Add power_supply_has_property_direct() to enable such use cases.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/power/supply/power_supply_core.c | 26 ++++++++++++++++++++----
 include/linux/power_supply.h             |  1 +
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supp=
ly/power_supply_core.c
index 1cc203f2780b..75b53aec5db4 100644
=2D-- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1367,17 +1367,35 @@ bool power_supply_ext_has_property(const struct po=
wer_supply_ext *psy_ext,
 	return false;
 }
=20
-bool power_supply_has_property(struct power_supply *psy,
-			       enum power_supply_property psp)
+/**
+ * power_supply_has_property_direct - Check if a power supply property ex=
ists without checking
+ *				      for extensions
+ * @psy: The power supply
+ * @psp: The power supply property to check
+ *
+ * Check if a given power supply support a given power supply property wi=
thout taking into account
+ * any power supply extesions registered on said power supply. This is mo=
stly useful for determining
+ * if a power supply extension should be registered for the power supply =
or not.
+ */
+bool power_supply_has_property_direct(struct power_supply *psy, enum powe=
r_supply_property psp)
 {
-	struct power_supply_ext_registration *reg;
-
 	if (psy_desc_has_property(psy->desc, psp))
 		return true;
=20
 	if (power_supply_battery_info_has_prop(psy->battery_info, psp))
 		return true;
=20
+	return false;
+}
+EXPORT_SYMBOL_GPL(power_supply_has_property_direct);
+
+bool power_supply_has_property(struct power_supply *psy, enum power_suppl=
y_property psp)
+{
+	struct power_supply_ext_registration *reg;
+
+	if (power_supply_has_property_direct(psy, psp))
+		return true;
+
 	power_supply_for_each_extension(reg, psy) {
 		if (power_supply_ext_has_property(reg->ext, psp))
 			return true;
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index cce61137aef4..73bcb127d0fc 100644
=2D-- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -934,6 +934,7 @@ extern int power_supply_is_system_supplied(void);
 static inline int power_supply_is_system_supplied(void) { return -ENOSYS;=
 }
 #endif
=20
+bool power_supply_has_property_direct(struct power_supply *psy, enum powe=
r_supply_property psp);
 extern int power_supply_get_property(struct power_supply *psy,
 			    enum power_supply_property psp,
 			    union power_supply_propval *val);
=2D-=20
2.56.0

