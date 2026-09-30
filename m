Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47BD514769
	for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2026 14:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790777352; cv=none; b=J5ldYhlCWjs8MMpqjZjwnaRO3saIETAUUgn+GfCOMJk+oCXyuOuChnkVyVDfJZYEirQiCKpQ8O6PudiZhgbnP6w5efz30xV9t8vO/LFk8/yYjuyMAPgqLhO82d21G++JcT4inKlJ4UEzdvOTV3IpF9Qzu1o+5gs0MXdrAQV4oZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790777352; c=relaxed/simple;
	bh=M/g6FVmoluV0YgJhBvvxHD6eJs5pCZwq49bi2wzAou4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hcb2V+QrHhIKGEg3/azgWN7TdCWw1aEvrKTCtPpU70twG3u+fBsFzFfExEWDTDxbVJP+KS6ypdFU2hA0aoMxrbwV+em+56a+TFpI7uzBGXE57Fx6im+xm3VFFeiqsKABN0/1z37TJ/9rWjRKQ6fi9lPYPI9lxaxr3RgvdoF6Ai0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etEMq0SQ; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etEMq0SQ"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49fff6f0f87so27088795e9.3
        for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2026 07:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790777341; x=1791382141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8pJuSm/1HrjdOBptJ26UHxOB3/Tz6mdZxePy3K7M22Y=;
        b=etEMq0SQG2LSMV8M8PyW3yciTz/dIET5k523QQLI/CmsiUQMxtG+8S7hXdDyiERLYL
         ULRCqxdr1WoFPIxkruEYD4TYjmI5Y/MoQUljUay7zYtkqISLXJ9TwPgRecHWSRnbvx4i
         M8opc8XyjW2CyIckEU4BcQp9TOJswTazPF2MarGdLaMa9ncdJxT6yg5Lt3tNmxF1mn1F
         +b5BIieWbUj1R6Lna/mH+ynj/mTUgJ4E4OLQEMj7kW8zEbmLH8xzUALsqiEe+XU1awMh
         Ns1hx+kwL57+y33MqgiDWIhsTTCMUEoG654I/unBqyXXNyf9Rx6R/2A1adqBCZA8CH6k
         IN4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790777341; x=1791382141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8pJuSm/1HrjdOBptJ26UHxOB3/Tz6mdZxePy3K7M22Y=;
        b=W1F+GJPnrFnqlZ3kE8eY5dxQtvhne9UX4xFBgRoyBfiFva1xaMhlrB7E5G4Y2aLjtn
         fkIT5P/EwqiV8UdyecwbXWsRgYaRPYwhGjjWqP2QtgQk6WAaAa36joBApVQCSmAp9tiZ
         SddqRE/1ydbRgr7T0qoWUhJvabSbVSdQ7l7YrdgrvXmOHKLus+zblnITbtqoiOFNMd+3
         ID62+6gAUXhZ4moUoYCaEauv3anCvdkag8TauGLTMc/2B177lhtKRVDUvG9IzBpXuJwD
         ktoiffQ4pYORzdCRURRxvc/mazrXUbXFrVbwUEpMUMKDsh9i9Nt4YML3DleyYdTeRnPT
         sbvA==
X-Forwarded-Encrypted: i=1; AKwUvBz+H2C+SmLsRn+glRf9EmaLwbFN7D6UNXfCZufRP8tkBVE2+FwvJyKtSJHLIUunpyxQLK2VglDy+A==@vger.kernel.org
X-Gm-Message-State: AFuF++mohpjK/Q/EvnW93qixla7nTh1Smr/Xt8/kH8aDXmMM9CQ3jnMU
	qH+D4XQ+r8wkAdfD7hlzqD5Hvp29syKmz2yBdDPPuC9Mmk5tZe7j+yvd
