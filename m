Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DFA3D904C
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 08:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784105673; cv=none; b=qp6YFDeYrb8myBVW45NysN3KRbuy4laDBxag09gggFbhxd9VQ1Hcwn9j2+exsz8wFoLYI0u7Pp8cidqVoj8fQUEzYeAqlmWi5CHXPyjs/cySRjllrVC+60nhwYzikBmcuGTdVxhGZuVvYHD2x/OF+wKXJAbSe8eKLLLEbMjo/Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784105673; c=relaxed/simple;
	bh=rdGoAErDNJBoyYumylqg66ArDzAHOM3wX5UO22Ntd3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mvUyMsF/+t/v/m3yzVWsWn04g/ofVTEsbcPnjEcwjtN0+1DsIDqbmUQe+WxoJgMmZXovQQIZhc7fmZu/FuuDrjNbMUzW7xzJdBXujT25GwBFGoImQfasjPOh0/kO6ASvKn/o/wRq6BJCeA8fAzzUDykeAD30kh0itYuz5B+QpWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ijHjYnM/; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ijHjYnM/"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-848595b338cso6084901b3a.0
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 01:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784105671; x=1784710471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tiAJexuP13y6uWXyvfEXpTcy6egDm283JzaUjb9zN+o=;
        b=ijHjYnM/3tgn+KlB+XxWanrduV9o18Y3avJUFrunGxFuIrrYkuL+D12bpNP/I7jtPY
         qMpapp6Z9xkr0JBfggFmD+XgiixuwdlgM0SMgqxpKpkvVwkGXfpgfim+SJsMYS7md3QT
         y3nIvdooeKsthPUoeQI4b7aPmyGfWsCZejwb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784105671; x=1784710471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tiAJexuP13y6uWXyvfEXpTcy6egDm283JzaUjb9zN+o=;
        b=nR/pPzsEyBpMYIFCyL2eaR8rn+u5qjJ4KmQzT+F7x9aZpXGdSCNNIA3f7h9EzuJDqE
         UFag0TvwWejJJc6fNk9jCTfttOO5H7IIX88cbl5sWqnJFnJ33Af5bGyKrcPx0XAAwlpz
         1q3WQVTVAgzWZp/ypwe7ruf8xujyLviNLX8rLxaavupckfdxa/p1Tvvn8RY4+cbclRaA
         oHYLhPK+IMgQahLF2lCBNH015Pzv6lj8bmKa5JbwCBmAvf/RlLw1ysSZ6oci+DZ5JTeX
         cweqkfePSgTDCIx2vr9g4DbsluMGyH3qZIRW7TUTYbHMzAQaGHQPyo/yGx2bWUH5oGte
         hSyQ==
X-Forwarded-Encrypted: i=1; AHgh+RoEGs3N5h0XAmAFUsVuPBZO4WW9yEgSR3GeikDYa3vKs4XlAy+WyKt/hK/RFlX0ohxN2jVYCGe8hg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxpOQuG9yuRPQkAHda8pnNLHEaHVDATPE7wV3CEt1BsNAdd8FUM
	SdgeBym7a6An6Pn1pqNhsEWn4YqOS9Cd9JEcza5friUX6vct0evQsn/DBVwP2XYnEg==
X-Gm-Gg: AfdE7clilUceYup1dx2PQiSofYfiOhuO2o9TzsF3XxxKiYFhw1I/Ul6xp8lbwmwJ+O5
	TMV6n74rRbeUmmRVQTqky3d/c+Di4A5zHTjTmFa9ZfimzV/QhkG2MWW/R7EgTkGZYXFAIS+Atwq
	wXfI58ED2IRH+Nh58Wq6GlodPhf95iE4GgpGSq+KEiKUtnAuNg+Ru7AtyQ2960OzBa/xC37TSQf
	yPSc774wx0VwFl8eKb70FEOR8I1RPiiZvWFKg2G+/GJa+lBmQlFHzhVoyzCPA9JuzZI03QOM7Td
	W+QvMzKdnzXnOxWqvw0Jw/0Y4qhHkxFksvJjPGrfQc0a5Na0aGyM7r5Hcy5jtaqPYce6Z4pmvpb
	5cIwoHjepJhUEtmuMcu2BGhHXrgHIUm2zivFpRZ3TtJuJtsZZzhqo+uilUQ97majjuAcqb820tS
	qcnn0pgJn1u7yRCBIRUcMNQ+mRW0dOFZtSAKBqlcuT/IyWOZAjUzVzxJUnn5OAEKlNgxPphg==
