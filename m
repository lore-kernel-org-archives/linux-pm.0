Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F783BE652
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 17:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787159333; cv=none; b=RHidZOKfX9ARMBXFUXUDeg9wSLNGajbP/LmawTlPjFq+WRY3t7rDlmPEcdx6zorRSXbcYj2bpzh+7x+GsIL3Jizn99LpHMoJwKUWemS9oSUpM5/ekoDqkN2evvoFeRBEUAEXye6HmlgPDoHTtDTkv8eL6QZiMG9yBLXeHQ6wXw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787159333; c=relaxed/simple;
	bh=Tf5wc7bu3a3TFETKLQNvn2N82/G6xfLEOxnV625fL3w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iDw7UC8JVJLGN68XEr8mJGjAYX/EZYPmB8ud8cKANdSqQvd7VWV82rxFTxFBJ8koAwH2YJQ5xp9+ksS5nuAnLZRjfosm0vPHK9Woh7SiYsR1sJtdbTRf3BJjUEPrwOV5N4uaoiFdOSsf8hHzNDahcBpolIFAykZYBkyy6sCm1xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=dWMY/oyO; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="dWMY/oyO"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84862b0d5f8so1064849b3a.3
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 10:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1787159330; x=1787764130; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mslSTT4HR6M/LY8MZKEoPtjWWSb5EtDljl3c3rxu7Ww=;
        b=dWMY/oyOxEjy7a0slqdW4/Fr185g7hEx2u9K8pb1uYuUlzx8nr7sadiCRdFxjzxMfw
         OgM5LDegWToQRTIg7s/imKXsduqOlODndBE23DaOjhCBceDyTKdkyu+R+zWMHsRmL0hE
         vhCe44KFi2oZ9KMSgv4xSdH3hnLkCSeLA6lphoo5482Gs8AepNhhM50TqLSk9NI03V9L
         +50U1ubLkBC8bwQMQ4zFm+95J0SAtNkeaDcp2XIjp0xQDtIeoObQr+CNa2Oju24KLfOz
         WE2Luvy52uQoKMRKeI7Rb5tqDm6FKc45PH1othyDkhEG9XgHANzIQXwDv+AyHlNpXdyO
         /Wsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787159330; x=1787764130;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mslSTT4HR6M/LY8MZKEoPtjWWSb5EtDljl3c3rxu7Ww=;
        b=dfMBmpQdNuO+rKGP6tnm3KvbOkVXVfiYJ8zbN5RyD5/QBYQhvACyOSxARYp6YmvsW2
         WvxmyL515GHfBWEmsof9RUqSjptvhRaMKzmlquW8Ik6IodqetVBYt8GPvLa0vsFGvZfJ
         rLpW8SghvJ0jyQU96whjL8dK2n8LTLFzLcaDCuFdbtg81dL05UKXBYaL1ATbF4pgHbII
         oqvj0O5bWfk81cZQUk2beYSfIIS2IQOsKI7R1DdtsHIvXtq0G+amegaTnnVZjfXU2eM2
         eFBbE6KD8Me/P4bwoHFhyeXzBV/1dIu6hlTFvTU6XF2Qi00U20wC556d+Pm7xhcIM74D
         m34A==
X-Forwarded-Encrypted: i=1; AHgh+RqaXFsMuuMNIwv2oy5+BfYd03r0xy68/bKfgIXyMylxMIgBK0+LtFenaryHXwmqffvXmvm1WWfhvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8MyMu7jGi/LhXwnVSrOY7qvADNbQmbImAzUdUl07Hd1GWD0ld
	jBUGIHjs1NOuqS1BdDN45f3TXl09XNggj3WjmkiUElD+92rO89f5KVcGaH7GnVX0/bWrOk7WJB0
	WjCgOtpo=
X-Gm-Gg: AR+sD115myMPKIYcMZbuLSinlp1wSMlXfP8yDoj0cn6QPAg2vo+ndTCxDvbQWZvg3rM
	y3H2SB+hhPJuHgbHRlNBlfw8d7xDyNuXWTJDkNrh8RPn38uQsP5s7i0Cidl19g3pFVD8JqQ2Wkv
	Y984GBBgiiPimnJCvTqWBiM/5E/jfgDE00IZue/KMiOzTI/NoX72PgTASIiaNO+qXNpTsCKi52m
	7GFuD7XensMQQfFOciDlkRMYZfljlP6EsY91WeGE+DjnpYw1v5vGeuP2vQh0ITMIlfpMX7PqsIa
	lUcrmn8Vn85TkoSONGkXn6Zabi5mceKkzwcEvJZ/TRGgZx9ya6WRUa5vwGVTxZ6EuJqjxL7/Eo9
	6jgzUo5jWt2u4pRe7qu2b65CK/FbRF36pOkmn+xw9jIA2R03ymIiwtrGPv+/WSdYkQga0giN/2W
	L5B/tDSn2GEmLF4rsD3eibnqGhkqApoasd+TuDCa2/Ns7uM3NS/msyvd3UVw==
X-Received: by 2002:a05:6a00:190e:b0:848:30c3:45dd with SMTP id d2e1a72fcca58-851d38eecc5mr8723562b3a.11.1787159330113;
        Wed, 19 Aug 2026 10:08:50 -0700 (PDT)
Received: from localhost ([71.212.202.210])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-851d3362cf8sm941272b3a.4.2026.08.19.10.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 10:08:49 -0700 (PDT)
From: "Kevin Hilman (TI)" <khilman@baylibre.com>
Subject: [PATCH v4 0/4] PM: QoS/pmdomains: support resume latencies for
 system-wide PM
