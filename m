Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795711273;
	b=s/XzHq4xPIWMpQwZmKdArslQ9/XtIAmPd01Ys3Ofwu71iSHTyxgdxmI5A+v/Omfnfn5I
	 ECZJtYR0fK0Soqw0peOoLdB8rqqRiZbYzaFYWliuKS3uefYrodXoiQ48XbxrV7+siwT5+
	 dDJL0BQDFfKj/qDDZK4xKy99wlKduZsm6S1Ey6XhPBAGWHrUOE5ASy0N19BnypeOTyjJu
	 BtCrpXgK+n5BPyCOMzSJAhwPH39gHO0eY/cMFOrRVS3KC0Ep+HBPwkEngszb4+On2I6tA
	 deRfrj3vI2pICwwJ9dKSzQqEZXApNfvnN1JtEvYauheeH+phUkihUQ+n9ZJfFVqJy8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795711273;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9ic7GIeBAEK//ldCqzOdV9U0524b8pdj40NAXKTVFaA=;
	b=Pxbb5xQlPeTsWmWRlmkOoVdvHbpn81gYg8KF4IxWExvsCVDEVDYDsLIufyUXmWaSWPxh
	 +M7tVR2bA3cb95BZ8wKo0AGOhU7StZs2IojDHMoc+qJ6LftedEDAMLH5kJxTmGQ/BOY+a
	 Vr9wbeSHLwVsrkPYTDnEveJ7Qw5TmKf++PN/8T7HFMezv6ZJkEqs/rSPQKynueToA6lPO
	 1PLdnhy1kLSSBwMlwCggN3Rj+3sl7mtMiUaDs7ePh1vAx1MdnfOPJ80XGhzxa0n/nV3ZS
	 1pQjt7dE+paLFrVARVYZgr0227nhHQfWQuCWOPB4ZC6I/POufQxUJjXtg0YF+5a4VYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S7Zf4Rhf;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A87606A31C
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 16:41:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86A87606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S7Zf4Rhf
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48e09aa5264so4225069f8f.2
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 08:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795711272; x=1796316072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9ic7GIeBAEK//ldCqzOdV9U0524b8pdj40NAXKTVFaA=;
        b=S7Zf4RhfhwbU/5iB1U7hQ/IKD2M96tHFgp2QNQ3AnUaG1/XxMtr5EdHFovP4DSz3jn
         eeF3dlIM4iYvA4Zz0NfrwSH1T550h6Y9f3JjR1mCro+/ekjWFvqVYOPdSfJWD3i5ATS3
         uB0k14jzCvAe9vAq6bOQHnvOSBkfHGSImvtTixddmj8SYeRvK4VLEjxJZDp3Hsw1PJQM
         tiRG9XSaUDomOjnmi+MUotzJ7mBtxN//L+qn1ee3XkuOGC/Awt3oyDo1XtPKxeVjsnBc
         DP0DmN0EJImZu99vHjFQD2JSmRswiS3OSxgRr0wl7g0ixyD///debG0cyYftdhaoIzaY
         IdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795711272; x=1796316072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9ic7GIeBAEK//ldCqzOdV9U0524b8pdj40NAXKTVFaA=;
        b=rx/2bE9pqXz61+mhB5Vwpe7HkPDiA2YKG1ffixcFthZf7ydrlDjb2LJyzoJKtDdgiI
         pGRmwFTPC7jmGr/ZMJ9+xPYKA9mzUQxyGh9cR+4eYIqaB4aAYBhR6JayZBT9JmfdFwiJ
         MuuUhr6vpivXOfpFEfCxCkAy+ZfJ1ywV6ecHnADEZJJzV7RPn0+gF4iULAeP8VgwPeP0
         9ye+O1S8e2WNezACo1BwGMCHWicFJLHTUSgDkjXgT7JX7jci23eX+NGRZTN77v0GXFCD
         Ere+WZDGQ9UNxIDWyv4bk1yunjwWOSJIohED6xP7mEWx4KxtfIANyScScgvMRc/q1LHN
         1NmA==
X-Forwarded-Encrypted: i=1; AL+hErFqaUecCdEMECC76m2N/BE49Xk1CRLwgrv+9Cu1YZs7nfXQ0nIH7VMIpCL1hFrHjADCSMXtyMjCIg==@vger.kernel.org
X-Gm-Message-State: APuU4Z//TMnNTnQB8S0YdR/VD5q/m8CltYC1idZVxDRK0K+tA19KMqES
	qhmw+eHGPBXBSoWGuBO1es+/y2BGr9xMV9qXCs4d8NlV3WZrOtwI5Yuz
X-Gm-Gg: AZFdTZdOjwfaZgdCd1KUjbh6ymd0fwzKF/Mh0OivxTc2FlFr8orhwa0cjX7KCTN5SZD
	riaZZIvUY8Dd2fKVtkrWLxZsRRqYvuhVE3W97IUo7rDW1ugaKt/rPxcbhPN59Pm6eH6nr4s3lkD
	unmFIaawctMV/OIFNA9wZUIVRHOFqXnvCdsvC90fZRPqcI72nC3VvPyOCRPHKMcvqKHQGVuOFKR
	4+tSapFjMwi5e8WIbaIf0chXBl5OcfgDL8isaNHLuSvPEstt8JTAERYr3AgCSW1xRRhemSAMIeU
	jcoYKrYMcDeA30JjY69G4jVhHl/tOn2usRNNc/6KIMimtR3u/UELzbZRSE1C5HMyrRLpUoGU44l
	DOw/8XmKMKCLr+QL1UsdH2pJiL1upCwzOoR8ZUnB9EcYDsN9mvLnJZe59LC2cCctGjOJFAlVv+M
	VEunPicAY4PUOvUeolzee8TRADx4kupo9RPL/z5Qkjj+eLLUewmP1qy64gmv2N7b1xCzdBf/ao+
	tIOHbqvnGL8wPup/nzV0w/lsgz2aq3CesdFE+r0UoUcgHGfKyH9lMYJCY7O9RDPmKF5V95kZlQw
	phNce+hT9vmuOtqhP//VkDqzajrHoKhWFdmZd17FDLx9qRH09zv6gi8=
