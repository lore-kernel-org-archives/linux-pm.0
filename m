Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.250.60.165
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793302486;
	b=VhbFgev6QRnxYVA0kayqA3k2Oz0GdMqoZJW66vvb1AVaRKkQoiOf/QZl6uUdgu1CtbCE
	 NC6ODDuZx5T5ckY8bnD6WLRZ7V8p3QMZFB4DcD+PnVMMR29Wd/9SqY0n3iPxQ3s1lI5Xs
	 jv9Scz++yEpXXIdI195bXc+NCIDyfK8nGmQKhrZ4nkVLA/QTFUyvQzQAwVpFqHVYMj/YZ
	 4V2JYilir5/qyvfuot+3uNqgAEptz9wswVCNXzNH+ZgL3DKRtZ8eNhRT7z1jOqEnWmYQ2
	 7KfrU6Tm645WD//YoeFAPZcvRjfm2GRg4RiB1TbBJTGgYK9wKb2XfnwUhcpwcQTbYmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793302486;
	h=DMARC-Filter:Received:Received:X-Yandex-Fwd:DKIM-Signature:From:To:
	 Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=S44wys8E71CePiKvfI/lFmXkBchWBTeDphCEFyFk3Ao=;
	b=0hFRbO6DHtDCjk5qacIoyp1W4FoY36fyBNpig7oU7+GZ/+mrgEEUiwzCD7zKeTOgG/Os
	 w0AEbHFENzDzrhGJFulgknDDFn35ddRW6RnJacjbUvaekoJPW0Zx5+WU0DpJYyhNWMrSO
	 zdIaTum7RynQybDV+ZqUFNawu1PuvocJ+so//E44JOWy74GU9jYiCUfzMaf/pJO2SoB5a
	 fGbQkU0wCCb38OliAEuJBphdrN0003+kHdAE5YOz5A3oBiBbnT0k+YD+kjYRnzy2CZ1/j
	 NXmT7BeOvFz3+UpySzKMyvRS4KmWIiwUsxHuch5WHAXm2OxYT7h6GNyfvsjAZJKbXQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yandex.ru;
	spf=pass smtp.mailfrom=yandex.ru;
	dkim=pass header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=W2dKFKVq;
	arc=none smtp.remote-ip=51.250.60.165
Received: from forward105d.mail.yandex.net (forward105d.mail.yandex.net [51.250.60.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B952606A31A;
	Thu, 29 Oct 2026 19:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B952606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=W2dKFKVq
Received: from mail-nwsmtp-smtp-production-main-34 (mail-nwsmtp-smtp-production-main-34.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:2499:0:640:3812:0])
	by forward105d.mail.yandex.net (postfix) with ESMTPS id 398C5100045;
	Thu, 29 Oct 2026 22:34:35 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-34 with ESMTPSA id NYpk4nSh00U0-MKwfbOCM;
	Thu, 29 Oct 2026 22:34:34 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1793302474; bh=S44wys8E71CePiKvfI/lFmXkBchWBTeDphCEFyFk3Ao=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=W2dKFKVqr+3QFWQuMeVyDngvIHvQ/l6roqSmT9iWPFhY1mRYcm+d6L4OHR/5u6aws
	 7XX7/6KB0qvgV9EPPHfAbACdL6mb7fUc5PB9xZP3jho2DIr4iZU2iFKizRMtV/5nh2
	 z/+P4nGT7tgbsr/EMh1bCMsxCHHVO3nYWoA6kGRk=
Authentication-Results: mail-nwsmtp-smtp-production-main-34; dkim=pass header.i=@yandex.ru
From: Kupreenko Danila <keckerz@yandex.ru>
To: sre@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andersson@kernel.org,
	konradybcio@kernel.org,
	abelvesa@kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 0/3] power: supply: read-only CellWise CW2017 monitor for Redmi Go
Date: Thu, 29 Oct 2026 22:34:14 +0300
Message-ID: <20261029193417.551058-1-keckerz@yandex.ru>
X-Mailer: git-send-email 2.56.0
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

From: Kupreenko Danila <Keckerz@yandex.ru>

Add a read-only power_supply driver for the CellWise CW2017 fuel gauge,
its Devicetree binding, and the Xiaomi Redmi Go (tiare) I2C node.

Unlike CW2015, CW2017 has a different register map and battery profile
protocol. The driver requires a gauge already initialized with a valid
battery profile; it reads voltage, integer SOC and temperature but never
writes CONFIG, changes the battery profile or resets the chip. Charging
status is unknown; presence is not inferred.

The CW2017 source is an independent implementation assisted by Codex
(GPT-6). Firefly was consulted later as a behavioral reference, not as
a source of copied code. AI assistance is disclosed in commit trailers.

