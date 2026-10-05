Received: from mail-ed2-f34.google.com (mail-ed2-f34.google.com [74.125.228.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CA847426E
	for <linux-pm@vger.kernel.org>; Mon,  5 Oct 2026 16:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791218602; cv=none; b=O1GD6+u3r1Tedx/aOqIz+o4vPmwNF2pUqOc6WgW5IV3+0Ib6TtZPhr1wvBRDl8jV44sKpS+ay5+o6RNkOD0U2ubZTwPQoLCpdcarYZ8osKoEeIRJGHolmL4uoyZl+CIne76wPaz2M5cH9H+VjLBX7jSAdl9GLV4q1VwIgdKnF5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791218602; c=relaxed/simple;
	bh=YB+YbwoKBhI3W4nwrDoCGLgvOKJw1wBczHlEC67lwnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Leg6hEfxqhswfhWuh2uaxB9tQWea0umxx/2It9tFygKxpOeQ0GekRMrEpx30bQVQAfMebjFRrBhP59pisNpTD+PDOPhOKMqgB8ubic5vRev9mfHm4ZKzeiqU0m5bly6s5d2/pqwao5VMyKD8qABOgvM+LYASlDzU270QUly/GDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbHxTNn5; arc=none smtp.client-ip=74.125.228.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbHxTNn5"
Received: by mail-ed2-f34.google.com with SMTP id 4fb4d7f45d1cf-6afbfed31d1so2177596a12.1
        for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2026 09:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791218593; x=1791823393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K5qqgHu+1fJfvGHmeLfFQndeBQWOkuM18hB+/Gz5BUo=;
        b=CbHxTNn5gouwFLhqX6kvWfffsGp/cjztnVn4iVlCbwlU6rbZPiswRykQK39hwSVH0C
         0vDkum70MIfK8BnpRnZgTTIfVJcg2GABOIXNHlmn0vaV50N95WP12q/7Ep8XJGA+Y8VH
         JmcdahN5MFc9JQEGG1ESLBlfIzw84cRNhRie7uvKlD4jS2/Xr/WvjwRueBUwQGrqnk23
         +DnePaeozkosPPQCkzeNoIUmYUye9/PB6lARqeXHyTYz/6EZI8e8E9Gwn417i6GZZFFu
         IZvmFMiwcJgwkZtupiCdvrhUlAqMVrepnbnhAVsY3swrgzI1WXJ/Nplf0tXwJhsWGf4j
         ucKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791218593; x=1791823393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K5qqgHu+1fJfvGHmeLfFQndeBQWOkuM18hB+/Gz5BUo=;
        b=Qzexg9TEKwpjQCpdP+jnvghxYYrN1SnuF0WKkUbj7Im9tmE4YLny0xX+ZS0byG0lX4
         CvUeix/3C7SU6RtPS+4Kj2MnfuELbPZnpYCY9NOLFEZZEzv0bp9A3Oxa4Z5WssKVr0sl
         5lbbOpur8Y+DX4qFUX2cfqsNhFnud4kw4f3iziDP1X9FUndQ0nyXyUgcKRAOD0JJaBmm
         z7MSHT9Mhtr29xCJjIHoYzsrsY2+skWhSGoRCp/4hhGxhLQ1ODZ1xwsmOLgqoydLuje2
         G8qKW53srYztgLaU8m4POhsenPDypGiW6clHB4G9JdJu/TpMnMlafLof5nXEVy0WfE2x
         rewg==
X-Forwarded-Encrypted: i=1; AKwUvBxVJjQunJeQ95NYr+EEMDXhepWBtjwqkMY79lT6+ZwfkCGCqFExTRnmj6y6Iios3PP0MEFo3YESww==@vger.kernel.org
X-Gm-Message-State: AFq9FYI044Xe+EdhMuWm8aFXm+BsHAQWRKArHu2p7VwqTvPZnWKRHV+L
	B9M/Shp8kxCvNaR7c3+dhnKan8MWuj31uAWGEcqnFcjMPDvmEf0N/xtY
X-Gm-Gg: AYBFou1ajbbacZOmQhajwhW7QLc8MJO0gr3Zo3j9/Ksd06KXlboD/oHKFohQm2ozMzu
	76fhSVHFWSfa4IFCKWZo3tJE4y/qM+KQLhkJJCWpPNXZcOYqx0Cs6AxGUwWnTU/84r1rT4aDyUG
	mHk69tpVdZtiLcP9xnfsltsY7biD88AtkbFVBzWmqbQ6Ge2Doe07mVGofx6yfLgogSUbdwT7+w+
	Y3gYhN5aCux9zVJWVwP8yOfAIGJV0slMAd6dygUE6UhFVYBVSdhuaVXGIC1iwL7lSxFKaIyXUEC
	mB/wnWCeNyYGPbl8+pfjqc8cwyp6qZmvsh5a6AXowPwg6bZPHoL2jra4MrpmkDOMoO8FTI5k6Sm
	is5hpsfZrMn0pUxSxSzC/YG5nfav4MFjgoXZbNEkJVTcTlziRe/BPlzi7zyhGMKoqpLdkAMYCvq
	L6kdEcPiMg9KADwcJZTmpNZ1wdj3AKa5Max4tqJYvf7ftHd0qb65zY15TJBhMG+nE3zGH30yJ6H
	8CgMyiV1zeAheUXmRHZxts=
X-Received: by 2002:a05:6402:24ce:b0:6aa:734b:1a28 with SMTP id 4fb4d7f45d1cf-6af9e2ecaedmr7014561a12.34.1791218593075;
        Mon, 05 Oct 2026 09:43:13 -0700 (PDT)
Received: from workstation.home (161-53-210-87.ftth.glasoperator.nl. [87.210.53.161])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6afb021af56sm3485851a12.31.2026.10.05.09.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 09:43:12 -0700 (PDT)
From: Stanislav Zaikin <zstaseg@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Stanislav Zaikin <zstaseg@gmail.com>
Subject: [PATCH v5 3/3] arm64: dts: qcom: sm7325-xiaomi-taoyao: switch to device-specific pmic-glink compatible
Date: Mon,  5 Oct 2026 18:43:03 +0200
Message-ID: <20261005164303.1208127-4-zstaseg@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005164303.1208127-1-zstaseg@gmail.com>
References: <20261005164303.1208127-1-zstaseg@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch taoyao to "xiaomi,taoyao-pmic-glink" compatible so
qcom_battmgr can identify the device and apply its taoyao-specific
battery property mapping, required because its firmware shifts
battery property IDs relative to the generic sm7325-pmic-glink
firmware.

Signed-off-by: Stanislav Zaikin <zstaseg@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm7325-xiaomi-taoyao.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm7325-xiaomi-taoyao.dts b/arch/arm64/boot/dts/qcom/sm7325-xiaomi-taoyao.dts
index 6f8bc65bb99b..bc4dfa49ef38 100644
--- a/arch/arm64/boot/dts/qcom/sm7325-xiaomi-taoyao.dts
+++ b/arch/arm64/boot/dts/qcom/sm7325-xiaomi-taoyao.dts
@@ -72,7 +72,7 @@ key-volume-up {
 	};
 
 	pmic-glink {
-		compatible = "qcom,sm7325-pmic-glink",
+		compatible = "xiaomi,taoyao-pmic-glink",
 			     "qcom,qcm6490-pmic-glink",
 			     "qcom,pmic-glink";
 
-- 
2.55.0

