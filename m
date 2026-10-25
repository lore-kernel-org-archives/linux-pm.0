Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=138.232.1.140
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792956163;
	b=u30sQNqDg0GrrNmTx/SDjVsFiAUHNMHSynp8IJ3KCLZJjT0lVh+qytsFb8pwkJoHd8Dr
	 qtNdK8kPzfQUruhODb8U6znk5AsudsCNVGILcK7jZnKw8ijPvY2HfEcfvFWjxGStUn82m
	 8Z0N+NW5JmPQlvAKBZgKeEIxt1Olk5YMGvyqSo1fSug6MwunXg5NZ64SFYikYoURd/Ay4
	 3Pby6S0QXWKnGZh/bI8Pvln2a71UdDuNZsaz1O4noBDOF/xe+G3bzLj4zL/bdXzrGfSaW
	 b5XrByqSL5z6MwfeDN1JpM9BCrpXituxZ9kiQG3Rd0oeA/wu4PHMJY/OqFPuOoWpAaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792956163;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Spam-Score:X-Scanned-By;
	bh=4Tvh3ER3yLmblvY3yXSbn1ihzEpc/dPSRG3EnZEQ720=;
	b=xGxOilVqtbDIiMgeuKiV9PLa9ZP5CVEFeQiDl64/FEpDQddJyBmBxl9FFSo3xWixCoot
	 xyAykA2U5fvJILRrdaK5LdgQXPAh3fFp1viJkbXIAZWdMfSFUg2Rj/JrL5Wdihff/aSsZ
	 wRLWRlevnjDP1Fh/T/DlU664W7Xrt7/htud6jTGhzdLIwhr6HrCIjXPcRzkAJsg9HNP0N
	 VQXAVD9YdZGkJLCPDogYSIEwy1tbsyVxC7P57R/5ILNzKWZbw4I8sxgCBpY1XkF11cCO7
	 KhM1CQ/7hW5cAM/KrO/UzpsjGEd5Oq/hkTtJ2GjGrXIOHU5dbB2BstkH2R3SC9xXDNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=student.uibk.ac.at;
	spf=pass smtp.mailfrom=student.uibk.ac.at;
	dkim=pass header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=R12NoYLl;
	arc=none smtp.remote-ip=138.232.1.140
Received: from smtp.uibk.ac.at (smtp.uibk.ac.at [138.232.1.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12636606A320;
	Sun, 25 Oct 2026 19:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12636606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=student.uibk.ac.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=student.uibk.ac.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=R12NoYLl
Received: from surface-pro-5 (178.115.151.51.wireless.dyn.drei.com [178.115.151.51])
	(authenticated bits=0)
	by smtp.uibk.ac.at (8.15.2/8.15.2/F1) with ESMTPSA id 69PJMK10517096
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 25 Oct 2026 20:22:23 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.uibk.ac.at 69PJMK10517096
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=student.uibk.ac.at;
	s=prod24a; t=1792956144;
	bh=4Tvh3ER3yLmblvY3yXSbn1ihzEpc/dPSRG3EnZEQ720=;
	h=From:To:Cc:Subject:Date;
	b=R12NoYLl7dofrZhqAh7l5eB0oPYAZY2oo/Wn/yCUtxkk7LQaz1nieBJa0xdTF1Mgm
	 tSee/yLMwQWK2QXQXWRXrgbrO2neCy6/oZ5vTQ9DIt8IxvV1hNTnNyRejd7B1O/buW
	 Uazurn5UtuEy+Ucq/+XL0KH0wa/IQe+rLFDlgayY=
From: christian.koever-draxl@student.uibk.ac.at
To: neil.armstrong@linaro.org, jbrunet@baylibre.com, sboyd@kernel.org,
        bmasney+clk@redhat.com, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com, rafael@kernel.org,
        viresh.kumar@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        =?UTF-8?q?Christian=20Stefan=20K=C3=B6v=C3=A9r-Draxl?= <ckoever@outlook.de>
Subject: [PATCH 0/4] arm64: amlogic: S4 CPU frequency scaling
Date: Sun, 25 Oct 2026 20:22:15 +0100
Message-ID: <20261025192219.209137-1-christian.koever-draxl@student.uibk.ac.at>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: () -13.0 ALL_TRUSTED,RCV_SMTP_AUTH,RCV_SMTP_UIBK,U_H_APTO_LONG,U_RCPTS_11_PLUS
X-Scanned-By: MIMEDefang_3.2_at_uibk.ac.at

From: Christian Stefan Kövér-Draxl <ckoever@outlook.de>

S4 keeps its CPU clock registers in the secure world and bins its parts
by voltage, so CPU DVFS needs three pieces:

 1-2: the CPU clock in the S4 PLL controller, driven through the two
      BL31 SMC services the firmware exposes (sys_pll and the CPU clock
      tree), modelled as one clock because the firmware calls do not
      map onto separate muxes and dividers;
 3:   the secure monitor call that returns the CPU speed bin;
 4:   a small cpufreq driver that picks the "opp-microvolt-speed<bin>"
      curve and registers cpufreq-dt, like sun50i-cpufreq-nvmem.

This applies on top of "firmware: meson: sm: make power-off work on
S4" (sent separately; the command tables overlap). The patches touch
clk, firmware/meson and cpufreq. Patch 4 depends on patch 3; 1-2 are
independent of 3-4. I am happy to split them if the maintainers prefer
to take them through their trees separately.

Tested on an S905W2 (speed bin 2): 100 MHz to 1.908 GHz with the
vendor voltages, transitions under load for hours, vddcpu follows the
table.

Tool use (Documentation/process/generated-content.rst):
This work was done with the help of an AI coding assistant, Claude
(Anthropic), used through Claude Code over many sessions. It did a large
part of the hands-on work: it read the vendor kernel and the firmware
interfaces, probed registers on the board, drafted the code and the
changelogs, and ran the builds, checkpatch, dt_binding_check and the
tests on the hardware. I directed the work, reviewed every change and
the final patches, and take responsibility for them. There is no single
prompt to quote; the sessions were of the form "find out why X fails on
this board, fix it, test it on the box".

Tested on an Amediatech X98Q TV box (Amlogic S905W2, S4 family, 2 GiB),
vendor U-Boot and BL31/OP-TEE, Linux 7.3 plus this work.

Christian Stefan Kövér-Draxl (4):
  dt-bindings: clock: amlogic,s4-pll-clkc: add the CPU clock
  clk: meson: s4-pll: add the CPU clock
  firmware: meson: sm: add the CPU speed bin call
  cpufreq: add an Amlogic speed-bin driver

 MAINTAINERS                                   |   1 +
 drivers/clk/meson/s4-pll.c                    | 320 ++++++++++++++++++
 drivers/cpufreq/Kconfig.arm                   |  14 +
 drivers/cpufreq/Makefile                      |   1 +
 drivers/cpufreq/amlogic-cpufreq.c             | 184 ++++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c          |   2 +
 drivers/firmware/meson/meson_sm.c             |   1 +
 .../dt-bindings/clock/amlogic,s4-pll-clkc.h   |   1 +
 include/linux/firmware/meson/meson_sm.h       |   1 +
 9 files changed, 525 insertions(+)
 create mode 100644 drivers/cpufreq/amlogic-cpufreq.c


base-commit: 7be4bc52fd9e0e55dc9a2e0232b89427d2c4b614
prerequisite-patch-id: f977117cf7f3a613f667c2106e7f4aafc0ace116
prerequisite-patch-id: 1ec4e1bb456bd13cec4f140219f700f44ea19606
-- 
2.56.0

