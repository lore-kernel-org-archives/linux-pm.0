Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1136A3242CF
	for <linux-pm@vger.kernel.org>; Sat, 25 Apr 2026 07:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777101950; cv=none; b=IpsAfh2uBG9ES8yUqF/LMmGKgmk50H2voMh7h3NXZNuhZ7A2gKioYqnvExS1TXp3L1PZjwiqWHG1953IuY4AWz/IsRDn8UKmJ6cBfX+fytGoL7vY8kIiPAfCVdc2chLkbbQP+eiIOZdQ4+DPi6G1hjpx3vjXZWScTDOZwhOPVv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777101950; c=relaxed/simple;
	bh=jf1+Bl8cSaCB8pqDUmuf6Na1TNKBF2ZTBxAbiQL0X2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JB4OgH3YEF9ucls5VLZQQnRsa+tERj/naeiqwoKd2obQbypnTms7q0vOFPQfXHWD2adQSu5Vf+os+FJXS5XrPvrbqdJhLUfjULPl734sAIdF1xpQvW4dMFcH6ZOwhAPZVkNhoCQYp4XcchzzMhZF0M1MzCbvcXyQ+BToioO9w1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xfb9j+St; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xfb9j+St"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-38ccde812ecso84691991fa.0
        for <linux-pm@vger.kernel.org>; Sat, 25 Apr 2026 00:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777101946; x=1777706746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fQ1DxqX+WTZVsJ+5OAiBiUZGCLgv+/vT//CdieX1Us0=;
        b=Xfb9j+StectW8NmmhHv0YaB8e+EerymEaWrqnN5ZCk2V4ENyBMTuHINDoZbIR9tE+j
         7kC3CrCX1azoza8kglTb5OwGA+NwcQJOf4CcS8BY02MrUQ5HpKFKCrhf2S1MG8BESyuu
         uds6kak6oPkCvebJR6J2QASyAZmdjBz5877ebTFG1aIfmPCmQijgZ8OWf+JGNqD+eRsK
         UhMzcxCDyXzjGrRu361GJR97IGAWter4vX2LWrnuZ0t4VZrfw0uBcRpq8pnrl80D/W6o
         e4EM/L+Tt8WGa0PnDeyOf4Rj2Po6Mshu3fktf7BeRIcNZB/o4YLMjmC+IK9eAeYj4iBf
         28sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777101946; x=1777706746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQ1DxqX+WTZVsJ+5OAiBiUZGCLgv+/vT//CdieX1Us0=;
        b=C0pVN475OPeqgLaRjNk8UY7IWIEAV/ohYviHz2zEESPBWGTd/vtxh1QcdAqMWhJvs8
         Ii7msSUw5GhhQ+vct7pwKg7u6EfxJxLSztZ6SAj627JKjWznkGv0fgGHUZsI3hBz8Gc/
         vSslAyndQGfuqSIpWHXInIPAF+AohO8kq/Dc3toRaXXSrjn1AmJ/6OHdNv9XKZoA6siZ
         M94s8fZ5Pbn4oQEXQQWWO/plT2uJ4+Om+zygrC29937TrSUAV57IDxvcV6jklArAm6Xv
         PKi8ub0vEETg1GaeSUBwGgY3n5rIVh59Bd1pX8b8n9Hg0tfFu+GEXUMS2UbstM7j0bSr
         dP1w==
X-Gm-Message-State: AOJu0Yx0xXCahlBpmup2zb52Qr0+T1POU/+UdEeseDAV6OnqMDgX5RL3
	F3jCP0V9pZ8GhLuaB78m7Pmjz2mypdTraqitpTgUfoKPeQ+YiwYqtTn7xOqpLMub
X-Gm-Gg: AeBDietwru2Fv3bzyBmz2JSc4xQSYGx8JWKyMfJe/BltCLeTVfRHFS+/B3t55VNEcaz
	l5g2fzcN9H/QPTaeGgtHHPOwmp20XSo++gJ/09KupTUk4Ff99WvzPvy8scLK99HsBMZL/jtAZDm
	3W9YGgv6FEPD+IuRC+wpB4DfxHy3ACPi0iMwAyarDOCLJHHGkmxs5sG8jAph4cvKygGw9hkMWYc
	q8RXB+OyIT+E4I/z8v7vOAZ9UtiBsy7yd2KkgodIEwuGQRN3GcbI1WtyxQVDCuiX+/2rW6yNSSA
	PN8SWgPQZJuDTMmRjhRT8nCqMeIfa2/2O8UhOBLpqxknnHPOXHuxQcH96wc971vwkMWUh0ylJFq
	pZwIYaEZB73TD4Z5C+sMNYwnH7YSQzcQc+k2w1CykgIf9bVNOd+4Bzw4TcjZVwCtRQZAkp+7RI3
	V6+dU/Y4TTrzGT1ovvracFiVN9S5tYH+nnbjj8GSX/4V7K12cX56CJ6BePg9Jk6DlSIvWA
X-Received: by 2002:a2e:954e:0:b0:38e:7f8b:7f1b with SMTP id 38308e7fff4ca-38ec9493487mr72797231fa.13.1777101945681;
        Sat, 25 Apr 2026 00:25:45 -0700 (PDT)
Received: from abityuts-desk (176-93-242-43.bb.dnainternet.fi. [176.93.242.43])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38ecb5f6666sm55070071fa.15.2026.04.25.00.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 00:25:44 -0700 (PDT)
From: Artem Bityutskiy <dedekind1@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>
Subject: [PATCH 0/3] intel_idle: Drop C-states redundant when PC6 is disabled
Date: Sat, 25 Apr 2026 10:25:28 +0300
Message-ID: <20260425072532.358365-1-dedekind1@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

This patch series drops redundant requestable C-states when PC6 is disabled in
BIOS. For example, Granite Rapids Xeon has two C6 flavors: C6 and C6P. C6
allows only core C6 (CC6), while C6P allows both CC6 and package C6 (PC6).
When PC6 is disabled, C6P becomes identical to C6 and is therefore redundant.
Refer to patch 3 for the full rationale and details.

Patches 1 and 2 prepare the code for patch 3. They introduce no functional
changes, only restructure it to improve readability and maintainability.

For more information about Granite Rapids C6 vs C6P, refer to this article:
https://github.com/intel/pepc/blob/main/docs/misc-c6p-c6sp.md

Thanks, Artem.

Artem Bityutskiy (3):
  intel_idle: Add constants for MSR_PKG_CST_CONFIG_CONTROL
  intel_idle: Introduce a helper for checking PC6
  intel_idle: Drop C-states redundant when PC6 is disabled

 drivers/idle/intel_idle.c | 104 +++++++++++++++++++++++++++++---------
 1 file changed, 81 insertions(+), 23 deletions(-)

-- 
2.53.0

