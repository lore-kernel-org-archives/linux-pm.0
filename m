Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794836349;
	b=dwRF6T56dkkvkdnANZ24La2vUY2ZwjxXfXu0RYfX4Lezhl2PC7nmjPvlOOeeq2k9igy2
	 OJR7kv0782jFIOa8vLUL/ieHYC/lUrqJyIDYbHHKiWzrJiwu7Jz5YhLH0r7MQ1N6A2fbk
	 VxKAZktYfvXm0Z4mAqKtaujlPYeUKSVeDqO4zhp/zx0YrU/NWBOEXfB0EVXKRN3iKV4Ty
	 Sf0ub0BTGBOVCEVTXTV0nxuT9/eJq16DTagHNCzgtEJ9Ejk57vB0wKVHLUgCN7oBwt2o/
	 oeKAu0s3FH05rEvtS1YpZqS9QdDRgL11JFg64JhCdfmlHVroVYcRURNN31XONjgSM2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794836349;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HsELSAnxZihj6ZkiimEvCuTIFKXoiz4Ga8/+1nOu6fs=;
	b=n1bit/s8p+ZcE2r4vHurOC38MnmSr+dyTT76BWq6gb1RnFuQt5sX/SuNS5Ebkq0pFXw7
	 grWILF/wXgY4Ta2vpxo1mfITNqfC17pDMrGBEMCnOWKWHtht3WaStaaF3DMUAkWMz6mJ0
	 ecWAxVpGk7cnPeCoHuExhi6Nr0q3ozFZViM9xULaBn3/ozDS4M+H6NepMWYuE5594/7Vg
	 jwNx+Sgc8Kkzif+NIWN6KkaFBwH7tW56bMA4jqiq9tuJEbiJbJb8vPgijoGr8sxTHxWW/
	 5L7qCF8A/kzf3E77IFDfc6V6wg1UYnLz2HY0+GQ/dhEs/w71Ms0kOu+qfC99HLKfWZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fQVNaGWY;
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87C4606A329
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 13:39:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A87C4606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fQVNaGWY
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c4322d310e7so636035466b.0
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 05:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794836347; x=1795441147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HsELSAnxZihj6ZkiimEvCuTIFKXoiz4Ga8/+1nOu6fs=;
        b=fQVNaGWYmeClC+iZ5aQrT2xu4pWQ7xor+FJzP7Vz2OIGAYwCe67gtufjbbImSINN3n
         UO2jkZ0DKhUwCsCd6coLqb1Gx+xCqWEmzecVe4PczqQzaQ7wPLknCr9JLQDRw6xeG3uV
         eboCkLF6AGb4CQORCOgxrK42uN+sd05JmMv1vySKwmu/TTu3Y1k4xAf7gaT6mlVRO74I
         nhqQJOqydmzv32StJKgB98cKraU4xkfgTz9FLErM5Yad2WAfzVeegpVRb2Q2xvmzvAR5
         cz7rmKlTQCyfCvBBicYeyMcX1rNWfvRmVZsMdxx4c8NcLD5x7IbT55qvjnX4NmBQgj7h
         RBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794836347; x=1795441147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HsELSAnxZihj6ZkiimEvCuTIFKXoiz4Ga8/+1nOu6fs=;
        b=c6XqTWxQrS5yVb4+cZSkviJU3G3bBxN334DOQrvVRpw5iqpKKr2OsRXxzvpLL2owSg
         kfKvDSLsO+6mSSG5Upo4tjsJgNEktmbkaUHPmvS/OsLP6yEM/ctK5/PdQw/8YzdY2GqX
         AbITP+KO+EiDf4V6LG/GGRaZnGt8GuRCpR362P2tuRZryVezikvtdeQSulqbkutiogGJ
         NHoMGCsVCtD3FBGyn+FJjCFQO01Puzk2JbJmxTVHzqQhi5EsXH/fcGyXjENGThDi8A24
         E3fahotJI5L1qn3l+PJE/uUCetuJ9bahDXpxJ/Fzii/CgB9so/Zzy7OMVdp6xQ7R2v10
         2zoQ==
X-Forwarded-Encrypted: i=1; AL+hErH4+gRoc32d9mSeSnBlbQVSkSY5JIKTSegbSHMRRVsTQBOnxQ/1D0TjFcJ/CwajRdvWvKmL8jdI/w==@vger.kernel.org
X-Gm-Message-State: APuU4Z+YiU7HQ0UmGBZI1sbGg9zON7TuNDL5KH6dIoBUe1mN/k1tmf+q
	6zmaHRhI9e3IWFKxzmKaXoy6b3QJGa1SpLIU4ZxbmxoEgId2pm2VMO5T
