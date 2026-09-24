Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4BB489894
	for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 20:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790281816; cv=none; b=lZzxd1xPZrLfblv8swqgzIJyyfWkT30pcExvj33hv5FrbhyjnrVoSa6Pz+9dUxu/cgX8Cyt0rEMVJIUUQDBEgYPycDeP4S//KyJY8PiD9ZDtgpjvTzNmn7h/vfOsKnRGZ55pW0J9BXxhRKIWA/f5on8OxgyTymqsJfKqRpos6sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790281816; c=relaxed/simple;
	bh=ucvY9WncuyAbBf3haKVVnY0b5VmRR1oST4g06/aG2WY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JnezELGxTKQcayVCRcqvuXnVnirceHafFmBqd/OwccrIiUg3GC0c4c9d7KigTudEq+P3TC0J9cSR4hgOJCXOYTNyu/L5FUNG4ArrQ0l3RR52pTzOIK7CQyGOW3y6rJ7K7adVgqb58usDxzEoW7Uh6RStVQNe7mVF5tzXTj9yE6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=PbLpY/zy; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="PbLpY/zy"
Received: by mail-pj2-f41.google.com with SMTP id d9443c01a7336-2df90e859e8so607675ad.0
        for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 13:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790281808; x=1790886608; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2vqiD8N2i+Q4UpMQGEo6dP4Z1IIVc9oYO8E3mXJLoiQ=;
        b=PbLpY/zy4UEcQegVfvO/r38wwHPubVgE125ZWF5oxVnn1sfyW0PaUWkxZby7z33i7F
         R6iWvCpwge3JMjm3ZOZ5VmARMEIwtGyas6kSBDC8G9J8Y37ubz5ISubEAbeXoXKxfJRJ
         7yPGJI5ga0yLV3iIMpOKVbTHOXs8mMCs9NivqwnMX1AoZXj85cwDbJEiYbsOi6BbGNW/
         c4CZuaT6vp6+R08Sni4CdkcCkMys5xVO1CNZyvxT3GXQT9/HrdsqLdCnXHIq+2sv7Lty
         zTJqSqsX24gyE8B+6qbqZspaTh/0+ylR2tBoDLHMwE6zAYRAJB53xWJn3e/ZmtGjHlHc
         915g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790281808; x=1790886608;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2vqiD8N2i+Q4UpMQGEo6dP4Z1IIVc9oYO8E3mXJLoiQ=;
        b=uR9G5F9apDYsEhkU+QwxCbLfa1PpGg8xIdif8n2Jr/9amMvchSR4WlulnvolsxXHeh
         imzvEglKho/dOW9ZIY+LqhTqnXXeEhGgJ/Q5Sh36+iSujLXgSf2a9PQmAdukArkZWybZ
         snrWHd7JqHIc3WQ5gzPcpokjBkNlI1ZYSkYGhmsw7koOhH07zr9wkDIT5L3coXvDtTTs
         lfgjmta3pWbRY5kc21khQtjhe1he4Sdm5TgbA5nDZiy+MaN/a2/PA9MUPCKHavE5sO+I
         rd2vF9tVFiHBaNLy6wMJTOywUodRpeLCPQ8qyKdUFGaeg6BxuaPzOR3H1L8ZIgHoI3Tw
         0yNQ==
X-Forwarded-Encrypted: i=1; AKwUvBwXJ/jc5JFOxCetAtMhSVtDqId3hp65WuKkbNZtSV0q4ittcChC6t2WmoEbX6RPxfjDmZB6wg8E1Q==@vger.kernel.org
X-Gm-Message-State: AFuF++nq5L6cXGR0TSRDffgBiU33l2FJ6Vp9UsIAtneucupNrDVlCib/
	6ipydNMh6ajNT9b3Jp0Ru7Xi7FrIFmJSbZpjBwM5okMA/+KmOF8k+sktLVst3n2Q5yU=
X-Gm-Gg: AYBFou1PJgX+YQtryNZsmwvP5DqAuWF22HsbEde3Lk3YQflIPTDCeRb/qQzApBsaGhD
	74WhI0u6mXR2oQelhK9cufFFznIOIuqMZJyge4euOLJlZJNoPJG/Hn2XaRrBSk3oMMPzkI97zju
	2vFk7azA4kiWMZHOWYl3uz8uHU+9fKGJ+xCvnDT8ffa1abPL0EWTvnVaXhYDY56yplB1LFs9V8y
	l++yHo257Ywutx3W4Hg23lwynmEgjW3W9jrYLtEBB7x43ZeM6NJWbNRX+Zvec3L0vCgIX+d7sSD
	fv6kXybyiDF7pxUeXmYLcllDsZRzek/DERItnCtaqeWz5lH38D/ifJY7MPd8eE+NjSGhkAqT4U2
	Z8KlA8Rvs88GwDyxLmeVbsOYUz7RbTLIYwO7Tcsi3/OeTpEZrNRG+pbnGcOMQP1bcEO2C6Gj24x
	ZEQXDDVMmNU+PDQ9gNL6JJ++4Suy8+bNHPc/WkT0ipuoC1z8lYRN9aBNudzxBihQlrfUHcyzbz2
	I9rPA==
