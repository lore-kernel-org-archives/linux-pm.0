Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792687343;
	b=lqQbk6zhmpnJ6hIw3qxI0qc820ZRw+mgOv+s3EG5VJrBPwdtBO1Pzq3KXI5QFLBYp2mV
	 FUboUZlb0MLvDQZaTJtYev8IZrX4uuLGk2zDsLA7muP86yG3DwBISmCC2gCQw9dqmdt9v
	 CHqm6ntE4u0CZ404i5ITh/X8AVvIHI6OqgnvtcgeNgkluNVz/jpQ/kbwwfUINaMjjdTJe
	 w9NZ88T31jajgEE5XXmZ1C4LqZaM92DjXGWas342ixx2c30Rn1qdmHO9CId3h6nfrz3KM
	 5UR54iZecNV0R1JbmbRNCi2qqKkmLHkfz/NKmb65zQmsBNtwAZfmXVebNfES40Y4IrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792687343;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BpFS6ySbwG4J+0ZDYOqEgZMFTp6XLFpyMVM4kuMmIEU=;
	b=Jr1zk71JE3+MPbR/R2dj8TlwHtZ6pOv6GVJ0kYDoGK3tQwJZGM6CBRyhV8DwPKXHUYRS
	 NP+A5LDLksZaaFZVsdk58TCbI8XbHBWS27iuXbaK+bAMj7DUmr9daQ7xraXfU1sfLgJNX
	 G96FAUl/cWkCBK3tQNSyzKwq+55Nezwja1M5tS2CRL1a6gnOI3snd7HAOMAtAp9qZr9/Y
	 oIU9qENosw8FrWKh0jAzOIww59SOYgTuKBeX+3C7FE6fIhxt72ba1o04+eGiSCej8kwS9
	 WCqKiFKO2G+tEQA9/mExZl+nkYUTHUt/q485LOBj/QDX7zf5GjR0Y5Ee+7VZ2IOyWDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="Zly/bhuk";
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D56606A31D
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 16:42:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14D56606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Zly/bhuk
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48dfdd0678dso8665f8f.0
        for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 09:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792687341; x=1793292141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BpFS6ySbwG4J+0ZDYOqEgZMFTp6XLFpyMVM4kuMmIEU=;
        b=Zly/bhukMS6FJUjJfT1eSqtaTbkAgukn20PNTV+vr3KX4kG2j6DGVJa+PChtvWhfPj
         cdXq80B0ssJ8Ip3qy11meFWs6jY7RkF8Q3FGJs5gDYEdqQkMSSk1U1wVUxeRl+ftO1Tq
         nRm0yyPMkb7PklYx0RwaGNe9HE7sn30WOkLhrgixmaTTKwS3TtkE4wVzTZ4SKrZAWMq0
         eUsrqrd0Poi1f29mM47ne04K55Z1jqBV6MAsAJqLEwAvSK0FBd0e9sBxl4q6jgKUpl2D
         BXHLa7GhF1owwciNJ9qIyfOxGvc90wf5zKVlJfOGde0GUKoIW7KJFz6j4uXKmyIVj+xd
         nJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792687341; x=1793292141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BpFS6ySbwG4J+0ZDYOqEgZMFTp6XLFpyMVM4kuMmIEU=;
        b=OP6bkMuWzAFxFgI96y1M5qLJQLTRp559Yx3C4NjDVvP+Zy0HofA4NFGZhEgnQt8Kjd
         qBPuYUVe2IHUoFqg6oIwVqnshBCX4Bg9SZQ5i79Zr27ayt2/Jl/aMu0Hb5nq5UA8YQ/b
         heUQaXyN4mjBgW7rXbKQ5NEJU/ye6UWocD/gByu36vvHtGb/sR8lOQr321852XF1bUQz
         Q2NEoISun7kJWeJPe2Ke5ndgEtwMgRMn9oFouh9LYZOi1nQ8RFJAUDWBMkosZIvU2w8F
         Hi3Xc0me4cQzsm8/aRWRR5V5555VmPuOLTtIQoirVhM4RbCaouMGl171J3waw6MGigC/
         kYQQ==
