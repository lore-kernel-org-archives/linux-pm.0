Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329616;
	b=FAFHJDnGJ9fwuQXpuWI69GScd2AzWjLY97YaWNrm8787cH0pxplTciWJ4eZGft4gXcAS
	 FsrI7zWE+qU5aWozR2q0y3o3qkDDpLpCChuT9ji5qxqQTzdjTZA3a0bLV5S3ctG3LwD9Z
	 2wL+EXBhhpHZEDe3Bp6LACoqM6ibLTUFate40ds3OBC2n7Yj5hvWyubK181YGLTXQucOE
	 Ka3j96A5/YtwjLqQ1VpBBuyI8sTTVgmu6UZAjyyKwkQaS+DJHhvGAmybCORKuNddYVMIQ
	 5oFc4ANFKkftEIHjDWnq0IdJpypDyv7ks1dtc1ydnSnom4xCg4NJHqXdwjKBfCg9yyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329616;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=/RER00NDr9Q6NVXXkd7Gp6Tg8Wv+6goEFJNK2IeOJR0=;
	b=35cs/WRLQ7HqqDzG/2apoCdkVqTQGzePnEQaZ52hqU1vPBfr9XtUYE8RT4K/LggCNscL
	 nQjPjSCOTjHPOra1pWsSi7D4YqQy9BV79Y1zpv6ijzuiSXN6inV7bdTaYPaH+ksu1Cqbg
	 UOMpfiL+U6VFpiDHPthGm/ydra97eyQO1A7y1PDoFPlsTiY6GD+tNM0I+o1XxU4P+s39b
	 z5vHef65YP2m6HaTm1nQZhJNbYRr+CQI8qQuD39xS8RSg3BUlw0lEHBEW/39EzJmcWs4r
	 4BsWMWGzXtadZis4u2Iox0XzLXZYD5wJ+M4uqz2Z8wH23Vmli/dpI2uMJ2KPvDU7raw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=AmfZNPYM;
	arc=none smtp.remote-ip=212.227.17.20
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9716F60A5BC8
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 16:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9716F60A5BC8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=AmfZNPYM
DKIM2-Signature:  i=1; m=1; t=1794329613;
 mf=PFdfQXJtaW5AZ214LmRlPg==;
 rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
 d=gmx.de;
 s=s31663417:rsa-sha256:ib1zvtow4jRWwXWx+U7vcjp/bZq0
   TEUbqa5W3Rd+vx34pj/YvIKtoorgw/2VigGP97k+qFRfsApKGgWThvGQ/79sg1Afi2Otca9J/jr
   r7vs1zr35iVX84OL2QfAD2IdgvhVQ2q1BUgXCep78kSpdzi1TupH9HRfTUuACGPXcdTq96lGi3/
   pqG0evqtCPo9gDyItbLOCisCVcQWwyhzn+cgSN7ZpiAZTM1wXcp/vmHORjFV9XWoX3LJSYjRBya
   drh/I9MbniPa42Mg/5QOaTttUCbS75CQCc3/mHj/K4LWA0ZfGC+EelWXFLQz+J+25aJEhAMvXxG
   CaEb22bUUQARmw==;
Message-Instance:  m=1;
 h=sha256:
   1eXjTZC/ZjpoCmblF3JbJIM8MpNqIM0Rh9tYRu7rGJU=:
   oI3gMHzVi8JuVfK5NJe35wEI4TLYBzlMQ3HlsFs0dB8=,
  sha512:
   eZYRqi57HG3JHXYlWzXi2o2uxC3Ka1pW4x+yWBOOHdtSawFNpVQ7sasgmkOmPZYYaGJ157J2ufKNCSjm2EWJxQ==:
   R24nVhm6kLBFRxoQFTtnhsNAOhPXvROgWtAFYDo/J/TbrHPLl+vvQlPBpHsBkSjySoLW8tZ12rigBqoxUfCjeQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1794329606; x=1794934406; i=w_armin@gmx.de;
	bh=/RER00NDr9Q6NVXXkd7Gp6Tg8Wv+6goEFJNK2IeOJR0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=AmfZNPYMhjA6SCOoNYBSvmZJAnSU5wpK1sMbswhE6wRsq8vuLnR5zgxZgeVGgyRi
	 UGgPA1cckD4/ofa5XQvZWu63j+bPLPY6P72MUAP8pTrIse7ODHRvzO1LGXBSFksPk
	 29feOSi9dh17+rrfyWdHDw4Yau8Vl8ZYqzzApJLjBfTFbJsRgY26qETkksnhkD27u
	 PS/DPgk1YiVB5tu/9F6JK8KgYHHs/vjognMNznTzDUJxu3eLw+hEAiF727pJgSq3X
	 OfkxwzkL5F01+EYvz5Wf5E62waDR7WTyiY1roahIPTrcRVihGSYa377FrmtAuzuVl
	 up90xY0Co33nzBDd7w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2wGi-1xU6t00GWC-00DWoq; Tue, 10
 Nov 2026 17:53:26 +0100
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
Subject: [PATCH v2 2/9] power: supply: Enable struct power_supply_ext to be construct dynamically
Date: Tue, 10 Nov 2026 17:50:03 +0100
Message-ID: <20261110165318.631010-3-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:GmfaXIlrLjwA7i9Us8KXJZvarVUh8OlZ3lUTTBZ4CoPtU2BKO55
 nXXLRD0n9maJ6+qPL1aSVtTWEXAGiMoko+hBTz0ZrROO4ekxaF132Vp1+0E8ezTxtbuuAK0
 /LtSSiGGJOzKWtb3II0cRfS2FKGypmhF3MHZIjGxhzodyXBk3YFrTTwVt26GnXO4w7vVRcc
 joaLqG7Laj4R/bM7Qz9jg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WcNwVWWiAz4=;zF8UhUzHHY0lLKowBTu7w03EBkO
 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

Providers of power supply extensions currently cannot construct them
dynamically because the pointer to the name string is declared as
being const, even when the remaining members of
struct power_supply_ext are not declared as being const.

Remove this pointless restriction to allow providers to dynamically
construct power supply extensions.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 include/linux/power_supply.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 73bcb127d0fc..a0cabc139298 100644
=2D-- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -318,7 +318,7 @@ struct power_supply_desc {
 };
=20
 struct power_supply_ext {
-	const char *const name;
+	const char *name;
 	u8 charge_behaviours;
 	u32 charge_types;
 	const enum power_supply_property *properties;
=2D-=20
2.56.0

