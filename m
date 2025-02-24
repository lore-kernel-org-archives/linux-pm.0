Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492CA26280C;
	Mon, 24 Feb 2025 17:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740418488; cv=none; b=TzTbQWkkcnODNIhjsTOddNl+NdvT1LM2bYYEjfh8VcpdjBXuQlbyF7OET3nEhbvbogVfscuK3mRw+9tg4yqIJEPGQrTcL11lmEAdxsjJuyrOl4t8gld1oyV8azKqUhHC8mm17mAxUp1QjD39IBOiDhXR7JhN60RKAsWLk881mmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740418488; c=relaxed/simple;
	bh=edUuCxZmNUmLsPyfgUJoQW+TCJ/+pdgsueE2Hpek9Bk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bYc6gYfSSOpkVbooiPXLzX56njCBsGL7cUqKy+0fmYUWgB874+6rGhLREZ47olsjuF+VRZa/obINELUm6I5KHCBDAYXPqXj+CUoESKcI11ROe12HHnnh6hQ4rtJR+it0Whl2HIYqiuviUlGFYzPRajuIVtD+S6LxhzgrG8FaXfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EF52152B;
	Mon, 24 Feb 2025 09:35:02 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.65.109])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AA1353F5A1;
	Mon, 24 Feb 2025 09:34:43 -0800 (PST)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael@kernel.org,
	daniel.lezcano@linaro.org
Cc: lukasz.luba@arm.com,
	rui.zhang@intel.com,
	srinivas.pandruvada@linux.intel.com
Subject: [PATCH 0/4] Thermal: clean-up with kcalloc()
Date: Mon, 24 Feb 2025 17:33:02 +0000
Message-ID: <20250224173432.1946070-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This is just small clean-up inspired by this patch [1].
It aims to keep the thermal framework up-to-date with the
recommendations in the community [2]. If there are (or will be)
some static checks in this area, we will be OK.

The patches are on top of latest thermal/linux-next branch

Regards,
Lukasz Luba

[1] https://lore.kernel.org/lkml/20250222-thermal_kcalloc-v1-1-9f7a747fbed7@ethancedwards.com/
[2] https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments

Lukasz Luba (4):
  thermal: OF: Use kcalloc() instead of kzalloc() with multiplication
  thermal: k3_j72xx_bandgap: Use kcalloc() instead of kzalloc()
  thermal: int340x: Use kcalloc() instead of kzalloc() with
    multiplication
  thermal: hisi: Use kcalloc() instead of kzalloc() with multiplication

 drivers/thermal/hisi_thermal.c                               | 4 ++--
 drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c | 4 ++--
 drivers/thermal/k3_j72xx_bandgap.c                           | 4 ++--
 drivers/thermal/thermal_of.c                                 | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.48.1