X-Received: by 2002:a17:903:2345:b0:2dd:c100:2521 with SMTP id d9443c01a7336-2df7e3b3ff9mr24242245ad.42.1790281808085;
        Thu, 24 Sep 2026 13:30:08 -0700 (PDT)
Received: from localhost ([71.212.197.238])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2df913ff226sm1210925ad.34.2026.09.24.13.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 13:30:07 -0700 (PDT)
From: "Kevin Hilman (TI)" <khilman@baylibre.com>
Subject: [PATCH v6 0/4] PM: QoS/pmdomains: support resume latencies for
 system-wide PM
Date: Thu, 24 Sep 2026 13:29:55 -0700
Message-Id: <20260924-topic-lpm-pmdomain-device-constraints-v6-0-a69a4856252b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEOItWoC/5XOy27DIBAF0F+xWJeINySr/kfVBeChQYofBWo1i
 vzvxc7CVeWFu7yjmXPngTKkCBldmgdKMMUch74G9dIgf7X9B+DY1owYYYpQRnAZxujxbezw2LV
 DZ2OP23rnAfuhzyXVQckYJGjjQRhJGKrWmCDE77Xn7f2ZE3x+1bryHCJn80J0XSyXZtInhpa9a
 8xlSPf1vYmui//8ZKKYYEpM8MIHGzy8Onu/RZfgVNvWkoltMCPyKMwqrGjQDnTLpfU7MN9gRel
 RmFdYy1adBTeSGrcDiw029HwUFgvswZGzDFJosQPLXzBTR2FZYWa8C4IHDdz8ged5/gGuG4Tja
 QIAAA==
X-Change-ID: 20260120-topic-lpm-pmdomain-device-constraints-e5e78ce48502
To: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
 Ulf Hansson <ulfh@kernel.org>
Cc: linux-kernel@vger.kernel.org, Kendall Willis <k-willis@ti.com>, 
 Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3073; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=ucvY9WncuyAbBf3haKVVnY0b5VmRR1oST4g06/aG2WY=;
 b=owEBbQKS/ZANAwAIAVk3GJrT+8ZlAcsmYgBqtYhO0b9l6jUxF2qS1L74DDRERS/SGdTfOnkJ+
 lYeK1q2WoaJAjMEAAEIAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCarWITgAKCRBZNxia0/vG
 ZWKlD/sG9D5ZUy3FR9XKUJIyhELNNFbuHHYQLae3ETjnktjYdvRrEV/VbgWz8Bb8X47hWuA+8tN
 geDlIfidptkCjDNB57Q/dPCQnvuk5dEEA7trPfd/dVZVwcGLdtzlTVqIMu90jkw8JGMe6STYO+d
 IlKzFKg91nuRGtyIJQ3vQF+JgEPcSW3JaQZVRtnlxvzmCXf/pwylBoIhcMnDMJLaRkREzdfiNOv
 ZG5MMVbyZV6PhsrVyKLN6lNUvNVsHTgT7mihVrUyM0udKarFx866F2EQTZQWx6q+hA6DeiGEBUy
 Eo+Oe1B5lBvw4b2UYsSnkEo7/ZXX75DKRf1Uf7WvxTOn34LqeuDCmu0u4W67oAyaBvqP8yh3V7H
 zG3xOAHL8l6hpUCRz+X7Xy2NF1MttGv9xJS8APgVrNcORySBgaOxCoqrNiGFCCkvNwUMikRxi2C
 CduFETr4/XKkg2I7nw6hdMXIWY6DHIpZq+H1XR7CjqxAAoNdI0423NtLdLDjSWqvDcUaIC7ppIf
 z2Z8aHWk9qqv4wUxXz04cUgEVRlZgazSqzHo0hYxKhT7DC21SOe0dCHf8xF8hXOOAFvbWKqDKg9
 sVJFMyqJ4Qln0EomUGIP6d8GICC3zaf3wONLk74UnsOHxDdohFCcopOUszi6rL8U+tQLvcWbapc
 p/c9fi8gc2adVZA==
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
Changes in v6:
- use forward declarations instead of include pm_domain.h
- remove over-detailed locking/lockless comments
- fix 64-bit math overflow on 32-bit systems
- drop extra dev_dbg()
- added Rafael's ack on patch 2
- Link to v5: https://patch.msgid.link/20260826-topic-lpm-pmdomain-device-constraints-v5-0-28cbf43f7e38@baylibre.com

Changes in v5:
- update copyright year & author in new header
- add Reviewed-by tags from Kendall & Abel
- Link to v4: https://patch.msgid.link/20260819-topic-lpm-pmdomain-device-constraints-v4-0-7ceb095f5474@baylibre.com

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
 drivers/pmdomain/core.h     | 18 ++++++++++++++++++
 drivers/pmdomain/governor.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_qos.h      |  9 +++++++++
 kernel/power/qos.c          |  4 ++--
 5 files changed, 119 insertions(+), 2 deletions(-)
---
base-commit: 237a1c39e8dfd3e1c6f1f023eea37a48ec04cc63
change-id: 20260120-topic-lpm-pmdomain-device-constraints-e5e78ce48502

Best regards,
--  
Kevin Hilman (TI) <khilman@baylibre.com>

