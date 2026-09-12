Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0949D26CE2C;
	Sat, 12 Sep 2026 06:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789195870; cv=none; b=U2AvT0HNn5tmjTUfswbtczjF/mZ9y5KnOM5oaq3tXAmhrwMQwvhflFW/Gw5lKEFyWhYxXuIsDG3z0ix16emj/iIlWRB3b1Rf6Cfm7ttTN04MEElhVHAHgQprc2+4VpiGn2gNeuewKZXRuFqeKxgVUJ3VBs4cSVEZ6OU9mUfzrzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789195870; c=relaxed/simple;
	bh=AKP6AeGesIaVtdZBx9Nw9MPi/xcIFDgn/Sa6HGJ0Kz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YDI6oP8et8ujrcx9aszLR5e8s7RCqAXGQmybTLA1r56KwyLRq2WTDTznZG/JxW0IpbnRzML+bk7jbFW1td8oeSZCvMRYzm9tsVffFSOqGVaZE2RkyyUlGrR0u5Ku4S11j/ZiM9sAY5owImpAYsW7WRwzcoaRaMYoqmVj3sDlTG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=hiRsrBnl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xfBOxyIE; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="hiRsrBnl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xfBOxyIE"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 833817A00C1;
	Sat, 12 Sep 2026 02:51:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sat, 12 Sep 2026 02:51:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1789195865; x=1789282265; bh=pXelZX8vHK
	ysmBTKdiKejFzl/2p5vCMGgp21kZl21jw=; b=hiRsrBnlxsefTGda2N1uAs+xp8
	yekMNX5yy90qikBkAg7DCIdQ2Bo7uF1VBCJWFuIzzXptDkiuFy38KAolnO2KxyYt
	YgTsu/Sq37kuRfjEHkovEDOtgkwoG8VZB/XmSLLLeL6wqKxbwKU0LNSgTFq3jeeO
	h3DShAxkvk23Pu3SqMDE8NZkYIrAp0roUU12rdTR3HXE+WW0FUD0ZbJPD/mZdm1f
	yu0GKfOFRMrFv07G/uNuDLt5sWPj9WxFt1ZuFUWn/DjOYMHghaF41pxsFkkfWT/W
	J2tzu/fHwTL1EerMYO3xXFntHzbcY8Sd/Lecp80/ikYmD/eZ2wpKMHQlp9XA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789195865; x=1789282265; bh=pXelZX8vHKysmBTKdiKejFzl/2p5vCMGgp2
	1kZl21jw=; b=xfBOxyIECso5VM6+QHZgkwAFNjbCkuLwDW0+LV+WOSkuOID0aGz
	Olhys97hu4/DfZkzrZXujPc2IWK6HpifRIoJnHZ5kTSe6Cc9s+YXBdl/HfF1UThe
	tw0BzW2nk2y7m0wwYg4UwTbtmFIH42cR8s0LWlPW/RazivIrNRRWhKD30HbUk4WE
	mV6bGz+q579NKWEo9RgJFsKnVgXa9/8k8LON1lYnc9nG3raXkw108MlTZ5U7NI8B
	4NV3V1i3k1XTVEzAxkz5XkDY0fxRfpa6TCZ5H+rRZVr3aa924b/050R9iHn+ire2
	S0ukwM/iL2gpKjEcabb0MM83wbhN2i5kApg==
X-ME-Sender: <xms:V_akaseX7i16dWfw94yLXj53yqAI5aVlqbB6VR4qH7iE6S2gy_2gnw>
    <xme:V_akauVJb9aiAHeu5d0sakAoof3oy02TsXyhZRARIECWOvvU44QbhfEYGxHSlJ16M
    7d33DgQuMeBdYElfy7e601gC_cVcvCAmuy9ueGx1ox5IHlnAYdF1YKC>