X-Received: by 2002:a05:6a00:2d19:b0:848:44ae:47c1 with SMTP id d2e1a72fcca58-84a559964ccmr5439963b3a.78.1784105671342;
        Wed, 15 Jul 2026 01:54:31 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:47d7:4aa5:a6f8:2279])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f819117sm2757491b3a.59.2026.07.15.01.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 01:54:31 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Wei Deng <wei.deng@oss.qualcomm.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v5 03/16] power: sequencing: Add pwrseq_power_is_on()
Date: Wed, 15 Jul 2026 16:53:33 +0800
Message-ID: <20260715085348.3457359-4-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
In-Reply-To: <20260715085348.3457359-1-wenst@chromium.org>
References: <20260715085348.3457359-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The power sequencing consumer API already does power on state tracking
internally. Expose the state to consumers through pwrseq_power_is_on()
so that they don't have to reimplement it locally.

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v4:
- Make pwrseq_power_is_on() return 1 if descriptor is NULL, i.e. if
  the descriptor is optional, matching the other pwrseq consumer APIs

Changes since v3:
- Added missing stub function for !POWER_SEQUENCING

Changes since v2:
- New patch

Needs to go in with "usb: hub: Power on connected M.2 E-key connectors"
as it is a build time dependency. Bartosz wants the change on an
immutable branch to pull into the pwrseq tree.
---
 drivers/power/sequencing/core.c | 19 +++++++++++++++++++
 include/linux/pwrseq/consumer.h |  6 ++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing/core.c
index 02f42da91598..db8c91be10c9 100644
--- a/drivers/power/sequencing/core.c
+++ b/drivers/power/sequencing/core.c
@@ -968,6 +968,25 @@ int pwrseq_power_off(struct pwrseq_desc *desc)
 }
 EXPORT_SYMBOL_GPL(pwrseq_power_off);
 
+/**
+ * pwrseq_power_is_on() - Queries the last requested state of the power sequencer.
+ * @desc: Descriptor referencing the power sequencer.
+ *
+ * This returns the last requested state of the power sequencer.
+ *
+ * Returns:
+ * On success, 1 for on or desc is NULL (optional) and 0 for off;
+ * negative error number on failure.
+ */
+int pwrseq_power_is_on(struct pwrseq_desc *desc)
+{
+	if (!desc)
+		return 1;
+
+	return desc->powered_on;
+}
+EXPORT_SYMBOL_GPL(pwrseq_power_is_on);
+
 /**
  * pwrseq_to_device() - Get the pwrseq device pointer from a descriptor.
  * @desc: Descriptor referencing the power sequencer.
diff --git a/include/linux/pwrseq/consumer.h b/include/linux/pwrseq/consumer.h
index 3c907c9e1885..3c6122bd0205 100644
--- a/include/linux/pwrseq/consumer.h
+++ b/include/linux/pwrseq/consumer.h
@@ -22,6 +22,7 @@ devm_pwrseq_get(struct device *dev, const char *target);
 
 int pwrseq_power_on(struct pwrseq_desc *desc);
 int pwrseq_power_off(struct pwrseq_desc *desc);
+int pwrseq_power_is_on(struct pwrseq_desc *desc);
 
 struct device *pwrseq_to_device(struct pwrseq_desc *desc);
 
@@ -53,6 +54,11 @@ static inline int pwrseq_power_off(struct pwrseq_desc *desc)
 	return -ENOSYS;
 }
 
+static inline int pwrseq_power_is_on(struct pwrseq_desc *desc)
+{
+	return -ENOSYS;
+}
+
 static inline struct device *pwrseq_to_device(struct pwrseq_desc *desc)
 {
 	return NULL;
-- 
2.55.0.795.g602f6c329a-goog

