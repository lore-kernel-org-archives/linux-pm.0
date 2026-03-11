Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5222B3C65FB
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 09:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773219662; cv=none; b=oVppkany6yv/g9RSK7hitDwCJfXAoijKXhXK4s3atYAx24La+NOByMsAHGdrgJNr+R2I3tpzFfGY9bUR461Tdy2A70g5K2Degz24z+008PkMl5Ivm89Xf2D+kWKM5a722C5DEXFFFfVGqFR6qG0iEEkmDB2dDf2B+58/hGwZhrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773219662; c=relaxed/simple;
	bh=espMymzHE4HrTuSdbWke58KOjT/daVhLaUiaKZQO3ZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cm2nsNZrmCwr2fZOIlIxU8ymazSeqAxE3nN1j7yKkygZVnc9FnbfmZtEph/5VYz6JC55tjbsas2JVSyY5+yJLML39QrU82amroMr1B+I/bZWtjeSzrS7oRAQ77kAs/iyKIZq3jSnoi/9RH5Ychj1n8rBVStZKlLtLJjBDYF7zr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XAl4Mz98; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAl4Mz98"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-38a49fc06b4so25512431fa.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 02:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773219653; x=1773824453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRRYBopNS3qHJICGIMOHL0gkQOLsrqd2iq/1WotlQAU=;
        b=XAl4Mz98MlaZxTjtXJGqYyXyod8eZvNM9a1aN8DSYR/S3Pcfw18uBjJwQBmR2ADao4
         tokSs2fa3h832exYkP+Bh4GjygZqTauSKqe254Q/6bLGahLRJxyO9boaSzQ8b1oO9RjY
         fwhDDlHyiu5klMXEViLAi9z0XtBySEi90rEf7qiCB60naBJlXk/jNSABihS7iNTRjAXb
         xDt3fuKDiP9ArF8XNWU/FQ6rTt/YA53zUAqBi7HpqMra8X3dIVcoaIxe7NSvFW0l5Qck
         /eXl04QIi1pnBhfUlswWCplEzWh6UATFWpOH/QQaMGFjn5wTriQ2JvYMpUK2sMenlLak
         B9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773219653; x=1773824453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vRRYBopNS3qHJICGIMOHL0gkQOLsrqd2iq/1WotlQAU=;
        b=jqKYXyJN+mCecbWSPDrF6uuV0Y5urXM1BlmBHfIBhYMTiS4t6eJyKjSvpbOBfRr85J
         valNQYIkZjZt610eNCAsRvTRaVdDEHs880LaKdIsJjBIzqEWiSKV8CVrUX0OPy66eVCi
         mlyJD99A40EvSn1DaqpLmXCLi3GnKgvKwFwfbWWwzVxFS14RRceHd1IP43MY9rguBbRz
         746hrUghSRnVhzdIuF50TegcHtxxIrTtaofuzt1q6Ts+JetUG9DmthWEffLyY0D4jvxo
         obdDrsY78m/c++z4IBFP/NmCB4nuqJyhfJtvW+QU7GAVWilo36GG6BcXiZKztutNEOS4
         sC3A==
X-Gm-Message-State: AOJu0YxSqkOo+7bLjJG848Opzvn88td4OXYbbc00DlfTD1Bye0T/OOxR
	a4KTRkjq8RHT1sAh1+7CeczeINKM+iHFq+aLYxMV9VVUdTxQ6s//KuvI
