Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795341573;
	b=PQMNVZBqqUqp4d5/mhGcIHf3G7owk5Ou0RVVc5NvhrlVt9HQa21pe0K13K84vjVBcNI9
	 8oPaQFWUA/e9JK1iFyP9gkR2TdqOqfcvhlaNVYDAOjC9iGJSsIqETRNjkJXc+OL1Ry2Sh
	 Mx5HcwQGxEzH0WGbtBxXLEoNdaNEjdmvzDng9dKVrKr2YkAMQTAYwrVNKZcCLahVjBNhF
	 SeeAtH7yRycT+eq/LA5EhFIY+BP72mAtyouzWtzNt7kGXMU82Sey+OONMmryqfqrLQxar
	 vX3dv0ADsFKjjBIB7U+PHVDG+rmhtDSXC5pibnBJ4WzP+DMJUAcGic9CVGl0odLcAFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795341573;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8MeCAAjqoQjcpJhOdd3gfYW0bCsqsmcy6NjW9utaaGM=;
	b=o8/Tfse1mlSDtAMn3/P9PnYmHOd4DRSq9uRSwYFzodIU0o1c65TkwPjjkEXdYIyysGAL
	 yH3IGQqtPi33CzXw/0EnzErpDrQsViPoqPXpZO4fJB5y3B/Lquwp88fv7UG+mX8dpReIZ
	 QO334X1xZipDLYuuoWhZVUOuiDLF7qQ3FmjZDKBgPl05A0X7RBDbfAbraUU1zY6s7/dc7
	 7WHmDXBrkbj8SIB/TpTfRe+smx+GLbnCXvfwVU+dtgJcteTOooHMUXPhvVto14ALVy8CE
	 LrYu69Tx0m6eqgFxQUfxSWB9Xj32Nynzm2nW1BuqYdP/vHJ1q4ulfHVruL2aXz3Jp7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amarulasolutions.com;
	spf=pass smtp.mailfrom=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=NEnOOWwG;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A337606A32A
	for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 09:59:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A337606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=NEnOOWwG
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-492fcbfaa88so1393785f8f.3
        for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 01:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1795341571; x=1795946371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8MeCAAjqoQjcpJhOdd3gfYW0bCsqsmcy6NjW9utaaGM=;
        b=NEnOOWwGqHDW2nX9cVuBp5LrzYm41lhUtc9MJN1fdKEiOvW+8MXean1K6cynR39VXF
         HHa5uNGvU3M1NSYfxvHyzfKNtMZJ5GNQGXFISUYmveGuYk5X1kMeNLlwfWudW1oc2JqM
         HzY01fxoaITahBOq5PPAGnGnSxG22j+NPM9eM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795341571; x=1795946371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8MeCAAjqoQjcpJhOdd3gfYW0bCsqsmcy6NjW9utaaGM=;
        b=LAqDznfSDj71+uGP4lX9WMPbvPpzSRExJ76L+gAyAJVnzBuLyty1/3wqStEsAcqHft
         yFc7erc6I5eHwiUuEfLUE2rS1e5ImZIWvuJcsMiAXJP76FUrLhhQK2jdCjmISVKy1WPW
         0XN1HFOM57TWctX8qtyg+HDnD3nS7SBAi3RpudY9ImYSpG4snLt/nWOHuE969QwMtKnl
         eCZ4o3niRitFDm3lOAsXYuNoVDrsnRYVHgpmkQ+VOuikkIM3gvLdKR1k71lvjg9N5r9x
         d1zMhgIhyf1jtvp0tC+ikYKsVIBLfOk54RkPjU9yS1nBLaOZzn2FSUopbueV+36mtidf
         HCxw==
X-Forwarded-Encrypted: i=1; AL+hErGgfdTx4bc4XlMDdZl7fITP7zYtP1GhHhcQ0nmXwl3XXvaEkbZT4voz9LC/KRuVyBf0ce5aLrJHWg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/enw98P2CliBJPn5qAKpx1w5MsqA7ILQibkRnOMEpQJLjyXyeH
	oUgt6DzQ/D4MRhXa6dJ+GRlmV6CLCYB6ItyIcXZ7rhcOW6W4h7zIwLnfVb3j0Z9njXI=