X-ME-Received: <xmr:V_akarWSuPmCR8e8YBVpgWNJGIKyKAymA8sfUMAhs93hbx2WtoUwbKgNzIVM_65ANlcVoC3EyQ>
X-ME-Proxy-Cause: dmFkZTEPTAV3+XbjVP/bW4cRcXpyHrAzrH9+9QpuyVHtrKg7x48x8iJmpPt+1NC3WIxLWq
    r90BQCoAJYZ4nSPfYg34koSNDHSCM2PvChnmulEsow2NWcqxLYLRquMqtW/z7CFvgHF9xp
    LOS+C2iupKH/lT7unaEiIeevY0qs7y6OgZbxHtoot4tQNz9ihjBhVk6V9xUu18cmN/tk1o
    K+47UZXjeql+caK/KOSRUH22I0DMlynKeBZMw4qh2DpLfMXSqs0cPx/6PCAYwoBVOx8Rtx
    6GeClWPMRgiw9fCuJkVZfSxjLfC6gXvV53A9ZcDytiAoD7IwiylFwUUs4149lKa+UxHfUN
    o0sM/X690ex351WoPTjnMXG/DAMOBLbz4DIxnHRum+bC7G3+ct9UP63sYJ5eO2uFT/y+aN
    4cVYu8EsVuVmr2Kj++BLkM4hynmjuobdI3qqF4nstMu40TzyNeZ4k749sWkkR2ERCsBBP5
    bE+0sjSUSNnf8P7VaOmeHICeczk3YyWHBZheVLFz2sbV0JZ0BfUEVmp519eLCYmXJS1pym
    N5RqRZ1ViOlv51iW4mOTo8SnXd68vKLDSH71UY/+veMtHy29cynZjHqYy9iM0qK8qENLdS
    O5rFazB4HaGcUVaNRXJc+FZiH2IKGJZE7YzOkn0jAXpRsvxWu++S/vBC8vMQ
X-ME-Proxy: <xmx:V_akamNUNvB3xUSe3EjObkxaAHI9rk2yk-J9S-ABrOx9VfPS0elSAA>
    <xmx:V_akam6OUBb7IwMWMFVb-twh-Dwm4MwX6ADYMSIHO67EYnvRcjzlZg>
    <xmx:V_akanpsMUEkU4ILCLCKjaRjJR_mTUGUDAYSl_I-c7rMi9i0GPDYZA>
    <xmx:V_akakDyatk626BOurHHYVOSIPduqmBsokghXQ8dIq6S9SsV_nis4Q>
    <xmx:WfakapbatKBJhGytDqbeQ7IvGtzUSW2zdMOgACchzEOfXUxfph3yuaAK>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Sep 2026 02:50:55 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	ulfh@kernel.org,
	p.zabel@pengutronix.de,
	ogabbay@kernel.org,
	zhangqing@rock-chips.com
Cc: royalnet026@gmail.com,
	abel.vesa@oss.qualcomm.com,
	sebastian.reichel@collabora.com,
	sidong.yang@furiosa.ai,
	u.kleine-koenig@baylibre.com,
	chaoyi.chen@rock-chips.com,
	diederik@cknow-tech.com,
	alchark@flipper.net,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v12 00/14] accel/rocket: RK3576 NPU (RKNN) enablement
Date: Sat, 12 Sep 2026 18:50:39 +1200
Message-ID: <20260912065053.1519165-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the RK3576 NPU to accel/rocket, which today supports RK3588
only. The RK3576 carries two cores of the same RKNN block, wired up
differently. Two extra convolution buffer clocks, two power domains per
core, one reset rather than two, no NPU SRAM rail, and a PC_TASK_CON
that packs the task number into sixteen bits rather than twelve.

1/14 is Igor Paunovic's "[PATCH v2] accel/rocket: request the core clocks
by name", carried in the series since v11 so it applies to a plain
next-20260911 with nothing outside it to follow. It keeps his authorship
and its four tags. Tested on a Radxa ROCK 4D.

