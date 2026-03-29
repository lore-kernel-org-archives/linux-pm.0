Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD0236C0CA
	for <linux-pm@vger.kernel.org>; Sun, 29 Mar 2026 12:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774787721; cv=none; b=jftX4mrB1l8+qGOUalY1S7S+hUbkLnKpjYamk6Q98qrpp5qGXuALjwxSchVlHCTB6C8+OZ8wlgCqL5F0KR74dqpyDGeVlFe/0OYFukspev++rgKVbcr3GfVMVGeFKySCoBsFAJfPaFVgqQyDKB6Ywv/uqPg13GGP764R4gkXZ8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774787721; c=relaxed/simple;
	bh=hb3b5Xn6nqgDmPUXGa8SEWTqyas5qT4V0APOofxhyPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S4DBVrpYx66D4gi1F4El0mULX2rRBS3ZWAsZMKjoQvTniiwm4DZyrYYp0bAnaoYdVMmRJBvmzEq3NXIuzJ4exu4AqK8E9vEHTef40FX25lCcu9mQ8nkNFtINI+Yehm65BMkUuqj7KT/i3pGpyg/xbA96J6HjTwA6bbB5bCYcswQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GvjEv4dg; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvjEv4dg"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c766cf593daso2606228a12.3
        for <linux-pm@vger.kernel.org>; Sun, 29 Mar 2026 05:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774787720; x=1775392520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5wKSxAHN0Stzff0w5tTcgOX+ksB7Z1iTuqZjXxjUVhY=;
        b=GvjEv4dgw0TyGju87nChsRll8zSJE5Gs7b71k4rez4mNcMFHrHSvkRAj4qjPoMtP7S
         9x1rLXFS81NWf9y8FycZlkt9qqRJtZInqcWD14iLLw1UBDfJLPcDgtcQqfZxk2TSs6x6
         LdGavDrt+B+iY0ubkMY5VVp/1IyOFau4B6xQ3QVVC+k+7CJWADMYZpGePar90IRCWX41
         7k1qXqYJZyE0QT+xUp70bi1glgNRWScd7xv2gN76SHesyokkFmmAPWju3zjwfYXIiOr8
         Rn2KL++P1eMcbq4yz3IsMqMdiv+t2x8uqvmr70+P4bQZlq8MIpxLNcPAc13VgoRXxiYT
         VaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774787720; x=1775392520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5wKSxAHN0Stzff0w5tTcgOX+ksB7Z1iTuqZjXxjUVhY=;
        b=kgJr/+ZgTm375QAtBJtb2DJ8P2aGL6y/uzvWFuX9oL7r57nUCdlp9fQkjKJf0DPEJV
         Cw/7HbUL5Sp12G+2icItI+gG06nPXqyXuHc5LEW9y32b80qYkuwExkQ4A3xGaeG1kf2u
         qr9uSCSdn4MgbXYhubqksoEbIAmN1sPZQ02gSJ9sFMhEnjbFxMPfB/AyogViLeZT4K88
         SMzo6rBS7QlzRQlPU5NjuO/Ekof7tGCzz4EY/QVdajmlWxeF8rmqoCibhKws7Fgyx7HP
         HikjPfTPFQ6MMXEFMWq24UqcvnhTb78NZuvJdYMjyeBsBe8QpCBP0N69T3E6vzS/CFme
         Xunw==
X-Forwarded-Encrypted: i=1; AJvYcCWs0mEV2/mdugOiJFeCv8RUOgSNsHb703+2bmsTmKbyI+0fqWwCvSar2OIVEenQhjV8ldg/DqwNNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUDDMxtdpossoXSDMwbTz5mWQaW3IvkFCKdajWI9xUxjT0LYqJ
	3HAWNvXiBgeklAGhqaNd1rY3S0wXAhfh6VifncZEkU4vK2uMCOoxv1jg
