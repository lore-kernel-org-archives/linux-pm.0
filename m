Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744582;
	b=PRBcPM6qbAkPzvO98vaA2BD7T9Lk4wkyIu4nGBPwRRcWdxancCUYJQsfIJXcsxfDVleu
	 d1MuyvBw6JrlYKr1AHK5gEGAX80ia6wcJlnYfzlKcdgw74LxU9diXZCIOAA4Qmq2ajUsO
	 VwdrC+QsJnX1srPpgOMCeu+tP3RVZptg7JR5ghKzQxa/gn1TcU4/qIpYSmlgNmBBL/5mC
	 Aqwv/t2Aq+5Yhxl25B8DXnvUeNam5xZDj232gFQH75LZtrKcBjm7LvIcwdcLRZNrk5cRG
	 jSwAVs3PsoSKK8dZDvEBtvhQqueoFrlt/nJW/u4gqLXLx1C0JsFDAmGhnC9VS1d3Dpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744582;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=vG7YyaR1jfJGT4Zyo7fUKW5YQdRxU04KVZC/8HRXsU0=;
	b=JTqmRR9MUjo+jB2hAOHw0cq6NeroEft4I/MiSB2sDhwasOD2umpiQL9Sf5wlp5eb4W1T
	 NptTgHdgMzHVUy/JmcgVfRCqgsuEUYATg2c7jP2sFyvUbL1njo1oPI+IHlcof4W0/Z+D0
	 q0g9YUmQEirgK5rfgmOUdMeKWhKJ+cg9DMtiw2/WTbHxY5ELiYdczVVeqkrTnCEtlaPYA
	 vuX0HqW/DPO0tODSoJ424Zwh5TRAJo60u3kHPRWPBq4OuLmBL1kCiNyGtKo5+LJqGRfHl
	 XHVWUdfnSB7XmC0bJP7p9ZgfusGppoL3uO5rU5AztkrpUGjtMsD9swzONTbIPfuAtXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=mWQMoB0K;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78989606A324
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 22:23:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78989606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=mWQMoB0K
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1931ff67a29so399010c88.1
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2026 14:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793744581; x=1794349381; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vG7YyaR1jfJGT4Zyo7fUKW5YQdRxU04KVZC/8HRXsU0=;
        b=mWQMoB0K1VT+Qs08/4w1/EZaMZ962n0okVvivkeH/VyHpZt/S7I3EE2F9vs3758tTr
         dnebJ9MLlplJjZatFyvy+fgG8n/uK3SweCHTHuddXhyKsueRyw0sP9Wx6NeuiO7igq1O
         KckL+SOZCVvgBBgekcNt4p7ygVI2gei2ywWc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793744581; x=1794349381;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vG7YyaR1jfJGT4Zyo7fUKW5YQdRxU04KVZC/8HRXsU0=;
        b=JaYrEITIGb2ZI7uJI18tmOWyA/zlnwDBg+CyWWlz0P78YchY8uolW92YB/vWJlhLHL
         WOG1cvLjYebUOYMBFeewuZO2EhrRKTtALKJVIAcFp3H2B9lPN2kLmeq5N1qR/jiXtT2g
         p0a/8HyzofXA/q0KOHFOX9CZgD34sQz4Yu023/9GtVoEzfhelQOhP2Q7XATf32yLT5N9
         Lgc67BkkCg/D9GXIUsf8FoLCUPZDg3fI0zFddNbIy77CBjVvuGST3/yR/48sItCcD730
         zXEcQpbG1/MGdxVmnYwlQkCBv3Q7GuDH8lBifoC9svUed8m2qIKW1b6H/kkVxZOLaOrx
         /c3g==
X-Forwarded-Encrypted: i=1; AKwUvBxS8gC+j2Lz5F09J89/gzmoBad0Y1OIEk6gzhxkAlt1qRZz9hqHwZck/KjqDxp6FLdy3oBKqKGcvQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9LkW9x/cSuDo6qSfRSKZvC5cW9W/TyexIs4eaf2eWyd9ceyWQR
	P+xJBu5R1GpA/pKMQ7geeB66GmZDVoYvh5TIcgIVcC2XzLr4g8YtuB3lRMMi3SMH0g==
