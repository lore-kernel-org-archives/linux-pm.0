Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECAB36165C
	for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 19:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781207989; cv=none; b=h0XyBVEl/j6Tx4EXLEFJuQBi6LeiawGcPFqCS8m+dca4JLAKzbtlpM+nNKHP6dRjKS2WMPwIJZ2xdw+ziOrgTsFu017Oh1eXkIK5peO2ryvgZjHDrAiahlETxcrwvh4JWIS7M+e4RpfZpD8yDez8Fa3wcqmaLi6W+wV5CVktAFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781207989; c=relaxed/simple;
	bh=ZRTeKE9L28SSClA6R8MmhIQyoSwY0qQWWZ4jOPVVcJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ktV52Xdh59kgJ0TMYXT9QDZ/OkdySJ1L1IYclCCSrB9WrCaF9rab0a/q+iJa2elfknGtHS+hcQHJ3srYey9PFfMYZwV5DDwXZrm4lHDpAfIzuh0iSkq9TOvRhf2y6z5ga86iMWchakGpyhOHjF6T5fM2S2i9eG6fHAwjPqGl2Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=OOI2bveD; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="OOI2bveD"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8422f395a4aso257801b3a.0
        for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 12:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781207987; x=1781812787; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xUBSfKa41ClVExPzLchTVHN/6r9ZIx4CRl6lZXXhjbE=;
        b=OOI2bveDoiv8/h0YLhB9U2UJL6soQaNHBqmhAXBYbn7Dk/c76quUMaG4KJgoH66rpJ
         hnO4Sj1qF4hSUPcFrfxbZNBWrunhCjqJR07mmYNO/NfGTgfOmV4d5gf3YwXT4uWwHJvF
         StAjDFclePk05ECyt6L7XIPR+oJ4O+uHCXqDRs8GmWItvTzRAY/0CLJcI0typOrnxsB/
         td0DMJ8XmM2+WGFTfwdbBhK6RS8D0lz8rUVQHyDoiCS4YBcqj3oqRLAuk9UWp+fgm7Xi
         qkik4i7hlec+B3jtOyworoGck0lTo6hUyIEt5Wxsb+a9gh3y4jHmvUXIPQwuEPSMETaT
         3G+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781207987; x=1781812787;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xUBSfKa41ClVExPzLchTVHN/6r9ZIx4CRl6lZXXhjbE=;
        b=JfxGX/dwPnvSFzFUFkFCHEg3xLFgdM1VcSpaIS3LV1qokCSzXKQy4uFTpYMaDpdlIs
         EppEFoL3skui3VVG0abDRP/az9TjS05WW4oIwOdd6FYrXEbd5w6UfjHwJ8DlI+inMKkS
         b4MzL8LuZMGexKkv822teZASgUsrIJTcC1ZAaZp3+Pv2igQ0wMdDh4g035p/0iMO5giE
         VOtxYSo5dZ0I3gAv4vCpaddbDy2/A+ELqELOKJhwbvhKAAiQ80+zveYyjyNaKiHAkNsM
         +s8kHSnjR2J1PS5quEy/tGlnRz+RRUpSI5Gr5uvRcRM0cgHYFXkAyhyrKcjxZTlNk4OA
         bK1Q==
X-Forwarded-Encrypted: i=1; AFNElJ9Ite83vApRcjf/zFTbM8kB+E4HxQ2fUP4aoiBwawf6c/IHRUkiETQ3FhBIDHXPrgM+sQ/4262bsw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy+rZHeMYyU0L8wIsa+eEEavwf7ZjgjSZZphXh2W445w93B72N
	NDCkYGJnkAMIOE2KpIGluyiIFIVCJBStkfww/Tm3Z8jJBZt4OqVyLtAinumsit6Uy1PJRSldmx8
	G1VNLDbU=
X-Gm-Gg: Acq92OG1B393cbOqcCsQlPRGHGT3EugpjdA+w157bv5pd6vaRH++QW9xYMKBrEkhNtV
	zY4ugG1v8iqM1fqFcBpHCN6CS8L1dTRlx2ERfwNWRXUrN0ZybSxkTGTuZ9opjDfASYhsRlI60Tm
	T/i4r6P7xoaPrQh1drJ8kcFQcxtCZlloNB9PxBAXxlO89SLyeJUcGdNwxYrGq2UK3TqlvPSouyj
	V2E8/Gka+yY7WtDqQ6lFkVtwTLFzNxrgJg0cmLztANwlixgB9avXv8wxfDjXETkyjo2oUFmS97W
	kNxNwpwzBoFp1TBwKAH+wZXUuv6djUCbeENrkQoY66HfcMRGfOWKoAcxirKgdEt46lcNnHHdYem
	GCM6tKRUf2LAtqvY2YQXfobzMxL5vYbqcaU7JHZhXcNWNWGujMy2/e4tizlfk2UsY1TLtUhlfgF
	plIZg3kIerLbgOVD517Jo1xln5IHUF7oM=
