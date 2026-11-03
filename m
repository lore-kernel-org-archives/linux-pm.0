Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744585;
	b=bYJQWjIcaWktd0SQ2wQfxQNb/XqDTbYaZL/khcfPKZnJDwlYSaB5UZQ1o7J7XVA15xNb
	 NUKxAadOEQThaSrUe+JBSKsxpDOEUhfcxNsfE7H4OP5NaAZlfrQF6jnrgjsvqBNzb6n3W
	 rdYljd79urX9yxBZleUxqAt7Q9mcymt4ibFk9ldqqM6CWyXMZX+uNCdgEKgLacL+6ZC1/
	 eYqf6/FLzzjCJXrleeAfmVjqUmo8p9T+eDmAnx5Ty1d0r6JAhbaxDVEZSdKg3P6yzVmY9
	 8YTR/j3Pz0HR1hGO9sWWqn8G9s4j+86zZgw6SPLXmwGAwwVQTeTNGecy1agvzmEGR9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744585;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=THF8Gn9zKSMxI2CX7V8w53BXwvAHKb6Wu9y7FvwOfiw=;
	b=PQLQ95icJCRUa2rkotFoAp7SnRGTrK7V+Qz70fRJvz/rvC/dmQd7h8ul5MWUa0qS9xIf
	 u3eessUtZz46UoAzYYbPZmd7X91cgwLlwsVctoN2IBzIRhBxJDWDmaGfPTTKblR2p+NwI
	 jN33CnRodrIAtZsHwR3AMFAhEERrR1f5S9E7tRIsztq/gR6OLRHkWcXiea6iDgyaUHy6k
	 EiGOkVaz2qvm6c85V5i7s+Nm5iG+dqG43wjhJnqW/VwcWwPiczFdo1SrcHDfVvzowPECK
	 Z+lVCpdSRNYYoHvJRvRTpwlCRe1eg361lBCkDPR80rvvY8JLrO71hEWJm7aHqUgzmfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="O/b1OBkU";
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4317606A331
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 22:23:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4317606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=O/b1OBkU
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36a1947498bso34417eec.1
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2026 14:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793744584; x=1794349384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=THF8Gn9zKSMxI2CX7V8w53BXwvAHKb6Wu9y7FvwOfiw=;
        b=O/b1OBkUuusx7DQz9ovmSOPSSxAEV/QAEiEDArBnps+M9LDURrfuDVoWYz7K/VTeli
         cE70AvCQX3EJPH5SJGyoosAKCOCG3NL8rTLrFsNGqscz2ut4PvM/DT4gr0LZZ9hmvLmO
         kRVrkkfDGKX90/e7ioXLP8mqy7m70e9GE5+2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793744584; x=1794349384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=THF8Gn9zKSMxI2CX7V8w53BXwvAHKb6Wu9y7FvwOfiw=;
        b=MCrGaO8DLDbCAU2Z2tLfQI5Gz8E32Lc+RN/OBMQh5Hb2fNl+ioJc4CBHLi25XSD60z
         cVVudf5hwTqea49ejL6TyhKY7IRBgRHR+D/Cdc12nnlt/2RQxshnYfc3m2iRJxjlnpQr
         1Wly0ioj+DgjRIDLorMdrEZKQp2G/La7LD2GkSZRaYbfk/SUp/39CpmlFyLADi+/urKh
         dAEHgfYcm7Jy3Ubp6iZF3tEi5gSFIyy9wDC2xyfN1bu3rlF0W+zvbtL7hFHMLOTaHOPA
         Twxeu4J6A5vFHcA20OXv4PeZaf6UFZxYoW9vNu7kkDYyoY7NHBPnY0z2TGPs5wZKMcf/
         teQw==
