Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FFB2BD5A7
	for <linux-pm@vger.kernel.org>; Sun, 29 Mar 2026 06:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774764957; cv=none; b=l4BrYxTXJjCcD6FuOUu/wDReiKFCep023rUOED91SqDMDLfnXEyLiwzjaYXRjGH6jpX2r/9cUYSmYL3Cq85G8OXXyXXEeGIFghgyp9nGylkFf4lPwy0e4nsDnAIKE59ereAZaEyuUjM3G60OuOUWFp9PyBZF8H0zSkBfGT6wr5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774764957; c=relaxed/simple;
	bh=iL31+SMrBzKCE3ncPrH6N3IXt0HrvrV+OHrHkY3ZenQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aKQd3kLEsrPb+W2iHBWw1eG5+nS0doNNlSKrlK9Bsn5XB6rbuOGQInjdVMsvLtcggwH74eJOibDAzzgETganltDWNih2h3KMMD5PHEMKJb2eyHNkRVcFo1GtmhmU6n9QfmY09Tpcny81/GvMRt1FZiSh650K/GAn/106UVzB8FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8vuASOa; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8vuASOa"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82a07738118so1957198b3a.0
        for <linux-pm@vger.kernel.org>; Sat, 28 Mar 2026 23:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774764956; x=1775369756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzSVIyxJVE3INc2YlO2V/JlUMWvH8XiTteapFFYHtbU=;
        b=k8vuASOamzjpgg4c180pnK3+vziT5YhwXQCQKYS9zVEZWk9hbtyynosXifGEYkMqF9
         i1YQtkrYzviBIGwP98h0Z7KMh4S4G7+MTsZykZyQQ6jK+U5QqPBpFceRYUQD0YnzXyHo
         drEefCBAnaOYhOPH5ncxWu4opEjtZXRngL3aFjOQI6e/dCy57ifQdqyapaLqxbk6bEJl
         oNj60uThk+fRc6HwZ6ALeQtjxZ/E0QK+KMJukJSqrPujOBg+cDzAIW7Yfc20l25Rmlho
         sXUF5j/FML3adZa8+USGt3KTE5moimJwwtbWKvCkmnhXN29SqUNhs9PCA2sI7EgjlhlK
         N1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774764956; x=1775369756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jzSVIyxJVE3INc2YlO2V/JlUMWvH8XiTteapFFYHtbU=;
        b=kCIjyr8WfrEA8N0gh6fWQCmdPI/qnvrxXx2o0hCXG3xjAqFEDCVziIQazP9HR1ensm
         /ANLLLiUP584erh0s/ylu+RKnPgApthM2XBFzBs72C7+hLBuuOcDWZbOVBI8kKKgEgjY
         fHQb677YWqxETN57bwew4kJ9tO5fltqouygI3n9BsrfhwjCgUbQHfK2N/0RKu8Zh2KfQ
         kbdOflMaouJH3zd8wZJ865iJreiqs0m778pUigz04xGI+1llnS8V+zUvH/R9OmbiZIt6
         3NEeRKHH0Y5ADV6OTtreyJypPgfTmPvyaWvcNYG32vwcEhENdsq1il0bfHnKrwHRHSV5
         xtqg==
X-Forwarded-Encrypted: i=1; AJvYcCXCG1iGF5B5qYfj+4oRP1/UxAckzwudYn7W0uv+WqTcXsEc7+x0/GR5FW9WcgIWP2nwtIo9Y7PAew==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZpcFkVPFCy5rifqJUnGs2GPVlQzXCPIw3Q4s2OhsjJCkDUpPy
	vMIS39XoZ0R2K7IJRobmrDXGwoUuuhzsoIBclwMIM/87z36THodZd9bP
X-Gm-Gg: ATEYQzzFkns2nhfv47vlwmByGmCB3yV8hJZ5EsX9O+RXn4HxlXXigTTo7l4M4uPt7f0
	vYhlBbKogMrqyD+Yx1I8e2zbA3xTdytGmAnALEkEmrzVqmWzmBjVmN6xblwQ1fHSBC/naze1nx3
	fZiofnvkgv6VE5zqaqVQcJ4Sp6K2Br1Rlr2ndatwnqGUGtv5gaeoHMF/XlmhKV679Qzwn39MMwU
	Rp+TDLzxKgRgRKtoHcb3sVO6HhIT+6fB+/MwB82zKoQ53LT1qKUC8L1ZmwjtBFwaKx9oUF9y9o8
	KQJGRp+d1yw4W8AyxhCD+v9xrHPsZHGlkGBsTElseD7c7mPhfqE/XwJOe/f/aN075VfwmbvHd7l
	jUNjJ1YwL03O/FoZvjyM5GqB1E0RoSdHyXIJfVPXNMda/q9jPwRv9ruZ/86ECzjS2t964GBXfoq
	XSyZg6PaLXpQZEYsFpnVc1zwpJTQT+F1ttj7MbQFLyORIt93qsHFxg+6ZvtT2zyzF9u37g0UXIL
	Ao=
X-Received: by 2002:a05:6a20:7485:b0:398:9466:2eda with SMTP id adf61e73a8af0-39c878c4986mr8419647637.19.1774764956074;
        Sat, 28 Mar 2026 23:15:56 -0700 (PDT)
Received: from toolbx.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca8436f19sm3709731b3a.9.2026.03.28.23.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 23:15:55 -0700 (PDT)
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
Subject: [PATCH v2 2/2] ARM: dts: st: spear: rename thermal_flags to st,thermal-flags
Date: Sun, 29 Mar 2026 11:45:20 +0530
Message-ID: <20260329061523.98346-3-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260329061523.98346-1-krishnagopi487@gmail.com>
References: <20260329061523.98346-1-krishnagopi487@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

st,thermal-flags is a required property in SPEAr Thermal Sensor node,
which is incorrectly written as thermal_flags in spear13xx.dtsi.

Rename thermal_flags to st,thermal-flags to fix the property name

Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---
Changes since v1:
- Reword the commit message and subject

Note:
* This patch is part of the GSoC2026 application process for device tree bindings conversions
* https://github.com/LinuxFoundationGSoC/ProjectIdeas/wiki/GSoC-2026-Device-Tree-Bindings

 arch/arm/boot/dts/st/spear13xx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/st/spear13xx.dtsi b/arch/arm/boot/dts/st/spear13xx.dtsi
index 159e941708ca..97357680dd51 100644
--- a/arch/arm/boot/dts/st/spear13xx.dtsi
+++ b/arch/arm/boot/dts/st/spear13xx.dtsi
@@ -332,7 +332,7 @@ wdt@ec800620 {
 			thermal@e07008c4 {
 				compatible = "st,thermal-spear1340";
 				reg = <0xe07008c4 0x4>;
-				thermal_flags = <0x7000>;
+				st,thermal-flags = <0x7000>;
 			};
 		};
 	};
-- 
2.52.0

