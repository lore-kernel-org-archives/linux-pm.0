Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11D6524AED
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 13:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789651599; cv=none; b=sc0HAZ5PvGOboowLeooVWznR2tUavkw/x/4iiBE/J6FW/2j9CX1uDhAOkxy+A+h7ehTJfO+V9bNWff3GvtQI+4CSQKUUAWHgQaXq61ckcxQfAQZ9bUMe2v/czJ5jWyFdFJwlOfYwrRQ8nHDYHg2mdEBDedfZIj7+jBwK0VxE5p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789651599; c=relaxed/simple;
	bh=j9N1F68A+nbLgU/fzy1bw73Kajt5DcRURg/vv1A5UtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qRs+v+m2HqU8+QGu3dkKehYPRJWzMF22hZft1oEIXMTP7UfywtbGI7mWs1EPCc4YqGW4QCdKqNEA6YFVJjPPBZ/55QVRH0O9QMjXe3FikzfKiu8pyvf8J7592XLH5F38YIhim53mqtTdZsy0Cscrlqq2AOqITzzbbmQnf2AMVp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b=ot84PXGb; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="ot84PXGb"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-48439feca17so709885f8f.1
        for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 06:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1789651595; x=1790256395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FTWU3z7oT+AmhRKIBpIuUxW3EDym90iXyKLvYlGNFT4=;
        b=ot84PXGbGERRNYmGqx8gP9RP9W94E9HW7SL5axmELPDA/r/NaR6tHWfdg/I1Hfj746
         T5dhFmF8pLP0tKQERVtuDVAaS1fQUpDYzGc06AcCb7yZ8BTXxXGjjAxrJD01Gmy/Q3fZ
         BqKpAOS2QZLnBkVoeZtrsVRdoEsDliTdLtc4QralDY9YYDuxV+euPG8L0pCVfaO48rUj
         VM/sO2BHO6n2oBnWDSDFjo8mlDddfRTiVBCMRrAiNHQKjd+dl+SCz5JgEahz10vchm3y
         rdbMvMUlJ4atgMUhv6P0X9BZu88AsnYzvSDkkNO2VpmBeCnnEPNz2KA/ftN5Ybzlw8Qd
         Zliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789651595; x=1790256395;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FTWU3z7oT+AmhRKIBpIuUxW3EDym90iXyKLvYlGNFT4=;
        b=F3L5ETCZjakRteFrNPjSd1IfVLXtE7GKh2+Bm+t2CoWAPgiq0xkgrBTjsn69G40lod
         QWSUiGlZhl/f02HDTyU7kpOGTtkGgT8OBSZ72Dxtt9fKeYCcf0fs94MFKYEdoV1s0mhL
         uu+BmpxgvVohRErUTCbIlbKUxrB2wRYE5uNl0fL4H1QY4C+OHbKtmpTjjpfykUhz9k7d
         h9P6E7TG4SZojp/fjexB9tpqlvc6Ho5WVSEJ/yGTAF63sRgAdLQz8zTKoKs9k2kyUv4L
         X/8TYSbmceW+IeuZo5C71xyxyA+nUq3SzzuvKIouszKcuRYZvzjDBuippcznH9PfDNiJ
         n4RA==
X-Gm-Message-State: AFuF++m/5LbG+sIKMsJ9jkFd8JSWxT/ScYf/t+8oMyOHXr+PrQ8aPxpX
	y4ujuo/D0S/X7vCkMrqUFGirOjuqnGoQV/E7oVgnkTyLjrj3YQrHru32jiVY4B6nG+0tEegAu8y
	CoEKGHyvR
X-Gm-Gg: AYBFou0UaEMNWSo+dVPL2i7hE2vGFSPNquTOv1eUPH1qKXM98pcyupjq93es7FeL01C
	voVI4yYwP/IQMC45MVasxc7UWQ+dWSZX7O8xPF9Lk3kbIlBbhYOEHfwKNLSLlg80+VjzHALBIFP
	HSlvev6cAZ3Ri0+wwJ/rECQEPYtp67TcHV+TVmhN8l2XJ8mKoMWJ+qPEhPdHrnfRar6UPZlx2jU
	/VMvqT5DLlTxDqmhsueg5PqteciFMD2jrw41sf5GvHPtBHmyM9wVCtjnNiZi8u3uGEW/pI+J4DS
	dFSf1WjorPRZR7JjTWgzFU4SKKIf3o0Q02wJhWI1sNvuZIYxryF7xcI8IVPlYiI4YBJTvkKwRob
	rE4tLFrBpwHzJj4TyjDmwrLNUqqWe5yfgW0BnNqT6F1ezXFUdVb7FdgS3BpCr3VoPe6G6wO5mYN
	XANO5HPuT+LmpXCSNB4SarhZA2eBtr+H8kO2SxMqfhyoMcxDabQnhrSPGwkpIdiUDmX8xfznOGL
	tXn6G4rD7Ze5V9/5KJB2aDlH+E=
X-Received: by 2002:a05:6000:4697:b0:486:e6cf:96e7 with SMTP id ffacd0b85a97d-4870d067865mr6063193f8f.37.1789651594673;
        Thu, 17 Sep 2026 06:26:34 -0700 (PDT)