X-Gm-Gg: ATEYQzymv9XPLhBT/tEEvjCODwfrYTlPt08qnNv0dSNtswnfFT8psSzg+H6w3CbtVNm
	dnG88D4ALn2yoQN9DG2QYz2RJV5waHTHzp6Se5aKI6DFlNsDiUWpCQGWoZ5WqB6OdX4Ad+yPFGN
	cYDKPI9vP8ve/xtTyBQWWVljV4FDfg1aDYrHKl9tyXey24/euy9DfXCiyg7tqGJwXqSBrFnktsu
	lGATUf5Dgs+3F1gZtCeMvlWuXmvngsilQx6TWUdaTsvFUPVplD/OYS/NU2Q2LiRLZD+tFuWtoQd
	YgNpqQdcPPsamrrSOp0sud1kypKb4uXnMPmG1P65bquTmb+Yfjw+gDEUSt8ALY8VpaOo5IHxJ7j
	yBA4XmHFRwK4+qoOecD6gQ+2stEz2KYrTv77MlqU+gqsr9NrmYlujFvl7cqea6QOoQMdgRF75pB
	RU0Y6IBDm3FuB69ARdXtEVXhQM+beCh/h2ksNMsJku2oaLL9/0zKsoqa2T/8SMuRJWI6hv+Y6s0
	24=
X-Received: by 2002:a17:903:1a67:b0:2b2:51e8:2c20 with SMTP id d9443c01a7336-2b251e831bemr6342265ad.21.1774787719650;
        Sun, 29 Mar 2026 05:35:19 -0700 (PDT)
Received: from toolbx.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427afbe0sm58709665ad.72.2026.03.29.05.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 05:35:19 -0700 (PDT)
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: rafael@kernel.org,
	daniel.lezcano@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	vireshk@kernel.org,
	conor+dt@kernel.org
Cc: Gopi Krishna Menon <krishnagopi487@gmail.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	soc@lists.linux.dev,
	daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	d-gole@ti.com,
	m-chawdhry@ti.com
Subject: [PATCH v3 2/2] ARM: dts: st: spear: remove undocumented thermal_flags property
Date: Sun, 29 Mar 2026 18:04:44 +0530
Message-ID: <20260329123449.309814-3-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260329123449.309814-1-krishnagopi487@gmail.com>
References: <20260329123449.309814-1-krishnagopi487@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

spear13xx.dtsi defines a thermal_flags property in spear thermal sensor
node which is both unused in kernel and undocumented in spear thermal
sensor's binding.

There were no dtbs_check warnings associated with this property as the
underlying spear thermal binding was not converted to DTSchema.

Most likely st,thermal-flags is a misspelling of thermal_flags in
spear13xx.dtsi. Since both st/spear1310.dtsi and st/spear1340.dtsi
define st,thermal-flags property in spear thermal sensor node, we can
safely remove this property from spear13xx.dtsi.

Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---
Changes since v2:
- Reword the commit message and subject to correct explanation in patch 2
Changes since v1:
- Changed unevaluatedProperties to additionalProperties in the binding
- Reword the commit message and subject in the second patch

Note:
* This patch is part of the GSoC2026 application process for device tree bindings conversions
* https://github.com/LinuxFoundationGSoC/ProjectIdeas/wiki/GSoC-2026-Device-Tree-Bindings

 arch/arm/boot/dts/st/spear13xx.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/st/spear13xx.dtsi b/arch/arm/boot/dts/st/spear13xx.dtsi
index 159e941708ca..0bb88f2d4ef5 100644
--- a/arch/arm/boot/dts/st/spear13xx.dtsi
+++ b/arch/arm/boot/dts/st/spear13xx.dtsi
@@ -332,7 +332,6 @@ wdt@ec800620 {
 			thermal@e07008c4 {
 				compatible = "st,thermal-spear1340";
 				reg = <0xe07008c4 0x4>;
-				thermal_flags = <0x7000>;
 			};
 		};
 	};
-- 
2.52.0

