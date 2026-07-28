Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC9B3F4DDC
	for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 07:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785223921; cv=none; b=eqlYXk8+GsOZCqsAPhYSxeI4Ie2EjrSuhEWMZ6D3a1XDU6C7pNTN8DNn1ggMN08NluscRY7ANIyZskJJjqDfndEDiM1zJ+Drf3K1vEqWHf365aWqokhHKksVcoH6H8Ehp/boE7ykXo2bSRUWWY7C/KYjPmk7qHMTnKJEJ2IZt74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785223921; c=relaxed/simple;
	bh=8BdMURF69/uBF2yJWJR2TWG337rslns4sjCBwv/dzXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aPWYjo9C8xNdzgeOl/IyOgjGML1sFBDoMLTz9vizNiWBAwinXOkTHB0KCAHiJrFFzLO0LzlOYc5plvFw/tj0wdZCjd84ESC6R5hbPP4aiZZzTXgUoCEq2z8RfkeOaflmk4utl6jEYUcgkyNL+aylqKVrMFDq78+ruTuAU+9sD+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=manifault.com; dkim=pass (2048-bit key) header.d=manifault-com.20251104.gappssmtp.com header.i=@manifault-com.20251104.gappssmtp.com header.b=z0Dw9ttQ; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manifault.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manifault-com.20251104.gappssmtp.com header.i=@manifault-com.20251104.gappssmtp.com header.b="z0Dw9ttQ"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6aae2766d48so516341eaf.0
        for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 00:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=manifault-com.20251104.gappssmtp.com; s=20251104; t=1785223919; x=1785828719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aKsoUL/x0BWL8hOHZwkWcIVk7QHl+uLVAwgOItINi2Y=;
        b=z0Dw9ttQQ7hpjlkPwvqTuLQI8fkWkm8fynB7NVpWbnOLOZMjdIIm7SqcpwFlewuGYe
         q/yudp65j6veEOQGmcKC/QLrCEmzNeaiU4XllPaBJR0lNZOKs3/EQwCubYdLX7IfuFEz
         hiunQabF6ZKqh3GLdiOCLe8loSZaxhBzcg4Gon1CgsCbgWmyjvIp23NwKWuwEXFoPZPP
         Mj5hD0NldHv4s1J9VSoTfrHyN/Mv8ilRNv8Oalqi1RYsekITqCuFHb5khIP5UIxC4o2K
         R0dHb/GIkemjGMMbQBRHMjE6NIDzhojHsn0evm6RiUpPqeRrBI1S8e9ntbQWEmbR4HfS
         VsHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785223919; x=1785828719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aKsoUL/x0BWL8hOHZwkWcIVk7QHl+uLVAwgOItINi2Y=;
        b=FVPg6+epkUsNwuULuLV5PTIKjErh4Hi5tQc7GAhb9E4Qvhm0rSno9RejR/fO6fv2Kj
         RideDiFbfd75F+3EduJsH0l1qdRmn0NuouE569TnwuYWsKFVnKOzYslSxSytBDHAP6lF
         UIr5ryzcTVHmpb3Yes7CNCOkReiLDEmdhac9onqK/qQfjqIY2jIE383HIONh1FIP7SYi
         vyj5PIH2aF6WjaIgFkSxE70RN34DPrgcQvDdXRuwJDprub8COIVuPhxoHiWpLej6RRbk
         FXyr3nLLrETu/MzH+NV0P0b3ErQ9SNiIqCXei22+fvJZ+ErpO086c2LdXq+W+UfQT4ZL
         QcZg==
X-Forwarded-Encrypted: i=1; AHgh+RpytMEK+/lsq9caS5/epzvDI9hCweLy4T7rbx9qgo1OHZWcOxBOsLtq9rosJoe+ghWZb+4fJDGtgw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyA6T18IGJspPhwNCjS3cT5Vx85u3pR80jv1oGZY5WRD6FGoFSF
	HptBX/B1GdtzVd3N+5oGmW+cpclJ1MUBOcFcdSAWgbvBfz6W35mkKV40Ulb4KJRQUq0I
X-Gm-Gg: AR+sD11JFd08+aFXKM8PTTUkFws+YSzit4DQCn0JxgaST7fhBFPoPEP4fqMXwNVXyjM
	YD3DnPGp8gdpOlMF7FuYchV7iOLqGYTVUz8Il4T1RAEqe68ouMjEpft6udmy+AvNAA/uFDlubUa
	UH8JKqr1Sx726GQheg9cMvn+NYjeR4DThldermEGnE/JLeQvrIuGd3PLpvbCFRfqdhC6z0L3UDu
	uRRDRAU4ydFvDaEzztaYo640mY1HhXty3p+WtOS0HAwJQpZlD+xwrNmQeqCGv62g4FehM4J3q41
	xOECyUtDsLZdUs2vTpYfylYW5Dj30Y8gaEmeFJCGRrkvVyYZyLafB2ei3i9LRaHQYFM15zDD+oS
	rOkTBBzaYxZHFUnEdUzfsjVIHDvT+ktguD+QtyWj3KgIypOfNH7roN619HMOOD5HFnLIqCei7tf
	lH5ZaWVr/x285UM39oMQsrzpDeP1jTNkRPJYH5O1q0GkDqVjgc
X-Received: by 2002:a05:6820:80cc:b0:6aa:dfbc:65ab with SMTP id 006d021491bc7-6ac969f1caemr610511eaf.5.1785223914280;
        Tue, 28 Jul 2026 00:31:54 -0700 (PDT)
Received: from localhost (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ee2a102120sm14168192a34.26.2026.07.28.00.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 00:31:53 -0700 (PDT)
From: David Vernet <void@manifault.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Changwoo Min <changwoo@igalia.com>
Subject: [RFC PATCH 1/4] cpufreq/amd-pstate: Document missing kernel-doc members
Date: Tue, 28 Jul 2026 02:31:47 -0500
Message-ID: <20260728073150.54964-2-void@manifault.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728073150.54964-1-void@manifault.com>
References: <20260728073150.54964-1-void@manifault.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernel-doc warns about five undescribed members in amd-pstate.h:
union perf_cached's @val and struct amd_cpudata's @raw_epp,
@current_profile, @ppdev and @profile_name. Describe them.

Signed-off-by: David Vernet <void@manifault.com>
---
 drivers/cpufreq/amd-pstate.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index 23e8baa05849..99532595150e 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -32,6 +32,7 @@
  * @min_limit_perf: Cached value of the performance corresponding to policy->min
  * @max_limit_perf: Cached value of the performance corresponding to policy->max
  * @bios_min_perf: Cached perf value corresponding to the "Requested CPU Min Frequency" BIOS option
+ * @val: Raw 64-bit value for atomic access via READ_ONCE()/WRITE_ONCE()
  */
 union perf_cached {
 	struct {
@@ -89,7 +90,12 @@ struct amd_aperf_mperf {
  * @epp_default_ac: Default EPP value for AC power source
  * @epp_default_dc: Default EPP value for DC power source
  * @dynamic_epp: Whether dynamic EPP is enabled
+ * @raw_epp: Whether the last EPP write was a raw numeric value rather than a
+ *	     named preference
  * @power_nb: Notifier block for power events
+ * @current_profile: Currently selected platform profile option
+ * @ppdev: Device registered with the platform profile handler
+ * @profile_name: Name under which @ppdev is registered
  *
  * The amd_cpudata is key private data for each CPU thread in AMD P-State, and
  * represents all the attributes and goals that AMD P-State requests at runtime.
-- 
2.53.0

