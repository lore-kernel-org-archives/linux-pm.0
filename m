Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.38.64.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792753561;
	b=BTebSHNGb7iOOPCN8BJQlWBrIcDeIuGb/jxVcYR8s7CpzkWUZB7NeRF4Kl3VyLUVjt4o
	 hOBUxqDZliUI6ERfO62U1PIGpjwaeGgy/lnGOqA+/yaNyBHGdHOUiw5djMloZy6b7/eDK
	 Uz1pmFqaR2lZkAENSv52Kw5YcHUedpcNnR6bm3XIB4L7lz24VQ3pDo4BJm542cQAZxUHq
	 8/DFZFQaY0Dp6pNRSms8KhFbu8U9jnFebhYZxZlBB29/FpGCakBhL7lD4hEhj9FVTxnqv
	 S+hIeEUDGiRBaZUgsM8RdSB2NUAodrF9Xo9R7Az0kqEpHGt4OsVJRwFQEtK0oFPhojQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792753561;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=/rQlsHaf8RUxj4BJ5C4uFZp1pXhNw2oObE6nCLkBPIk=;
	b=GTwyz1zG7AzhXKSAv4ULfKRao7sVupwe6NOjv7ZjhXGE3cJTVL9wsJ4tM40UF8OcoXQ0
	 1L3pDy+N90v6Xh7xEU7BOl9KpnnBbHECJgdManh3V0uRElAN0XwzapDLG1gR3LgK9ICrq
	 FJ1+fuvPBYCj8WDy2sQXnoFpcCiv+vSPJD1/12AZGoJK5MkHLAaZXJlN4x/jQVxSQXYNf
	 YRQvHGhofnOc6gqeY8Oqi48KTcrUv+K4v5Joqs7WXJEecBP8z66fGNBxDAhPAKXiXdbmB
	 dfG3S9kJ43pAx3P3YYr1WVwtsxWjSHncPDCajX+gK4ez89k0W8kG7Ql6rV9lJ3xoUmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ustc.edu.cn;
	spf=pass smtp.mailfrom=mail.ustc.edu.cn;
	dkim=pass header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=WsBuFAaz;
	arc=none smtp.remote-ip=202.38.64.46
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA528606A31A;
	Fri, 23 Oct 2026 11:05:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA528606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=WsBuFAaz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version; bh=/rQlsHaf8RUxj4BJ5C4uF
	Zp1pXhNw2oObE6nCLkBPIk=; b=WsBuFAazG//+mgfQh/unhuD0T6gpPU+KtWIz1
	vMhSqyNIq2+m3MnfjokluEAwORJbv7n5VTGi+QsyAS9NmLCMvzvky5kgT60fdedQ
	v6rPD0+Gk67LSrIY5EZFL1SE8kkYQ6wpriF9YPSbTrYDhHnv++8fFulvaVTXIKE6
	Gi8g68=
Received: from [127.0.1.1] (unknown [114.214.178.200])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgB3AkeMP9tqZHU0AA--.1874S2;
	Fri, 23 Oct 2026 19:05:48 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, linux-pm@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Mike Tipton <mike.tipton@oss.qualcomm.com>,
 Taniya Das <taniya.das@oss.qualcomm.com>
Subject:
 Re: [PATCH] power: supply: qcom_battmgr: do not report power_now on SM8750
Date: Fri, 23 Oct 2026 19:05:48 +0800
Message-ID: <179275354818.2172689.9851715727007912571@mail.ustc.edu.cn>
In-Reply-To: <101257b5-7e43-4cc1-ba17-1507dad27b52@oss.qualcomm.com>
References: <20261013002124.332111-1-xiaqinghuan@mail.ustc.edu.cn>
 <179249416915.570120.11194300523322683054@mail.ustc.edu.cn>
 <101257b5-7e43-4cc1-ba17-1507dad27b52@oss.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-CM-TRANSID:3pYKCgB3AkeMP9tqZHU0AA--.1874S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GFyDXF1fJFW8CF17XF43Jrb_yoW7tFWxpF
	9xK3sYka1kJw18X3srAr1xZas5ZrZaya98Jr1kG348ZasxurySqryFkFWjqay5urn8X3WY
	vrs0qrnF9F4vkaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk2b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK
	82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
	C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48J
	MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMI
	IF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
	87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUgcTQUUUUU
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiAREJB2raZFVVbQARs2

Hi Konrad,

(Sorry for the subject mismatch - this continues your suggestion inside the
battmgr thread rather than the SM8750 sleep one, since it was your reply in
this thread that told me what to try. Feel free to re-thread if you prefer.)

You suggested disabling rpmhpd_driver.sync_state to pin the rails at their
maximum corner. I ran it, it worked, and I think I now know why. Short
version: the effect you saw is not specific to sync_state - it is the
Retention corner, and there is already an upstream commit for it.

What I observed

Board: Lenovo Legion Y700 Gen4 (TB322FC, SM8750P, mainline port).
Symptom: with the camera power domains powered on, turning the display off
(DPMS off via the compositor) hard-resets the SoC. No panic, empty pstore,
no userland record - the reset is below the kernel.

Two kernels, same userspace, same device tree, same module tree:

  7.2-based tree    6 of 8 runs reset      (your sync_state arm: 0 of 4)
  7.3-rc7 tree      0 of 41 runs reset

