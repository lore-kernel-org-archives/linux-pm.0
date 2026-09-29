Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C41450B8DB
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 10:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790677731; cv=none; b=tWvxG7UuZ32yHvye+SGvfQu5dRUB5S2nrdE/lrNXOaN5HsOg0vGbAJeHXnVbPqHFRe6VtmZoxCuJdhF1I4mMFVMhOLXZ3sO2s88cGFbBZaguBWGT2XAkQ/j9UoquBlqbhoyHo4a4apzi4qlKH88oDSEE09soJSNs3u2YwpU4o88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790677731; c=relaxed/simple;
	bh=nD0jQ0sanXtfhte+cS4Eb6xgGbAdsdiqP+FoF7tBRHM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CnAy84Jaja4/w4Z3zepdTGRo84DwRG15Wv07jWxabxE70IqPVI+VWi8nHOSIYAGbRUuXnu24369tOFzDVvmSBxLfiXRtn5GbAjLyUrwAYCkIn8oY1OD9JFbDQFDwsSBB6mcR41AgI9hmsgDvythM5d9MF5AWnq6gd9k0MVkUaOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=86AxwoQj; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="86AxwoQj"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4887f690df6so2854752f8f.1
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 03:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1790677714; x=1791282514; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OjnLLZEy4NZ05RWw4wcrVNfIfzQkE+4cewTuv6QJdW8=;
        b=86AxwoQjp8tyrf2rh+EQ/6k0rZuE6nFtpDLR1dJRe+laj2umkWNcfzBMQEZLMdNnkc
         AtYlntrifj20TwAzWMaLfWxTrW9+BMDVg9PSWo32cxAO+PjIBQJ1huKgGdeQBVJ+iLm0
         MJetV8cwW1ZyUVONHG/7NEPC9xieRWcMdOQ7D0vYqbM/qXOGQNlrv374Srxj7kWygDqK
         iEmO6ZSSx28ifgWPLQf4pL56rgSvd+jAjb0SxCcu1mBPzFVrX+4IdM0SRqAclTmeOX8e
         H6fws2aKiKiWhhVbePt7fV9MlwPwLYk1ZmBtHz8TmrLGQwhwGBvQc4O6fKeCNrlBnrm4
         Loww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790677714; x=1791282514;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OjnLLZEy4NZ05RWw4wcrVNfIfzQkE+4cewTuv6QJdW8=;
        b=nWjWZwcC2Ff4Mfew5CwUzWloUYlWFkW7YBvuXv+MocawHilhImedmfDn3BWXJ7PYB6
         M9qFw6IzjL8J9TtavZ3hEUyPbYIjnIwRTrTcCCyVAx9Y/K6T+qQYCSQnJ0c0/5uxyuVT
         WfE8pLQOu6AQR5YCLPAY4g4WDKZ1D9hJIaDBvpIFGLmjv5oIL33A4DIz9IyZXdYFhi+s
         JXzg6KVC2c4qN48Ptewwi/LD1SfnsCouuw1X2gkQsw/Gxs+sHSMBjo0/CwmNAQjjGO2K
         2QvCl21+JZd7YQJpTCjX2AqtTgnErualFBiD+FZAiLhbSITfEJRtJjyCoVsgjoiII+V2
         yezQ==
X-Forwarded-Encrypted: i=1; AKwUvBw5DtS9TJ4G+3eS4M48GOf54jElCHVKgfobrnYEvG5F93CquYWQT9k/W5dEN+/J6Hl1fgC27KxrjQ==@vger.kernel.org
X-Gm-Message-State: AFuF++la77zeBTUnGpbbnvS/1+kheTGdCFeBNntjFH5LyHkKPYOD4RJt
	jytPAE+zg9FkAtqFsciEjAnA9l+OEbVu/iJghcJR6v6QF67opJjqVdSI8M9FmfBBi/M=
X-Gm-Gg: AYBFou2UudLhMG32mfPj4tyxLQmVxBKwZAtUOizso5LMoK1DQmKg6yqneSfPY4rTftE
	V/505VBzp+H/gSMT74+vh/m7ryVO5KmrfERCFqfKoSP4APdM9NGdnRkWDeCvepIycdwuM0Ultnc
	QnMY/8hWVsxECd83+9axVd2KgSsnQkOmjIkuUI5oqQB/kd7XQh4Jbh5038quLA29iecZbaFKuR8
	SsE1HUOWDMAzWfZDJUoQj4JnoxybzeUDnIsB8Z3a5ZPtIkDlQzJi57vI3nTy7yRebZIMhovevdH
	OLpzwnvCxHKcxMIqfDd8sqlBWtR9WdLOmmkjA/hjdKIe0M6TvZwC9aHL0tWoOihPHLdPza55qKB
	hK0sAx5biqVElqmUMXzzASlc9fQTytlUQOVCre4NwXEJmVgHWjBbxGmlKGC/Nt6Ww7oaCRu1m0P
	thuLKTlWkye0r8OA8uLNEIHnlNotzlc7jDIiHtSsr4dVHaBr+6et2SCLTwXcbY0aN3WYbiDaOwE
	rqiIvlJfq92Bc9HbQ==
