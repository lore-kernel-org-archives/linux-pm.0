Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D712935A3B8
	for <linux-pm@vger.kernel.org>; Sun, 12 Apr 2026 21:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776028810; cv=none; b=TYt4sx5tHTpiF4+PONGx3nGy/pJ9SCdhao5dYnI/7iMr2o3Mzt/qaGC01BsUWUXh5XKBqTiHj+4TG1GPd2bt1hfng3tHtgrKORsyNCzKasKCGXKkrB2v+h1tAE/XrZ1NAbu5Uzru6aBpw8c5tpLXVcAhm0iRX6QuQILekTaJW98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776028810; c=relaxed/simple;
	bh=tMkRUfTN8Bncs3EGHrvIFw8FiA2N2/PBiKt5eJsmrek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PzBYgXPkGICQfu2LJL8o/fPrdlRRxrhBwcnjX4reMLgDy8W9pfp/ksQJVm/BhFIYhaFRpCQ56yJDXTP44eCtst5Hfgdov2f71C6sSAYAdE1bq0eWzdJIo/hyoPh6Xo/NRdQU8fIRmCCpepmRpJ3DrM+4ZCHoHGfsg5byhEuUkxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJsdlDI+; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJsdlDI+"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c76b6abdb73so2704236a12.1
        for <linux-pm@vger.kernel.org>; Sun, 12 Apr 2026 14:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776028808; x=1776633608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gdpHnJzsZ54JHVpvw0E3kldQ22xP3xvLv/vXHJI/JDg=;
        b=AJsdlDI+FsbaqhO5QVTmXSRQocn7dUabl45gfvFPSYiG/AQNgt6tfh2S7lhkf/cSOq
         HGPPy6Et0iSkl/Fgxubjq2zMAGQ0eh3kr4kpnZduxMQRWNQ+7Mf3P6dF5bD9ENDy10YD
         tT+ltPV/36zjErM0ctuxhrvLPKjwHIFoUmieJBwNrE4/cxnz1vFCRBRuW+MmqdyVlPXG
         5LK+x16JX3KRyXEmxQZRkShHxe/OBMDdpQkRgEzH4Vgj9a1xcmsIFzaPPmHUp9DcbI1d
         NTaEpX9f3TUbJngHKhg5UGdeqMXo5PSpbv4MSZo+X75jOSlBFmMIaOKLMUEhYCO5zq0E
         KWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776028808; x=1776633608;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdpHnJzsZ54JHVpvw0E3kldQ22xP3xvLv/vXHJI/JDg=;
        b=KVbR6wjWWUXxBAJkbqcQEU5HqH+S8C4XCYen7VFx0O87GKvTJ5BhbnyAjofka0Yubw
         JD4GbEYwAhy3pmDBuFdrai08vy+/aGdaCK+9qcPoLcfQKk63vPXiBua9o0NmBKtatNoq
         t4jFraAkPnKl6nz6Z0vx7JJjG1doLM1+HelwMKYvxBRBFIuC2+XfXakMWVs5vfZ+XBlG
         2a9PLCeTn01+iLsvKyzyz2r+Oxscy5VQydZMXkCY/7UsJaZjsxeGRk7htU0Y/RqwFRwg
         NYrYFkzIWPl5cn6w8/uMPTna8obkhAhKKQev0uF1vpYbigWRKk+odLVSGTLg6m4VAboP
         LBJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqjZCnebMVSwxh7fA53eAV/w5Qx1aqludYnvfUfnWOuHlnUAylcFrFeKISBBZdzyyAl+x/htsVIA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+Kq/2yMTzlgbvsXqDFAlRJAN70lYxnAPU7we3YsFm3mmGeT2m
	OXXDfzaJX5yEz8z/HtMKF2SpDSVAc0xo2PziAgnLcQojXih7Pd9RgQgzoaeOaA==