Hardware testing on Xiaomi Redmi Go (tiare), postmarketOS, Linux
7.1.3-msm89x7, using the original pre-v2 driver source (R5):
  - module auto-loaded and bound to I2C device 2-0063;
  - running srcversion matched the locally built R5 module;
  - capacity, voltage and temperature appeared in power_supply sysfs;
  - three consecutive measurements remained accessible;
  - udevadm monitor observed power_supply change events, including
    voltage and temperature changes at roughly 30-second cadence.

The v2 change preserves the last completed sample across system suspend
instead of overwriting sample.error with a synthetic -ENODATA. Polling
is still cancelled synchronously during suspend and an immediate poll
is queued on resume. The new sample can therefore be compared against
the actual pre-suspend state.

Host regression tests reproduced three v1 issues: spurious change
notifications for unchanged measurements after resume, missing
availability notifications when the first post-resume I2C read failed,
and artificial -ENODATA on early thermal temperature reads.

All three cases pass after the fix. Further checks cover valid/invalid
transitions, temperature reads during a blocked post-resume poll, and
64 suspend cancellation and 64 teardown cycles in a threaded model.
ASan/UBSan, ThreadSanitizer, ARM64 PM/thermal build and MODPOST, a
no-PM build, and sparse checks also passed.

The R5 hardware results apply to the original driver source, not to
the modified v2 suspend path. The v2 suspend change has not been tested
on the phone. Mainline Linux 7.3 has not been booted on Redmi Go.
Hardware PM/unbind, power cost, calibration, temperature-source
provenance and induced I2C error recovery remain untested.

Early post-resume temperature reads may return a stale cached value
until the first poll completes. The driver remains a monitor, not a
battery safety controller.

Open review questions include policy for already-initialized gauges,
3-attempt probe retries, nominal 30-second polling and up to 300-second
backoff after failures, and event frequency with small voltage changes.

Changes since v1:
  - Preserve the cached sample across suspend.
  - Fix spurious resume notifications and missed availability changes.
  - Avoid artificial -ENODATA for early thermal temperature reads.
  - Add host PM regression and concurrency testing.
  - Clarify the scope of R5 hardware validation.

Link: https://lore.kernel.org/r/179329639684.489944.6322623410181934358.cw2017-first-public-rfc@yandex.ru

Kupreenko Danila (3):
  dt-bindings: power: supply: add CellWise CW2017 fuel gauge
  power: supply: add read-only CW2017 battery monitor
  arm64: dts: qcom: tiare: describe CW2017 fuel gauge

 .../power/supply/cellwise,cw2017.yaml         |  52 +++
 MAINTAINERS                                   |   7 +
 .../boot/dts/qcom/msm8917-xiaomi-tiare.dts    |   9 +
 drivers/power/supply/Kconfig                  |  14 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/cw2017_battery.c         | 367 ++++++++++++++++++
 6 files changed, 450 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/cellwise,cw2017.yaml
 create mode 100644 drivers/power/supply/cw2017_battery.c

Range-diff against v1:
1:  450435406 = 1:  450435406 dt-bindings: power: supply: add CellWise CW2017 fuel gauge
2:  9439176a8 ! 2:  6c76f0f28 power: supply: add read-only CW2017 battery monitor
    @@ Commit message
         reference. Host tests exercise the actual driver and mainline uevent
         helpers with mocked kernel infrastructure.
     
    -    The same driver source was built for Linux 7.1.3-msm89x7 and tested
    -    on Xiaomi Redmi Go (R5). Module autoload, I2C binding, battery
    -    measurements and kernel power_supply change events were verified.
    -    The mainline kernel itself was not booted on this device.
    -    Hardware suspend/resume, teardown, calibration and energy use
    -    remain untested.
    +    The pre-v2 driver source was built for Linux 7.1.3-msm89x7
    +    and tested on Xiaomi Redmi Go (R5). Module autoload, I2C
    +    binding, battery measurements and power_supply change events
    +    were verified.
    +
    +    The v2 suspend change passed host PM regression tests, but
    +    was not hardware-tested. The mainline kernel itself has not
    +    been booted on Redmi Go. Hardware suspend/resume, teardown,
    +    calibration and energy use remain untested.
     
         Assisted-by: LLM sparse
         Signed-off-by: Kupreenko Danila <keckerz@yandex.ru>
    @@ drivers/power/supply/cw2017_battery.c (new)
     +	struct cw2017 *cw = dev_get_drvdata(dev);
     +
     +	cancel_delayed_work_sync(&cw->work);
    -+	mutex_lock(&cw->lock);
    -+	cw->sample.error = -ENODATA;
    -+	mutex_unlock(&cw->lock);
     +
     +	return 0;
     +}
3:  46d6f633f = 3:  1ceaa947d arm64: dts: qcom: tiare: describe CW2017 fuel gauge

base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
-- 
2.56.0