X-Gm-Gg: AZFdTZdih+Bc+R2HJh9EoEb9S9VBRRzSdsLytFHfacGSBWAoDFCgLCWHUKDplMZiim/
	CNBnJZT5c+ue8nymFjoD+9Vx9oOp5NAd7VmI4entpCigGm4Faw+5svZKyplpo0FjaYw5WNiKmLU
	gNI7D2NykzUptxD3WrwPoNkJZxAxBbdJFvMUWWW0FnSlTphX/N4ck02O1OrqEkAkmQ3lzpAMAcP
	tC3sNzFfq3Os0fOmUTeJTTF7eTZNl77KsJ3azffIAstxFhmwrmedUQnNEYhxKlOigBeDsbvdqKf
	1NqBdkUoZoy0BngjsejDTja6HZaf/EY+YjOsGFDzuVLzzCudjszBBDwAskt89jqN92damHmm3nh
	qnCOZL7nl/Yj1kxWh4PlpbLCnesJ2hzxVNoKEK4Htf5jS4hYao6x2hgDEFYTWA0QblVL1S5ewJ2
	jV0rgAEkkUAZkz0tD+jZyiLsUr7Q7xNeMQ4DdRKppdIO0avYY/L6JAtGqa0oMf+bMJYoANpmPDc
	xSev8sKzaiHOZUj5pYxIyDyEsttzHsI8hU2HaFXUv3udbXbqSValZ2iVSl9YWob57PczH1rARwj
	NwV+ga/f6XW9ZxgALV5JbKmPHrglzK6UDZL7tZMhgl0d97aDij59c7EdrnV+ucvLq6O2RqGnEiy
	/qmcKEnG5l823KhLYITfzwycIKr0nx8OAuee5R6cV8gfSX4ZyPw5W5vmW7VCBRVn7ykxsjsvis5
	PTaWV/vaZLUGbUIsCBSCIcek0Sdg==
X-Received: by 2002:a05:600c:45d4:b0:4a2:84c:52f3 with SMTP id 5b1f17b1804b1-4bb8880988cmr185327855e9.6.1795341571496;
        Sun, 22 Nov 2026 01:59:31 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b7515sm342455265e9.13.2026.11.22.01.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 01:59:30 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: michael@amarulasolutions.com,
	linux-amarula@amarulasolutions.com,
	Lucas Stach <l.stach@pengutronix.de>,
	Peng Fan <peng.fan@nxp.com>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Fabio Estevam <festevam@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Jacky Bai <ping.bai@nxp.com>,
	Kees Cook <kees+treewide@kernel.org>,
	Marek Vasut <marex@denx.de>,
	Ming Qian <ming.qian@oss.nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Xu Yang <xu.yang_2@nxp.com>,
	bui duc phuc <phucduc.bui@gmail.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 0/4] pmdomain: imx: Keep the domains left on by the bootloader
Date: Sun, 22 Nov 2026 10:59:15 +0100
Message-ID: <20261122095927.2631909-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
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

The i.MX8M power domain drivers register all their domains as off.
A domain left on by the bootloader, e.g. to show a splash screen, is
then powered up again by its first consumer, which on the i.MX8MN
turns the display off and hangs the system.

This series reads the state of the domains from the hardware, so that
the ones left on are kept on until their consumers have probed.

The first patch fixes an error path of the blk-ctrl probe. The clocks
held by the last patch are released at sync_state, so they stay on
until all the consumers of the blk-ctrl have probed.

Tested on i.MX8MN (BSH SMM S2 PRO) and i.MX8MP (Engicam i.Core MX8M
Plus Fast Ethernet C.TOUCH 2.0).

Changes in v2:
- New patch
- Release the resources of the domains left on when the driver is
  removed
- Take the references once the probe can no longer be deferred
- Clear the boot-on state when the domain is powered off
- Release the references when the driver is removed
- Rebase on the changes of the previous patch

Dario Binacchi (4):
  pmdomain: imx8m-blk-ctrl: Remove the power notifier on probe failure
  pmdomain: imx: gpcv2: Keep the domains left on by the bootloader
  pmdomain: imx8m-blk-ctrl: Keep the domains left on by the bootloader
  pmdomain: imx8m-blk-ctrl: Hold boot-on domain clocks until sync_state

 drivers/pmdomain/imx/gpcv2.c          |  77 ++++++++++++++-
 drivers/pmdomain/imx/imx8m-blk-ctrl.c | 132 +++++++++++++++++++++++++-
 2 files changed, 204 insertions(+), 5 deletions(-)

---
base-commit: d0f871bfb831705d9f55479f5b2b40f636ea7b16
branch: imx-pmdomain-boot-on-v2

-- 
2.43.0

