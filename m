Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794491374;
	b=Ai7y7CCE+i+JPzRahhrPClqpI4Lg3tbIrEvmUlLJxnXwTGU0yiDWpq7gblicTpZH/GWd
	 xNPLtrCwh39LkP2hJku5hYDUJPu+qm7mYN7kAKZmJpqWjAx0xPjPxiESf6fAs0W3Ip/7r
	 fbb9JN6Ih3ycMwTGN5+eUGlvZyfP2O7wx9bsl7d2MzbOlkaFTPWlWzJyaf5oLp3McI/nh
	 sLS5MXGrYNb9SuJylP4PYR3iUj61EPoSB8RiwEJd/baszCetwdwqMxj8YEUg8BqVGQqHi
	 hwBSq3KnxTnEIUIlbqy3lY36FjvxcpIwXhxAeq2JAQLA0Sw8sG1I87zHtaaYLeXONYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794491374;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jQ9FeRAXZK1KkJCdEA8O5o1oktiZUjTf4lBe7KLzAWY=;
	b=Wjbz5m/ZlaMTZFaUt7lANs7YRXKXn9QO3v2E+sTitUCSZ5yAEHHaLJrW38IJ45HYbKP7
	 eEjyEoWTKtMPjHfnSOr7guFgQjDja+uo67UyBq65/EYK/xaQ/SJdf53prmNNUfiVEfvcH
	 M4UjRN31d/6rJIMYj72kel7PdtdQMwm4pXne7AhXxV93P1RQIb/O5gijqja0gL6XLi5Qg
	 K4xwmxDKOz0LGVGQyZn8IXiRvM/e9DEQlUMEeJcBxhQ9xvaJ6tfEKtIdB57RwwcL2AQk8
	 Q3NJ/0b/JK0Wu5Uf0ruoxOJUgCtTWnbTa+jI4OddIZ49kGbfZCsIWqqsqBdfMVWkacA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="G/0APneT";
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3BF606A88B
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 13:49:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB3BF606A88B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G/0APneT
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8a39e5161c1so3236328b3a.3
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 05:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794491373; x=1795096173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jQ9FeRAXZK1KkJCdEA8O5o1oktiZUjTf4lBe7KLzAWY=;
        b=G/0APneTalyZHNVJn+Orz7dqjahcrBHq3vJs0ca7CF+dDsWBekJzRxJ7E84Jn6TuXj
         ho/NduaEqmLieP1DbioyaxdUdFPdw1fQc5AqwdUDjXTEZZuh/xUF8scHsmyBkhZ5lhOQ
         gR2Vrbo6QgbNaJGFQz9h6cRGgXwXAdJjCrY23YZCgv31Zztyh8NHF9UflNNn7auHOAuk
         BbaUGUPzOVTD+ZEHKrEEB7E8Axx205z6iAQXz0A3a3QYOKEpx1UbQ+NaLlcFxAimWJXV
         AhUZ3TMPW7QhILA7tbIZ2xS4m/8QdTp1uDcT+kSnNWsXqHQ0jaP2paYGQ7JcMUMkUFrX
         NTug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794491373; x=1795096173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jQ9FeRAXZK1KkJCdEA8O5o1oktiZUjTf4lBe7KLzAWY=;
        b=es7HNGQrb8RiL93RPD/UmKVr5v4Vs/rJ4Ky/Yfajuvd6GMQFfi8gC/RglEUFuDDy0H
         14MZwFceiuC9pW1DLIDaHL3XQG/u7gq4SQKEXZqQ2Ib8nkK/JfHkL/p9DjKAB1uBhGwc
         KB14cT0LXPmFR7jL1s7RS37RNNvWW2jcHJRxAmPg8+MaK5HLwW1F3+kQFHLitcU/sqrV
         muGxNS28KP/zgFCAtIKDnwVUCOCZkX4ri2lhc7AMaY4ZXn5JM5NMTkRqCA6tjtksCgjq
         JEid59TXr/1JTJn5lAd15mVgMFhKSv/1PHThs0gr5gS6v0R4jLn9fQqYDH3TcqIu2V/n
         5cXQ==
