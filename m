Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.210.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795777004;
	b=gkfxtR8yToNL7HLVbcrMm4rb5misa38SVpL9lpXW6ob5wJTZEZeuUhA5fvmzjgrSr6fC
	 3LZuxvFK/MUrovLS3GAek0L1qkO1C+4FlhtcoukwFPkFifSRlQHOrz/W0rCJYZrFG6GZg
	 WPkomErb3GDMGl5zVlhy/MIeiAqgEdNJH9FBxQKKbyPCYGwwqhn+sGQW+qUVr9eA25dNq
	 jGwe7iOqjtAFaiaMqUKuPqbQsb9T6cQ95gBVyGWwW8RTx2fFq/CUQIERLw3WhGjVBivRb
	 itAuVqeF+/e7xLlfFJlvDjMIL3O6VST7IhvNcoctc38tPzwr1pqK12sBdz5OkXtqV7w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795777004;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=C+G9MD1YETmf62awSsJnA8r3aF77m2xP9BdbBEqhs7Q=;
	b=sWq0os9IBDKD35ThpM65tUAGlqMLGXEEPWR3h73AJJ9qUiISCxL9w2TjwZLlzsiWukfn
	 17UclOypKMUsIG2x3hOQlXeYdK08d4zRK8VTEFVW4sN0JwYQLJfMmIfDjKJzo2SphCNIv
	 ZYMhmGGkwIvWbQwbHdpFmDZrV59YjeOe89ZkqqYway1WIryrRbAB9rYuCZASnlhtUOV9w
	 Ly3AGVp8LJVOVpQjz/FSvZkQmjGNAWbteiUjS28QMZKxuNQXjAn2z7G0J6dpmsP7K88gh
	 WdPrS15Zv5T5EzgE+vs+v4tsS+YGU3SSxDcGOJo2UPr9f7K3NYqVdJu1njxpBtsbE0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SA+3qEPS;
	arc=fail smtp.remote-ip=209.85.210.51
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB766606A321
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 10:56:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB766606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SA+3qEPS
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-862aca1ed4dso3101320a34.0
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 02:56:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795777003; cv=none;
        d=google.com; s=arc-20260327;
        b=Sa1FNfiE73a18sNfO0/EqyqndPNhLRlM8Jb0eox5ckT6NZmA4pCUM7kGCQv+j2aW9g
         G+VdSi3ZXhdiIVQToHC2uVWfGNfryFXbb1Q0bhgyDnflapSBw7n1+0y37euoUiMFQhiY
         P4Kv9o5B20uN5sr6slm5XUlC3Kpy7MIer3TL1KWQvEk3RNyHkXsxzzkCfeth7DwM7oRc
         AveyysSAtJaxb3f5kMagJnJU1bO+TMsgO5wiHeY+fpbR0BVBtS3BoExSNVcyrUuElkeH
         2J9GTd9fl7GW2GIwlTdmrZ87VtXN6foXQUkLJ13hm6lRX0BOlcAZ+MZSP2b+vsFRPJXp
         SRYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=C+G9MD1YETmf62awSsJnA8r3aF77m2xP9BdbBEqhs7Q=;
        fh=c4dJTNI7ONOskMU0/E5uT6Fr9I94uKEn/4P5WCN0Ya0=;
        b=RQsQGrT3faBBaOBziQeJo0TC9AV1NrhSzqIzi9WnTW7w76UmfTjYNnHAyaGz+FYfUH
         oTw/hJUmJkkFMMzpYfRnY4dqi4S2m9k6L/LGhndZIUE6dHA4eh2cvdaL7uQqE/EtVX74
         JYHAEIrGHfX+pFJ8mKmj+rBnTLe0bYPNLImHwbSSizHuyHeFWKnmMOnkD80M3wBfpAPx
         PHDLrRu7/w0QgqOk8+uKbHBGopyxemGMQyijC7mxGk2Ha8FUikfSetvonfFhzxRJFSvl
         tQrWy7Yw8lEt8ZZudPFYPf7sfkAyQ4IZxcCjy/nSVEiY1eWqNob9IlkQObpRasLnt9GD
         oQMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795777003; x=1796381803; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=C+G9MD1YETmf62awSsJnA8r3aF77m2xP9BdbBEqhs7Q=;
        b=SA+3qEPSnsArNIrrfZSSnr6k90iPLdHMqPX+EaLNJl1+rMYZ3NbUoXwa90eFJKlp8+
         ptAEhVKlMTWcsz7NnW/WRwPJsYncN4+WCmoifhL2vANXvazfTvmDuNuiPZ5vWGzC/dYV
         9rJEl1XOevzQzS4s0NoMVN3XA/Xn9J6UaO2vW9iXODIWwsC/HlYy3imYT15hWjkLOslp
         1jLCuCPX/ssyBwQGkIxwCNw6JXqehdRbo5Avr4Ukvie/sEcBD/os9QCrH9UDPbNzxELH
         YTygYXxSS/Y2wr6LKGt3nJqlA6O5WceG9Eo6F0e4YQx55w8cUXGhwEtBzR82RdBz6rcF
         kaQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795777003; x=1796381803;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=C+G9MD1YETmf62awSsJnA8r3aF77m2xP9BdbBEqhs7Q=;
        b=XQsAlISuMozm1W+NTZxf/VjUOhgh0kS15yMb5af5oB3vh7QkDKyzub8x13iRaIdDSY
         9S/+rDpOoWWmcNL2a9mUyV0oRzcD0obw/ne7l+u3MZnZwpJ/wzMPYgK+pw02EpQisS2D
         8orbLdsaxIILYvK4H6+oEGFnD30P9ojDtuAAjquUa+cx31NmRsoeYmBfyqYmdy5SiilT
         e0QEoiFPj8DIAlV2NFlPSugkkS8exhQJ8ahrRVU4ylSeonHZRUNxIiUKefdmSqNUNYJo
         UmbKSyBv1jhgrW5sa7pmpDqE0uioCawHnTfjyzSEMnHre1PkUxkqBZQ/B9QPxRs3jsfY
         TCNQ==
