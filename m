Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751C0438026
	for <linux-pm@vger.kernel.org>; Sat, 26 Sep 2026 14:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790432977; cv=none; b=W+PsScIMA+FSfonn28Gtz4dvGpezxIPSexeKtL1K7fv2JgC3WMRezzwhppUwDSMB6LpsnBNS3rfp8HeQQyfFFXs4fcxQj94rQZI1FgIH+/evI1yQHod13W66heyIIGu3VUKvgsRMJqfR9o5X5PocCrKE0H3N3L9Qx/EXiQ730cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790432977; c=relaxed/simple;
	bh=1s2j05WGuSxdMxu0mPvRMGsuFOmVgRS1uYIlgnv5nRY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sf7IOxJZEkcXKCGizUe4TsW1k7+Bshhf75c8Aj093xTPolaI0thAgm5BpvSC+aOcSqtyWAVLO6KW2KM48e0DslAlPBEx3TZq5re/REsSpw+mAutcq+jkdftyvbuJPsYc9jkcrVqf1idVGVWwfGgyvokziTwjrgihVwnsuaFrGCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AuAMWOFJ; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuAMWOFJ"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ff9642c57so1723505e9.0
        for <linux-pm@vger.kernel.org>; Sat, 26 Sep 2026 07:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790432975; x=1791037775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CfMv/6BkPBKZ8qC/KjQG7o9GMKGsM3AsVIzAe/BUdtM=;
        b=AuAMWOFJSdKfQxADAZ4iZ/iUZopBQMqIt3Ub+BTFjzlW+EUuXxdbeIoomIGDLpvsiH
         GRDKs9EUpPEZSMEGcsa/QzRl6AujbnW9beJrtarye/QpwdxSbpuCpW8Mud0SHmn/E2P0
         szIkK6wpn+geJuZwPulgXJeFbjqPziIr0kEITvzW8qqET9OoUBnb5Ah/5OKUeMN6eAVa
         b8yAS7eFsw0FhGtX6B1PRi59EeSPCePepOukQh5YmGP0iYNN0WSJ/bzRSTxEya6O56us
         wNxIoEy03iyVIBgS0Dab7CBeabLFSOwdeJ16Idxxfvy+3Fv3dT4aR+gnu6f0ImgEO4s6
         hMDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790432975; x=1791037775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CfMv/6BkPBKZ8qC/KjQG7o9GMKGsM3AsVIzAe/BUdtM=;
        b=Wtl+vfu4GBD5XPw9JJAxkNNoNZnENKqi+rz3yirIlmn56qHkXj6k4BwWTyPegQO+cm
         JuGyldFR1tKvnlvLSlXdRt2oBoxj8Jh/3xpPel0mpoIpA0tI+MAkWTSKjlGiPHgOOiCQ
         q6UZkWB063dPMlLBBqpcSpGZUVisQlTvLJF0xeJ1hbFZVA2xeWF486IdND+TkUkVXsq4
         Z0lx3AVhH2VBApeRK50LOqXHwfZ/+MEQ3DR5LqhqC00oXOxPZ/jG4hYoATRib0wvSfOI
         GOGqq7FfrUEIFxseq9sf8sj/x5otciEJF8Fltr+xPAVRAb23YjDqHT1Z9K98KMONJnzG
         s7CA==
X-Gm-Message-State: AFuF++m+r4BjvC4s28pGoziXCnqF4AMCELe2LZe7OHvh14e1qj7lcH8g
	0ocjcqhadzDUG4kRyK7/Ab6oUuok4NMqxuh4NTmrbde6M8IRNbfZxGd/
X-Gm-Gg: AYBFou0r6rvnYvYMEe0dwDpfhxrxDyBrPpAq9SV3GC6edBhHl66B8F7SAYzNOTeP/Hu
	8G/fbK35NOOcB8M+QB+oUAUmLgbLWW/+gQ09+7ZrcDQYjTVnnvA7xyy0kVS8dh4MxuVhxCSi3F+
	1rk+Ybuze3+oGoVyS6e/tOXJNYgUJbDt4Mf3RpX01NWsxEippkGuoqQPE1/onXaPJVYsvw1FJrh
	0/+0ZpOvrq3XzzWOpcM5BGUB02J+bRNeBlQ3rBqWoXT1H4qF9w0WhrzV6a/Vjlp77hyZZhXaKs9
	LN4JM6KoGFfBqtxkCoxhs89RKozbDaR0o0+ZmY8uRzvfXDrUioBzw1XxkHaaqv3Uwe5ZfHw9HYE
	6TnYM6skn9vcPZRUG492QlR+DempHbyZKZq76NDxZBCHH718pETJd5LCw5Ojnt8ykhIXYykeSJk
	K4DrSIcfa/WjbuUzzXUGKuD3P41p4A6Af/U7fnaH0BE+VG3RGp9E9+BErE+8i2hrOmg8jqH9OyY
	3G3eHqqxmBO9QSVJdM=
X-Received: by 2002:a05:600c:1908:b0:49f:ffa2:1c72 with SMTP id 5b1f17b1804b1-49fffa2221emr10341055e9.11.1790432974517;
        Sat, 26 Sep 2026 07:29:34 -0700 (PDT)
Received: from xeon ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fef60da94sm98116395e9.4.2026.09.26.07.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 07:29:33 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/1] power: supply: generic-adc-battery: Fix temperature IIO channel conversion
Date: Sat, 26 Sep 2026 17:29:04 +0300
Message-ID: <20260926142905.206215-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Temperature IIO channel data is provided in milli-degrees, while
POWER_SUPPLY_PROP_TEMP is expected to be in deci-degrees. Adjust the
existing logic to reflect this conversion properly.

Svyatoslav Ryhel (1):
  power: supply: generic-adc-battery: Fix temperature IIO channel
    conversion

 drivers/power/supply/generic-adc-battery.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
2.53.0