X-Forwarded-Encrypted: i=1; AL+hErEq6UxtwwkXXoC5rewmqU1hVc5Fo3K6k1uUN0kHtlKKg3YoRjmyhMR45zsm+VaZOqHDH9Z68jKNSg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8g1JyDVbBgjDgQmoPRgXg00PcAkexU7JFRtFFirQLOzET7k5Af
	ZjmseyOfAVaBjK1i+khmDbLSMbG+eBUAy2Qdm4m+3I20qM7QozYGxBRC
X-Gm-Gg: AYBFou2QWJAf47as/zdlPv+t0mnLR+6nYEwHt/0zk6bTP0wldVTLRhavtap4NVQpv06
	7cvDPzqU5tq48VuP+k5vh+f9ab0DlV7oOW+pDZ2+vSSnvOJz7o20CLlOCoYtmZEdB4sSOOG43qv
	AvbmuzpUXXMfwfRnh9jBO0Xuu0ddXPVKSRxe0Yr6iZH7g3CCZaiDuS/ivacFD2BisMhAHVBmFUx
	IB/SeCpYSQEQP2gQWIgLWVdH1mXL4Nso5jIjgKR5IRp4r9PCGMX9FVf1nsLY/NBfewYgoEkCnC3
	zUKdFh0tP14qIW4i6fua45Nneesuxn7t4ztLI3cR5bUGbQPjQ6kqktes2iPX+H9TnTi6KFr727i
	PG9E3b5nrsZP8RInjl10f2RoNF+rQLX3Q3Pzxbp+bnaT6RCEzLtuX+gUgceMYxQ4scfiQNRCshD
	kPhm73oO8+63xlWT+pnLaOC+kzAGwsZKiUODNQzNbCrBD8TBccnE5z1KE5pqit4GZjDyQpZZPA1
	4O2RUIErR6s71aXscqlTe9B0DI0FmOIuqdu3rqoXE4BGTt0UJxpZYdUGbVzzw/pyLH2V3L53av7
	Ug2t+Kfd12zOC9NsobiAoRFOAebXWGarwfM9QHCXdA==
X-Received: by 2002:a05:6a21:4801:b0:3e1:8300:f6d with SMTP id adf61e73a8af0-3f2ff2d2523mr6322723637.59.1794491372834;
        Thu, 12 Nov 2026 05:49:32 -0800 (PST)
Received: from DESKTOP-NM9EKIA ([180.67.33.100])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baaa2a6c51sm3550580b3a.14.2026.11.12.05.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 05:49:32 -0800 (PST)
From: Joonhoe Kim <26rote@gmail.com>
To: sre@kernel.org
Cc: konrad.dybcio@oss.qualcomm.com,
	jingyi.wang@oss.qualcomm.com,
	kamal.wadhwa@oss.qualcomm.com,
	anjelique.melendez@oss.qualcomm.com,
	dhruvin.rajpura@oss.qualcomm.com,
	andersson@kernel.org,
	dmitry.baryshkov@oss.qualcomm.com,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] power: supply: qcom_battmgr: Kaanapali current sign and charge current limit
Date: Thu, 12 Nov 2026 22:49:25 +0900
Message-ID: <20261112134927.95-1-26rote@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 fixes the sign of the battery current_now on Kaanapali.
Patch 2 exposes the firmware charge current limit on SM8550-class
batteries as charge_control_limit and charge_control_limit_max.

Patch 1 has no code change. Its sign is still checked only on the
Lenovo Y700 Gen 5 (TB323FU, Kaanapali); Konrad asked Jingyi on v1 to
check QRD/MTP [1], and there has been no reply yet.

Changes in v2:
- 2/2: use guard(mutex) [Konrad]
- 2/2: return -ENODATA when the firmware reports a zero maximum [Konrad]
- Rebased on next-20261111

Link to v1: https://lore.kernel.org/all/20261016124806.1789-1-26rote@gmail.com/

[1] https://lore.kernel.org/all/0e5b7d2e-e141-4ce4-a873-b65bd9ef3c4a@oss.qualcomm.com/

Joonhoe Kim (2):
  power: supply: qcom_battmgr: fix the battery current sign on Kaanapali
  power: supply: qcom_battmgr: expose the charge current limit

 drivers/power/supply/qcom_battmgr.c | 61 +++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)


base-commit: aaa2f954c21b205a0bcd0961e5b2be4e82e58455
-- 
2.53.0