X-Forwarded-Encrypted: i=1; AKwUvBz47NpASHH3L9IPf+eVpoc5VffAPLweXwXFR7mVmmJ/W0h78em5tGkHBTcsjfYf809j7YnVIr3m/w==@vger.kernel.org
X-Gm-Message-State: AFq9FYLEfAciOg8laby58Sto68X0YVrry2m3pSpfhBZKwAfy8/geJ8og
	FcmvMsQy7atdPUIwrl9eNUAZpdVhDeVzmPbSpl6bV8R8m7kQCMPZFR03
X-Gm-Gg: AYBFou01jP54CB6zjrBY2vlaBdUN2mUQLd5AQAkwva5K0xejvDwtftm7wig5cACjGFO
	yQ60Z7sQOviOdg73E+Z8zGt7+aKc/QEQImbhMhXJD3WT57DCIFpxig9HCA2ykSl11nfFQM1jIsZ
	qX0dPBQxKnIcAmvNlEhSSQmkRP1/gishmotu5RMfaOEwcLRkLPQ/X7/Op3lOIicK34P4/pw/V/+
	mi4MYTRgPQyIxLG67kGjDHL8obWfP37cDbBN0ALTBv5Dn8PN3mObwzw8xIz0Kmhez2KC5ID/Iwx
	n8R0mARnWv77um0vl5N7h9k18yzToS09k2+FqXOrONgZhnnorKhAgC87jv4WNtlugTesiinEX1a
	A+PyRGcFokXN+KXrU2EOykOg3lCWzqf+TKOzBaq1M5qljyc3KPUGlUZmgVNZgn4dji5dVO35OHM
	Q4Xjrms0JBZwt1PC7C8JfKD7iH9bYEYgU61v5uf2Xg/n9US72yl7i+Go6KdYsvlxdQMCAszYhVR
	sPl/AXzxjeOnuV/BaEjvfuaF2TPlsJxVubmA23jJ1+/MRG3Arc1963+UyRQpTC350ln5IIR6wOg
	VBFjPg==
X-Received: by 2002:a05:6000:50:b0:48d:e696:8a65 with SMTP id ffacd0b85a97d-48e264db1a1mr8359382f8f.46.1792687341082;
        Thu, 22 Oct 2026 09:42:21 -0700 (PDT)
