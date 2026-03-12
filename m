Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB36C3FE36D
	for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 17:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773338037; cv=none; b=snyyfnqRUIc4e4h/Cr/Qe3FZDtYljVSj3YUixW3k+i4z2iBLmLjOJ1IpJolb5rPm7j7b4RNztpPz8NIPhqMphdQ3/pUAYSlyJvGD6tEUeJLW7NftczVn2sN7390VpDIRI+fzd3st1bx+haM4s0Vr6tMfGJ2Sc+hKceOFI3hyq3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773338037; c=relaxed/simple;
	bh=tEF3yhkGk7GJZbXxScXpV6WB7vdFV4j4XiHTGehOpVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ksUUrnhNZZZ/54TK7RbB1iWlLlBvAD7/upEd7pT0xxQ8p1ejxaxOJdZwcM2bSZ9NvDx+jtQHjG3PEv5VcoTjwN1H0yr9mhkeFx7J4P6iAHDbgPT+hXnG2u02agbLbF9CNa8iy1basgZCFfcCOF01i0wcva5m6UgZ/h0II01oMRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2HQ2Cea; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2HQ2Cea"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ae4d919f9bso9019895ad.0
        for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 10:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773338036; x=1773942836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QVWLPpAzQtONe2+RDE4AE36BbHIiMrCDRmv92u2lcVM=;
        b=b2HQ2Cea1O7SZhuLrNqbXYdKrGjzMzw3VJaV2TZCYg9VBaD6pcLuZMRJVnP3z+WcyK
         FpCq3HYOMdvR5Q7+Y9q2mMzCOG/1e0ojE597ZP/uV6Zl9j4UVJ9CgSoKwSEWgQpzlcPb
         3VZpem2ym/Wpu9j/aju5DeWb2R52xEzciGRuZl9IlkGTh0sLxTujXt5jvTKqxS78TTtL
         qjyC9SCJ84IIWivaaFzO5t0SJCy2aprMDNv7zbUt3VNefxxbaKykM+6+y6FHjwkPGOV8
         5bks8RRwSr7mn9azBn4MwCNjWrcBTUtj4ZclxFdDvgtUCWk3ZPnxS3Eg2B2ySuE4oNYh
         lAvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773338036; x=1773942836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVWLPpAzQtONe2+RDE4AE36BbHIiMrCDRmv92u2lcVM=;
        b=AEAvHNdyeztDCW8ZF+RHUpGIH+nhvbTA7bOuyRKJXYFeuDwO7eXLpuzwhl5yTkz9J8
         tdeueggA0UHkWUiJb6zmF714ba4f9xp7WvNPVdNEuGiuArXej6Nppudycvjbq31zy7n2
         DiN3iCRaHmWu6opLT8Ktpe2+c/aA2UskWnd1qK1+QodNL1n/Oh9wvjBTGDLIHeDxwbhe
         j8Ime+kPk3sNeSsc31VqsYhsiFi80pOPLWgEL+ed7ufih5+bW9IN4wdrqqNYNy6ht4Tc
         Vn7mODlrwh8enJmqQhLCm4Da/WspfsWDpK8WC6cAllL68VGdj0sIveELUqxWUtOC4P2H
         9saQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmpMmnykIPMNbAexvjzKnciLHB+Bh3jsZGarqbkIa3rBNZEnkpNVWCIahTC52kWS87sk/n/SzMjw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLZQRq5tz4a4DB5Ujxuy3d04At1lWol/vir+ds4tRgrv/1kES9
	hyUZlRMASYHMXxtXDVe41Z25Tume9M4CzFhOV1jayCnpJLakXtl7hov2zsxatQ==
X-Gm-Gg: ATEYQzy2/81v4aaUBSooK+HAy8uYgTH8WFLPJWhSRuMes2gHFidjtbyGxoKbcJLcTEn
	6cLdOjteXWyfKybUD8y7a4/rTo+MrdWVs+as+YJ5jF2LFYfGeswVD2rFR+eyvyW2cI+tBRo0/GL
	cqbcyWaAlx5e9S93sGDamzSJndqCaHZSis8aT1ifqYgGdAtuJwMcxq/kn4G8LEjMTZPa/OHyh82
	CzM4UAB+X6mwWlHr2QwVUZeFSCDDXN3kGGzv6NFAfbNe06zq59dJOBaQtVu0NEDlehRE7n63QQs
	LhjaAkdNWiJulSpVfdYHzcB4fqTCf0zUEFskiEEZRh3HT9R38e1vn8t8et2oDhsa4gHtt6Ju6BD
	jekWURW2hEvyvdjVsAQpDcadOA2fQYBOD49QURLcSCHfpt58zwTO7jIp1oz4nifrBZ3G6qsuBGA
	AT/JPz+gFF+pViVFqR0XXTKfp4oftQ535OXRl1dTDknfotGFxSjrqZOBcugmfaPz3t5Erv4oqfr
	ftS81WVkRnkVpHTlvQ09ZM/q19ifiP7MZm6
X-Received: by 2002:a17:902:d542:b0:2ae:55eb:f82d with SMTP id d9443c01a7336-2aeca92183fmr3959315ad.1.1773338036145;
        Thu, 12 Mar 2026 10:53:56 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com (7.162.199.104.bc.googleusercontent.com. [104.199.162.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae378ca7sm60453345ad.91.2026.03.12.10.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 10:53:55 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: djakov@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org
Cc: marscheng@google.com,
	wllee@google.com,
	aarontian@google.com,
	jserv@ccns.ncku.edu.tw,
	linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 0/2] docs: interconnect: Improve API documentation coverage
Date: Thu, 12 Mar 2026 17:53:39 +0000
Message-ID: <20260312175341.2944154-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve the generic interconnect subsystem documentation by including
the existing kernel-doc comments from the source files.

Currently, the documentation only includes the provider data structures
from the header file and incorrectly states that consumer APIs are
undocumented.

Since drivers/interconnect/core.c contains a mix of both provider and
consumer APIs, this series uses the kernel-doc :functions: directive to
properly separate and document them in their respective sections.

Kuan-Wei Chiu (2):
  docs: interconnect: Add provider APIs to documentation
  docs: interconnect: Document consumer APIs and drop outdated text

 Documentation/driver-api/interconnect.rst | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

-- 
2.53.0.851.ga537e3e6e9-goog