X-Gm-Gg: AYBFou1UrKuacqhuJQKqDPIZ6Cy9bwGOV3tjKQoKa8KALRxf+iJMMZPEtD3zeLcNV2j
	wrgEvyLSrbigKfKRtW/PjWGAU2MvaeFxfcGUVC3wDTWf+ow7Tgi1BEq+nCZDmrf3GKZDBBXAwVC
	Muyb9Bts6wingopnMwi6leaVJ2bpKNjpYdWSGeNzpAVtRAKjFl12MVxZWhbU9M0oMf2fiDJFfsH
	M+OPWiv8I/8IQx1UcUWDBhpjplgLKPbg2tnkO6FH1SyjEzCRLt627xpEObZbG25Q+YON3Sh9Daz
	ghHNIHxyYaWqBPBH4HG/hdXeAQq0UtpVhWXFInu90KFPckCuI1qm6zqxmA0CDDzhrnVZ91Fr53D
	qpgrNrr8cUhvvgjHDvXirvaU2CcI0cuwqEpFu1+S+izOJXCpGCw+JjKqa8HMXz3bAh75MUY+b83
	dpP8uKZ5fgD8AQ07Ia+TUs364nz0cmqLWGQ27aEPej2Q4qHuNF58orRLoT460drMjdDhHvMAapt
	ec7Dzng1EaFBETRbyfBTelBD3jBd8OPtkuldt0fVBRCu2H6xH+O49kJa4dX7k62RQJ8Z2IQJErz
	yI4CWTZ7HmD3USrF1HLqYirCAuXCViG4rmpkSlgBhLy6+ZNWADIiOO7VtK4MkVeAynV9CKysndv
	2owQAX8yPoI+DF2P8FaSJOasugr0joialyB7L7iQPpTdKoc3KwdtR9+O1J3wJMtNWixCPPLxeOk
	3NLyNE9uT7Iv2/tqti6KaWHOb2K95Isgv4UMDqzU31HXylMa9ASYW1bsfUiHePkIKUw7ttI1Nbl
	A==
X-Received: by 2002:a17:907:1c8f:b0:c31:fb29:a137 with SMTP id a640c23a62f3a-c5096313a83mr870027766b.21.1794836346930;
        Mon, 16 Nov 2026 05:39:06 -0800 (PST)
Received: from Ubuntu.tail0f733b.ts.net (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c50e9b2b5fasm61267066b.35.2026.11.16.05.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 05:39:06 -0800 (PST)
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ian Kent <raven@themaw.net>,
	Danilo Krummrich <dakr@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org,
	autofs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+002fb7b2d0bc53bf7e75@syzkaller.appspotmail.com
Subject: [PATCH v4 0/2] kernfs, sysfs: refuse splice on /sys/power/resume
Date: Mon, 16 Nov 2026 14:39:01 +0100
Message-ID: <20261116133903.400202-1-krystianmkaniewski@gmail.com>
X-Mailer: git-send-email 2.53.0
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

This series refuses splice on /sys/power/resume and gives writable
opens of that file separate lockdep classes, as Tejun suggested in the
v1 discussion.

The reported cycle is assembled from two operations. Splice into an
ordinary writable kernfs file records pipe->mutex before of->mutex. A
normal write to /sys/power/resume records of->mutex before the autofs
pipe locks when resume_store() resolves a relative path.

Patch 1 adds SYSFS_NO_SPLICE and kernfs_ops->no_splice. Every open of a
marked file refuses splice. Only writable opens use separate of->mutex
and seq_file lock classes, because only they can reach the store
callback which creates the reverse dependency.

Patch 2 marks /sys/power/resume. Normal reads and writes stay unchanged,
including a write which resolves a relative path through autofs. Rafael
acked it to go together with patch 1.

Other stores also look up paths. They remain outside this minimal series
and can be marked in follow-up patches.

Tested on v7.4-rc1 with fresh builds of the exact base and the patched
tree. The original C and syz reproducers report the lockdep cycle on the
base and run without a lockdep report with the series. Splice and
sendfile from an O_RDONLY open of /sys/power/resume return EINVAL with
the series, while read() still works. All 33 QEMU cases booted and
completed in both phases. The builds, W=1 checks and Coccinelle checks
introduced no warning or report.

v4:
- Refuse splice for all opens of marked files (Tejun).
- Keep separate lockdep classes limited to writable opens.
- Add no-splice operations for read-only regular sysfs attributes.
- Keep Rafael's Acked-by on patch 2, whose code is unchanged.

v3:
- Rename SYSFS_LOOKUP and ->may_lookup to SYSFS_NO_SPLICE and
  ->no_splice (Tejun).
- Drop the mmap, prealloc and binary attribute checks (Tejun).
- Add Rafael's Acked-by to patch 2.

v2:
- Replace the v1 locking changes with per-attribute splice control.
- Preserve splice on read-only opens.
- Split both the open-file mutex and seq_file lock classes.
- Reject incompatible mmap and preallocated-buffer combinations.
- Reject SYSFS_LOOKUP on binary attributes.
- Rebase onto v7.4-rc1.

v3: https://lore.kernel.org/r/cover.1794479968.git.krystianmkaniewski@gmail.com
v2: https://lore.kernel.org/r/cover.1793715774.git.krystianmkaniewski@gmail.com
v1: https://lore.kernel.org/r/cover.1792577179.git.krystianmkaniewski@gmail.com

Krystian Kaniewski (2):
  kernfs, sysfs: add SYSFS_NO_SPLICE to refuse splice
  PM: hibernate: refuse splice on /sys/power/resume

 fs/kernfs/file.c         | 51 ++++++++++++++++++++++++++++++++++++----
 fs/sysfs/file.c          | 23 ++++++++++++++++++
 fs/sysfs/group.c         |  4 ++--
 include/linux/kernfs.h   |  9 +++++++
 include/linux/sysfs.h    | 22 ++++++++++++-----
 kernel/power/hibernate.c |  3 ++-
 6 files changed, 99 insertions(+), 13 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.53.0

