Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405C137206E
	for <linux-pm@vger.kernel.org>; Wed,  8 Jul 2026 15:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783525565; cv=none; b=oedrBSMaxqKR/EYO4afhNiTZVUekZYeafMHMY9pStiS6SgwHlqqC1kh8fCShMfBp6ziJm+p99kvtCinJ1zlWKo0gwYDEGe+h5oSJCT7mHaiupucImNED70Kv18l9hBWX+dav6Q/RHHlvgn8RNyEnbRhRwHVgD/1qVoKub3PhwPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783525565; c=relaxed/simple;
	bh=9vHkvbT9qGw6XnwnbsV8mVwKGJQJ6h+q3CIzqn5nO9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hYaYiDLWjsxbD/RWaiDxbmygQPpNovhWOQ0HQMeK+ftJ+MC1h3aYXLLjYxcRhGU3V6qr3vmC6a1M4OXkzp5P2lpqeTkF7o6nxddxOPL74Y/2vrIzx6tYjkfvV8baURKyjDyLClQei8MUQDa6IueaOTWJAubWIrX3mPeHoKozEC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V9o0/GIU; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V9o0/GIU"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4720d22c94aso808420f8f.1
        for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2026 08:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783525562; x=1784130362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=f/mdlbu7kxNAYQt2PwbA0grJPU5KW1EejarCbBPlRO8=;
        b=V9o0/GIUUfwXKE6Si0vT9XcZGfRtCEAITKFydTRSMtxOkifhRtmp/MtdeuBSvQjlah
         GKs0jcAl1dbNwep3X2epdX94A1E2PRCE/RJiQzscSyYA+100AJlBrKKtfaJDQR7m4qkR
         MweaN2SaoTQVXZzo+CbE6iStSMIrM4q/CBP5yJG7R81GdmoVDUVD+GVaUICIey6oYKd8
         c0/nveapDqgLkjDAcqEvEelk984mV+G/mTYHz2PA9ukpzmVGFCRmoyUTJUuTmnoF/KXq
         /H2ps2dV9sdcW0mO39x4tQ2SC1Bv8NBxCJ8uQ5aycxoeyR9m8B7y7ZQSTbchyM/Rw7cS
         uAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783525562; x=1784130362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f/mdlbu7kxNAYQt2PwbA0grJPU5KW1EejarCbBPlRO8=;
        b=qjabpETkcBt70lYR/jTgxXVWvi6xD0lRHieUjARwcRnIPkoo8KcyGXVvEI+i401tOT
         fvAmF6UCrDv6IJnfbnDW7RSsbs0ho26uJmXpsbzjfhxDZSKD9Sr5FCfRVgMCuH0g/oYr
         hJh1iXQ2mbc0AojFoHnIfZXjR5GQX3DFbIwIWDWKYoFk0sCSHeWJMSrhQxW/ubnmFLM0
         jMr5S2EBC0rS8Fjm5cO5DGBrhWyZPvf5n1xatZH84e7mZEbhVFhjpGGcbjJY4gYWiE9H
         0fOWMVUYmfFJz32JneFAJeYr0xIRVXpmQdESD1SNcKoZ8kG/V1uwkPmGdyqq9mggGHU+
         4sMQ==
X-Forwarded-Encrypted: i=1; AHgh+RpchyZX3xKeohuDYkKGIOq+IYw3UPzfx4M9z77pDHnzeHONvlfj/XmmLILG/ZHiaVTBIvTNsa6tJg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOuYiyBZSf6vwypCyCsC+PQcMIXshoIH9vfXzMkH4mI9E+PegP
	Lt0/04O6iyGE+iI99oLAI00gz/LrBMM1KRS95+uU9D9GIzm4c8VkUuoP7ZszI/qEuC4=
X-Gm-Gg: AfdE7cnRaOxgyTxlHkql7IsRlKhGsfd7pmxmi5T5npT5z/7C7cQ6DNx4jfijTXmrisj
	9R/i5SRZUUENlSEelA3TGL4out74yvTrcO3ckDr/tO/ETwKyVBlwQm+J5w0/FzIzwLatIF4mwJC
	GHqWo1GZfO2Vqjy9cERRzV0QrkPLZztWnEs3H8Y7j9py3a1HWdxGfpmitxqU3oA2u1dmZmw37Ii
	krnlZeVmYUuQ1Nr9JK8ldDivPUT8gSYx7Cr4ysNp0r1OZ3axIpP0mfGExljY8ucypEJ/pZCV3pX
	oQKP31AKzBlIYO+4/BHNrFY2w1jsM3I46xtAtret3COGCLnjLscDfLxxz4TmqSdXr57TgFGGApK
	01l25Fk45YYcDpu8g3qDsgG5F71AmFkV/ZCDCYzrzVmqyT6ChXlXQRh3AVAfm31PFhiF1eew/nA
	mjSgxiQb3XRztgGwiXqpKxyP1q4SsmlDHz+mOF7dNB
X-Received: by 2002:a05:6000:4304:b0:46d:55a5:8ec5 with SMTP id ffacd0b85a97d-47df078bbffmr3378920f8f.33.1783525561596;
        Wed, 08 Jul 2026 08:46:01 -0700 (PDT)
Received: from zovi.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d780csm44806847f8f.11.2026.07.08.08.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 08:46:01 -0700 (PDT)
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
Subject: [PATCH 0/2] Bring includes in linux/kmod.h up to date
Date: Wed,  8 Jul 2026 17:44:28 +0200
Message-ID: <20260708154510.6794-1-petr.pavlu@suse.com>
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

Then clean up linux/kmod.h so that it includes only the headers that it
actually requires, importantly removing the compat linux/umh.h include.

Apologies for the wide distribution.

This cleanup is motivated by trying to reduce the preprocessed size of
linux/module.h, which includes linux/kmod.h. The linux/module.h header is
included by every *.mod.c file to provide `struct module` and other related
definitions, so it should avoid pulling in unnecessary dependencies. Note
that this series doesn't immediately improve the situation, since most of
the files included by linux/kmod.h are, for now, also included by
linux/module.h through other paths.

Petr Pavlu (2):
  umh, treewide: Explicitly include linux/umh.h where needed
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
 kernel/cgroup/cgroup-v1.c            |  1 +
 kernel/module/kmod.c                 |  1 +
 kernel/power/process.c               |  2 +-
 kernel/reboot.c                      |  2 +-
 kernel/umh.c                         |  2 +-
 lib/kobject_uevent.c                 |  2 +-
 net/bridge/br_stp_if.c               |  2 +-
 security/keys/request_key.c          |  2 +-
 security/tomoyo/common.h             |  2 +-
 21 files changed, 22 insertions(+), 22 deletions(-)


base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.54.0