X-Forwarded-Encrypted: i=1; AKwUvBwRp+u1k31aLWxWdDb0Hhbr9Ib39nJ4JjTLGE/rTLsZYk/o1oweJ7inqW43ArPWD24NOJL4hQiKxg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+VqwramVneb5PzI2dHwlZ38VzPm1doVcADw4eDb1CWPjX968W9
	m1jOy2Oe6UqkP8UIY086oMhrNGGJBXAJzbn1oFlg4Mz2i3Xfidkk3WncvL7iHjVyB/ElFp+c1kv
	C2Ms=
X-Gm-Gg: AYBFou0/+j5BOUujY6icMBvH7zpYQKozI4tDvzUAthri61Yzg0SW1T1YEpbXIm5yjdz
	Yw45mIjq616seJW38KhtfkxHRiPKoBZkO6+cCzbCZslYGQYl1R7MVk9NJMFO0mHHI/6AXsXg0IJ
	aNk2H7Y4sI0sP5Ly9CLTo2Hnooe2BLzJ4iSumrpQx5js7XvN8EWZVQw7AqpLA99fGW9KNejazN0
	TJqVonSvGIHx2iotX51izs0f1CTwJrGDQ9WqWVilcW4hv4LHGec6oQVAf02Z9Jczsus6/jKGdUj
	EaYXfOn7d3mg8Tq8C1OKYIwuv6o2EhfXf5ILnux0G3EDIjtJR5uytSWdMxaxPgdmS2qyZy+Ipwr
	IlTq52/xloOpFxsiAFDejZCsmu4qGnZDVAemr0qShx9ZPwZ4keZNbeNv/9dmPUEGreTYq81QDG0
	2ekHcP4yaH3VwKCy6N/hu573hABu92cEcac0N6R0fMvFkjrKDjmeLM9FcGfXH8UCUyZjZOKdrPT
	maJWcTUAoBdHoBR3f81ZFj7McBMx6Ua6WPLdRUDxyJ8vVE68b22NaRs8J7Lh28BTIymxUmJSrP4
	bhMCIeNGhDhaNbJNyVMLUZ6hSOjXGZHgcz1YqxCy/vTKdIHRJ87dMSdj0VVP5JL5M3yUlvr+aE9
	td21sJUU+6rlNUw==
X-Received: by 2002:a05:693c:69c9:b0:36a:13df:749d with SMTP id 5a478bee46e88-36a423b3dffmr18134134eec.24.1793744583878;
        Tue, 03 Nov 2026 14:23:03 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:ab71:b3df:693a:fbf2])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-36ca38a67edsm988222eec.8.2026.11.03.14.23.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 14:23:02 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Fabrice Gasnier <fabrice.gasnier@st.com>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Ulf Hansson <ulfh@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 1/5] PM: runtime: Only queue an idle check for RPM-linked suppliers (part 2)
Date: Tue,  3 Nov 2026 14:14:39 -0800
Message-ID: <20261103141442.v2.1.If69ddc515c2e9fd4338441e87688b9d690d2ef36@changeid>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
In-Reply-To: <20261103221717.3840215-1-briannorris@chromium.org>
References: <20261103221717.3840215-1-briannorris@chromium.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit be5755f023e7 ("PM: runtime: Only queue an idle check for
RPM-linked suppliers") was incomplete. There are two other cases where
we perform idle checks on non-DL_FLAG_PM_RUNTIME suppliers -- in
pm_runtime_set_suspended(), and in cases where we failed to resume
suppliers.

Fixes: 5244f5e2d801 ("PM: runtime: Defer suspending suppliers")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
Noticed while touching this function in subsequent work.

(no changes since v1)

 drivers/base/power/runtime.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 304a2b123420..9d3508d9b4a2 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -343,6 +343,9 @@ static void __rpm_put_suppliers(struct device *dev, bool try_to_suspend)
 
 	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
 				device_links_read_lock_held()) {
+		if (!device_link_test(link, DL_FLAG_PM_RUNTIME))
+			continue;
+
 		pm_runtime_release_supplier(link);
 		if (try_to_suspend)
 			pm_request_idle(link->supplier);
-- 
2.56.0.398.g882cbad275-goog