Received: from localhost.localdomain ([188.190.249.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2584c3b0sm15040175f8f.57.2026.10.22.09.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 09:42:20 -0700 (PDT)
From: Vladyslav Tymoshchuk <tvlad744@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Cc: Abel Vesa <abelvesa@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Reichel <sre@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Casey Connolly <casey.connolly@linaro.org>,
	Johan Hovold <johan@kernel.org>,
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
	Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
	Joonhoe Kim <26rote@gmail.com>,
	Daniel J Blueman <daniel@quora.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vladyslav Tymoshchuk <tvlad744@gmail.com>
Subject: [RFC PATCH 0/4] soc: qcom: pmic_glink: Hold back notifications over system sleep
Date: Thu, 22 Oct 2026 19:41:47 +0300
Message-ID: <20261022164151.592-1-tvlad744@gmail.com>
X-Mailer: git-send-email 2.45.1.windows.1
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

The GLINK interrupt that delivers the PMIC GLINK messages is requested
with IRQF_NO_SUSPEND, so the clients get notifications during system
suspend and resume and in suspend-to-idle, and the work they schedule
for them can run while devices are suspended. Commit c7c56b6ec077
("soc: qcom: pmic_glink: Fix device access from worker during
suspend") moved the altmode worker to system_freezable_wq as a
stop-gap, and left the proper fix for later:

  The final shape of the rework of the pmic glink driver in order to
  fulfill both the filtering of the messages that need to be able to
  wake-up the system and the queueing of these messages until the
  system has properly resumed is still being discussed and it is
  planned as a future effort.

This series is a proposal for that shape, to have something concrete
to discuss:

- Patch 1 does the queueing: from ->prepare() on, pmic_glink holds the
  notifications back, and passes them on from system_freezable_wq once
  the system has resumed, in order, without duplicates, at most 64.
  Responses are passed on right away. The service UP is held back as
  well and passed on after the notifications, DOWN is passed on right
  away.

- Patch 2 does the filtering: a notification is a wakeup event if the
  client's device may wake up the system, see device_may_wakeup(), and
  the client's optional wakeup filter accepts it, which is the
  callback that Casey suggested [1]. pmic_glink reports the event when
  the notification arrives, and keeps the client's wakeup source
  active until the notification is delivered.

- Patch 3 enables wakeup for ucsi_glink, as Jishnu Prakash proposed
  [5], without the event in the callback.

- Patch 4 makes qcom_battmgr wakeup capable, with a filter for the
  charger notifications, but leaves wakeup disabled: Bjorn does not
  want a laptop to wake up in a backpack [9], and a battery charging
  state notification woke up Abel's laptop with some chargers [10].

The UCSI connector work running before the devices it uses have
resumed has been hit on three boards so far [3]: on X Elite with a
PS8830 retimer [2], on SM8850 with an FSA4480 switch, and on SM8750
with the dwc3-qcom role switch, where the register access with the
clocks off resets the SoC [4]. With patch 1, the clients don't have to
keep the work for their notifications off the system workqueue: Abel's
UCSI RFC [2] would not be needed, and the altmode stop-gap can stay or
go.

The earlier discussion is in the thread of the first version of the
altmode fix [1]. Krzysztof:

  Regardless whether we call pmic_glink a bus or some sort of
  transport mechanism, the users of its interface should not be
  called after they are suspended.

Bjorn asked whether a bus would mean "some mechanism for pmic_glink to
defer these messages until resume has happened". Abel found queueing
the messages fine, but noted that it does not decide when to wake up.
On the UCSI RFC, Dmitry asked to fix PMIC GLINK instead [2].

Why not in GLINK: dropping IRQF_NO_SUSPEND would break the other users
of the interrupt, as the description of c7c56b6ec077 says, and would
not close the race [6].

Why not a bus: patch 1 gives the guarantee Krzysztof asks for from the
pm callbacks of the pmic_glink device, and the wakeup policy stays
with the client devices, which reviewers preferred, according to [5],
over making the GLINK interrupt a wakeup interrupt [8]. cros_ec does
much the same: it passes the events that came during suspend on to its
clients in ->complete(), and decides whether an event wakes up the
system by its type and device_may_wakeup(). Its default wake mask
leaves out the battery events and the AC disconnect as "not actionable
wake events".

Open questions:

- ucsi_glink wakes the system up on a cable change by default, as in
  [5]. Should it only be wakeup capable, like qcom_battmgr?

- pmic_glink does not wait for the work that a client queues for a
  notification, so if a suspend starts right after a notification was
  passed on, the work can still overlap the suspend of devices. Should
  ucsi_glink cancel the UCSI work in its ->suspend() with
  ucsi_suspend(), like ucsi_acpi, or should a wakeup notification keep
  the system awake for a while, like the timeout in [5]?

- Only the latest of identical notifications is kept. That relies on
  the clients treating a notification as state, or as a hint to read
  the state, which holds for the in-tree ones. Should a client be able
  to opt out?

- qcom_battmgr notifications no longer reach power_supply_changed()
  during a suspend, so its wakeup source no longer aborts a suspend
  started through /sys/power/wakeup_count. Does anything rely on that?

- Patches 3 and 4 depend on the API added in patch 2. Should the whole
  series go through the Qualcomm SoC tree, with acks for those two?

Tested with suspend-to-idle on SM8750 (OnePlus Pad 3): the series on
top of the v7.3-rc5 based kernel that the device runs, with debug
prints added. That kernel does not have the dwc3-qcom fix [4].

- Awake, with qcom_battmgr wakeup enabled: of the 23 qcom_battmgr
  notifications for an unplug and replug, only the four USB property
  notifications were wakeup events.

- Cable plugged in (one run) or unplugged (two runs) during
  suspend-to-idle, with the default wakeup settings: the held-back UCSI
  notification woke the system up. 10 to 13 notifications were held
  back and 6 to 8 passed on after resume, none dropped. The wakeup
  source of ucsi_glink stayed active until they were passed on, about
  1.5 s. The UCSI work and the role switch ran only after that, and the
  SoC did not reset.

- With only qcom_battmgr wakeup enabled, a plug-in during
  suspend-to-idle woke the system up with the USB property
  notification. The UCSI notification before it was held back without
  a wakeup.

- With wakeup disabled for both clients, an unplug during
  suspend-to-idle did not wake the system up. The 11 notifications were
  held back until the RTC alarm 55 s later, and the SoC did not reset,
  so the queueing of patch 1 is enough to avoid the reset.

- 25 minutes of suspend-to-idle while charging: one qcom_battmgr
  notification came, was held back without a wakeup, and was passed on
  after resume, with the battery state updated right after.

Not tested: PDR during suspend, more than 64 notifications held back,
hibernation.

Kamal Wadhwa's PMIC GLINK RTC series [7] also changes pmic_glink.c, so
whichever goes in second needs a rebase. Its driver enables wakeup on
its device, so with patch 2 its notifications would become wakeup
events without further changes; today, the alarm only reports a soft
wakeup event through rtc_update_irq(), which does not end
suspend-to-idle.

I used an AI assistant (Claude) for the analysis and to draft these
patches and their descriptions; I reviewed the result and ran the
tests on my device.

[1] https://lore.kernel.org/all/20250110-soc-qcom-pmic-glink-fix-device-access-on-worker-while-suspended-v1-1-e32fd6bf322e@linaro.org/
[2] https://lore.kernel.org/all/20250205-ucsi-schedule-conn-worker-on-freezable-wq-v1-1-107d1356b77b@linaro.org/
[3] https://lore.kernel.org/all/20261020132432.998-1-26rote@gmail.com/
[4] https://lore.kernel.org/all/20261018143126.3978-1-tvlad744@gmail.com/
[5] https://lore.kernel.org/all/20260722-ucsi_glink_wakeup-v2-1-b43dee56df24@oss.qualcomm.com/
[6] https://lore.kernel.org/all/CAMVG2ssS4=Kb=OxuVXb_062fgvBfKz+X0q1N2rFob0TH6JypYg@mail.gmail.com/
[7] https://lore.kernel.org/all/20260807-rtc-glink-cleanup-v1-0-7801e4d69c4f@oss.qualcomm.com/
[8] https://lore.kernel.org/all/20240603073648.3475123-1-quic_deesin@quicinc.com/
[9] https://lore.kernel.org/all/ZnIe2hjPgWipDfgG@hu-bjorande-lv.qualcomm.com/
[10] https://lore.kernel.org/all/Z5taRZ0om5y%2FDJ69@linaro.org/

Vladyslav Tymoshchuk (4):
  soc: qcom: pmic_glink: Hold back notifications over system sleep
  soc: qcom: pmic_glink: Report wakeup events on behalf of clients
  usb: typec: ucsi: glink: Wake up the system on connector changes
  power: supply: qcom_battmgr: Allow charger changes to wake up the
    system

 drivers/power/supply/qcom_battmgr.c |  19 ++
 drivers/soc/qcom/pmic_glink.c       | 257 +++++++++++++++++++++++++++-
 drivers/usb/typec/ucsi/ucsi_glink.c |   6 +
 include/linux/soc/qcom/pmic_glink.h |   2 +
 4 files changed, 281 insertions(+), 3 deletions(-)


base-commit: 9a482184d910775cf648863148944945b74e2815
-- 
2.43.0

