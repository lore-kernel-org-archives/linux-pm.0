Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF02F34252C
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 13:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784639563; cv=none; b=B3p/D62rGwulGgOLlLTHFkAUva1Fp9gCAFz99AlidBjhafJx62SaIl66VLwxRdN4+TWdqlz+nvKa/C5I76UF7Jjpr4OYg7mp7PyceDyVUPjFdZmsOWFAculdzTdFJI5wdkQMUaYkzHAxTL+LpnV0y2TPfuBrqG0bhXYMTcy8XxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784639563; c=relaxed/simple;
	bh=nS5SJQmwq8NU5ulEg4x+lVkufqolSp3mR/z1Mkjawbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K28Wpt+wrMnx51piQUtRdjdOk9y6Qixddsn+8EGYMe9ruOc8XW7o0s9JXCPf7FBGjwLUxw6DzMpSaqGUcAJT4LeBciy+JnVi0DKzAr4xzaJh6EcPIbcpRkoHjrTAYso24zIAnZaORN8/zVFDaiGchfvO32H0LX03OYHG/8lBSu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dEanDhrt; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dEanDhrt"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47f81a3ccf9so409814f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 06:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784639559; x=1785244359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vXH/AcaDYaWjD1D7W7UeWMormFqpNiZzAjn7k+W0SEQ=;
        b=dEanDhrt+jUSTiBzkZBe0IDLwLG75pM5Ej1XjXee8zrpLAmD21ET04fM4I4lSVGfIW
         Q+my3B99PjL/v3z/hKeBaEWBvESw9aih0ETnhmnxgmsV8yWAICVR863KOzNO3Q6s3zEa
         AsP7Etn7j7ODIbZAjvTfuEYqOUEIsm7vfo3jqniyHInAEsa8pv3nsw27xExEGpRa3Y9x
         MfXam53sX3lIDX0uGAnDaqX6iiaAP5givXlPKLnjV9hK/UcKtu3pnpVVebROttjRDlly
         xxuIg53CAha66tiu3ZOo2YqVicN5ea8F68oJW63P6K3AXhXD14C5DsdnTeOlMgWZtwiA
         bODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784639559; x=1785244359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vXH/AcaDYaWjD1D7W7UeWMormFqpNiZzAjn7k+W0SEQ=;
        b=gEvh42hxWW3Lh9jgD6baIiv+vmvfajtIvqgkczsK7kp5qkA9RhVSniOnc5XJgpEY/e
         eZ4CFU1igYCV4XcVmK/4zjBdeJ1Te4aRmTldbi5sF4uf9ug4JzfAlf+rp3FNkPKPsLrp
         O+nJz8Hv2vGkEVz3NTEu4oikd7FIHFZgg/jtLMtabABND6NYhJs9VgPMShLfesEMo9g9
         3om6FBjvAUGmrhPs5Ct437KWgxDJcoayg3K4JaW6QmJnRCYbzhKH4joKFppgiN+YcqNp
         ugsQ/Caq+SCNbKcoCQxOOfHCWICg7x1SYnkREMhGNK7KxZ7g3fQkBScX4Q2NC1Dh9L+x
         ffrA==
X-Forwarded-Encrypted: i=1; AHgh+RoCQPuDZAM3O1hTu7ITzuxXG6iN4P9j+rdghUbojNNyUdJuTloOSlokmeXG2rPI8TWBbqePzW8ihQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbF6kmtDi+WhFCJLXyx8Whck7FBvWD5IPT7jsdmCXlR3Ulf8Vb
	5csFkGOzV0ECa1HmPA4QFEZRxWLfGTwcuEOZCx/e4puDLhqEM2Ls9mMkT0ViQQTIago=
X-Gm-Gg: AR+sD10cEBbKLTzlLNBkOs5SByZC4bpCs4RRBxflHP53x4narsuJfwOVYktjsVK8N9h
	UUB+F1lkxAg5xn72hhAnCJ3iiJHEQnresDNslerwj3jJf92TMX5iSrINmcJazfdfsoieu6o20y5
	b3YukkSfMq3Z7bFeyP1TgvtuXZXuevSM3xj6lVog8mcSJtelp3DUpcQRecBi75rr1aoPQ+tYbvd
	3Iw3P4EmlxBs/spM1rIAJM8JTNhAnJz9Vw4jgaLB+e2btNn4tuV+uhS3+DIGEEWxDAwTqOAmxAP
	QtnEzG0GT9fmMffcau3cTjl9X+DaIVQY3dh/VHQ5y9b4tjFhEqfREhETPEPF7RkUJnTHdqSfTwL
	tz2JdKNIx/ugYzUDYLf6EEW2f40+XrfzEApgXxXmqwZ0Tp4yTWdfmyLzSgyOPBokmbBO1dnBwlQ
	==
