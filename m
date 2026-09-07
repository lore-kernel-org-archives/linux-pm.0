Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96D7485CEA
	for <linux-pm@vger.kernel.org>; Mon,  7 Sep 2026 12:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788782846; cv=none; b=SjU8ZO0tBgLUqKKMo1tp2NLryrWJBqVwqSZ3ZYJwmIFCnWvhyhJsiNIRa1p/ejz3N1dSi5nveRh13ghU0l4WibqzdZNnhfwGn8MsGWIbxmQYZCtyLmlmF82tzX5mTFBtiZ12q5qTyttMvhTf1M8lo5rn60XklQt2By0IR7rWFuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788782846; c=relaxed/simple;
	bh=P7CaDYp4Md1JqTyutqJPlck3ggTW3k80tlDn2jcOYR8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ifTQubO/u1ueXW6vTPlG0b2dnb4ktPi0JW9GtTcbkWPO70kBMl4b2RrR6E7YA43NylxQOPKyC0XLlCdSQEfKx2lbqTs0PbSZNRV1rcGKi3kp2Cb6He/6SSeLDrzOOmN53DctnW3OcRiADXCLNiGQ+Lnqk9nLnG0bdwRnnV6bo/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yuc1wh8Z; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yuc1wh8Z"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6aca0f482e5so3943875eaf.2
        for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2026 05:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788782843; x=1789387643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mdcXJNy9L8Tsu/vg5VhZVH08lUj+s69BRMYHBDv7fJk=;
        b=Yuc1wh8Z2allQOLB1X+Fx8FWuKZ9jaW8Lh7xou61YWzz3lO+uabc6Fl9TG83LeKekz
         6+MNdBUVZSggZBpYunxV33ysEZNSbfBd9m8WdOtkxQu5PeMT/9GgOjg3gI2ZE5sCuJOD
         mgzoQMwSttI9X7DE6LeCICS1aEJh+9jxajwxhzalbCwbJ0ldoDads6KxxuYrsqcxG8jJ
         Cpay2A6v1eDJhteL7+3nk3JTd0VkGEyylaC6iRkJv4HQ/nxxRQPLhb0wHYnOcYyXsWc6
         kEk5P1Rd6r/XKorsx4LxLoH1NIJR2ufvsAOWwVhTi6vNa/TfVQF4bq54wdId70MMjlrg
         6BvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788782843; x=1789387643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mdcXJNy9L8Tsu/vg5VhZVH08lUj+s69BRMYHBDv7fJk=;
        b=VTrVUWFnY7DXr7HnGZ9/VncHFktD9fZ9TMZGbxq1DSwG7uzqrZFJYY0/pvqNXHykD2
         eKwKM10Yog3aPKN70HLdMyDf6Uoq8huc6sy/r160ofWfQ/nkRIMMXO4UWB45BgjWRYni
         a6VH/XPeI1GVx7/Jn+/qlOtfk7IgI6A2q+8qJsapD1CBec7x+4TW8VqqlVE1uWKi4VPD
         8gp9M/TKntvat6OMRL6lFxcUjU5GXVLzS1TLNkPpsckeWluw9ZVmjv7fO8QFFkNDMtoE
         49iAmM5xfzUmigEeL0LM5qzLG6L4wp3btTYFDDmaXt/cxgjSxSUjnhBelGsshBzgoY3E
         gGGQ==
X-Forwarded-Encrypted: i=1; AKwUvByNvo6oqa9WeQUdKoMiMwpgdIg82K075w0ZztF+jAw+Ki7E1D12bD1CJB9JD3odcvY3eJd4kZST6A==@vger.kernel.org
X-Gm-Message-State: AFuF++lFSPd2dk0QrqrSm6zz+dNLc/E/p28+klgVN7jxOI+BO64xZ5tP
	dnT0ROTrLE4iQB6wZNgdH7LFat0BX/TeddqS4c4GTL2kDbYbX8OfDAUo