X-Gm-Gg: AYBFou0mwTxK7b50O0ijJIBDyMy5Hw54w9wOJ+HE5x2pBux5DzbcoaYaFQ8Ql/VYSiT
	q2n7CwdpScD8yprWdDW8MhjyOb5iiEoJgeFctmJW5unaAaqrwWH8LGPpbatrhrN6U7HLalrqWW6
	+46rF0FaAZ6OsYhOYzu+8Bb64NfxZiL6o4nOd6/KsSadAnTf/Uaxz85iX1jONkHM1FAa+FHFwKK
	/H2UVJEnBVrjIpYwY8A9bj5mhLR1fYaFHuYf3PZ5m0jtqaGOLUyaXYv3REO+AwKV1LX0FrPJK70
	C/J4a8k4MsLrftLefFyAqCcpmn6BUlwV5kbxWsHeIBnrqoh7aJLQR18avuhZ+LJH/kugwV38QRD
	w2fltrQg3S8kauibmw9N7DM12aYBxxEw/DGzNvJhCcKmkXSh8Y7PvoINcFydT12urWiV/hT23kU
	9nHuxEV7CxYDaE9uZT2bZ9MYGU0ydBQkBVFmTl3VmSyt6Yp7T1/L1ie1+YpTZGlszxbJaHBWwhO
	6wBhpIm/MJZR6aQn+7nsx6OIXiZRXR8vukctYBtuSZ8
X-Received: by 2002:a05:600c:4e41:b0:4a0:1723:2d90 with SMTP id 5b1f17b1804b1-4a01ad7d018mr22575335e9.4.1790777341205;
        Wed, 30 Sep 2026 07:09:01 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.116.68])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01e63e10csm2352115e9.2.2026.09.30.07.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 07:08:59 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Bojan Smojver <bojan@rexursive.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PM: hibernate: Wait for in-flight reads before freeing the read-ahead ring
Date: Wed, 30 Sep 2026 16:08:49 +0200
Message-ID: <20260930140850.4864-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

load_compressed_image() reads the image ahead into a ring of pages with
asynchronous bios, and waits for them only when fewer than CMP_PAGES
pages are buffered. From the second loop pass on, reads into the rest of
the ring are thus in flight while buffered data is parsed and
decompressed.

The exits taken on an invalid compressed length, a failed decompression,
an invalid uncompressed length or a snapshot_write_next() error jump to
out_finish without waiting for those reads. The function then frees the
ring pages and returns, releasing the hib_bio_batch on its stack, while
the outstanding bios still write into the freed pages and hib_end_io()
still updates and wakes the stale batch.

A corrupted image is what fails these checks, as the CRC32 is only
compared once the whole image has been loaded. With such an image, the
resume fails with "Failed to load image, recovering." and the boot
continues on top of the resulting memory corruption.

Wait for the batch at out_finish, as save_compressed_image() and
load_image() already do before releasing their buffers. hib_wait_io()
returns at once when no reads are outstanding, so exits without
read-ahead in flight are unaffected.

This was found by code inspection. It has only been build-tested; no
reproducer was run.

Fixes: 081a9d043c98 ("PM / Hibernate: Improve performance of LZO/plain hibernation, checksum image")
Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 kernel/power/swap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index c78f1593600bb..49b3da89b49d4 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -1198,6 +1198,7 @@ static int load_compressed_image(struct swap_map_handle *handle,
 {
 	unsigned int m;
 	int ret = 0;
+	int err2;
 	int eof = 0;
 	struct hib_bio_batch hb;
 	ktime_t start;
@@ -1478,6 +1479,10 @@ static int load_compressed_image(struct swap_map_handle *handle,
 	}
 
 out_finish:
+	/* Error exits may leave reads in flight into page[]. */
+	err2 = hib_wait_io(&hb);
+	if (!ret)
+		ret = err2;
 	if (crc->run_threads) {
 		wait_event(crc->done, atomic_read_acquire(&crc->stop));
 		atomic_set(&crc->stop, 0);
-- 
2.53.0

