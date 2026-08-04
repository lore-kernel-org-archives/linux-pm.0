Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86DC44E67C
	for <linux-pm@vger.kernel.org>; Tue,  4 Aug 2026 10:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785838483; cv=none; b=A0tx9FKsFsBhrjSfD3jvbSRGiObZPs6I1Jp0497x9JbL+OBTu6E36MgyQq3U68PD9aOFVSa+tSeQgClx9nTcmdpb4bIYVCo2hFzvqwezUrpvviCFtCIU9iG18dcGs6LVaVWXF3lgustrPiL9GAIEeUQUeMiU3t83aFnXdunIRxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785838483; c=relaxed/simple;
	bh=VXPAoIW83Gi8vWtsC4pBFBAvmVVdxni+SOUAWNR1d44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h0sOMtWGcj0p8tp4Nm6NnUXTAyzULy6pNIE57wxOvQot8jTjbuZp78wREViy1s0R5mWLmxBDEsOLoponTBLcsLTdaRAQYdDT0K8J9YfqwfMYW+GqRqcblPbUBypWYyxpkO2pEU9OgEXVDV3ONc0hZZsq0YTiiU4VdZuhTuJRv74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b=ulSPlOdj; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="ulSPlOdj"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so17650035e9.0
        for <linux-pm@vger.kernel.org>; Tue, 04 Aug 2026 03:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1785838480; x=1786443280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JgsWhoUDU2owmdTdKUwdWJEOQz43lQL+3XxnY2PyCXU=;
        b=ulSPlOdjYovJqadc5ZuPJp4our2JyyUBwzxf0Dm8+vy/ZVLD+fd5MVTs5r0YRg6xfE
         gTGXf4+P439TiFzUnOODxw3bSY9LuSrpLBeYZgfdPDMxDOfT4Fh7D1cVO5BjTR7CR3pG
         Ezr5q7DhZ3ndqW2E0LKCezOhUEAQkfOHrpZAoPQ1yYZbnC7xnk1SNyUXQHX8g88CK1Ii
         80T8Rpq9P8XyT6Q2WIXfUr5f9L4CIPKlOBLHwN3jKA0TB3Eeo6wdxGYKHpfikROai/q5
         isxNoQQp6b+tOF/moMu7+ZIFpw8lg1nrtkLsXKpwNW+JSVfzst/rYN9whpeDrOPZcmI9
         s8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785838480; x=1786443280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JgsWhoUDU2owmdTdKUwdWJEOQz43lQL+3XxnY2PyCXU=;
        b=czuu3X1Gp/M2MCQHniz6DKK0ytcnbDtsc6z6VLKYtkwqtHRr9Y7ElNDBMtp3aww7ra
         5AtnnzXfltHHJCA85zjw3VsdJK8thddKFgknMFHgoqAip6HVtBWIv7nblhiw3vuT5Uy/
         kwB3rm4EPEmwYxfy/P9xoyb29mjrimH6nHZcl/bfy+ETij4VUTG10fWgkvmx9zo/4FMd
         vhF2/5/UgXao84U9DcgqCVf5JL5u5EdQpaCNi2rZHvLm2WQJAqcVctMRakL7HclT7Quh
         iq4Ym3y5+CzWRnhGl8cQfNCF/MZM58P34jVumgQJbIyQVmiWnvXGCWp5VMMv/xirX2Qx
         TUPQ==
X-Gm-Message-State: AOJu0Yz+SZWIfXAkyapIXp0tgRw6p9TM2CxgIM8vT2mrfh4orjeWsY++
	mmYXLTRzE7al/g3AFRPYDbUpTJEwP89LiWPIr1hqdfP8GSot7F2hGON1WNT6wLeRQqeEVj4L9z5
	AN+3YvnUX