X-Gm-Gg: AYBFou2CSNdG9qbma23/B7l93Es70CruQiWHVaIpPaVvR6gdZL0wOtl64d5+VPLAs/w
	aXvHJtlaxXlmBGuUoKOEjejpxMfcw2E+im4/cY87ipE9Jmo6o7ryHbDJjtiaUKbn7GAwSnMVpzT
	dgDslOoYsgFk/GDn010LYG06tvlU/HqBvPJkPkZ7taqJRF6Whiix5yocB40Q4xw9Yya1dx+nOoz
	V9cYpmj5v9LUtWMbp8TYa2KLG3+DLYpWVpz5tJd9DqOSi1dpOXzotW6OIrDYxfBIlZhMJyV+s87
	roa1bgIk9ea/f4p+ihJCAVl2Kfk5/QZEQDiLZFv1WGAXpnNq9p+QSKPR+0vs5S9i6qhqrWoU+Zc
	RfLVr0Be6qy1NC3wJ/Esg/UY3d8pTQY8TQ53INQGE+VUrWPtGYCUzsmAFGaMRw6L4YY/K3YuJ6O
	jiOEOcp6hhaQD5yTP0xa9I1zAlDbA1qRHd4MOy8YzbzdnOHn+jCZyM4tZkUSmUEIFXm8J9nlrLS
	+i1gzDt3wT2Ynbb1JRHrVBs
X-Received: by 2002:a05:6820:6ae7:b0:6b9:3295:7704 with SMTP id 006d021491bc7-6b9329579e2mr5576998eaf.52.1788782843391;
        Mon, 07 Sep 2026 05:07:23 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339aa37dbdsm23658592eec.11.2026.09.07.05.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 05:07:23 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Shuah Khan <shuah@kernel.org>,
	Thomas Renninger <trenn@suse.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] cpupower: monitor: Show how a counter value is exported
Date: Mon,  7 Sep 2026 17:37:17 +0530
Message-ID: <20260907120717.35503-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"cpupower monitor -l" lists the name, the processor hierarchy level and
a description of every counter, but not how its value is exported. Some
counters are a percentage of the time spent in a state, others are
absolute values with their own unit, for example the Mperf "Freq"
counter reports MHz and the RAPL zones report micro Joule. Both cannot
be told apart from the listing.

Show the value type behind the hierarchy level and document it:

  [%]   The counter is a percentage of the time spent in the state.
  [abs] The counter is an absolute value, its unit depends on the
        counter, MHz for "Freq" or micro Joule for a RAPL zone.

Before:

  $ cpupower monitor -l
  Monitor "Mperf" (3 states) - Might overflow after 922000000 s
  C0	[T] -> Processor Core not idle
  Cx	[T] -> Processor Core in an idle state
  Freq	[T] -> Average Frequency (including boost) in MHz

After:

  $ cpupower monitor -l
  Monitor "Mperf" (3 states) - Might overflow after 922000000 s
  C0	[T] [%] -> Processor Core not idle
  Cx	[T] [%] -> Processor Core in an idle state
  Freq	[T] [abs] -> Average Frequency (including boost) in MHz

The check mirrors the one print_results() already makes when it decides
how to read a counter, so no new helper is needed.

The time granularity part of the ToDo needs a new cstate_t member every
monitor has to fill in, keep it noted.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---

Notes:
    Changes since v1:
     - drop the value_abbr() helper and check s.get_count_percent inline at
       the printf, as Shuah Khan asked; it matches what print_results()
       already does a few lines above

 tools/power/cpupower/man/cpupower-monitor.1              | 8 ++++++++
 .../power/cpupower/utils/idle_monitor/cpupower-monitor.c | 9 ++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/power/cpupower/man/cpupower-monitor.1 b/tools/power/cpupower/man/cpupower-monitor.1
index 89af019f8dc4..c8008919627c 100644
--- a/tools/power/cpupower/man/cpupower-monitor.1
+++ b/tools/power/cpupower/man/cpupower-monitor.1
@@ -51,6 +51,14 @@ coverage in square brackets:
 .IP \(bu
 [M] \-> Machine/Platform wide counter
 .RE
+.IP \(bu
+How the counter is exported, in square brackets behind the hierarchy level:
+.RS 4
+.IP \(bu
+[%] \-> Percentage of the time spent in the state
+.IP \(bu
+[abs] \-> Absolute value, the unit depends on the counter
+.RE
 .RE
 .RE
 .PP
diff --git a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
index e8b3841d5c0f..df00e82eb820 100644
--- a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
+++ b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
@@ -284,10 +284,13 @@ void list_monitors(void)
 		for (state = 0; state < monitors[mon]->hw_states_num; state++) {
 			s = monitors[mon]->hw_states[state];
 			/*
-			 * ToDo show more state capabilities:
-			 * percent, time (granlarity)
+			 * ToDo show the time granularity of a counter, this
+			 * needs a new cstate_t member every monitor has to
+			 * fill in.
 			 */
-			printf("%s\t[%c] -> %s\n", s.name, range_abbr[s.range],
+			printf("%s\t[%c] [%s] -> %s\n", s.name,
+			       range_abbr[s.range],
+			       s.get_count_percent ? "%" : "abs",
 			       gettext(s.desc));
 		}
 	}
-- 
2.48.1