X-Forwarded-Encrypted: i=1; AL+hErHJIZSLpDjem3itngT2ejZHEhPt+vuRXL6go9tIpDOnPnUlMR8KOEu+ZHAlKGA8IrqOLKk7yBElTA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/1u1Nvx8hBYkb195sUD1Rf2X0C7MSz0vALERwLZmyJGBufyikB
	z8eQL08LqUn5t6Cmtq6par5zs3I+HlNzKGPFTyC1bRzti4Nl0bxwHeot4XfGFJjV1ca46NOz5ZV
	nBmZo02fZ+cFJOxCYt9UkDTApGD20IlU=
X-Gm-Gg: AZFdTZcrCyhjGftaucyXOPkpXnJPP8q3pEK8Ad/gqT9PQ91Nt28WlMv0Ph4ja67XBdP
	jlNHXi2wnR3iyIl3w4AS3BaQK4xMciqHT9EpTvVbgPWroWK1C1DZcmSNrmM8OopxTOyAIlwbbR+
	1QIj4ZWfJrXWqyF5MBFhJwsPX4K0hBhdvrKwdh61Ea5bCbgk1hiDiyQ9PRBMpI0TU4j1fhfD7Y0
	PSDs+g+elWKHH43NVrwqhTrsbja/GkXB73hRCGe/TmJKTRb/npM8u1kEJmwa0WAN9zVQPHFMrat
	NgBBKxF8QBkO1sTNSTj4JJqrV8+/TLlMwDR7dYLY1c2klPv3m+BoYCuJNn6fKA8WL6vludPXPXg
	3fGptiGpsf4QcOIZXfNys4rBW0/cXd9G4vgdz/A0vSP4NArgdYTovM9H51H1vBrEYNQ==
