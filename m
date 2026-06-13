Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B89A312819
	for <linux-pm@vger.kernel.org>; Sat, 13 Jun 2026 06:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781333904; cv=none; b=ZHk67jzf8ulsMTWErJ07M3RuzPePVT2QVD8rmcs7+ONFMNAB4k1CkTIC6RFlXCEkVYDoaXLN+O4yBM8TlZDAvOC+Bd5u8ZhteT4YJjygwvGw8KJYkgPS6dHBdrvkCy1o+TB+xN9pIocqY6ymeiNI0Eernjlh9pyjUyRSesFtpfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781333904; c=relaxed/simple;
	bh=ZmjUWLZQV3tSstvk97jQqCJd1dclKlQbaWWfUTHqXBk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b4wow2gSOxTfmmXxQmL298lVffyFX+7Wf8cOJDQQe8Ug0NvXW5aa/ZAruSZirkoOKKZQtmaBTVnZGHgLFp4ZUF3IxlZOxnaGsE2G1SN/W3iCLFCrhlahwP1dB0ehY7F/LnHlE/JK4I7qfvj6EPvHu4WogAywHoar39Y7bqSttss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HtqC32bL; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtqC32bL"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4921e4dd62dso5888865e9.0
        for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 23:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781333900; x=1781938700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4QsU3lUuOvN1fkkJCd/R0PVYRNNXIyBXyGs7tF0ADRs=;
        b=HtqC32bLOwIpZ9AN9tHJ8G/HI7yUwc9LmH+TRjyqNHofqaLsxDTTD8m71pmuMQRr1t
         8TCSt/4yYJHjxqNEpupoujKcqDPiGgpr2FufaG9S6mRNvVYKLtxCIGnuCVuzcHg1n79l
         3hIA+DlwsrhmGIVBer4CBmv3IRAzY/EKNRr8JVHxXVWmELmquPr8f1aKxtbVRy6tRqv2
         iz24nnss3PrP3lCS1ylB8vuKmMyzukegYjeIsaqzgWjn4O+LZ03t1SecWiqD/u74g5+j
         aiwxTtEgbosy8G7MuEN6kFa3ZMgHtTnVcHZjKM7XfPorQfjy1sxRCFiF4vM/0xiON20c
         /+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781333900; x=1781938700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4QsU3lUuOvN1fkkJCd/R0PVYRNNXIyBXyGs7tF0ADRs=;
        b=h18IT+YuIXHN1KHqdl1tmg6YPBVECGcJNKJWtNJxa+6EJnUKKBScTiO1/r2nsgVLox
         cr8hcqojZ2NLKhyEUBC25KZEgCayfOZh0mC/GI0a9AOUSITXWwoR5cK4ZGoWG6pSaUoe
         3hnnM/z6vlWMQslXkrjVg4kugAubyxnIMIdVHQxf/3ipe4aJxfIScADrY0dVWpSR5P25
         MAG0MPzHRCTTtRkV4xAYAyZzZ0kfGwTfFsRUQq9nyJiKd/Z90BgX6tQDfQzdlLNEnrNW
         FgnSBE/oa9MmtlGtXRcJRYsLcBqA8QylvaMR3O/FgvE2p3ngOcuUDj9/+G4E+y2hA+UF
         pgKA==
X-Forwarded-Encrypted: i=1; AFNElJ8qWQq8A0Ba7hM3XeQLa856FWIWQ5cJG/JHnd1CoH7bwe3OrXlIqmKf3erZb27nQ7tiPKtWIl2Y4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YymlmbY3Gf5yo9L1AdAwLFz15amOhq8vuVvfdM3rZ4VGK0H7SUK
	ZvGujNVOpmHCx1hkKdmSl+opCTaMEg8SERaZSaPyA91L4NrpTzoB+mEu
X-Gm-Gg: Acq92OHqu06i54cqC0Smkr5BH7CTOqu3cK6Wk0WPbr7IJXPgvMmtx752Um4+cuMvWiv
	q1xkoES1kISV7Jamwjp1RjcIku0cNqvJq9PNgai2x2F0xmznxSoz7URR9DuWqSW/0HdwaUf63am
	kQP7o3mNTkUL0fJX4Tj2zjvQN8mLz7hJG3DyhZTSrHhtvVWto/O3+NSOqYmEz3JfE9arATnLrS1
	/0aqbGA9YwSGGm6CZ/D/v2vtpjxKodFdx2g9DLDvxHT9B65FcmcSnLv8c2Y6kAt16Z1fInFleFJ
	lLObpA+A4ZF7wILs6Cbtao2vHyaw0uF3pY5M7ug0e1pGpI3gg/mZW5oXi+IKUmeG4I9UMSD2EKj
	iT1blV7x+QjeK0oIjDQG3j97+1RHBjg+e2MXAQQ6C8WGk6EXViHS/uvNrcL144zIR95fj/Fl+Mt
	jvOdh/sY0liQJNnPqyDhApLAA3563IV1w6EzNwyQseHQ==