Five things changed since v11:

  3/14   clears the raw interrupt status beside the mask. Masking alone
         left the DPU bit latched until rocket_core_reset(), and the
         hardirq decides on raw status alone, so a fault from the IOMMU
         sharing this core's line would wake the threaded handler again
         and "No handler is running now" would stop holding partway
         through the function.

         It still tests "> 0". An earlier draft of this version changed
         that to "!= 0", on the reasoning that -EINVAL means runtime PM
         is not managing the device and the block is therefore powered.
         That is wrong and the change is withdrawn.
         pm_runtime_get_conditional() tests power.disable_depth before
         power.runtime_status, so -EINVAL masks a suspended device
         rather than excluding one, and this driver makes that state
         twice: in pm_runtime_force_suspend(), its own system sleep
         callback, which disables runtime PM before turning the clocks
         off, and in rocket_core_fini(), which suspends then disables
         before cancelling the timeout worker. Either would have put a
         register write on a powered-down block.

  10/14  cycles the resets before the settle delay 9/14 adds, not after.
         PD_NPU0 and PD_NPU1 ask for both, and the old order spent the
         delay and then deasserted a reset with nothing between it and
         rockchip_pmu_restore_qos(). The reset is SRST_A_RKNN0/1_BIU,
         the bus interface those writes go through.

         This is a change to code Abel Vesa reviewed. His Reviewed-by
         is kept because the patch still does what he read, in a
         different order; say so if it should go. 9/14 is untouched.

  11/14  checks the match data at the top of rocket_probe(), before
         anything is allocated. of_device_get_match_data() returns NULL
         for a device bound by name rather than by compatible, and such
         a device has no of_node, so the walk of matching nodes that
         sizes rdev->cores[] never counted it. Storing into that array
         and checking afterwards writes past the end.

  13/14  gives CLK_RKNN_DSU0 a rate. Nothing in mainline sets it and the
         NPU comes up at 786 MHz, while Rockchip's OPP table asks 800 mV
         of its 800 MHz step and nothing sets the rail either. On the
         ROCK 4D at the 750 mV its PMIC boots with, two jobs at once
         make the second core write single words wrong, thirteen to
         twenty rows of a 5400 row pass, where either core alone is
         exact; at 594 MHz, or at 786 with the rail at 800 mV, four such
         passes are clean. 594 MHz is a divider off GPLL and sits
         between that table's 500 and 600 MHz steps, both of which ask
         725 mV, so it is inside the voltage a board that describes no
         NPU rail already provides.

  14/14  enables both cores and both IOMMUs. v11 enabled rknn_core_0
         alone, "left to whoever can test it". It has been tested.

Sashiko raised one thing on 4/14 that an argument does not settle.
pm_runtime_put_autosuspend() is asynchronous with a 50 ms delay, so on a
workload whose submit gap is shorter the domain does not cycle after a
reset, 10/14's power-on pulse never fires, and rocket_core_reset()'s own
resets are all that run.

Measured on the domain rather than on the device: over one 60.8 s decode
of Phi-3.5-mini on a ROCK 4D, genpd's npu domain took 46.8 s active and
14.2 s idle, which sum to the wall clock, and its idle-state usage count
rose by 202. npu0 and npu1 rose by 210 and 217, and current_state reads
off-0 either side. The domain cycles about two hundred times a minute
under a real decode, and the pulse fires.

Whether it cycles after a timed-out job is the half Sashiko is asking
about, and that depends on the gap to the next submit. Inducing one needs
a kernel with JOB_TIMEOUT_MS lowered and a flash, so that half is still
an argument rather than a measurement.

Findings Sashiko labelled pre-existing, for Tomeu. These five recur; it
raised thirteen across the nine mails, and the one not listed worth
naming is a 64-bit DMA address truncated to 32 bits, which faults the
IOMMU above 4 GB.

  - the job completion path takes iommu_group_get(core->dev) and never
    puts it, one group reference a job, flagged on seven of the nine.
    5/14 moves this call rather than adding or removing it, so the leak
    is pre-existing but not untouched;
  - the shared IRQ handler touches registers without checking the PM
    state;
  - runtime suspend has no synchronize_irq();
  - num_cores is used both as an array length and as the probe index;
  - rdev is leaked through devres on probe deferral.

5/14 moves the iommu_detach_group(NULL, iommu_group_get(core->dev)) line
out of the IRQ handler and into rocket_job_next_locked(). ZhaoJinming's
"accel/rocket: Fix iommu_group leak and unsafe IRQ register access"
changes the same line, is marked for stable, and carries the same Fixes
tag as ours. Whichever lands first the other conflicts; say which you
would rather take.

