Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490953769FC
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 12:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788525026; cv=none; b=ZAXJTFCYijrgq316NaCIhsbw2erLl9fYpZgC5SWpkg2GBUkP1Z6UJEQq6xMYGldCPjCxTIb4ts4Q7CVH/owZowViBZmK0Hnzc8ncbSN0i8DtOhHLEMd+VYoXadyiTWYnc+zbsmYnEvR0Uc2hcP2hnI9jefWHgmNYGZPjWSVnWqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788525026; c=relaxed/simple;
	bh=Fxorm3DS2+Aysgdl5P3byLfJY54JArob01AMvSl6ArI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PXNY+OtJuAK6NluIK2N3UrdxuUqcbQh8Y9rtfgq88c8fh2SmxyoaaP/Ur4+2idJ69gxpZAjiyMVs79saDVI/i40TIaMqCAkuVX0ExzB7JmYXTOrdDcAy8IMuGwYg+Cy4cwQ7SORM8ytBaN8/oy2fQWl6K0js2JykSuPS23CZ8AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/ShqAT/; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/ShqAT/"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc147d86bebso975520a12.0
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 05:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788525023; x=1789129823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vFvOCesDJE1WQsfXuAeNAFRnkI1SonLn2LJfZ1tDqrY=;
        b=R/ShqAT/Hwejo4/Xio59QH/jnRTWr5my0G/DUGgdXD2JyeiHO8Nbi9aoHZabTCWX4w
         88pPwiugFJFIkXfmUml3DLyLwxo/Td9FpziqXvVzIJHUBrEKPgwbsFVGxo+Mw2QIfGOj
         A6y/NxbRn3LHK2+L55uXkTPMOg9Oy3Sq4w34JnT8mDtoGksv80q1oXit9Eg7//VQNtp9
         EkEiUJLDQVZ73ptBkLnGWkFVw2XYzAAIYXmwZB9Dk4tjB0E3iuS8PEr7+jHLggtfPeGC
         1viemVKCR9TUL+Chtqe62RKL4pHDBJs9yjl5UGo4CjS9uFDySmjrmtDVMhIelWTc6TEd
         KElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788525023; x=1789129823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vFvOCesDJE1WQsfXuAeNAFRnkI1SonLn2LJfZ1tDqrY=;
        b=HTbThByD6aISFaQN1rg4qE5kWcMRRLUDgdhNXzyCaobkWXtg4xX10r/L7M28ebWi9V
         9vNUiieVjU1DvXKj/vxB1h8dpp4/0sXaNOHMH4wAvpAASnaiJEehwKAxdEadFTnKzDV2
         7Dj9bdha9bUmskiN2Eds3jdt/X1kI1pIw4hq46y2g7kLt19yMTEzdqiAHAqUKtLi1WuH
         dGM/dAFlxJOgMZQMYCJAsBTpl9pt+jmhfz5VgBBvKP9aoil4WWH1e6kBtAVH8UkPl2Fu
         pu09XFr8u7IOt/+oCLBQPiKBXPPXUpr8pgrofdYPQlmFo0vpPB4HklwQXKqdZqqrFR6l
         cM+w==
X-Forwarded-Encrypted: i=1; AKwUvBxuIM2fKYKLf1Sk1hIj7WnuguEzzcUyRQ8wxY3LQiSJB+l8YrpfhycvXMbtF3evKVC2tvmILBt5gQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lk0TPJ1BEILCKNt3Vq2AwFwMTApTkmz80IjBwUY03Jd0pQpnGy
	5zi3E4WwLuV84dCh0AQyKibyFP51KoroCk8SKHnCJ8njLoV+j6RZl3Kb
X-Gm-Gg: AYBFou2Z0nYauiWz7re5CxVScn+p+3jkqz/6AHK1fIVsdNlD1LFwmjA//qWLcas7Nlq
	SheveX9CCc7HnKr/jSIEG+ge62iNAjFX02q9jeKTQi2/QUjuZ20AYrIPdGS/urXX4DS5NtGaJoM
	shbAL2cheLMyLr+sINXLHwB6KYlfQn6a4PtNfvcOmGMrMiOzKkEMZGESZfLSsjvJNqa1n6JSYZD
	rvzda8PD6ry1lxh4D1l06KdVny3Bjgs2rhT96M+jT+sVbT4D4LmMxRF39rPq1/k6ma6wia+56L3
	QnCQzzBfAmqNcheB/D+RDpGvhWx2JLVu68eXSJxjC+LyQh5sWsLTDbfUifPNoWw1VerJDnDXk+Q
	TZt3WTUSFxxOB1SQiSno0sUmNqUB4366j8JrLnB0BMFBUKj5llvP+d+mHTzVAljkNjJDPXXNo11
	kZ+1KPXWqkPhMJE70rtlbvKpFy81fUNOyWNDmbTQKpMJNDvizWTYcTvQECdqg/nPOxf5cdNP/Db
	d/6XPprjWBj0oI=
X-Received: by 2002:a17:90b:4b04:b0:396:4ce0:6400 with SMTP id 98e67ed59e1d1-39b07f33963mr15173478a91.2.1788525022476;
        Fri, 04 Sep 2026 05:30:22 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339af25062sm9587131eec.16.2026.09.04.05.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 05:30:22 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH] turbostat: fix typo "intead" in comment
Date: Fri,  4 Sep 2026 18:00:17 +0530
Message-ID: <20260904123018.34947-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct "intead" to "instead", reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 920694c3c1ec..e2bb99d9b7a3 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -10448,7 +10448,7 @@ void pmt_init(void)
 			 * Set the scope to CPU, even though CWF report the counter per module.
 			 * CPUs inside the same module will read from the same location, instead of reporting zeros.
 			 *
-			 * CWF with newer firmware might require a PMT_TYPE_XTAL_TIME intead of PMT_TYPE_TCORE_CLOCK.
+			 * CWF with newer firmware might require a PMT_TYPE_XTAL_TIME instead of PMT_TYPE_TCORE_CLOCK.
 			 */
 			pmt_add_counter(PMT_CWF_MC1E_GUID, seq, "CPU%c1e", PMT_TYPE_TCORE_CLOCK,
 					PMT_COUNTER_CWF_MC1E_LSB, PMT_COUNTER_CWF_MC1E_MSB, offset, SCOPE_CPU, FORMAT_DELTA, cpu_num, PMT_OPEN_TRY);
-- 
2.48.1