X-Received: by 2002:a05:600c:c171:b0:48a:53cb:8604 with SMTP id 5b1f17b1804b1-490ec4dfb03mr56249045e9.14.1781333900211;
        Fri, 12 Jun 2026 23:58:20 -0700 (PDT)
Received: from debian.tailb81abf.ts.net ([2a01:e0a:104a:4d80:14c0:9448:1c38:77df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492202e5cbasm42917705e9.2.2026.06.12.23.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 23:58:19 -0700 (PDT)
From: MidG971 <midgy971@gmail.com>
To: tomeu@tomeuvizoso.net,
	ogabbay@kernel.org,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ulf.hansson@linaro.org
Cc: dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	xxm@rock-chips.com,
	chaoyi.chen@rock-chips.com,
	finley.xiao@rock-chips.com,
	diederik@cknow-tech.com,
	jonas@kwiboo.se,
	Midgy BALON <midgy971@gmail.com>
Subject: [RFC PATCH v4 0/9] accel: rocket: Add RK3568 NPU support
Date: Sat, 13 Jun 2026 09:01:07 +0200
Message-Id: <20260613070116.438906-1-midgy971@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Midgy BALON <midgy971@gmail.com>

RFC, not for merge. End-to-end inference does not produce correct output
yet (see Status), so per the v2 discussion this is a request for design
feedback. It probes, attaches, and submits cleanly on a stock v7.1-rc6
tree; what remains is one hardware-internal issue.

The RK3568 has a single NVDLA-derived NPU core, the same IP family as the
RK3588 NPU the driver already supports; the register layout matches. The
RK3568 differences are a 32-bit NPU AXI/IOMMU (vs 40-bit) and explicit
PVTPLL/PMU bring-up to power and de-idle the NPU before it is reachable.

Patches:
  1-2  rocket: per-SoC data struct, then derive DMA width and core count
       from match data (refactors, no functional change); patch 2 also
       bounds-checks the per-SoC cores array.
  3    rocket: RK3568 SoC data; start the PVTPLL compute clock via SCMI.
       Powering on and de-idling the NPU NoC are left to the power domain.
  4    rocket: reset the NPU before detaching the IOMMU on a job timeout
       (the detach otherwise stalls a wedged AXI master and WARNs).
  5    rocket: keep the IOMMU domain attached across jobs instead of
       re-attaching per job (the per-job rk_iommu handshake on the idle
       NPU MMU is slow and noisy); also drop the domain on reset and stop
       the scheduler before IOMMU teardown.
  6    dt-bindings: add the RK3568 NPU compatible; require rockchip,pmu
       for RK3568.
  7-8  arm64 dts: add the NPU and its IOMMU, and enable them on ROCK 3B.
  9    pmdomain: give the RK3568 NPU power domain a regulator so genpd
       owns vdd_npu via domain-supply (Suggested-by Chaoyi Chen).

Dependencies. This series no longer touches the IOMMU driver; two
in-flight Rockchip IOMMU changes are relevant but not part of it:
  - Simon Xue's "iommu/rockchip: Drop global rk_ops in favor of
    per-device ops" [1]. On boards with more than 4 GiB of RAM the NPU
    MMU's DTE must stay below 4 GiB (its DTE address is 32-bit), so the
    NPU IOMMU is described with the "rockchip,iommu" compatible, whose ops
    allocate the page tables with GFP_DMA32; the SoC's other IOMMUs use
    the "rockchip,rk3568-iommu" (40-bit) ops. The driver keeps a single
    global ops pointer, so two ops on one SoC trip its coexistence check;
    this series therefore sits on top of Simon's per-device-ops change,
    which Rockchip (Chaoyi Chen) confirmed is the intended way to give the
    NPU MMU its 32-bit DTE.
  - "iommu/rockchip: disable fetch dte time limit" [2] (Simon Xue / Sven
    Pueschel, in the iommu tree), which sets AUTO_GATING bit 31. v3 carried
    a local AUTO_GATING patch; that unconditional fix has since been merged,
    so this series drops its IOMMU patch. The bit is a no-op on this
    hardware in any case (the page walk completes on its reset value).

Power bring-up. The NPU is brought up through the power-domain layer (no
driver hack): the NPU power-domain keeps its clocks but drops the pm_qos
phandle (qos_npu sits behind the gated NPU NoC, so genpd's power-off QoS
save faults reading it), and vdd_npu is wired as the domain's
domain-supply with the domain marked need_regulator (patch 9), so genpd
brings the rail up before it de-idles the NoC at power-on. The PMU de-idle
then ACKs without PVTPLL running; PVTPLL is only needed for compute.

Status. On v7.1-rc6 the driver probes, creates /dev/accel/accel0,
attaches an IOMMU domain, and submits jobs; the program controller
fetches and broadcasts the command list. Inference output is still
wrong. The kernel side (this series) appears complete; what remains is
mesa/Teflon userspace, which still emits RK3588-tuned config (to be
filed on mesa-dev), and the hardware: with corrected config the NPU
reads the full input and weight tensors (per its DMA counters) but the
MAC/output stage never completes and the job times out, leaving the
output at the buffer's zero-point. It is not in the command list (a
byte-exact replay of the vendor's command list behaves the same).
Pointers from anyone with RK3568 NPU experience welcome.

Known residual. On the first IOMMU attach the NPU MMU is idle with paging
already enabled; the rk_iommu stall/reset handshake does not complete in
that state and logs one burst of timeouts before the (kept) domain
settles. It is harmless here because the job times out regardless, but it
points at an idle-MMU reconfiguration corner the rk_iommu code does not
handle on this block.

[1] https://lore.kernel.org/linux-rockchip/20260310105303.128859-1-xxm@rock-chips.com/
[2] https://lore.kernel.org/all/20260428-spu-iommudtefix-v2-1-f592f579e508@pengutronix.de/

Changes since v3:
  - Dropped the local AUTO_GATING patch: the correct fix (set AUTO_GATING
    bit 31, "disable fetch dte time limit") has since been merged upstream
    [2], so the series no longer touches the IOMMU driver.
  - vdd_npu: new pmdomain patch (9) gives the RK3568 NPU domain a regulator
    (need_regulator) and the board wires domain-supply, dropping the
    regulator-always-on workaround (Suggested-by Chaoyi Chen). It relies on
    the in-tree pmdomain default-off-if-need_regulator handling. The
    "Failed to create device link ... <pmic>" line at pmdomain probe is a
    pre-existing fw_devlink cyclic-dependency warning (the single
    power-controller provides every domain, including the one the I2C PMIC
    needs), seen the same way on RK3588; it is harmless here beyond a few
    wasted EPROBE_DEFER retries, and a proper fix belongs in the
    power-controller driver, not this series.
  - rk356x dts: also assign the CRU CLK_NPU so the NPU AXI bus clock comes
    up at 200 MHz instead of the 12 MHz boot default; order the NPU/IOMMU
    nodes by unit address.
  - rocket RK3568: fetch the SCMI/PVTPLL clock by name (the v3 bulk index
    resolved to the wrong clock); drop the redundant driver PMU de-idle
    writes (handled by the power domain).
  - rocket: clear the attached IOMMU domain on reset; unwind through
    rocket_core_fini() on noc_init failure; stop the scheduler before the
    IOMMU teardown.
  - rocket: bounds-check the cores array against the per-SoC core count.
  - Binding: require rockchip,pmu on RK3568.
  - Dependency framing: confirmed by Rockchip as v2 + 32-bit DTE via
    Simon's per-device-ops series (was framed as v1 in v3).

Midgy BALON (9):
  accel: rocket: Introduce per-SoC rocket_soc_data
  accel: rocket: Derive DMA width and core count from match data
  accel: rocket: Add RK3568 SoC support
  accel: rocket: Reset the NPU before detaching the IOMMU on timeout
  accel: rocket: Keep the IOMMU domain attached across jobs
  dt-bindings: npu: rockchip,rk3588-rknn-core: Add RK3568
  arm64: dts: rockchip: rk356x: Add the NPU and its IOMMU
  arm64: dts: rockchip: rk3568-rock-3b: Enable the NPU
  pmdomain: rockchip: Add a regulator to the RK3568 NPU power domain

 .../npu/rockchip,rk3588-rknn-core.yaml        | 27 +++++++++-
 .../boot/dts/rockchip/rk3568-rock-3b.dts      | 18 ++++++-
 arch/arm64/boot/dts/rockchip/rk356x-base.dtsi | 38 ++++++++++++++
 drivers/accel/rocket/rocket_core.c            | 30 ++++++++++-
 drivers/accel/rocket/rocket_core.h            | 19 +++++++
 drivers/accel/rocket/rocket_device.c          | 15 ++----
 drivers/accel/rocket/rocket_device.h          |  3 +-
 drivers/accel/rocket/rocket_drv.c             | 50 ++++++++++++++++++-
 drivers/accel/rocket/rocket_job.c             | 45 ++++++++++++++---
 drivers/pmdomain/rockchip/pm-domains.c        | 36 +++++++++----
 10 files changed, 245 insertions(+), 36 deletions(-)


base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
-- 
2.39.5