X-Gm-Gg: ATEYQzz8r0mbt8zmiNeTnj/gX9FA10tpON8uTzAhlXvUC1sA0VfGp44KyX4WQ7D0mYq
	cnjYc4TL36E1qbInvzMP7dLsEVl6Brv9hf6sIyLuDrPqva8pJ4UQgWcKQTagEfPWI5jniSsxeC+
	CnLcwacF2jtQlRG21SVdcruFzK1mrhG+FIYMAjYGmoheSNN5q5IxzY/3gtnprFh4ossL8xvRYJ2
	HY98ae8Y+QhKh3f4oAFnCTTufq19kFWN1r7k/LRJa5PbDtoCW3ubPpWwsYz5AougXKQ6J/OawVN
	v408oUScMbHmcLvrtT6oMHseG47ATY20hbHNKf413xgMVB/NgGb32m6UNxuf+tddjFNklWLrsOx
	2V9GTv4tYsb61gySRJNmThMVmKbsNk0bfdaE1VIYcD3cjQfDjPAsrBDCO6BeOmEBb6yo5ZqPKNH
	Ue6guaqF8ceIUdvRZIoUl48nPRcStzMHZsB3u8XjXhB/m7P8UIqY4KHKYGz6R2
X-Received: by 2002:a2e:a992:0:b0:38a:4e8d:743 with SMTP id 38308e7fff4ca-38a67dabec4mr6996051fa.4.1773219652792;
        Wed, 11 Mar 2026 02:00:52 -0700 (PDT)
Received: from abityuts-desk (176-93-227-108.bb.dnainternet.fi. [176.93.227.108])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38a67e5ed41sm2645041fa.25.2026.03.11.02.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 02:00:52 -0700 (PDT)
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Len Brown <lenb@kernel.org>
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>,
	Artem Bityutskiy <dedekind1@gmail.com>
Subject: [PATCH 5/5] tools/power turbostat: cleanup print helper functions
Date: Wed, 11 Mar 2026 11:00:35 +0200
Message-ID: <20260311090035.169539-6-dedekind1@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311090035.169539-1-dedekind1@gmail.com>
References: <20260311090035.169539-1-dedekind1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Two cleanups in printing helpers:
1. Add a local 'sep' variable to avoid repeating the ternary
   expression in each branch.
2. Remove the redundant parentheses around sprintf() calls.
3. Remove an unnecessary cast to "unsigned int" by using the '%08llx' instead
   of '%08x'.

No functional changes.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index f5cf12ab84e09..70dbd927b6521 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2835,31 +2835,38 @@ void bic_lookup(cpu_set_t *ret_set, char *name_list, enum show_hide_mode mode)
 static inline int print_name(int width, int *printed, char *delim, char *name, enum counter_type type, enum counter_format format)
 {
 	UNUSED(type);
+	char *sep = (*printed)++ ? delim : "";
 
 	if (format == FORMAT_RAW && width >= 64)
-		return (sprintf(outp, "%s%-8s", ((*printed)++ ? delim : ""), name));
+		return sprintf(outp, "%s%-8s", sep, name);
 	else
-		return (sprintf(outp, "%s%s", ((*printed)++ ? delim : ""), name));
+		return sprintf(outp, "%s%s", sep, name);
 }
 
 static inline int print_hex_value(int width, int *printed, char *delim, unsigned long long value)
 {
+	char *sep = (*printed)++ ? delim : "";
+
 	if (width <= 32)
-		return (sprintf(outp, "%s%08x", (*(printed)++ ? delim : ""), (unsigned int)value));
+		return (sprintf(outp, "%s%08llx", sep, value));
 	else
-		return (sprintf(outp, "%s%016llx", (*(printed)++ ? delim : ""), value));
+		return (sprintf(outp, "%s%016llx", sep, value));
 }
 
 static inline int print_decimal_value(int width, int *printed, char *delim, unsigned long long value)
 {
+	char *sep = (*printed)++ ? delim : "";
+
 	UNUSED(width);
 
-	return (sprintf(outp, "%s%lld", (*(printed)++ ? delim : ""), value));
+	return (sprintf(outp, "%s%lld", sep, value));
 }
 
 static inline int print_float_value(int *printed, char *delim, double value)
 {
-	return (sprintf(outp, "%s%0.2f", (*(printed)++ ? delim : ""), value));
+	char *sep = (*printed)++ ? delim : "";
+
+	return (sprintf(outp, "%s%0.2f", sep, value));
 }
 
 void print_header(char *delim)
-- 
2.53.0