X-Gm-Gg: AYBFou0YClxQBIdetSpLzvysi4Hosy+6DjFUDWIcXJYdeJHewPYDaB2q0hSPbwpqfNc
	qfE9azdbMRfWrYreBTPfgJgJEUVd2a8dDkM9ARNWP++MSZZw1BM5sgMfPIigtc70wEmS70l+rJE
	R39qe5azuVFzXw/mIGMya28LrqLmaYf1lHqwKWctO6/Na9qapOq4GBixC9RFfMblwIEzEd2xgtQ
	BeRafuKNVxWYBR7iiSMJYimDa1CuNmA+WLDo74mIBwbUPK+Rs0vL+OXOLO4xGx/0I6lvpUgMOY4
	TSNLOLAx5k4OZ0aVxfefOgraz/a/DSogVyxXR3nc+sTxAXGNxN0YY7lrS1yTZq1Wr7mf0dwpHSZ
	++dJ/gfzvYO2d9E05x4O8rUxyOpG9QqZ+hMo7WjU7yEai5O1FSyG9FKQlIeXfRh+zkXTfXsuXty
	iCUt1yTBF3ECOa01CwKjfvYz0ALn+uDAmzDutr1ba72hF0IEqzf04cp/M9zaRkP7I6tiVkvDiBn
	+TD21va+w2wfNKsLgrRqWGcivsyUrArY0yV33mztynKzE6iaOvroE7tQfwTQ3/XGMsB5R8jS4qA
	CetE5QpEKlyczhxQyfLlNfbYebgHjD/xtii9GMS00YCNAr1uU2zUmosuGbxSdRkmUcJZ
X-Received: by 2002:a05:7022:b0c4:b0:144:eb46:c3f with SMTP id a92af1059eb24-1ac560219bamr19881274c88.2.1793744580537;
        Tue, 03 Nov 2026 14:23:00 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:ab71:b3df:693a:fbf2])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1b245b86fbesm1926506c88.1.2026.11.03.14.22.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 14:22:59 -0800 (PST)
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
Subject: [PATCH v2 0/5] PM: runtime: Improve autosuspend child to parent propagation
Date: Tue,  3 Nov 2026 14:14:38 -0800
Message-ID: <20261103221717.3840215-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

v1:
  https://lore.kernel.org/all/20261002230714.507921-1-briannorris@chromium.org/
  [PATCH 0/5] PM: runtime: Improve autosuspend child to parent propagation

See patch 3 for the primary change here.

In short: today, children can resume/suspend without extending the
autosuspend expiration of their parent. For parents where their activity
is largely driven by their children, this makes it easy to experience
"premature" suspend.

Many .runtime_idle() implementations seem to try to work around this
problem, and one in particular (stm32-adc) documented their problems
heavily in c537d3457542 ("iio: adc: stm32-adc: fix runtime autosuspend
delay when slow polling").

This is an attempt to improve the PM core, as suggested in review for that
change:
https://lore.kernel.org/all/CAPDyKFp=KTf8=zGBSzPYqhjnZpY8xwvjCeM1e-WTKT1QLSxaDA@mail.gmail.com/

This will make it easier to simplify many other drivers too, as a
significant use of .runtime_idle() is to simply extend a parent's
last_busy timestamp, as a proxy for "last activity performed by a
child".

The changes:

1) Preparatory fix, noticed while making the following changes

2) Because the last_busy mathematics get a little more complex, I have
   to change last_busy to use an atomic64_t type

3) Propagate last_busy from dependent devices (children, consumers) to
   their dependencies (parent, suppliers)

4) Add KUnit tests

5) Remove the pm_runtime_mark_last_busy() workaround from the stm32-adc
   driver

To follow on with #5: I believe almost every other .runtime_idle()
implementation in the tree can be removed after patch 3. (There are a
handful of drivers that should just use autosuspend. And perhaps 2 or 3
other drivers that do other non-trivial work with .runtime_idle(). But
most are redundant.) I may work on that next, if this works out.

- Brian

Changes in v2:
 * Update comments to explain when/why rpm_propagate_last_busy()
   performs the update
 * Minor kunit test improvements

Brian Norris (5):
  PM: runtime: Only queue an idle check for RPM-linked suppliers (part
    2)
  PM: runtime: Convert last_busy to atomic64_t
  PM: runtime: Propagate last_busy from dependent to dependency
  PM: runtime: Add tests for last_busy propagation
  iio: adc: stm32-adc: Drop runtime_idle()

 drivers/base/power/runtime-test.c | 99 +++++++++++++++++++++++++++++++
 drivers/base/power/runtime.c      | 30 +++++++++-
 drivers/iio/adc/stm32-adc-core.c  |  9 +--
 include/linux/pm.h                |  3 +-
 include/linux/pm_runtime.h        |  3 +-
 5 files changed, 132 insertions(+), 12 deletions(-)

-- 
2.56.0.398.g882cbad275-goog