X-Received: by 2002:a05:6808:6d92:b0:574:93c0:5aea with SMTP id
 5614622812f47-57a0c6c050dmr21770536b6e.63.1795777002704; Fri, 27 Nov 2026
 02:56:42 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 27 Nov 2026 05:56:42 -0500
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Lee Youngjoon <getfeus@gmail.com>
Date: Fri, 27 Nov 2026 05:56:42 -0500
X-Gm-Features: Aa3M54rDmdf4zHHYDtRAD-zOujdJiLrziVZuYZztEqHqEQISApJqxYvgDcdWXNI
Message-ID: <CA+m4KrDVNkHhqJhRVv7NRWhStNq8ZW+BfyAme6ZZrN-gqr9Q7g@mail.gmail.com>
Subject: [PATCH v2] cpuidle: psci: Skip Gaokun3 cluster power-down in s2idle
To: ulfh@kernel.org
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, christian.loehle@arm.com, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The Huawei MateBook E Go (Gaokun3) fails to resume from s2idle when
the SC8280XP cluster idle state (0x4100c344) is available. Keep the
cluster idle state in the Device Tree so its runtime idle governor
and the RPMh next-wakeup lookup retain the existing configuration.

For the Gaokun3 cluster domain, wrap the system power-down decision
and reject the cluster transition during s2idle. Leave the runtime
power-down callback and per-CPU idle states intact.

On a GK-W7X running firmware 2.18, the candidate booted with the
original cluster idle state in DT and resumed in the same boot after
159 seconds of s2idle using the power button and no RTC alarm. The
cluster genpd counters showed 510 runtime uses and zero s2idle uses.
The test kernel also carried a separate RPMh KTIME_MAX guard.

Link: https://lore.kernel.org/r/CA+m4KrB1p2u_y92phm-xpn3up=kebi1OmiVc3X4CCdFzHT9-5Q@mail.gmail.com
Signed-off-by: Lee Youngjoon <getfeus@gmail.com>
---
Changes in v2:
- Keep the DT state and runtime governor in place.
- Limit the workaround to the system governor's s2idle decision.

--- a/drivers/cpuidle/cpuidle-psci-domain.c
+++ b/drivers/cpuidle/cpuidle-psci-domain.c
@@ -9,6 +9,7 @@

 #define pr_fmt(fmt) "CPUidle PSCI: " fmt

+#include <linux/suspend.h>
 #include <linux/cpu.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
@@ -41,6 +42,20 @@
 	return 0;
 }

+/*
+ * The Gaokun3 cluster state fails to resume from s2idle. Keep the
+ * normal governor for runtime idle and reject only s2idle power-down.
+ */
+static bool gaokun3_cluster_system_power_down_ok(struct dev_pm_domain *pd)
+{
+	if (pm_suspend_target_state == PM_SUSPEND_TO_IDLE)
+		return false;
+
+	return pm_domain_cpu_gov.system_power_down_ok(pd);
+}
+
+static struct dev_power_governor gaokun3_cluster_gov;
+
 static int psci_pd_init(struct device_node *np, bool use_osi)
 {
 	struct generic_pm_domain *pd;
@@ -71,6 +86,13 @@

 	/* Use governor for CPU PM domains if it has some states to manage. */
 	pd_gov = pd->states ? &pm_domain_cpu_gov : NULL;
+	if (pd_gov && of_machine_is_compatible("huawei,gaokun3") &&
+	    of_node_name_eq(np, "power-domain-cpu-cluster0")) {
+		gaokun3_cluster_gov = pm_domain_cpu_gov;
+		gaokun3_cluster_gov.system_power_down_ok =
+			gaokun3_cluster_system_power_down_ok;
+		pd_gov = &gaokun3_cluster_gov;
+	}

 	ret = pm_genpd_init(pd, pd_gov, use_osi);
 	if (ret)
