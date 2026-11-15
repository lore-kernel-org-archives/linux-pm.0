Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794740926;
	b=syxxygxMnG5VMfJKLVGeDTvArinD6mQrN56i9WjCXuAsdoM7qHATh+y9pLmtDGWANwqi
	 TSVEGl3lHDzaZM8qLFi0MVXOsyMj1FU5Bcd/rYi1juUrjF4QeoQ3H66BwaxQzVOM1QWSj
	 CfWFQqdd+fUOneQ7MvYo+2xBBVwVw4q9vqtRry9yhKKwmZeIomH5LLzlSmVG9M/M36OZD
	 cjS27XVUWu9MRaWkxRvoh3A0iC3SW5UvR1IelR3y4Ox5tKAPS+6ZoqFheZlJSQgMh5Que
	 rpNwUNA2C3tyKfsuAXpnNfQZR2Nl1LSOYff9StShHHEfD2LXykAsuFq53iMeFpvHjrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794740926;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=88w6QzEJLCb8lOBnvjJq8KpuEJV6ibY/O1xw29xF2wI=;
	b=h/wwvqRK8+BhgtBrvKW4pwW69U6wCVb5EhMc1J0x/BTb9fkwnrmAChCbSQbR4r+Lj4Ov
	 8R+DBrcPlKCXbg8knKicHqJSV/z6iv26XXoTbT9zl8HND8jOJM0Apr6JphyFKm2CFhisc
	 XooQy3VD4krRNmCyqTaTipmo4ZKlofjA0sw3SQ3B/1tCQNHmEQb0jnW/ZFPMzbi6Ki9UM
	 hVSb4HnnoigAXF14L5HRgPf6PwCxBGdbOS5FIVjELo54aeX+2QOnHlWqQnuSOgscXtkZc
	 himsD0RfQbpZESSIZ4itunCzBKc8ytOLkuT8Scdf6VHJkwK6nUD/Oxkm5iFQx/fUw+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="h/ltmBfH";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17537606A31F;
	Sun, 15 Nov 2026 11:08:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17537606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=h/ltmBfH
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C5FF497;
	Sun, 15 Nov 2026 03:08:41 -0800 (PST)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C6393F632;
	Sun, 15 Nov 2026 03:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794740924; bh=KhEeNemkEpavm37chizGaegKBBqImS4b67JG9WiRUc0=;
	h=From:To:Cc:Subject:Date:From;
	b=h/ltmBfH5qRqUrpDLciy1QrMBFsmAB9s06AjHF7OcoCf3y1x3JD/RfpmCxrBQQClS
	 D2Aq5M1Eih6bqh+RyyPI7K8rXY7i5hwq2otIb1zyklO13KA7YwM5695so3KpYwTKM6
	 MOR52TSRRHvgV2UVJdSJjny/XMUSOqMhkg1aM+NQ=
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	arm-scmi@vger.kernel.org
Cc: sudeep.holla@kernel.org,
	philip.radford@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 0/3] SCMI Powercap zones processing fixes
Date: Sun, 15 Nov 2026 11:05:43 +0000
Message-ID: <20261115110546.2344308-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.54.0
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

Hi,

A tiny series of fixes around SCMI Powercap hierarchy-scanning logic to
address a number of issues reported by Sashiko.

Patch 1/2 is really a repost to an alreday reviewed fix, included here
simply to avoid conflicts.

Patch 2/3 provides the fixes around the logic used by the SCMI Powercap
driver to validate the hierarchy of zones provided by the SCMI platform
firmware: these are applied first to the original code to ease
backporting.

Patch 3/3 simplifies the code above by refactoring using cleanup handlers.

Based on v7.4-rc2.

Thanks,
Cristian

Cristian Marussi (2):
  powercap: arm_scmi: Reject zones hierarchy containing cycles or holes
  powercap: arm_scmi: Refactor scmi_zones_register error path

Guangshuo Li (1):
  powercap: arm_scmi: Fix potential stale zones after a skipped leaf

 drivers/powercap/arm_scmi_powercap.c | 42 +++++++++++++++++++---------
 1 file changed, 29 insertions(+), 13 deletions(-)

-- 
2.54.0