Your arm pins every rail without presync_floor to level_count - 1, so
retention is never selected. That made me look at what else differs between
the two trees in the RPMh power domain code, and there is exactly one
behavioural difference in drivers/pmdomain/qcom/rpmhpd.c:

  7.2:   if (rpmhpd->skip_retention_level && buf[i] == RETENTION)
                 continue;
         (skip_retention_level is only set on mxc and mxc_ao)

  7.3:   if (buf[i] == RETENTION)
                 continue;

So on 7.2, every rail except mxc/mxc_ao keeps RPMH_REGULATOR_LEVEL_RETENTION
(16) in its level table. That is Mike Tipton's "Skip retention by default"
(2026-06-29, Reviewed-by: you), which landed after the 7.2 point this port
was based on.

Confirmed against the actual level tables

The device exposes cmd-db through debugfs, so this is measured rather than
inferred. Dumping /sys/kernel/debug/cmd-db on the 7.2 kernel:

  cx.lvl   [00 00 10 00 40 00 ...]     -> has 0x10
  mx.lvl   [00 00 10 00 40 00 ...]     -> has 0x10
  ebi.lvl  [00 00 10 00 80 00 ...]     -> has 0x10
  lcx.lvl  [00 00 10 00 38 00 ...]     -> has 0x10
  lmx.lvl  [00 00 10 00 c0 00 ...]     -> has 0x10
  gmxc.lvl [00 00 10 00 32 00 ...]     -> has 0x10
  mmcx.lvl [00 00 38 00 40 00 ...]     -> no 0x10
  mxc.lvl  [00 00 10 00 40 00 ...]     -> has 0x10, but skipped on 7.2 too

Recomputing enable_corner under each tree's semantics: for cx, mx, ebi, lcx,
lmx and gmxc, the 7.2 kernel's enable_corner = 1, whose level value is
0x010, i.e. Retention. The 7.3 kernel's enable_corner = 2, whose level
value is the real working corner (0x038 / 0x040 / 0x0c0). For mmcx, mxc,
gfx, nsp, nsp2, mss, ddr and xo the two trees agree.

Note that mmcx is NOT affected - I initially assumed it was and the cmd-db
dump disproved me. Worth stating because it makes the hit list smaller and
more specific.

How it maps onto the failure

rpmhpd_power_on() deliberately does corner = max(pd->corner,
pd->enable_corner), so enabling a rail without an explicit OPP vote lands it
exactly at enable_corner. rpmhpd_aggregate_corner()'s presync_floor branch
then does to_active_sleep(pd, max(corner, pd->enable_corner)) - it reuses
the same enable_corner, so it does not save you here.

The rails in that hit list are the ones the DSPs depend on. From
qcom_q6v5_pas.c:

  sm8550_adsp_resource   proxy_pd_names = { "lcx", "lmx" }
  sm8550_cdsp_resource   proxy_pd_names = { "cx", "mxc", "nsp" }

So lcx and lmx are affected on 7.2 (both have 0x10 and neither is
whitelisted), and cx is affected while mxc is whitelisted and nsp has no
retention level. When the display and camera votes go away on DPMS off, the
DSP proxy PDs can be the last votes left, and the rail gets enabled at
Retention. What actually comes out on the serial console matches that:

  qcom_q6v5_pas 32300000.remoteproc: fatal error received:
      sys_m_smsm.c:322:err fatal notification received from TZ
  qcom_q6v5_pas 6800000.remoteproc: watchdog received:
      sys_m_smsm.c:322:err fatal notification received from TZ
  remoteproc remoteproc0: crash detected in adsp: type watchdog
  ucsi_glink.pmic_glink_ucsi: failed to send UCSI write request: -5

TZ notices first, then ADSP falls over, then the SoC resets.

Why I think this explains your result

Your arm and the upstream fix do completely different things - pinning at
the top versus deleting retention from the table - and both make the failure
go away. They agree only on one property: the affected rails never sit at
Retention. That convergence is what convinced me this is the mechanism and
not coincidence.

What I am not claiming

- One arm I built (7.2 + just the skip-retention change, nothing else)
  produced zero usable samples. All five attempts died in the display stack
  first - dpu vblank timeout, then drm_crtc_wait_one_vblank WARNINGs, dpms
  never actually reached Off. So I have not reproduced the fix myself on the
  7.2 tree. I am not presenting that as confirmation, and I am not
  presenting it as a refutation either - it is simply no data. I am
  mentioning it so nobody reads more into the above than it supports.

- I have not proven pd->corner is 0 at the moment of DPMS off. That step
  comes from the reasoning in your commit message, not from my own
  measurement.

- Everything above is one board. If other SM8750 devices with a
  7.2-era tree and DSP proxy PDS enabled at Retention do not reset, then
  something else is also involved.

For what it is worth, for us this is now closed: we run the 7.3 line, the
fix is already in, and we need no local patch. The reason I am writing is
that the observation is generic - any tree predating the skip-retention
commit that enables an RPMh rail through a proxy PD without an explicit OPP
vote can land on Retention. If you want I can send the cmd-db dump and the
serial capture, but there is probably nothing in them you cannot reproduce
faster on your own hardware.

Thanks again for the pointer - it was the right direction even though the
mechanism turned out to be one layer underneath what it looked like.

Best regards,
Qianhui Xu