Still open from v9, no reply since. 9/14 does three things: it adds the
settle delay, renames a macro, and gives RK3576_PD_NPU a regulator, which
also makes every RK3576 board force that domain off at probe. I asked
whether it wants splitting; Abel Vesa's Reviewed-by may be the answer,
and I would rather split it than have it merged on my silence. 13/14 also
gives each core both NPU domains, which is the description that has been
tested here rather than the topology; if it should be one domain per
core, 6/14's minItems has to change with it.

The bindings are unchanged since v9, where dt_binding_check was clean on
all three with dtschema 2026.6 and yamllint 1.38.0, and CHECK_DTBS was
clean on all 13 rk3576 and all 48 rk3588 dtbs. 13/14 adds a property to a
dts rather than to a binding, and CHECK_DTBS is clean on all 13 rk3576
dtbs with it.

A correction to an earlier posting. On 11 September I replied to the v10
cover saying that the 102 induced resets and the all-0x80 buffer it
described were not Igor Paunovic's. They are his: he reported both on
25 August in the v9 02/13 thread, and the 45 resets of 19 August and the
102 of 25 August are two different runs of his. I had read only the
19 August thread, and should have searched before saying in public that
he had not measured it. That mail is withdrawn, and both of his
Tested-by lines stand as he sent them.

Link to v11: https://lore.kernel.org/all/20260831081956.84871-1-gahing@gahingwoo.com/

The tags:

  2/14   Tested-by: Igor Paunovic   # RK3588, three cores
  3/14   Tested-by: Igor Paunovic   # RK3588, three cores, induced
                                    # reset, differential base,
                                    # JOB_TIMEOUT_MS=2
  4/14   Tested-by: Igor Paunovic   # RK3588, three cores, induced
                                    # reset, JOB_TIMEOUT_MS=2
  5/14   Reviewed-by: Igor Paunovic
  6/14   Reviewed-by: Krzysztof Kozlowski
  7/14   Acked-by: Conor Dooley
  8/14   Acked-by: Conor Dooley
  9/14   Reviewed-by: Abel Vesa
  10/14  Reviewed-by: Abel Vesa

Igor Paunovic (1):
  accel/rocket: request the core clocks by name

Jiaxing Hu (13):
  accel/rocket: take the completion register writes under job_lock
  accel/rocket: wait for a running IRQ handler before resetting a core
  accel/rocket: let the core suspend after a reset
  accel/rocket: factor the completion tail out of the IRQ handler
  dt-bindings: npu: rockchip: add rockchip,rk3576-rknn-core
  dt-bindings: power: rockchip: allow resets in a power domain node
  dt-bindings: iommu: rockchip: describe the RK3576 NPU MMU
  pmdomain: rockchip: add optional per-domain power-on settle delay
  pmdomain: rockchip: cycle optional power-domain resets on power-on
  accel/rocket: select the per-core clock and reset counts from match
    data
  accel/rocket: add RK3576 NPU (RKNN) support
  arm64: dts: rockchip: add NPU (RKNN) nodes to rk3576
  arm64: dts: rockchip: enable the NPU on rk3576-rock-4d

 .../bindings/iommu/rockchip,iommu.yaml        |  28 ++++
 .../npu/rockchip,rk3588-rknn-core.yaml        |  47 +++++-
 .../power/rockchip,power-controller.yaml      |   8 ++
 .../boot/dts/rockchip/rk3576-rock-4d.dts      |  22 +++
 arch/arm64/boot/dts/rockchip/rk3576.dtsi      |  86 ++++++++++-
 drivers/accel/rocket/rocket_core.c            |  32 ++++-
 drivers/accel/rocket/rocket_core.h            |  11 +-
 drivers/accel/rocket/rocket_device.c          |   7 +-
 drivers/accel/rocket/rocket_drv.c             |  42 +++++-
 drivers/accel/rocket/rocket_drv.h             |   2 +
 drivers/accel/rocket/rocket_job.c             | 135 +++++++++++++++---
 drivers/pmdomain/rockchip/pm-domains.c        |  83 ++++++++---
 12 files changed, 440 insertions(+), 63 deletions(-)


base-commit: 68142f986ff04b2b70b31db00f719bf690f64a9a
-- 
2.43.0