X-Received: by 2002:a05:600c:198a:b0:49f:ce78:356c with SMTP id 5b1f17b1804b1-49fe67023femr268059845e9.29.1790677714116;
        Tue, 29 Sep 2026 03:28:34 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.93.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cfb479asm66579305e9.15.2026.09.29.03.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 03:28:33 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Subject: [PATCH v2 0/5] power: reset: syscon-reboot-mode: Add support for
 Rockchip RK3576 reboot modes
Date: Tue, 29 Sep 2026 14:28:17 +0400
Message-Id: <20260929-b4-rk3576-reboot-mode-v2-0-5a34ca72065a@flipper.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNTQ6CMBBGr0K6dkxpSwVX3sOwsHSQ8YeSaSUaw
 t0FPIDLl7zvfZOIyIRRHLNJMI4UKfQLqF0mmu7SXxHILyyUVFZWqgRngO+6OFhgdCEkeAaP4HU
 pDerKt9KIZTswtvTeuuf6x/HlbtikNbYaHcUU+LMdj/nq/fsYc5BgC1NaJ7XzJj+1DxoG5H2PS
 dTzPH8B4FNEVc4AAAA=
X-Change-ID: 20260928-b4-rk3576-reboot-mode-d3804e39df04
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Sebastian Reichel <sre@kernel.org>
Cc: Alexey Charkov <alchark@flipper.net>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Shawn Lin <shawn.lin@rock-chips.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2582; i=alchark@flipper.net;
 h=from:subject:message-id; bh=nD0jQ0sanXtfhte+cS4Eb6xgGbAdsdiqP+FoF7tBRHM=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTtnnSR24Hn36M+tdhN73vMn2dv5+A7vic1urqA+dy0K
 GUb2eCHHRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOsY4RAxenAEz1tRxGhkeGK8/VXUmyZrOYcDszYNPaNR82PKzOOuRe6b9XaZNouyHDH265n3t
 KDv94cDB6pZ1E28/UYKuKxnWzJsVOrauLnR14lR0A
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Rockchip RK3576 supports reboots with a specified boot device priority
mode, allowing one to override the board-defined strapping config and the
OTP programmed priority setting.

Supporting it requires several changes though:
- The boot mode request needs to be forwarded via TF-A to the boot ROM
  (upstream since TF-A commit 2a97ba20e901 ("feat(rk3576): forward any
  boot ROM boot mode request on reset"))
- Some power supplies need to be kept active across the reboot to prevent
  early boot code from running into a synchronous abort
- The magic values for each of the supported boot modes need to be defined
  for the OS to use

This series enables the above with the RK3576 EVB1 board as the example
user. Other boards will likely need a close to identical change to make
use of this functionality, but need testing.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
Changes in v2:
- Fixed a leak of the dynamically allocated syscon_rbm->supplies (Sashiko)
- Uninitialized access to supplies[].supply (Sashiko) is fixed separately in:
  https://lore.kernel.org/all/20260929-regulator-get-all-v1-1-e887c66a47f1@flipper.net/
- Link to v1: https://patch.msgid.link/20260928-b4-rk3576-reboot-mode-v1-0-65486b03bd41@flipper.net

To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
To: Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org

---
Alexey Charkov (5):
      dt-bindings: soc: rockchip: add boot ROM download boot mode
      dt-bindings: power: reset: syscon-reboot-mode: allow supplies
      power: reset: syscon-reboot-mode: enable supplies for the next stage
      arm64: dts: rockchip: add reboot-mode node to RK3576
      arm64: dts: rockchip: name the reboot mode supplies on RK3576 EVB1

 .../bindings/power/reset/syscon-reboot-mode.yaml   |  8 +++++
 arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts   | 16 +++++++++
 arch/arm64/boot/dts/rockchip/rk3576.dtsi           | 36 +++++++++++++++++++
 drivers/power/reset/syscon-reboot-mode.c           | 41 ++++++++++++++++++++++
 include/dt-bindings/soc/rockchip,boot-mode.h       |  2 ++
 5 files changed, 103 insertions(+)
---
base-commit: 6375e61c01e93e35ee7acd336a689ac1fae4b509
change-id: 20260928-b4-rk3576-reboot-mode-d3804e39df04

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

