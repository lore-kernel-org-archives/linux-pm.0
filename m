Received: from tabos.org (krueger-it.net [145.239.1.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C7A3164B4;
	Sat, 29 Aug 2026 05:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.239.1.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787982353; cv=none; b=cE7YVhe70nC0Y+TfLYIPdkyVuyUYnhAMXulpIoY9p4ckItMhMB8370mPK2GV0K78vw3GKvP3PtYsJOyYVesiL2hr5yRU7i8fS63XZFckvgmawiD8k6PfDF3A4DPUmQGdhYQr48Xgf89ciV+1VSoA7lwAv5sQhfViB4YC3KumQZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787982353; c=relaxed/simple;
	bh=OrxYAnJ7fWEgGjDFAEVYgjNxXsjaQ703A0BMRoo+8YQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KxuGZCnA7Pw/HgZMxbHlCmPzW0P6LLPbkjFYXaaa51/IliYWdNweIcSVjpRoouhYFwAjWmJWPcSCyTLeCYJURK3BZm62D2+9r4NxCOQizpPYZACsYUDbB8HxUqxcA26KivzOAjV+y6HbzLCXATuohy8PpksTOrEErY29wIgU6PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tabos.org; spf=pass smtp.mailfrom=tabos.org; dkim=pass (2048-bit key) header.d=tabos.org header.i=@tabos.org header.b=PQCTd6qZ; arc=none smtp.client-ip=145.239.1.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tabos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tabos.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tabos.org header.i=@tabos.org header.b="PQCTd6qZ"
Received: from c0d1ngstat1on.fritz.box (unknown [94.31.74.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by dserver.krueger-it.net (Postfix) with ESMTPSA id 1F6B262E0388;
	Sat, 29 Aug 2026 07:45:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tabos.org;
	s=default; t=1787982350;
	bh=2LtXMhy2p0owS9hwq3abjMi2M+8ilWSUwuPZ0Z1IEs8=; h=From:To:Subject;
	b=PQCTd6qZvwAGyVzfxNUn9da2rGfrzYvNVy6leRNmmGKzCqvIxbeQDYBBqy4MrSsV4
	 P3MsovGY3+VOmuofb0Of8+ljUBD52LajCcNK0V7xsSMBvAJJXktEtmpfZcftOd5GIo
	 4eDICdx4muSlQ0UVnf1iq9mi/psXhb9AFh1ukfkbD2Ls9iOZqpYmpxWZmO9OnVtmht
	 fiCUmORGxkyElCYXzn80D4b9LFJSY9BTD5A2Id0XBUGP+XKsT/Ehs5RcNceuMqeumU
	 W/gE4G/p2fT8GrEfR1Jt7PNOIk5msQlu7sAUpPXCNtWqtLfEiE8r+C3YdsaipADcym
	 DFXfX0HQwzeIQ==
Authentication-Results: dserver.krueger-it.net;
	spf=pass (sender IP is 94.31.74.100) smtp.mailfrom=jan.brummer@tabos.org smtp.helo=c0d1ngstat1on.fritz.box
Received-SPF: pass (dserver.krueger-it.net: connection is authenticated)
From: Jan-Michael Brummer <jan.brummer@tabos.org>
To: sre@kernel.org
Cc: andersson@kernel.org,
	neil.armstrong@linaro.org,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan-Michael Brummer <jan.brummer@tabos.org>
Subject: [PATCH 0/2] power: supply: qcom_battmgr: report charge levels on SM8350-class firmware
Date: Sat, 29 Aug 2026 07:45:44 +0200
Message-ID: <20260829054546.86210-1-jan.brummer@tabos.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On SM8350-class firmware (everything that is not SC8280XP/X1E80100) the
battery reports no usable charge level to userspace: charge_full and
charge_full_design fail with -ENODATA and there is no charge_now at all.
As a consequence UPower cannot derive an absolute energy level and never
shows a runtime estimate - the UI is limited to "charging"/"discharging".

Patch 1 is the actual bug: battmgr->unit is only populated from a
BATTMGR_BAT_INFO response, which this firmware class never sends, so the
mAh guard on the CHARGE_* properties always rejects them. The values are
fetched from the firmware and stored on every access, they are just
thrown away again.

Patch 2 adds CHARGE_NOW. There is no dedicated firmware property for it,
but BATT_CHG_COUNTER carries the remaining charge rather than a
monotonic counter on this firmware. This is the part I am least sure
about, since it does not match the charge_counter semantics described in
Documentation/ABI/testing/sysfs-class-power. Two measurements across the
SoC range agree with the reported capacity to within a percent, so at
least on this platform the interpretation holds. Happy to drop this
patch or to collect a full discharge curve if you prefer.

Both patches were tested on a Fairphone 5 (QCM6490) running
postmarketOS. Before the series:

    energy:              0 Wh
    energy-full:         0 Wh
    energy-rate:         12.4713 W
    percentage:          59%

After, discharging and charging:

    energy:              14.4347 Wh       energy:              15.6003 Wh
    energy-full:         16.8807 Wh       energy-full:         18.1505 Wh
    energy-rate:         3.39313 W        energy-rate:         7.3492 W
    time to empty:       4.3 hours        time to full:        20.8 minutes

Two observations that are out of scope here but worth recording:

  - power_now reports 72097076 while current_now * voltage_now gives
    ~11.9 W, and qcom-battmgr-usb/current_now reports 11078000 against
    an input_current_limit of 3000000. Both look like unscaled firmware
    values. UPower does not use either, so this series is unaffected.

  - state_of_health reports 100 while charge_full/charge_full_design
    works out to 96.6%, so the firmware appears to derive the two
    independently.

The time-to-full estimate is optimistic compared to the firmware's own
time_to_full_avg because UPower extrapolates linearly and does not model
the CV taper. That is expected and not a regression.

Jan-Michael Brummer (2):
  power: supply: qcom_battmgr: fix CHARGE_FULL* on SM8350-class firmware
  power: supply: qcom_battmgr: expose CHARGE_NOW on SM8350-class
    firmware

 drivers/power/supply/qcom_battmgr.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

