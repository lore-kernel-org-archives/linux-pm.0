Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04C93B7751
	for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2026 16:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776185385; cv=none; b=erox82XGsx45t0qLHRHsS5mqvV5QR6pYpCG3Hbdo6NalxlLcxM8OMyrJIN5dI1hQ3w+bZe8DCxYqb+fy8PzgaHvtWQ03/YGasGJPux1R9N/HhQ0VLG3CDJeC17ij76cwrMbbYfkOKKRCYQ2xCx/qY5PQ5DW5wQFjf+u0wmHHMS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776185385; c=relaxed/simple;
	bh=XBjaBOxaANUQPaoOgpKdNyGLhamYxMVPpz2BcJFyE5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d7pkZ7GaF3YRi2wcbBHBlJOPoZbwT7e3hJMfSGuzO1xAaO25FajG5c/Td3c4iIiqWlMOxs5fq/eAUhG05WIo2OJS1ugH86MF/q9MKD/6V+2UnihZl87OhocYP/9GEPR5zu4BMBZSMI4/mCxwPg4YQDrDcDJO+aaDtkJRuv3sWsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntR/75Dm; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntR/75Dm"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b467d03d57so1651975ad.0
        for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2026 09:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776185383; x=1776790183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUoYKq79bxvjyxgdJrulHpNt50LqCWweYqk4dEJlv4E=;
        b=ntR/75DmI+HELpvMDzcDvAICfeCIDZ19RYWe+72xfbVhR+uDN40uA6y8t+r+x5NsGS
         L8P4RSm5UTzpUGsJ/kYtg6JdpGn+BDItZMHfcJ6XLEULvzuJ12Zi3GRhgQ9Tyq26yK5P
         88YS5g/ZP0A3apWqPqY6RU75gB2EvbesOsvK21jShfQzsF/xExhU4TKcHcomFucW6gSf
         pvSTFBHqI6X6srhTJRcpK5QcGGv11Jeeac75NO+KRzVY3hzJy74JJe6GeQZFzVOAaKrH
         KyDecIM1X3sLeGP6emcvYyUeunzYqi1ECQB8wFtvj4TCbOtYv/NbxU2lEA1XGQ2lvW3S
         CpUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776185383; x=1776790183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FUoYKq79bxvjyxgdJrulHpNt50LqCWweYqk4dEJlv4E=;
        b=oFewQbxkrKGiYUoj3yu3MNnvygrjdpnBKl8Ux9kr/quBs5CKvNrxMRLd7qsNsurAaD
         fCHsfO5VVAS97owgFf46NUVJt4QNBMvXN1YCVJK+4BxzORS5cspLtkaRFA8RKy3r+yxH
         gSuXtGi1FuEerPvUaFWcNsXtDKMurduIAmjWQqe0Kyod6hfKVfH5QnHneY++IR5bzQXb
         w2mrcAQtV5khcBstgHD/o0HOz9+hTePolF6mH3Uk/J83K17reJM4a8O/5DFQGhTJrGgG
         MXMsDqopsf/ca+bPJcu5mClAJf+PliLbrSdBnGZsqySo7BD5LTPTXahTV6MFxx2Sum/q
         HL0g==
X-Forwarded-Encrypted: i=1; AFNElJ/FAogUOnNdGKkkTt4f4a3YtZDvgjKyHxASouKCurcczXTo8kXRfVYD76sHpzXEToxOZQpLPiSTWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzoGAykBOycN4yJ3q/lj/kTKuynLt+1YK9nZ0wa/3sWvu9+wkBr
	DYNkHkIcC1SJNI0I3OMcVqG+via7/sq+2Hp8oAbrFc7JKuX0F2TzT0b/
X-Gm-Gg: AeBDiestxw7vCc5lj2HKer0D17dk9yWfypPkh9aJt5Dw+ZiATI8KVvbstnRHsm8TYZt
	zdREADZTIYmDcLGIhS6CXwYPEa7vqmGDgf0yr58EJSX+3xqsFPoKHh/b5OCWAE+RjJBxwEi6j0u
	jrjkXl/nSXHDXu+aK6v6YM9cgj7mkUbMA0zOe7LU6gqJiPoz7xaf+35tgo98/XqjiCQV+QyvZ15
	DJcZSvH65dX2zP/7E6v3SJ9V5rHV0T00kROuU5Xp7ZKydMQa5+shN7Oj5AnEF1PK2ezU7hZyYtu
	pbW/iI0gpYElAPd0Y1fWWSbm2Wy6Y8SEPrbG/H9rXtoRvfFJRiwkXmMpuwrSOz636lJ+TfnEORd
	kVTztetTUm4wfgO2kKohtVvzSz3bqPnR4b/NobgJrK/+xr7lNaShhW7JRIz6sRRasc4ukZ7+6aD
	IyGhMuYl1V3tnyEw7F
