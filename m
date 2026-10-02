Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C6047C0EA
	for <linux-pm@vger.kernel.org>; Fri,  2 Oct 2026 23:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790982444; cv=none; b=c8NXus4DlGnFV8mPnxCum+XDY7puIdtKSDyUvgQTwdG26/yT02KSm2CtznmNjIid4p7nWL0ZaHSBU8cLvyPzKTB/Ejk7kPTW1DReYpRp5X5dGADkTMR8dHJNAw3vZWDUfnfKoYld60mmWLnj5U1X8IdgwDk7WkZF9q5KPQ9rOdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790982444; c=relaxed/simple;
	bh=RGgoyqq4R7KoPnFF8uisNnEGFVRPpl23zQf4XjNBF4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DP1+ybTlZw5Mpc6ZCOYZIBVXoRVfqPdrZdLbedkmfC1RDebINEVYoGu0haWq7VIVWwvAN+PxoncZY35Y5FAwscgtdXdx2ROvUKfKBy/hXFruz7iq1bWEWsBBjfU/9w0WGkTEEIFWlOBhWEjZZ+41ThJDQEJM1eOCFL0f+bhoig4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=arzz32pc; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="arzz32pc"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34bffc8105eso115462eec.0
        for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2026 16:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790982439; x=1791587239; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2WeCGbzmbDMCGHEECOh1TDjR3OoHLvO5PyQaBzCE8Lc=;
        b=arzz32pcwfMXM2R5++aFzaSPf2fSZH9pb2V+jsj+clYGO4eyuevU8LGkIcbMXpxW1H
         vvkIKiaA0/fXNyGb3T+JmAD1A9roMaUUhbVKuSiug1EQfFH071tYhNDdQI5j26AMDrBn
         2TgrDplLUZHJu28zsQtkVE16U+aK6PDCj6nmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790982439; x=1791587239;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2WeCGbzmbDMCGHEECOh1TDjR3OoHLvO5PyQaBzCE8Lc=;
        b=MfIs25iDy67dC5hnxn1pG6g2yvwgJ8IuPlzUie9Ckrxh/n0EJQi42ac+XDuGnN3KNM
         ZHOcaywd4GTsQ9RpyfYtCDz3YyOIPg3CdNe6NMMF88UUjQrPe2+ozmWkuB0ZkB9bRJI0
         Lf76DqHiFqYguu7X0SQvsTY7XYhTjbI99rlhqFPMqAzsAdwA0rO6dGZbimNGYDyyeVeg
         cCXBwZwb7Ch35wtOuB/fUhdjmNAYE5SKA8NY4N2OI2rYc4NSHODtWArz/H+exd0cYCRV
         9ok13LFoCg4srv/WxcgNo85k6w02L5YLeYQYsX0s+fqimMrGjzG80zU2HH9zLlh/Pgql
         CwrA==
X-Gm-Message-State: AFq9FYJZvTGjQp4CdSnI8X9ctgG4GRoy/mIUdrfL/rjDpu0oBqCFPzXb
	7KoD5QyJ8GRDHLiAHiquU+WXy2VJOZZpWc8K5J9nBjfQbGHnB4uLup4hYfIfbpFFNw==
X-Gm-Gg: AYBFou37sdeyG/atsmVGIpgXxPzSdxs6YEINwCl9zvGmXugnX6Q8fdUCsRUaFtjnuhj
	6wSy1zlyjcqrXSn533glM+TuFOdKJhrVaT6QWqYltlQOsAGlHeBtHz4OJKnL7HUU9Bt3KsZesVJ
	KX9Y6fQcxn5Jmxyyt3AW1eHNUjkyYhPDbPCoMpEAIvQ2ww8TUNKBM0lcGluZqrN9Gg4hEpfJZwF
	oZb+hhg5oQNrGmhLFbWheLLZKf+DvRN6ljHnNQSvddsWmGgaHsW7ZmdVKshaJqykebQ1/oBu/3m
	gn9Dfqw9wjSVvYCXLbxH8y3m9xREwln3W4e2jDyNoCS7TtdQ3qxgqQee7WssoTXlnHDaSX9wdmy
	gyfe1PN4U5ag6cQDbQUruO1NB+5VKub0+bIF/WLiYQ8xIE9CSYQ+2DByi/Lhoez3+9v+RqLAr/C
	8HNda+TjYz7b5pndGFSLYJTBmqgOiE2Kq2WUlsG8kX0SY+1bZAvJsF0oCU3oDIrFwOUYjEPdaDB
	cZZmom/SdM/o34aT0AQeJtj1SIYse8o1+gRHA==
X-Received: by 2002:a05:693c:83c3:20b0:33b:f5b7:f494 with SMTP id 5a478bee46e88-34f1509e567mr5123379eec.13.1790982438582;
        Fri, 02 Oct 2026 16:07:18 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:b0dc:e72e:e96b:3323])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-34f14f98527sm8357014eec.16.2026.10.02.16.07.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 16:07:17 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	linux-kernel@vger.kernel.org,
	Fabrice Gasnier <fabrice.gasnier@st.com>,
	linux-arm-kernel@lists.infradead.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 0/5] PM: runtime: Improve autosuspend child to parent propagation
Date: Fri,  2 Oct 2026 16:03:04 -0700
Message-ID: <20261002230714.507921-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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


Brian Norris (5):
  PM: runtime: Only queue an idle check for RPM-linked suppliers (part
    2)
  PM: runtime: Convert last_busy to atomic64_t
  PM: runtime: Propagate last_busy from dependent to dependency
  PM: runtime: Add tests for last_busy propagation
  iio: adc: stm32-adc: Drop runtime_idle()

 drivers/base/power/runtime-test.c | 101 ++++++++++++++++++++++++++++++
 drivers/base/power/runtime.c      |  29 ++++++++-
 drivers/iio/adc/stm32-adc-core.c  |   9 +--
 include/linux/pm.h                |   3 +-
 include/linux/pm_runtime.h        |   2 +-
 5 files changed, 132 insertions(+), 12 deletions(-)

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