X-Received: by 2002:a05:6000:2084:b0:47e:81aa:3832 with SMTP id ffacd0b85a97d-47f6230e614mr22543209f8f.16.1784639559042;
        Tue, 21 Jul 2026 06:12:39 -0700 (PDT)
Received: from zovi.suse.cz ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63ee9281sm42070938f8f.36.2026.07.21.06.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 06:12:38 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Michal Januszewski <spock@gentoo.org>,
	Helge Deller <deller@gmx.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Kentaro Takeda <takedakn@nttdata.co.jp>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	greybus-dev@lists.linaro.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-acpi@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	cgroups@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-pm@vger.kernel.org,
	driver-core@lists.linux.dev,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v2 0/3] Bring includes in linux/kmod.h up to date
Date: Tue, 21 Jul 2026 15:11:24 +0200
Message-ID: <20260721131207.803760-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The usermode helper declarations were previously provided by linux/kmod.h
but commit c1f3fa2a4fde ("kmod: split off umh headers into its own file")
moved them to linux/umh.h in 2017. Add explicit includes of linux/umh.h to
files that use usermode helpers and remove linux/kmod.h where it is no
longer needed.

Also add a missing include of linux/sysctl.h to kernel/time/jiffies.c.

Finally, clean up linux/kmod.h so that it includes only the headers that it
actually requires, importantly removing the compat linux/umh.h include.

This cleanup is motivated by trying to reduce the preprocessed size of
linux/module.h, which includes linux/kmod.h. The linux/module.h header is
included by every *.mod.c file to provide `struct module` and other related
definitions, so it should avoid pulling in unnecessary dependencies. Note
that this series doesn't immediately improve the situation, since most of
the files included by linux/kmod.h are, for now, also included by
linux/module.h through other paths.

Apologies for the wide distribution. Acked-bys are appreciated.

Changes in v2:
- Remove the linux/kmod.h include from kernel/cgroup/cgroup-v1.c.
- Add a missing include of linux/sysctl.h to kernel/time/jiffies.c.
- Link to v1: https://lore.kernel.org/linux-modules/20260708154510.6794-1-petr.pavlu@suse.com/

Petr Pavlu (3):
  umh, treewide: Explicitly include linux/umh.h where needed
  time/jiffies: Include linux/sysctl.h for proc_int_u2k_conv_uop(), ...
  module: Bring includes in linux/kmod.h up to date

 arch/x86/kernel/cpu/mce/dev-mcelog.c |  2 +-
 drivers/block/drbd/drbd_nl.c         |  1 +
 drivers/greybus/svc_watchdog.c       |  1 +
 drivers/macintosh/windfarm_core.c    |  1 +
 drivers/pnp/pnpbios/core.c           |  2 +-
 drivers/video/fbdev/uvesafb.c        |  1 +
 fs/coredump.c                        |  2 +-
 fs/nfs/cache_lib.c                   |  2 +-
 fs/nfsd/nfs4layouts.c                |  2 +-
 fs/nfsd/nfs4recover.c                |  1 +
 fs/ocfs2/stackglue.c                 |  1 +
 include/linux/kmod.h                 | 12 ++----------
 kernel/cgroup/cgroup-v1.c            |  2 +-
 kernel/module/kmod.c                 |  1 +
 kernel/power/process.c               |  2 +-
 kernel/reboot.c                      |  2 +-
 kernel/time/jiffies.c                |  1 +
 kernel/umh.c                         |  2 +-
 lib/kobject_uevent.c                 |  2 +-
 net/bridge/br_stp_if.c               |  2 +-
 security/keys/request_key.c          |  2 +-
 security/tomoyo/common.h             |  2 +-
 22 files changed, 23 insertions(+), 23 deletions(-)

-- 
2.54.0

