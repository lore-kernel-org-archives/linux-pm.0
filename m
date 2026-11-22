Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795380708;
	b=ZvU0tuAIeRH6LqICqAM7sy2GbAj6D2uGaTyDF6YgUQbSd1WNAi5EjhGRnI4uYYEIAW6h
	 q7KWz39fP+zeeW3C4hDPq3VxH4bppeKD+oFBb42VibkitIJJUiILAATT63lzREgP1N1N9
	 HnDutgQTmwgdyhtddAbyRZcFSFSJY9ATx2SPU/puOzx/gs/AFYWAZfaj/P0A3FThJQchS
	 FIrR9KaoPFpiuBLcr4u90JQDL7usmtC5VbW93VYyOPcxqsPYhfKe6/DFczCdI1BzOWdi4
	 Y7cLssi73oFr6cAzurPYxghEy2wPtOy82IlRi7n1Bh/BTKtgawgMSSWrq8vTA95vlMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795380708;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DKG2CDpDJjCN3w8GhTWY2Le/K5MhPR+ZkRtKO6JJCzc=;
	b=1a7vwTfUwMOjDsUiEQ08D7PV9LmKH/II+aHP+mbANEN+DtFbV07PixwWky8ObXN/SfzS
	 fD+cQyDbiBdl21WYXgujLN6rvuts/QKBsugIiW1Ob/ab/LFt4IwV8NXwAQQzpKov18xVz
	 yZqAkVJPfv9cOxlYimARXCu35INT8R5EptxTBDG7X/yHHvQTWosaiTXYVS8xUfiU7694r
	 7m6jKASbg1dgQTaXTOYi1Nk9i2vV1K0HMz4XXEEFf0IDor94ifqzn57gZwNaJ/GDQWtuR
	 YhzRVBgveAhCjKkVxTigaGlOxtWXV1PwO9Q4N9TqLlzmqimzRkJMEAc8v940XqhX9cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amarulasolutions.com;
	spf=pass smtp.mailfrom=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=L2Y9n3+u;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BF1606A688
	for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 20:51:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98BF1606A688
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=L2Y9n3+u
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so2580586f8f.1
        for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 12:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1795380700; x=1795985500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DKG2CDpDJjCN3w8GhTWY2Le/K5MhPR+ZkRtKO6JJCzc=;
        b=L2Y9n3+utoQBKMDPIftPGwr0yTls4Snp66G2YJbJbIxoJc6rpYv1gZhwLYo32SEF6k
         7EjU36If1kk4PIB5UkMhoohqIcX11Y5OMdqjHfjWt7owfNp6xUwyCeYFw9LtqJ3OJIbI
         B0cx7Lv3q6e++h1geg/EZm6exoMHFv64W1E5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795380700; x=1795985500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DKG2CDpDJjCN3w8GhTWY2Le/K5MhPR+ZkRtKO6JJCzc=;
        b=pfLTRpTcIxVomlOOlJYRp5tJUf7r4MPTJxZHuVhSZ6AnXL21ewzi1tRVPAiw+a/+W3
         +SUmMiqp1RVlGJBKddwb97taX+aV630kL5e51owfZxebtjt4tZbIpUkfTui2INqbX5f7
         h43SThfaQKfp3PM0MuO56NzfHkow7DpvalMowJY9FEj2CIKLR3BQb005pEr6uGrBL9n6
         /RAJX432Wd82NXPiL4jBSsEVEIPzMd5HOE/LyXGAPQZmptxTekQ8EXnCwzhWacnBTFHV
         TRStj7Kd/XZPyitdvS6LdXXwirHTR4JBbeiiPGDj0peLJ3r//ctre1aZ24AbgkPlftEv
         /RSg==