X-Received: by 2002:a05:6000:40e0:b0:4b8:5ccc:eed7 with SMTP id ffacd0b85a97d-4b85cccefccmr15497144f8f.51.1795711271385;
        Thu, 26 Nov 2026 08:41:11 -0800 (PST)
Received: from vitor-21h1cto1ww ([2001:8a0:c4c6:f00:6ce3:c28c:2097:7d09])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b10b5f6sm39333942f8f.34.2026.11.26.08.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 08:41:10 -0800 (PST)
From: Vitor Soares <ivitro@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Vitor Soares <vitor.soares@toradex.com>,
	linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Lucas Stach <l.stach@pengutronix.de>,
	Advait Dhamorikar <advaitd@mechasystems.com>,
	Marek Vasut <marex@nabladev.com>,
	Peng Fan <peng.fan@nxp.com>,
	Adam Ford <aford173@gmail.com>
Subject: [PATCH v2 0/2] pmdomain: imx: fix suspend/resume order of the blk-ctrl virtual devices
Date: Thu, 26 Nov 2026 16:40:57 +0000
Message-ID: <20261126164058.2373605-4-ivitro@gmail.com>
X-Mailer: git-send-email 2.53.0
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

From: Vitor Soares <vitor.soares@toradex.com>

The i.MX8M blk-ctrl drivers drive the GPC domains through the virtual
devices from dev_pm_domain_attach_by_name(). These devices have no
parent and no device link, so their position in dpm_list relative to the
blk-ctrl consumers depends on probe order. When a consumer ends up
before them, the system hangs in the noirq phase.

Patch 1 fixes imx8m-blk-ctrl. It is v1 [2], now also linking the bus
domain virtual device:

- i.MX8MM, VPU: the codecs resume before the virtual devices and the CPU
  hangs in genpd_resume_noirq() of 38310000.video-codec. On Verdin
  iMX8MM this happens on the first suspend to mem.

- i.MX8MP, media: reported by Advait [1], the CPU hangs in
  genpd_resume_noirq() of 32e40000.csi. His debug prints in
  imx8m_blk_ctrl_power_on() show the stall at the first BLK_SFT_RSTN
  read, after pm_runtime_get_sync() on the bus device returned 1.

- i.MX8MP, VPU: a normal boot works only because the Hantro codecs defer
  their probe until the blk-ctrl is bound (the blk-ctrl waits for the
  imx8mp interconnect module), and the deferred retry moves them to the
  end of dpm_list. Loading hantro-vpu after the blk-ctrl has probed
  reproduces the hang on resume.

Patch 2 does the same for imx8mp-blk-ctrl (HSIO and HDMI) and is new in
v2:

- i.MX8MP, HSIO: loading phy-fsl-imx8m-pcie after the blk-ctrl has
  probed puts the PCIe PHY before the virtual devices. On suspend the
  HSIO bus domain is powered off first, and genpd_suspend_noirq() of
  32f00000.pcie-phy never returns. With the module loaded at boot, the
  PHY defers, ends up after the virtual devices, and suspend works.

On Ulf's question in v1 [3]: the GPC domains cannot be genpd parents of
the blk-ctrl domains, because their power-up is interleaved with the
blk-ctrl reset and clocks (see 25e252bcf159), so the blk-ctrl drives
them with runtime PM on the virtual devices. The consumer drivers only
see the blk-ctrl domains. Runtime PM is disabled in the noirq phase, so
->suspend() keeps the virtual devices runtime active, and the runtime PM
calls of the blk-ctrl do not fail in the noirq phase, while the genpd
core powers the GPC domains off and on through the virtual devices. That
requires the virtual devices to be suspended after and resumed before
the consumers, which is what this series adds.

Lucas pointed to v1 as the correct fix in the original report [4].

Tested on top of ulfh/linux-pm fixes:
- Verdin iMX8MM: 20/20 suspend-to-mem cycles. Without the series, the
  first suspend hangs and the watchdog resets the board.
- Verdin iMX8MP, hantro-vpu and phy-fsl-imx8m-pcie loaded after boot:
  20/20 cycles. Without the series, the board hangs.

[1] https://lore.kernel.org/all/CAAPs2HTo=4+AEw1+vcU6c9vt_O2BfF+gv3FFvx9G3KLLzCOsHw@mail.gmail.com/
[2] https://lore.kernel.org/all/20240418155151.355133-1-ivitro@gmail.com/
[3] https://lore.kernel.org/all/CAPDyKFr9Vzgm2C6Z57Bg5mUQxg5LK6goN2og3+RC3BkTZjiqJw@mail.gmail.com/
[4] https://lore.kernel.org/all/8636fb8d9809aaafbd8274ec0dbfc250e1113c73.camel@pengutronix.de/

Vitor Soares (2):
  pmdomain: imx8m-blk-ctrl: fix suspend/resume order
  pmdomain: imx8mp-blk-ctrl: fix suspend/resume order

 drivers/pmdomain/imx/imx8m-blk-ctrl.c  | 29 ++++++++++++++++++++++++--
 drivers/pmdomain/imx/imx8mp-blk-ctrl.c | 29 ++++++++++++++++++++++++--
 2 files changed, 54 insertions(+), 4 deletions(-)


base-commit: 458777762756acfc7d2c20067cca6cc817cc8dec
-- 
2.53.0