Received: from fighter ([216.128.28.240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf1f6cfsm15879947f8f.13.2026.09.17.06.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 06:26:34 -0700 (PDT)
From: Sean Rhodes <sean@starlabs.systems>
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Sean Rhodes <sean@starlabs.systems>,
	Evan Green <evgreen@chromium.org>,
	linux-kernel@vger.kernel.org,
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
	linux-mm@kvack.org,
	Xueqin Luo <luoxueqin@kylinos.cn>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
Subject: [PATCH v3 0/4] PM: hibernate: encrypted snapshots under lockdown
Date: Thu, 17 Sep 2026 14:26:27 +0100
Message-ID: <cover.1789651581.git.sean@starlabs.systems>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PM: hibernate: encrypted snapshots under lockdown

This is v3 of the encrypted userspace hibernation series. It protects
userspace-driven hibernation images against modification before resume,
including when the kernel is locked down.

The kernel encrypts and authenticates snapshot data and wraps the randomly
generated image key using a seed supplied by trusted early userspace. TPM
policy remains outside the kernel PM code: early userspace is responsible for
unsealing the seed under the intended PCR policy and writing it to the
write-only snapshot_seed interface. The series therefore provides the kernel
mechanism needed by a TPM-backed design; it does not itself configure or
enforce TPM policy.

The kernel accepts the first valid seed written after boot and does not
authenticate its writer or enforce image freshness. Trusted early userspace
must provision the seed before untrusted privileged code can run and must
provide the required TPM policy, rollback protection and recovery handling.

Patch 2 confines direct block-device write() calls to the active swap backend
to the process which owns the encrypted snapshot, its allocated swap extents,
the recorded swap-header page and the number of pages allocated through the
snapshot API. The userspace writer must use synchronous buffered I/O.

On a StarFighter MTL with Secure Boot disabled and integrity lockdown selected
manually, the encrypted userspace snapshot path completed full S4 and resume
cycles both without and with an additional user key. In each case the original
process and boot ID resumed and the swap header was restored. Corrupted wrapped
data, invalid wrapped-data magic, a corrupted complete-chunk authentication
tag and an incorrect user key were rejected.

The late user-key transition exercised by those tests is retained. This
revision also validates that a userspace-supplied encrypted metadata boundary
matches the authenticated image header; that mismatch rejection has not been
exercised on hardware. The encrypted S4 paths were tested on the prior
candidate; the revised allocated-page accounting and active-backend handling
have not been rerun on hardware.

The deliberately corrupted complete on-disk image case was not run because
the test system did not have a reviewed pre-root recovery mechanism for
restoring its swap header.

Previous version:
https://lore.kernel.org/all/cover.1785838445.git.sean@starlabs.systems/

Changes in v3:
- Rebase on current upstream master.
- Complete both keyless and user-key hardware S4/resume cycles.
- Exercise rejection of corrupted wrapped data, invalid blob magic, a
  corrupted complete-chunk tag and an incorrect user key.
- Preserve and validate the saved encrypted metadata boundary on resume.
- Drain buffered metadata before a late user-key transition.
- Reserve enough encrypted image space if userspace adds a user key after
  querying the image size.
- Apply swap-write confinement before enabling the lockdown exception, while
  preserving the ordinary availability check which routes lockdown writes to
  the confined path.
- Account the pages actually allocated through the snapshot API instead of
  assuming a userspace swap-map format.
- Document the first-writer, anti-replay and userspace I/O requirements.
- Remove an unused swap reverse-mapping helper and tighten local naming.

Changes in v2:
- Keep raw writes to active swap blocked under lockdown.
- Track encrypted snapshot bytes and header writes before allowing
  lockdown-time image writes.
- Split the encrypted stream at the metadata boundary only when a user-key
  transition is used.
- Return -EFAULT for userspace copy failures.
- Document resume meta_size handling.

Evan Green (1):
  PM: hibernate: add seed-wrapped encrypted snapshots

Sean Rhodes (3):
  PM: hibernate: confine encrypted snapshot writes
  PM: hibernate: permit encrypted snapshot device under lockdown
  PM: hibernate: document encrypted snapshot seed ABI

 Documentation/ABI/testing/sysfs-power   |  18 +
 Documentation/power/userland-swsusp.rst |  33 +
 block/fops.c                            |  58 +-
 include/linux/suspend.h                 |  24 +
 include/linux/swap.h                    |   9 +
 include/uapi/linux/suspend_ioctls.h     |  31 +-
 kernel/power/Kconfig                    |  15 +
 kernel/power/Makefile                   |   1 +
 kernel/power/hibernate.c                |  32 +
 kernel/power/power.h                    |   3 +
 kernel/power/snapenc.c                  | 952 ++++++++++++++++++++++++
 kernel/power/snapshot.c                 |   5 +
 kernel/power/swap.c                     |  87 +++
 kernel/power/user.c                     | 272 ++++++-
 kernel/power/user.h                     | 150 ++++
 mm/swapfile.c                           |  25 +
 16 files changed, 1683 insertions(+), 32 deletions(-)
 create mode 100644 kernel/power/snapenc.c
 create mode 100644 kernel/power/user.h