X-Received: by 2002:a05:6a00:2395:b0:842:499d:450e with SMTP id d2e1a72fcca58-843497500b4mr141035b3a.20.1781207987606;
        Thu, 11 Jun 2026 12:59:47 -0700 (PDT)
Received: from localhost ([71.212.202.210])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-84337b8fbdcsm2873353b3a.6.2026.06.11.12.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 12:59:47 -0700 (PDT)
From: "Kevin Hilman (TI)" <khilman@baylibre.com>
Date: Thu, 11 Jun 2026 12:59:37 -0700
Subject: [PATCH v3 1/4] PM / QoS: add flag to indicate latency applies
 system-wide
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-topic-lpm-pmdomain-device-constraints-v3-1-75d69438518b@baylibre.com>
References: <20260611-topic-lpm-pmdomain-device-constraints-v3-0-75d69438518b@baylibre.com>
In-Reply-To: <20260611-topic-lpm-pmdomain-device-constraints-v3-0-75d69438518b@baylibre.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
 Ulf Hansson <ulfh@kernel.org>
Cc: Dhruva Gole <d-gole@ti.com>, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=907; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=ZRTeKE9L28SSClA6R8MmhIQyoSwY0qQWWZ4jOPVVcJQ=;
 b=owEBbQKS/ZANAwAIAVk3GJrT+8ZlAcsmYgBqKxOx8MPc4peo/m/A+4QQzFeWFqW29a9qrnBGl
 Eon8REsyAaJAjMEAAEIAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCaisTsQAKCRBZNxia0/vG
 ZfSXEACGicZ2l6RS8eZsh05W0BOtggrmSgo2owTBxVFjclon4LzKT1SsxLR6L8zj3siE/83Imly
 +GfCVfFe7Xr7lTX7e1PVRM0rywxpBIr56nDrWfJ9VXs8vvqft3mxviEUKP7hJbArpuuJALBeqVu
 KdVm41XlqWtAuGPKFRDn7I7Y9d0fWgrqOX6TCIn+yTwncSu3+Pb5EaTsCSQlacwo3G/n4pDir4Y
 LS3tcx4RZ0lm5GugjysvNpnBnfI9IekNkenIyp0y3s4Xwlihn7xWerWPCjEgjdU2N+qtMKz7J8X
 lxCX2ImNr9KtzKpuz4Mt3eVowWTtIUTuQY/fvD9JSwTEFo7gZDXRbTjXEjEgq+IKbiOMaauMeqR
 rGMZq1gott1141LhlU4+qT+Tyab63rbR+yjxpSuNj++sMKUHqom29MSDYviXdqZzcMnhb1TLEVn
 LtEPpGUJwPd9e+ngPZPX/CQzVlfGb26hD1LYYrW/2vN7dTSWt8EEGWhXAyOwgokBcfuk2FOOmVK
 LgELvk+qLpveawp6KGDxXnJ7WIKA9Z7rBfP0rh6RJjMMw5Piif3uJGSjBH8rv5yHtU+UGaoRP1l
 X4TwY1mQm6FMWTJNvC1bOpBPGs4Jb2s595jk+vJdxyM21hDq4m4g40+kB3JOTYBSKacA6dV+4WH
 3EPcWdBzaep6+uA==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665

By default, the QoS resume latency currenly only applied to runtime PM
decisions.

Add new PM_QOS_FLAG_LATENCY_SYS flag to indicate that the
resume latency QoS constraint should be applied to system-wide
PM *in addition to* runtime PM.

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
---
 include/linux/pm_qos.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 6cea4455f867..aededda52b6b 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -37,6 +37,8 @@ enum pm_qos_flags_status {
 #define PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT	(-1)
 
 #define PM_QOS_FLAG_NO_POWER_OFF	(1 << 0)
+/* latency value applies to system-wide suspend/s2idle */
+#define PM_QOS_FLAG_LATENCY_SYS		(2 << 0)
 
 enum pm_qos_type {
 	PM_QOS_UNITIALIZED,

-- 
2.47.3

