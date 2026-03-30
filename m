Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5256F3C5525
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 11:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774868515; cv=none; b=p/zWBJW21RFgu3InU2rWwVEJX4vefU3xL1dHXX2Hb7ttFlvm6KuEoH1S41OT5XjQMoW65A/VHu9DJV/uT6gs1u5jRqke3WvchfRuv8vQZHetPhdb72lhWF1kulNbUnx8o2VZ4expv4tTRrD0KkPsYnFAw6HINaMQKW5jFGfMOYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774868515; c=relaxed/simple;
	bh=OzVTQgV7DNr9r03rbMR0B8M3EozSxWWh6geGT1Lm3Lk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=evR10Ru4KKRQp9hxi6pIO5PLeaHE5cH8ubFVMJAzBQymxjOP1H+eojTvCYyTtmvtLVauyWIA5twf/Jzfg3UF5HJydK/QfZ+UgeGm+EyC1LgyvZutVANr4SP2CzWnfh9xeOhK3G1IcFecFv12X9uUcBtksgKVmq7l4mCFjr319hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPrKxZrt; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPrKxZrt"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35d971fb6f1so1386667a91.0
        for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 04:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774868508; x=1775473308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tif0BX5UVtB4rV6WFT+caqXXTeWJp7XZF9XEZjBKH00=;
        b=KPrKxZrtzNm7H+lmmpwlsNPZw6mQBW5Na2GieYsiiuiBQPDaBwWjESlJEl8Da78DNe
         YXFdF8T3BPd72u6e1IbSnfAI1b6C7kwx3x+pPmedTWXrq1NVcB4sjD42E2pg8mP/7NZA
         A4ntRL67Pia2I+oNPcunrdUZ4lYCK1+DdYG0jdbuhzUrY/Sp4Nt3DkLB2GpiwXIef8xl
         QLwCFx8WmUEme7q4pM9blBkbF9j9WXu1jHHODUTUt1y8Cdl8FBv7PMTM9OpYcdVnC4TO
         bklXSi9N8VxhdmDVZr3W3ET4CHPyIP4nS7nQA6Osh5d3kRqKxq4Zf8BL8rEYgEG5dvp+
         VebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774868508; x=1775473308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tif0BX5UVtB4rV6WFT+caqXXTeWJp7XZF9XEZjBKH00=;
        b=P/e9jtCaZPwSY1uEmNIiozYYdjMClTDwSy/P6CAfk4t0iOsLWqo96zwngOYXzVWnl5
         qdkJMiW4WbyyZd2mZpZqWLTpF//YhLky2PjwrGfzGd3PcZtnJvRdZ8vCOt+TDhgKv+PI
         1Dq1YlVsFCKHipmvY2g3b51NVQ4LjQ/c5ynDgESESnB3xTZ860GuYtZgSo0251x5Ylvi
         qeM7cOopoSoxjEn/uGS9DYYvxpHwUdIiRP4C5SIYU+gRqRDL9YT1yCVya4Lts9KrpDXl
         aHHl1SyugS6viSh+r5HgIdT0AKyQoQTz4gShKPzRfc3LLiQonvNQyXQMdO2tkDNMIVJV
         DsQg==
X-Forwarded-Encrypted: i=1; AJvYcCVbrc3wxEKESiZxX57ZiUShu1mqghFDfk5VO4nZpWLZOEysYeF/usYa/g4Wa3BTEyA1OwIqLEdptQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7Qk0lo013Zs/2AQxpgQF/OgvhO2WxslpABlXSUSEF0zbJrcbT
	rHGp6YU3VuexytBTU0SxthWqWPYrmT6XJAR1d9XKEAZ7NsXMeL6aUgF2
X-Gm-Gg: ATEYQzzEKm1NCxtvv1aZocpqpB7+hPLouseO1mq8u/pJPOLs5NW9XJWyjXH81lMtzL5
	gP7y+64LxS9otoU06D96Fma2dSXtIwENPpca5nPLgc/cN0xzagIZHVk6H4Kj5BKXnctCDWeLb3U
	8InG9Yaf+f8Lso0uv1KQ7Xm3ySNXySeZPsofBVpvMT8C9KDk7bpsagJiG57I+FYR/w0mYJwxe1/
	oL3Tr81PEfcyy946LOVjnASnmAcd5l7w6JADqpil6hjJNUgxUCSLTi3MABHNdoBWLbNgFgeipv2
	kMV+FgzfAvIGAdB7qShKCD4kNYWV00w4yes+wwAIOTupxxn5Ss3H9o6La5+iUDeSEyANrS9QxxA
	xKvYYtLocJeS2eZGlbe1PYGyz1CT0B8IQGNuDWRN1OX9bOL4AIZIy4PyenYzzC7b7xv4zZ8BQ5/
	QOU95d1LqeCBPDxil8FngCWvNjys4Q
X-Received: by 2002:a17:903:37cf:b0:2b0:659e:97bb with SMTP id d9443c01a7336-2b0cdd104e6mr122029165ad.46.1774868508266;
        Mon, 30 Mar 2026 04:01:48 -0700 (PDT)
Received: from snowman ([2401:4900:646d:9a6e:3eae:13fa:fe3c:864])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24279113fsm77701375ad.60.2026.03.30.04.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 04:01:47 -0700 (PDT)
From: Khushal Chitturi <khushalchitturi@gmail.com>
To: sre@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ulli.kroll@googlemail.com,
	linusw@kernel.org
Cc: daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	d-gole@ti.com,
	m-chawdhry@ti.com,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Khushal Chitturi <khushalchitturi@gmail.com>
Subject: [PATCH v3 0/2] dt-bindings: power: reset: cortina: Convert to DT schema and rename node
Date: Mon, 30 Mar 2026 16:31:33 +0530
Message-ID: <20260330110135.10316-1-khushalchitturi@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Cortina Systems Gemini Poweroff Controller bindings to
DT schema and update corresponding dtsi file with new node name

---
Khushal Chitturi (2):
  dt-bindings: power: reset: cortina,gemini-power-controller: convert to
    DT schema
  ARM: dts: gemini: Rename power controller node to poweroff

 .../cortina,gemini-power-controller.yaml      | 42 +++++++++++++++++++
 .../bindings/power/reset/gemini-poweroff.txt  | 17 --------
 arch/arm/boot/dts/gemini/gemini.dtsi          |  2 +-
 3 files changed, 43 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/reset/cortina,gemini-power-controller.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/reset/gemini-poweroff.txt

-- 
2.53.0