X-Gm-Gg: AR+sD10iCB6sGfM5LuhY+dhhw/YdQcXZ1ePhNMbXOBvQiiYA6/FjzdjDqrtbDRgnhGd
	oK4D9XFG6V47y0tE/ZF/PRdRKRK6ccxNY+8xALBQOo4CPXxYV+7NaDCLENLhxo2BfuWjkvvsq3n
	Uk/rrp4JPRdenooAt4CXeia53CZ9hkhLkgIMcirD2faTrueU/lva7y5kr5B3TxtG7HP01oyeZcZ
	sFUo88+QWUtOPh5/3lzhjckXqEXcLPJ2CoAWVIudP8hEY0CtG250x8b6CqE75DBXfOZgZf5gIzj
	sjxwrpvvZ5fxkHpLt6OiEd4jABcptrj0w3CdxqP226FeOswIkFNeaMw9/SSXJaiaSxCxftNrNs9
	JxgVA4NkS7+rdaUdT5iqm/2dQxEJSAB11U86WtNzOLg4DrO9heSgBBZ4Yk29k1KaU9LnX1GjCXB
	r0QAe4SzXXFJp9UH/tX2j5sRDJIwaAPF2z4rzxTisdOmGO0eZh9bI6mcDgeY3V4anP6lAJH4HyZ
	GK9W7M+fG23TEp2xHm5TuFXJ67k9GY5
X-Received: by 2002:a05:600c:5494:b0:493:bfad:9d99 with SMTP id 5b1f17b1804b1-4980c679d64mr312201035e9.13.1785838479939;
        Tue, 04 Aug 2026 03:14:39 -0700 (PDT)
Received: from horizon.localdomain ([216.128.28.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994a0f7bf4sm73248805e9.11.2026.08.04.03.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 03:14:39 -0700 (PDT)
From: Sean Rhodes <sean@starlabs.systems>
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Sean Rhodes <sean@starlabs.systems>,
	Evan Green <evgreen@chromium.org>,
	linux-kernel@vger.kernel.org,
	Xueqin Luo <luoxueqin@kylinos.cn>,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 0/4] PM: hibernate: encrypted snapshots under lockdown
Date: Tue,  4 Aug 2026 11:14:33 +0100
Message-ID: <cover.1785838445.git.sean@starlabs.systems>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1 was sent as an RFC. This version keeps TPM policy and seed unsealing in
early userspace, while the kernel encrypts and authenticates the uswsusp image
from a locked seed.

The stack adds the snapshot_seed ABI, permits the snapshot device under
lockdown only once encryption is enabled, documents the userspace flow, and
restricts lockdown-time block writes to the active encrypted snapshot
image/header path.

Changes in v2:
- Keep raw writes to active swap blocked under lockdown.
- Track encrypted snapshot bytes and header writes before allowing
  lockdown-time image writes.
- Only split the encrypted stream at the metadata boundary when a user key
  switch is used.
- Return -EFAULT for userspace copy failures.
- Document resume meta_size handling.

Tested on StarFighter MTL with a TPM-sealed seed: encrypted uswsusp
suspend/resume completed and restored the image. Also tested with lockdown
enabled through the encrypted snapshot device path.

Evan Green (1):
  PM: hibernate: add seed-wrapped encrypted snapshots

Sean Rhodes (3):
  PM: hibernate: permit encrypted snapshot device under lockdown
  PM: hibernate: document encrypted snapshot seed ABI
  PM: hibernate: harden encrypted snapshot write path

 Documentation/ABI/testing/sysfs-power   |  14 +
 Documentation/power/userland-swsusp.rst |  20 +
 block/fops.c                            |  55 +-
 include/linux/suspend.h                 |  22 +
 include/linux/swap.h                    |  16 +
 include/uapi/linux/suspend_ioctls.h     |  31 +-
 kernel/power/Kconfig                    |  15 +
 kernel/power/Makefile                   |   1 +
 kernel/power/hibernate.c                |  32 +
 kernel/power/power.h                    |   4 +
 kernel/power/snapenc.c                  | 940 ++++++++++++++++++++++++
 kernel/power/snapshot.c                 |   5 +
 kernel/power/swap.c                     |  98 +++
 kernel/power/user.c                     | 247 ++++++-
 kernel/power/user.h                     | 151 ++++
 mm/swapfile.c                           |  32 +
 16 files changed, 1651 insertions(+), 32 deletions(-)
 create mode 100644 kernel/power/snapenc.c
 create mode 100644 kernel/power/user.h