X-Received: by 2002:a17:903:faf:b0:2ae:3f3f:67c4 with SMTP id d9443c01a7336-2b2d580f23cmr111214755ad.0.1776185383117;
        Tue, 14 Apr 2026 09:49:43 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4dabca4sm153358325ad.15.2026.04.14.09.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 09:49:42 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Youngjun Park <youngjun.park@lge.com>,
	Kairui Song <kasong@tencent.com>,
	Chris Li <chrisl@kernel.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	linux-mm@kvack.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH v2] PM: hibernate: keep existing uswsusp swap pin if re-selection fails
Date: Wed, 15 Apr 2026 01:49:36 +0900
Message-ID: <20260414164937.1363887-1-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260414143200.1267932-1-charsyam@gmail.com>
References: <20260414143200.1267932-1-charsyam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 5b2b0c6e4577 ("mm/swap, PM: hibernate: fix swapoff race in
uswsusp by pinning swap device") introduced SWP_HIBERNATION so that
the swap area selected through /dev/snapshot remains protected against
swapoff() for the lifetime of the uswsusp session.

When user space issues SNAPSHOT_SET_SWAP_AREA again,
snapshot_set_swap_area() currently drops the old pin before attempting
to pin the new swap area.  If the new selection fails, the ioctl
returns an error and user space is expected to abort the session.
However, preserving the existing pin in that case makes the kernel
side more robust against a failed re-selection, while keeping the
existing userspace-visible behavior unchanged.

Implement this with the existing swap helpers:

  - look up the requested swap area first
  - treat re-selecting the already pinned area as a no-op
  - pin the new area before unpinning the old one
  - leave the existing pin in place if the new pin attempt fails

This keeps the hibernation session protected against swapoff() until
/dev/snapshot is closed, even after a failed attempt to switch to a
different swap area.

Suggested-by: Youngjun Park <youngjun.park@lge.com>
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
Notes (not part of the commit, stripped by git am):

Changes in v2:
  - Drop Fixes: and Cc: stable; reframe as a hardening improvement
    rather than a regression fix, per Youngjun's feedback that the
    current behavior is intentional and there is no concrete
    user-observable harm.
  - Drop the new repin_hibernation_swap_type() helper. Rework
    snapshot_set_swap_area() in place using the existing find / pin /
    unpin helpers as Youngjun suggested; the change now touches only
    kernel/power/user.c and adds no new API.
  - Update the subject and commit log accordingly.
  - Add Suggested-by: trailer.

v1: https://lore.kernel.org/lkml/20260414143200.1267932-1-charsyam@gmail.com/

Baseline
--------
This patch is generated against linux-next at commit 5b2b0c6e4577
("mm/swap, PM: hibernate: fix swapoff race in uswsusp by pinning swap
device"). Mainline does not yet carry that commit, and neither the
helpers used here (find/pin/unpin_hibernation_swap_type) nor the code
site this patch modifies exist there. The base-commit trailer at the
bottom of the mbox records the exact commit.

Testing
-------
The behavior change can be exercised entirely through the
/dev/snapshot ioctl path; no actual hibernation cycle is required.
A targeted assertion test is below; run it as root in a throwaway VM
with two active swap block devices and one non-swap block device
(three arguments).

Run inside a VM on linux-next at 5b2b0c6e4577 with this patch applied:

  step1: pinned active swap /dev/vda
  step2: swapoff blocked with EBUSY while pin is held
  step3: repinned active swap to /dev/vdb
  step4: swapoff(/dev/vda) succeeded after repinning away
  step5: repinned swap is blocked with EBUSY
  step6: bogus SNAPSHOT_SET_SWAP_AREA failed as expected: No such device
  step7: swapoff(/dev/vdb) is still blocked with EBUSY
  result: pin preserved across failed re-set (hardened behavior)
  step8: swapoff succeeded after closing /dev/snapshot

Without the patch, step7 instead reports
  swapoff(/dev/vdb) succeeded after failed re-set
because the old pin had been released before the failed pin attempt.

What the assertion test covers:
  - SWP_HIBERNATION is enforced against swapoff (step2, step5);
  - the success path moves the pin from one active swap to another
    (step3, step4, step5);
  - a failed re-selection preserves the existing pin (step6, step7);
  - the pin lifetime ends on /dev/snapshot close (step8).

What it does not cover:
  - the snapshot_open(O_RDONLY) initial resume-device pin path;
  - the full suspend-to-disk image create/restore flow;
  - concurrent swapoff racing against SNAPSHOT_SET_SWAP_AREA;
  - the type == data->swap idempotent branch (not externally
    observable since it intentionally skips the bit toggle).

A normal sysfs-based suspend-to-disk cycle continues to work; the
find_hibernation_swap_type() / pin / unpin paths themselves are
unchanged. Build tested with allmodconfig and run-tested with
CONFIG_PROVE_LOCKING=y and CONFIG_KASAN=y. The VM was booted with
oops=panic panic=-1 so any WARN/Oops/BUG would have halted the run;
the full test completed cleanly with no kernel log diagnostics.

Reproducer (C source, for reference only -- not added to the tree):

 // SPDX-License-Identifier: GPL-2.0
 /*
  * Reproduce / verify the SNAPSHOT_SET_SWAP_AREA pin-lifetime behavior.
  *
  * Run only inside a throwaway VM. The test manipulates swap state and
  * leaves the target swap area disabled on success.
  *
  * Usage:
  *   ./uswsusp_swapoff_repro <active-swap-1> <active-swap-2> <bogus-blk>
  *
  * Exit codes:
  *   0 = expected (hardened) behavior: pin preserved across failed re-set
  *   1 = old behavior: pin dropped on failed re-set
  *   2 = setup error / inconclusive
  */

 #define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <linux/types.h>
 #include <linux/suspend_ioctls.h>
 #include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <sys/ioctl.h>
 #include <sys/stat.h>
 #include <sys/swap.h>
 #include <sys/sysmacros.h>
 #include <unistd.h>

 static int encode_dev(dev_t dev)
 {
 	unsigned int major_num = major(dev);
 	unsigned int minor_num = minor(dev);

 	/* Match new_encode_dev() / new_decode_dev() in the kernel. */
 	return (major_num & 0xfff) << 8 |
 	       (minor_num & 0xff) |
 	       ((minor_num & ~0xff) << 12);
 }

 static int get_block_dev(const char *path, dev_t *dev)
 {
 	struct stat st;

 	if (stat(path, &st) < 0) {
 		fprintf(stderr, "stat(%s): %s\n", path, strerror(errno));
 		return -errno;
 	}
 	if (!S_ISBLK(st.st_mode)) {
 		fprintf(stderr, "%s is not a block device\n", path);
 		return -EINVAL;
 	}
 	*dev = st.st_rdev;
 	return 0;
 }

 static int snapshot_set_swap_area(int fd, dev_t dev, long long offset)
 {
 	struct resume_swap_area area = {
 		.offset = offset,
 		.dev = encode_dev(dev),
 	};

 	if (ioctl(fd, SNAPSHOT_SET_SWAP_AREA, &area) < 0)
 		return -errno;
 	return 0;
 }

 int main(int argc, char **argv)
 {
 	const char *p1, *p2, *pb;
 	dev_t d1, d2, db;
 	int fd, ret;
 	bool buggy = false;

 	if (argc != 4) {
 		fprintf(stderr,
 			"usage: %s <swap1> <swap2> <bogus>\n", argv[0]);
 		return 2;
 	}
 	if (geteuid() != 0) {
 		fprintf(stderr, "must run as root\n");
 		return 2;
 	}
 	p1 = argv[1]; p2 = argv[2]; pb = argv[3];

 	if (get_block_dev(p1, &d1) < 0 ||
 	    get_block_dev(p2, &d2) < 0 ||
 	    get_block_dev(pb, &db) < 0)
 		return 2;

 	fd = open("/dev/snapshot", O_WRONLY);
 	if (fd < 0) {
 		fprintf(stderr, "open(/dev/snapshot): %s\n", strerror(errno));
 		return 2;
 	}

 	ret = snapshot_set_swap_area(fd, d1, 0);
 	if (ret < 0) { fprintf(stderr, "step1: %s\n", strerror(-ret)); goto setup_err; }
 	printf("step1: pinned active swap %s\n", p1);

 	if (swapoff(p1) == 0) {
 		fprintf(stderr, "step2: swapoff unexpectedly succeeded\n");
 		close(fd); return 1;
 	}
 	if (errno != EBUSY) {
 		fprintf(stderr, "step2: expected EBUSY, got %s\n", strerror(errno));
 		goto setup_err;
 	}
 	printf("step2: swapoff blocked with EBUSY while pin is held\n");

 	ret = snapshot_set_swap_area(fd, d2, 0);
 	if (ret < 0) { fprintf(stderr, "step3: %s\n", strerror(-ret)); goto setup_err; }
 	printf("step3: repinned active swap to %s\n", p2);

 	if (swapoff(p1) < 0) {
 		fprintf(stderr, "step4: swapoff(%s): %s\n", p1, strerror(errno));
 		goto setup_err;
 	}
 	printf("step4: swapoff(%s) succeeded after repinning away\n", p1);

 	if (swapoff(p2) == 0) {
 		fprintf(stderr, "step5: swapoff unexpectedly succeeded\n");
 		close(fd); return 1;
 	}
 	if (errno != EBUSY) {
 		fprintf(stderr, "step5: expected EBUSY, got %s\n", strerror(errno));
 		goto setup_err;
 	}
 	printf("step5: repinned swap is blocked with EBUSY\n");

 	ret = snapshot_set_swap_area(fd, db, 0);
 	if (!ret) {
 		fprintf(stderr, "step6: bogus unexpectedly succeeded\n");
 		goto setup_err;
 	}
 	printf("step6: bogus SNAPSHOT_SET_SWAP_AREA failed as expected: %s\n",
 	       strerror(-ret));

 	if (swapoff(p2) == 0) {
 		printf("step7: swapoff(%s) succeeded after failed re-set\n", p2);
 		printf("result: pin was dropped on failure (old behavior)\n");
 		buggy = true;
 	} else if (errno == EBUSY) {
 		printf("step7: swapoff(%s) is still blocked with EBUSY\n", p2);
 		printf("result: pin preserved across failed re-set (hardened behavior)\n");
 	} else {
 		fprintf(stderr, "step7: unexpected: %s\n", strerror(errno));
 		goto setup_err;
 	}

 	close(fd);
 	if (!buggy) {
 		if (swapoff(p2) < 0) {
 			fprintf(stderr, "step8: swapoff(%s): %s\n", p2, strerror(errno));
 			return 2;
 		}
 		printf("step8: swapoff succeeded after closing /dev/snapshot\n");
 	}
 	printf("note: re-enable with `swapon %s` and `swapon %s`\n", p1, p2);
 	return buggy ? 1 : 0;

 setup_err:
 	close(fd);
 	return 2;
 }

 kernel/power/user.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/kernel/power/user.c b/kernel/power/user.c
index 4406f5644a56..e1ab85db2e95 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -218,6 +218,7 @@ static int snapshot_set_swap_area(struct snapshot_data *data,
 {
 	sector_t offset;
 	dev_t swdev;
+	int type, swap;
 
 	if (swsusp_swap_in_use())
 		return -EPERM;
@@ -239,18 +240,34 @@ static int snapshot_set_swap_area(struct snapshot_data *data,
 	}
 
 	/*
-	 * Unpin the swap device if a swap area was already
-	 * set by SNAPSHOT_SET_SWAP_AREA.
+	 * User space encodes device types as two-byte values, so we need to
+	 * recode them.
 	 */
-	unpin_hibernation_swap_type(data->swap);
+	type = find_hibernation_swap_type(swdev, offset);
+	if (type < 0)
+		return swdev ? -ENODEV : -EINVAL;
 
-	/*
-	 * User space encodes device types as two-byte values,
-	 * so we need to recode them
-	 */
-	data->swap = pin_hibernation_swap_type(swdev, offset);
-	if (data->swap < 0)
+	if (type == data->swap) {
+		/*
+		 * Re-selecting the already pinned swap area is a no-op.
+		 * Keep the existing pin and just refresh the cached device id.
+		 */
+		data->dev = swdev;
+		return 0;
+	}
+
+	swap = pin_hibernation_swap_type(swdev, offset);
+	if (swap < 0) {
+		/*
+		 * Preserve the existing pin on failure.  This can happen if the
+		 * target swap area disappears before pinning, or via the
+		 * defensive -EBUSY path in pin_hibernation_swap_type().
+		 */
 		return swdev ? -ENODEV : -EINVAL;
+	}
+
+	unpin_hibernation_swap_type(data->swap);
+	data->swap = swap;
 	data->dev = swdev;
 	return 0;
 }

base-commit: 5b2b0c6e457765adbe96fb2d464ff1bcd3d72158
-- 
2.43.0