X-Forwarded-Encrypted: i=1; AL+hErEKwypbz0CFTwCc0YdhOIYrANLnyCjonpG1QggmFhKhAzDMGAR2Yq4KC6gnB1Qiy+CEYslbQl480A==@vger.kernel.org
X-Gm-Message-State: APuU4Z8zCFF5J7aBMXPS184QgsovDWZBsCXu/+qQnAJmeoIOPcoe5o6L
	GnfhQGqSsDU6zDYlA9nXYNf0Jzr50XZHgQ0FEJHzseiNJERFzYZb/vA21kDcGQSv4Ug=
X-Gm-Gg: AZFdTZesykjr48srM8S7owdJdckVgc/JvEF7oyRic/biPxCSweS3jzEQE02a3ykvobt
	w9jEkzJuXbnvY7REapvmlU2PRdh4IXO/KHREWrGK52et/AL5w7sBU0y6zRA3k2Gz7Y/xnnLzf57
	sMFEFq2xsq+PMofjlj9tuuNt29ZtGswaAEz8YPfhQYfKI9YLvsTzkOe2kUzyeGeOu0pcBn1nAcC
	bAQrrzRLFLJE8zSXllHJorzjiESjkulgO7H3QNZlye2TsnY3eDPsC/5ZHPtpl5ku2uwTCoxfUme
	z+JpEd0oY7jEtN2IURbBO2uLPn3RaXk0YeXtU9q4CHcHGjTWte9rW7qaW+isZYI6WngKY1LcOxn
	5S8tER6hPu8SXzZTcmYc9RAc5Vkn6sL2GFLSKKX6FxoIzsgqlLDxOvIwA/kLutDzxNRIenwIgyN
	jwCrBFh0Hp8MPLVj0n+OR4kkgLifp4JmU2i6Xy4l1If7yl0vvvOin6piV2wYja8jZlKZpsrp6yr
	1iTAxowcJH9q7bKHpTG5q6PmubixOYw+UicSE13RMuIlJXDtwisLQWgtaos0zXnE9cWnc2oI45P
	NSqxBB2W3Oo1/SI/9If5Cf25BGeIml0sBb7Y5oR5au4Rh8NQMJVP0uAcZ1nVF0U0MPrwulDdHFI
	ljArVLrYxFdOSlmwLnZWU7CsF1xuIe2ZuRgpWCTmUlp43ZXKQFF340XU+SPnHC5ofuXmzS1H0Kn
	0gN945XtiQ99cjxUdwQ/KMZZM+Lg==
X-Received: by 2002:a05:600c:34d0:b0:4bb:6a5a:7839 with SMTP id 5b1f17b1804b1-4bb889428eamr194057365e9.34.1795380699930;
        Sun, 22 Nov 2026 12:51:39 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b7515sm397355305e9.13.2026.11.22.12.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 12:51:39 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Lucas Stach <l.stach@pengutronix.de>,
	linux-amarula@amarulasolutions.com,
	michael@amarulasolutions.com,
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
Subject: [PATCH v4 0/4] pmdomain: imx: Keep the domains left on by the bootloader
Date: Sun, 22 Nov 2026 21:51:09 +0100
Message-ID: <20261122205136.138173-1-dario.binacchi@amarulasolutions.com>
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

Tested on i.MX8MN (BSH SMM S2 PRO).

Changes in v4:
- Register the power notifier before powering up the bus domain

Changes in v3:
- Add Reported-by and Closes tags
- Drop the runtime PM reference synchronously in the probe error path
- Keep the bus domain on while the state of the domains is read
- Remove the domains before releasing their boot-on references

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

 drivers/pmdomain/imx/gpcv2.c          |  77 ++++++++++++-
 drivers/pmdomain/imx/imx8m-blk-ctrl.c | 156 ++++++++++++++++++++++++--
 2 files changed, 223 insertions(+), 10 deletions(-)

---
base-commit: d0f871bfb831705d9f55479f5b2b40f636ea7b16
branch: imx-pmdomain-boot-on-v4

-- 
2.43.0

