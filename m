Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A236041A4F9
	for <linux-pm@vger.kernel.org>; Mon,  7 Sep 2026 06:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763682; cv=none; b=m9wVu028m2wku8cqoE8qorUo2j8GWcg/LNJEf1lPQEVzweLmHjd6oMB2K7jZtIYtifvRE67K+Y3U2ERZ7xg8Ywuvyn+/PvOzm8NXnDghIeBRkMJXqU4+ezPNW5UbHuaFFNK02L4sco0MXBK9zBPNFPttruk6Peng2Fefyx4Yv20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763682; c=relaxed/simple;
	bh=yXnUcv5qVGtYzgWj9FiGbfPJUzxRYD9YlLEosr6E6dM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJ0L1ourN7WSjfzar9/ruMZL5T8gBMZ2WqInwi0Dj5C3fYqd0R3fpwqSYmgn48REnq/wNo25PXYvKUnqfQm6OweXlGDBVI0FzkHv0c4RkZe1X8V3S8VFTteCJD3JQUxAN1gPuvrILl2TUQ19sUYQK1QSzUbEO32HaH+QOAzoKfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TEkA2AXz; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEkA2AXz"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38e58034d05so2529837a91.2
        for <linux-pm@vger.kernel.org>; Sun, 06 Sep 2026 23:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788763678; x=1789368478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HpKYH0amj/dwSRkLCI992Ocp0fThRc8J4K3VwmqlP48=;
        b=TEkA2AXzP1ykjfqACx/jwed0U0LNdDZW6cGOrZ5RQo//9jTV+EFTNwnnmVzXjhb2op
         6BPX5Ow09lMovUQMg3a5IJ+aIFH0adXTPVdP0+KC5v45Q5TFr0f11AG/7dNn7t5RbItV
         c/FOxNxh3mUnUZ2+Z5UAmFDnsEqqDhQAaznTL5N3yyR4KmX3CkHPYapRil6wIcYCS1+B
         6X0ch2njIoFDNS7TwVF+yChN9zUPBvQ3zn8HogDmLXr+Jpyh2s+XiGYvjuK/a5zqhILT
         J+innFog8GVkrLiD5DdP+1vhX0F+laIpVd0uaIFiMElXfHI3JY7CLHyK4iKOUZITTDw1
         P+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788763678; x=1789368478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HpKYH0amj/dwSRkLCI992Ocp0fThRc8J4K3VwmqlP48=;
        b=KE8EnxHBh4M68nmGtyhIyRmvgst3omE2C4accTYLGoSBPAEusKATw6Aj2zFjcSUVzZ
         mf6tXQEwW00cvsMIyplbzQzlmUImWzw7NWhFXMa0K4VfPHMtQ6MiH8al/uNYQ+Qrit9E
         52zJXo5hgiFSqkG6flr2BomrV7dQON7p96kVLlTqydFVnZFoUVv7buMZvoRy9pNAaPMA
         teqUPPdciLvTNyFTchTVw250a1Er0Q8hd9YSnx16Zf/zA2zhzpI91bs2JrdcQzvQJaWu
         2GkEO8C/+gPmur7FnQgng1+8c0NqoVY32f+OZFqUkN7bPNvNowQZUc3RPZEeN+g0ZDU8
         oSHw==
X-Gm-Message-State: AFuF++k81d4ZBt1MD2FS0kBx87V+Z9tP98qT2EB+hzB2aa1AHiDG8EJu
	XRQkHOxFt3q8I7h0Xc3htsmmHo8mUjQjz18TxGo/j8d3AWi1knSr96oj
X-Gm-Gg: AYBFou3fhKvk5rJGazKEjalJoC8O9kdp3PxXJawTuNRlmvtkjE/F5NXSjzkIevoWvkc
	aYgyUZeShD7k9dgNpWIWgOjBrwKs8/eH457Cs7a8JQCNfooB5zQyCqArVb7NyUM2meUtYdUxUI0
	pmaR542hN2AO2qQNSG//wy7GoUoBxkUMkn4ysDuWKBVdDe5lMUyNxi+e8tjAdmfYIv5t48tBwaj
	/pU6oDiaPfguepzRrvuOHSTgD32UCj/JW7eVzzvO3JCRa2ZlCzIDaW4mK1TZpuCLTp1LU2PmRll
	6V1+vvtUcWkYl+LyiNAGuTp6f7a1aHbQX0jw9LLEVU2tB8kcbLwbeMfowI12jZBrz4jnIEt/htz
	GmHowUm+QyiUvVcQLyfRlAqHNQG0szLnfpDU9vBBqenzURlaLmA0ySeXcmM1OfjMb7X226Hkb9N
	c3/RoOogsKTaKI/eL/OOMq04OM7MKW84om/U0E8k9ejoUVnnxWAbhoxa8Gp//ng4s8mGe3tlqFl
	wKgANTciaC0sw==
X-Received: by 2002:a17:90b:35cb:b0:398:a486:81ec with SMTP id 98e67ed59e1d1-39b261ae617mr36625720a91.11.1788763678086;
        Sun, 06 Sep 2026 23:47:58 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-333c9db92b1sm24811158eec.9.2026.09.06.23.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:47:57 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Eduardo Valentin <edubezval@gmail.com>,
	Keerthy <j-keerthy@ti.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pm@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH 4/5] cpuidle: fix repeated word 'that' in comment
Date: Mon,  7 Sep 2026 12:17:24 +0530
Message-ID: <20260907064725.10686-5-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907064725.10686-1-hemanth.selam@gmail.com>
References: <20260907064725.10686-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the second 'that', reported by checkpatch.pl as a possible repeated
word.  Only touches a comment, no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/cpuidle/cpuidle-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
index aca907a62bb5..d2fc216c38fc 100644
--- a/drivers/cpuidle/cpuidle-tegra.c
+++ b/drivers/cpuidle/cpuidle-tegra.c
@@ -281,7 +281,7 @@ static int tegra114_enter_s2idle(struct cpuidle_device *dev,
  * LP2 | C7	(CPU core power gating)
  * LP2 | CC6	(CPU cluster power gating)
  *
- * Note that that the older CPUIDLE driver versions didn't explicitly
+ * Note that the older CPUIDLE driver versions didn't explicitly
  * differentiate the LP2 states because these states either used the same
  * code path or because CC6 wasn't supported.
  */
-- 
2.48.1

