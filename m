Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDBB450416;
	Wed, 23 Sep 2026 07:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148243; cv=none; b=GY2nO5Bv2ZU+TlIkbq4nj6jDQ8r+aPgAqGA6IC/CbzRYW1ZSbkDYKDhVP3ldhYOGzZ2BUQklANPS69mAfdI1K+wd0S/0/ie3hXXSeY6w7+OZpSmPtbfErfm8rfJnG+w9pBwB0QAqtXNyubsbPzOUy+PZD0GSYDjtZ03Ui+oc7kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148243; c=relaxed/simple;
	bh=UaqCiK5kR6zZ6YSdOk5LLGKaESwbOwE2p1co/yqpIaE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QR1RSwgtpMtDTBNghjLlPposIUF2NI4ZlhXJNkis1s3u/fHaC6Rg/oe8heU1wZ/3fp6jzevZmHtLKxmyra8gDGYIfFIsVXB1K5Slg3oEAy0MTEbxgnvE2ssYMBZ/qoIGFlgKpYhd30ECxLoGkNx4cp3O9wqOBCvZ2Y1R1+fKvlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOxOWS4O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOxOWS4O"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D6A4C2BCF5;
	Wed, 23 Sep 2026 07:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790148242;
	bh=UaqCiK5kR6zZ6YSdOk5LLGKaESwbOwE2p1co/yqpIaE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=vOxOWS4Op4dP16N4DFqIb8Evw5IBqQI4ghR/VezbaCftw1yeYZ5j9MI+ruhTAUvGg
	 9xWYZC4tSCAAjtW+cpS+m8OpRLT6p8w+TxGyjAawUwFPoxQC8dFsVHWjNE1GxpWFrs
	 fASoCXMwdmeQ7b/wxLvuSGthZw6OeB1zrf3HEhh1xIFFQXfiwpOiZPJWoKXGnKSMRy
	 h7Svh8JqT6QYwbzS1Ulo2zyEI/LXP8yCDyj+fAUIBHQFi4fTUTzovv1eFyCTFR4SP3
	 VHNXJhqri9Vvb9LG+qZfVtKWSAT4+QDP21C32j/O4n+jlwhvkp3CcqwNTBBsCtmqYu
	 Jx1DzekchIBuw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651D2C98302;
	Wed, 23 Sep 2026 07:24:02 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Subject: [PATCH 0/3] cpufreq: mediatek: add mt6572 support
Date: Wed, 23 Sep 2026 10:23:33 +0300
Message-Id: <20260923-6572-cpufreq-v1-0-41f7af6d6d1a@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMSw5AMBRA0a3IG2vSltZnK2JAvfIMfFpEIvauG
 J7BvRd4dIQeyugChwd5mqcAEUdghmbqkVEXDJJLzQuZMK0yycyyW4crU0KnSuQCdZJCSBaHls5
 vV9W//d6OaLb3Aff9AMBW/VNwAAAA
X-Change-ID: 20260923-6572-cpufreq-51645181e634
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Roman Vivchar <rva333@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790148240; l=937;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=UaqCiK5kR6zZ6YSdOk5LLGKaESwbOwE2p1co/yqpIaE=;
 b=Y9b3/MY3HkYmoYQloksip6ASc6JC/N8OjZn4qOGxEpd4xxnuaWshSYvG/SkvwRLC5uT+mWD+Z
 y5eumooGZ3FB7/lzch7c5LOl70VYE8jcnxejl0/AHVGdMaA46Vdc7Nh
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com

This series adds support for mt6572 SoC frequency scaling.

Since there are (at least) 3 variants of this SoC, first patch adds
support for CPU speedbin. This is also useful for mt67xx family, which
has a lot of SoCs where the only difference is CPU/GPU clock.

Tested on both mt6572m (1 GHz limit) and mt6572w (1.4 GHz).

Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
Roman Vivchar (3):
      cpufreq: mediatek: add support for CPU speedbin
      cpufreq: mediatek: add mt6572 support
      cpufreq: dt-platdev: block the driver from probing on MediaTek mt6572

 drivers/cpufreq/cpufreq-dt-platdev.c |  1 +
 drivers/cpufreq/mediatek-cpufreq.c   | 59 ++++++++++++++++++++++++++++++++++--
 2 files changed, 58 insertions(+), 2 deletions(-)
---
base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
change-id: 20260923-6572-cpufreq-51645181e634

Best regards,
--  
Roman Vivchar <rva333@protonmail.com>


