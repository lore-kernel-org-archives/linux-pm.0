Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EA02248B3
	for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 19:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773949646; cv=none; b=kivIq3SemdR/e297VLFNwWO+JDQ9k2vAnhB6v6setivfftdVRJ/WGToVEe4V5ABPoa7sFtmKeZeuZ3PTE3IGY00CKOLihEcRPK0M1i0DxWdvgE6sB00Fj70nj911cFomCgR/I4OoJy/u8cW+xjdNgZc37Ezm2TwaoEKrQtkq/cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773949646; c=relaxed/simple;
	bh=nyiZdk69JHyRMSxsgfCfmEEAuMmh5HcweuE0na5MKlI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L8CcQTdG/wBRFOtsCZ/GUQcuSwd/B1d/bddJxm1DP2K19z1vWi9TK3GrQEUVoVEtCrjFgBUevQIcty74P22wxumFqkYYtmFSHjCBDanPF1IjS6ZIe3TaveWDfKzJjYDrlCl4/Pef76rG3E74NCuNfI+jG/QeXoE50CJZc6936uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lOHupTOW; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOHupTOW"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-829ac8d56c5so1001317b3a.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 12:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773949645; x=1774554445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KKET5NPA5ASmk1jkTd7kXsD4vcOiadP7Y/oX3DOtA4E=;
        b=lOHupTOW2CZmjz9ZssNobBmJa9n5wVBwHhoX1Vbfe3vIoILrFRpBbwmtKtnOVMREJv
         gF8TPL/UpW8Q2ZjAWxJWojuzhHJjCtbeBEoZzXzAi+Y+D68ejyodU3GDGEOawbexUxQ2
         ++4WM+CW29D583OAuo9tWPIQnPYNdAH/Q71z6o2P9WQySuDOOSDk00uzxeWkNGiujuQz
         xZ7ai2FTPYgsEpwKGVEZcvW4A8HkuOX6bjXOwuFgp7PIrfP/mRyn/EpgoxmMjktOE3fV
         P9sD0WEse8pw0O1dOxpBXFeHTo0iiqfFmtr0yGQ8SJwkZ7UYYAwtRciG44G01ZKUe3Zk
         edMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773949645; x=1774554445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKET5NPA5ASmk1jkTd7kXsD4vcOiadP7Y/oX3DOtA4E=;
        b=pIuyjxgjRLQ7VvDBaexiemrkslTHcs7/ebfrsjeY3OIFspzP9Bsfbot4czbrRfzxS0
         yby0ETgZnRTHpboHWhKgRu0wketFkf8wRevQRXY3cVmBfM5CvkLA7lqZ9us1hvMwytIX
         R6yyj6QwoKN1V0zemMiLSfeO6a/54G8kTa9cO985BOEaub5Lkun2VKQFIPTH7k2pXR6S
         2Q7hGjWG6NKbxKVxe8unwwn4MOVkBv/DqM5VVcv2C5LNfB9TXcRw2nfQ8fEOoHOeGdBo
         1FcvzlYjE4iDyCiUf15lCA0LJxzQKhEkXu0vxZ2DeJo1ebtzES3da+4A22M/cwady2jV
         955g==
X-Forwarded-Encrypted: i=1; AJvYcCV4zObn8RrpNV1DnhX4AT09nHgT84Xv5J9d34FF3E6SrKRlk8aOO70waahtI61m7qhflqOIwzF0+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfloLdG8bzpyQAPV5D0U4sYLK+lB2hihoRmI0FgZ5KWf5hJQdE
	NidfwvLKhDro33mmuPh777CUXALDcGiV6qzUr4SSFj0UKKDASVn0w8zU
X-Gm-Gg: ATEYQzzUqg2fD639p3zOk6E2vIZNbulKTK6PrzkWnolw17SEP6BF3LnzibZfj1NeNOI
	MM1DzDlpcFUfOlS4BJvFeZIEcZ790FfG3P4tF5OwwrrhnwmZ9dRSDZz7H18oDQPDw/la+1eqAYf
	8F+f7y1cckc6HqjFNrsR1bNW6mgQU7OC9Tms4zytK0BvdUaRjbIya3hPO/GSD+p05PmlXmEvT+3
	gGacsa8PwUs6/Ps9HwxHT8LDpG6R3W1ZRM98JIkANZRtkaqHr9ALpXrGGeb0dos08R/Iasug8z+
	S3FjGhJnXxOxm5r87aWeVtWs5/FFLPJDnvFjrvPyh3AfrshSVM4rSa3HF7wgddtQRYGofTVLDnR
	zxjjHFkDy0twr4V0QdVPIwI0FiZ5M4Y33fEWqzpv4yUx9v4iziCTrs0moZLFs5IclYQ3oOUEVgY
	5a2OulD4JxdI1n6l4Z3g==
X-Received: by 2002:a05:6a00:2d96:b0:82a:768c:9a49 with SMTP id d2e1a72fcca58-82a8c32727cmr360003b3a.42.1773949644550;
        Thu, 19 Mar 2026 12:47:24 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:51::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b040da7besm11132b3a.49.2026.03.19.12.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 12:47:24 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	miklos@szeredi.hu,
	david@kernel.org,
	therealgraysky@proton.me,
	linux-pm@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 0/1] writeback: don't block sync(2) for filesystems with no data integrity guarantees
Date: Thu, 19 Mar 2026 12:45:39 -0700
Message-ID: <20260319194540.3463371-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog
---------
v1: https://lore.kernel.org/linux-fsdevel/20260318225604.71545-1-joannelkoong@gmail.com/
v1 -> v2:
* Still kick off flusher threads for writeback for SB_I_NO_DATA_INTEGRITY,
  instead of skipping that entirely (Jan)
* Improve commit message (me)

Joanne Koong (1):
  writeback: don't block sync(2) for filesystems with no data integrity
    guarantees

 fs/fs-writeback.c              |  7 +------
 fs/fuse/file.c                 |  4 +---
 fs/fuse/inode.c                |  1 +
 fs/sync.c                      |  7 ++++++-
 include/linux/fs/super_types.h |  1 +
 include/linux/pagemap.h        | 11 -----------
 6 files changed, 10 insertions(+), 21 deletions(-)

-- 
2.52.0