Date: Wed, 19 Aug 2026 10:08:35 -0700
Message-Id: <20260819-topic-lpm-pmdomain-device-constraints-v4-0-7ceb095f5474@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABPjhWoC/5XOTW7DIBAF4KtYrEsE2BiaVe9RZcHP0IwUGwcIa
 hT57iXOIlLVRbp8o5nvzY1kSAiZ7LsbSVAxY5xbGN464o5m/gKKvmUimBgZF4yWuKCjp2Wiy+T
 jZHCmvt05oC7OuaQ2KJmCBKUdDFoyQZq1JAj4vfV8Hh45wfnS6spjSKzJd2KasOy7qnaC3PeOm
 EtM1+29yrfFf35SOWWUMx3c4IIJDj6suZ7QJti1tq2kiicsmHwVFg0eeVAWlO+lcX/A/RMeOX8
 V7huspB/fh15Lru0veF3XH5Cijei3AQAA
X-Change-ID: 20260120-topic-lpm-pmdomain-device-constraints-e5e78ce48502
To: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
 Ulf Hansson <ulfh@kernel.org>
Cc: linux-kernel@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2507; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=Tf5wc7bu3a3TFETKLQNvn2N82/G6xfLEOxnV625fL3w=;
 b=owEBbQKS/ZANAwAIAVk3GJrT+8ZlAcsmYgBqheMgxpyeMoXOurPYKKet9ku4mWzlISVIg3+V2
 3yIF+jK5aGJAjMEAAEIAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCaoXjIAAKCRBZNxia0/vG
 ZUfrD/wNw16gVuaGsrPjkk9lyjfCmDNYttx4l401oKQfNGMkitabHiAbWQEsYSQ27lFWaU3tT/E
 JjwaNZvWwyLFTXgvjtuEIKRAN6dPf0w8LoqbH6cnlVLMyhXZsf2m8i9gluRiBfcBvlpXRX1ro0V
 ZL7OKmJzY+9p1JP6pVjiIWPCerd9JQefWbalWt3Tz9WSBIZUAzpR5P5XiV3bpTpyZcVa1cr1r3i
 EEO7mGwIMfOtC0YAl26GXsVwfuS+2HVAXnYRwLVKqDZRePWgaj6G3q3/AN8nUBAhBsxGnfIGo+w
 KcF7gKLrQ3dtKazfIx2VV7PzHpOuwXWyzazn8pX8GKC6W/pd2ZMJlAtUBOzga1f/2z9K26XIUWk
 Ged6Pc1kN5fVWkZ4G/m0Mjmj5cu/cH0CaI4p3Kx0wj0VuBdVgwD+j5F3VQ8ZyDMaqfxF5NzDjqQ
 swUKt8apoiJPoFrtGff20Iw+a5zUtSSSFr1LB+91fRZumcHK+JVvfBOPDizQSxlEyWjiiz5dYje
 BLrmOnUiAFdUhEc/idxfx0P5vvIJ6paZXY7rz/MMwEjnbPrylkMOHVf05ke67zFVVyDQiiRdQTu
 4iQnJ64ADdAaX9VJr2Xn53F3beu7vfDTRjmwuNwhF1cdD+Nt92Iz6r058loonA/eQQsWSIq9aaE
 VNfqWtUFMsA7LBg==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665

Currently QoS resume latencies are only considered for runtime PM
transitions of pmdomains, which remains the default.

In order to also support QoS resume latencies during system-wide PM,
add a new flag to indicate a resume latency should be used for
system-wide PM *in addition to* runtime PM.

If a user requires a different latency value for system-wide PM
compared to runtime PM, then the runtime PM value can be set for
normal operations, and the system-wide value (and flag) can be set by
during suspend (for example in a drivers ->prepare() hook) and the
runtime PM value can be restored after resume (for example, in a
driver's ->complete() hook.)

To: Rafael J. Wysocki <rafael@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
To: linux-pm@vger.kernel.org

Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
---
Changes in v4:
- added corresponding WRITE_ONCE() to match READ_ONCE()
- rebase to v7.2
- Link to v3: https://patch.msgid.link/20260611-topic-lpm-pmdomain-device-constraints-v3-0-75d69438518b@baylibre.com

Changes in v3:
- rebased to v7.0
- fix PREEMPT_RT: add new helper for lockless read of flags for atomic contexts 
- update kerneldoc for genpd_for_each_child() as requested by Ulf
- Link to v2: https://patch.msgid.link/20260205-topic-lpm-pmdomain-device-constraints-v2-0-61f7be7d35ac@baylibre.com

Changes in v2:
- drop the userspace interface
- add genpd helper to iterate over all devices in domain and child domains
- new flag means latency applies to runtime PM *and* system-wide PM
- Link to v1: https://patch.msgid.link/20260120-topic-lpm-pmdomain-device-constraints-v1-0-108fc4cfafce@baylibre.com

---
Kevin Hilman (TI) (4):
      PM / QoS: add flag to indicate latency applies system-wide
      PM / QoS: add lockless read for flags
      pmdomain: core: add genpd_for_each_child() helper
      pmdomain: add support system-wide resume latency constraints

 drivers/pmdomain/core.c     | 45 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/pmdomain/core.h     | 17 +++++++++++++++++
 drivers/pmdomain/governor.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_qos.h      |  9 +++++++++
 kernel/power/qos.c          |  4 ++--
 5 files changed, 129 insertions(+), 2 deletions(-)
---
base-commit: 237a1c39e8dfd3e1c6f1f023eea37a48ec04cc63
change-id: 20260120-topic-lpm-pmdomain-device-constraints-e5e78ce48502

Best regards,
--  
Kevin Hilman (TI) <khilman@baylibre.com>