X-Gm-Gg: AeBDietgJE/H0RsQlBcGklT5fSnZoxgUGtwGH1LFtn9mdHZpJFFOjinefuBrRipHSco
	P2e2xAGZswd749tzV3tqsZa4ZoI4wzmxou22iBwsCrNC1nKNE8LtpliA50oG5p1tVHihDbxWnKm
	1uJVgjoZ7vgmVHFyujxylcK6aF6ZorvZRd35kAK2Oa7X6guTrcgRQki2opAtfvb7UJxk3QrVMQo
	fvcxCwsgA74t2zMLlyF1F8S211Kz/l80x0q5KcK72rWAkOCAhXr+sORDjundhd5+bHo+Rbe9ppd
	Ehy7dnEPusK5sjGBaW5otScnltPeXBf+XssXbeJz2ESdk2kWqS79v5rgPowq0fxCEJ6CRuLw24r
	QNNSenb3q4AYZsG9oc3vieiifeTEYg4AZnPTqHw10JII94ngw+87FwFajCuYFKE2XRorj3FDZMI
	T1IfNd72HV5/+Gqnt2sqLbDJ4qim4eUWJUCclZrS3aj607OAdVPhS0tEcCU/FxuGe3SDeVMmmcs
	N2NkushAF70k/vk4SHiL2Jo/fLOjPBt52bytFY=
X-Received: by 2002:a05:6300:210d:b0:39f:c48d:fcd2 with SMTP id adf61e73a8af0-39fe3ddd0bdmr11728694637.27.1776028808178;
        Sun, 12 Apr 2026 14:20:08 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com (100.130.194.35.bc.googleusercontent.com. [35.194.130.100])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7921a3e6d2sm7615779a12.32.2026.04.12.14.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 14:20:07 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: geert@linux-m68k.org,
	sre@kernel.org
Cc: jserv@ccns.ncku.edu.tw,
	eleanor15x@gmail.com,
	daniel@0x0f.com,
	laurent@vivier.eu,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-pm@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v4 0/2] Add QEMU virt-ctrl driver and update m68k virt
Date: Sun, 12 Apr 2026 21:19:50 +0000
Message-ID: <20260412211952.3564033-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a generic platform driver for the QEMU 'virt-ctrl' device [1]
and transitions the m68k 'virt' machine to use it, replacing
architecture-specific hooks.

The new driver ('qemu-virt-ctrl') registers a restart handler and
populates the global 'pm_power_off' callback.

On the m68k side, the platform initialization is updated to register
the 'qemu-virt-ctrl' platform device. Additionally, the 'mach_reset'
hook is bridged to 'do_kernel_restart()' to ensure the kernel's restart
handler chain is correctly invoked.

Verified on QEMU m68k virt. Both system reset and power-off were
confirmed functional by invoking 'reboot(LINUX_REBOOT_CMD_RESTART)',
'reboot(LINUX_REBOOT_CMD_POWER_OFF)', and
'reboot(LINUX_REBOOT_CMD_HALT)' from userspace.

Link: https://gitlab.com/qemu-project/qemu/-/blob/v10.2.0/hw/misc/virt_ctrl.c [1]
---
Changes in v4:
- Fix sparse warning caught by kernel test robot.
- Pass the struct qemu_virt_ctrl context to sys-off handlers instead of
  the __iomem pointer.

Changes in v3:
- Add a reboot notifier in the driver to handle LINUX_REBOOT_CMD_HALT.
- Handle native endianness in the driver instead of hardcoding
  big-endian I/O writes.
- Select POWER_RESET and POWER_RESET_QEMU_VIRT_CTRL in m68k
  Kconfig.machine.

Changes in v2:
- Use devm_register_sys_off_handler() instead of register_restart_handler()
  and global pm_power_off.
- Switch Kconfig to tristate to support modular build.
- Add .id_table to platform_driver and use MODULE_DEVICE_TABLE() to correct
  module auto-loading.

v2: https://lore.kernel.org/lkml/20260203170824.2968045-1-visitorckw@gmail.com/
v1: https://lore.kernel.org/lkml/20260112182258.1851769-1-visitorckw@gmail.com/

Kuan-Wei Chiu (2):
  power: reset: Add QEMU virt-ctrl driver
  m68k: virt: Switch to qemu-virt-ctrl driver

 MAINTAINERS                          |   6 ++
 arch/m68k/Kconfig.machine            |   2 +
 arch/m68k/virt/config.c              |  42 +--------
 arch/m68k/virt/platform.c            |  20 ++++-
 drivers/power/reset/Kconfig          |  10 +++
 drivers/power/reset/Makefile         |   1 +
 drivers/power/reset/qemu-virt-ctrl.c | 122 +++++++++++++++++++++++++++
 7 files changed, 159 insertions(+), 44 deletions(-)
 create mode 100644 drivers/power/reset/qemu-virt-ctrl.c

-- 
2.53.0.1213.gd9a14994de-goog

