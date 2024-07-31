Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D9510A3E;
	Wed, 31 Jul 2024 02:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722393924; cv=none; b=DL0HiuArK2DBD37z2aFJ6IPqYzcF0G7rHLDqctcU56YigIHWckSHqo1G159W+Npac+VMw92wqZRazAyn4B9StNA8rqwkQ0LOjSMMKAwayXiw5momq2RmcK18YcxCmHNRtnOEN16gHDUVIuU3FxGWf7wGX80LuJpWpffsp/dRdE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722393924; c=relaxed/simple;
	bh=q9gEgC4EsLq9WyS6kKSUzixkEag3lez/lZB20Ec2wpY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t3jXoyo1/KvmSYoZ69ZXKuK6LeXLjqrZylCrVYGXfcLBUhC9nZ3B0M7MFI2KLR2FqmSCQgoVl64hRoxafG0xU3mTvvMSphZlVQsAaZPROYNoo5lLk6ixAQcVbXuhPJzH1zBG6W7ee7txdpzhU+UmCyNpsNh48+JEoVyAAr0rRyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-1fd9e6189d5so39677645ad.3;
        Tue, 30 Jul 2024 19:45:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722393921; x=1722998721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N1mN8tQQyGiWdbRWhNmw4AxYg7OYaRujP3ts6w47Tmo=;
        b=fMgEiXZPva0iJgg5AqfMW0EFDTD6jXRekSQnWeHSitPrwwUR6zTYoCO3aFFvFjelIB
         t81zc/HcoImRpoY/AeLEix5CdsmgmLPq5M7GD9OU4M2FzgOayv10FAbwY4O5LX1Af3jb
         sfCsG9Dd/i0M59e8VXDZkiJBw4ShZ1HRR7q4qRQBeCYTQ6sN9VyqtdI/3BpPZoIeG154
         eAtwMYxU9QUNzxdyg5nsp7yyYVw3WkpbAWRyx1P6rDx8xdisZwDnvssKbN2L+fT82twk
         NDqmzSRWshYkOuNg1+/0mlHj/mJozxMrolubqZjhXdGuTwznPiFKg5g84EkvaNzug55d
         zfXw==
X-Forwarded-Encrypted: i=1; AJvYcCW/Le8qF+zhv7fXltYqTfDYc3k6GR/qTeIlq4QQ5GhKZlaK5pMlysxMupivftFZtjsektRPRzQdqIGlfzZ/DxBFm31OhswH2ulBMK95
X-Gm-Message-State: AOJu0Ywer5tcZOZ8c1ADqzSDVnzDfMVYIqHcpN2HHXq9sNi0tjHkHdfJ
	l6fWPjzu1ts/2ZLBe2N65M0quLvxuYrnBOMk5wgqYwVYx+B8goaC
X-Google-Smtp-Source: AGHT+IG2HZcg6F3cxGHnD6iDyMPLr2GQYlHbN4mjL5h+Qzr6cYDwC+0JwZj6NlGMoy+99dJkT8O75g==
X-Received: by 2002:a17:902:f60a:b0:1fc:5319:8c7d with SMTP id d9443c01a7336-1ff049206bbmr132351125ad.61.1722393920672;
        Tue, 30 Jul 2024 19:45:20 -0700 (PDT)
Received: from kylin-ThinkBook-15-G2-ITL.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c86afasm109620575ad.42.2024.07.30.19.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 19:45:20 -0700 (PDT)
From: xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	pavel@ucw.cz,
	len.brown@intel.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiongxin@kylinos.cn,
	Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH v2 0/2] Use sysfs_emit() and sysfs_emit_at() in "show" functions
Date: Wed, 31 Jul 2024 10:45:16 +0800
Message-Id: <20240731024518.126716-1-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xueqin Luo <luoxueqin@kylinos.cn>

As Documentation/filesystems/sysfs.rst suggested,
show() should only use sysfs_emit() or sysfs_emit_at() when formatting
the value to be returned to user space.

No functional change intended.

v2: Adopted Christophe's suggestions as follows:
- Fixed some formatting
- Fixed logic errors in mem_sleep_show, pm_test_show, state_show functions
Thanks!

Xueqin Luo (2):
  PM: hibernate: Use sysfs_emit() and sysfs_emit_at() in "show"
    functions
  PM: Use sysfs_emit() and sysfs_emit_at() in "show" functions

 kernel/power/hibernate.c | 22 +++++------
 kernel/power/main.c      | 82 ++++++++++++++++++++++------------------
 2 files changed, 56 insertions(+), 48 deletions(-)

-- 
2.25.1

