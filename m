Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06FB37BE95
	for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 16:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774022477; cv=none; b=Dldz6wOFCtPZk4Mkf4j0wZdxftt6d1HPwkEmNxnedF1vm3aFra6aichHk4ngNKKKXhAaBR+IxXV7pgtQZ8DZzRrvumeK5f0rbyTFgINQ49rvD/bXc60HIhs3Az2W6csLGIJ0QLIVoGZ3CsvGtOrh3CaNhmLZaM6+iDx8xsx06GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774022477; c=relaxed/simple;
	bh=VvDq6lbA0+MBNpru3nhz56fcZsBSYOu1Jq1hxe+kZqk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=a0PVUy9pyq/o8TEMxOtaLObsy4OXcYeBM/X+9Vvjb6o1JKfPkq1ixqXu947aMADmiLXLSVlog2MuxsaDfyAivZ4Shjb+RWcasKkY91i54JwEoG6j5qCsr8YfNAS+JJrkes7e8W6cteTxwemNyNpIvYCIX2yFMq9hbQ/NmFdoItI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p5ZA8cTc; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p5ZA8cTc"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c109ba1296so19854456eec.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 09:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774022474; x=1774627274; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mMm4wBnmSeubt2uXZ01V3PsbZvesaIurFwFXvpVAv2s=;
        b=p5ZA8cTcBkGTqaSrKbX00Vv7Esrp8U1C7LIgV/4rKgpvLbrNolt39ZWtQ/dHnrwK7i
         /xwY2RqfoBDDx3RMOgI3x1oROAteWPnzPNeqTpwcAOaIiMMAHuDdqItU4FgAkYcHCOzk
         p36i1D8JLQGNlRu7z08GNm1oV2R6MGltjuQ7NZmxL1wniqGD+LckzVog0f0jaQJ+HGeW
         wZ5ULKAT5flTAuQoi3e4T8kSPlx2XQC6E0WvHkTOvK7IfRm5kLhV92CS4vcZEc45CGoD
         5lDd9pBMZYLbdoAuiSnL43BekYoqfHTaI6e6nR/ISouk4dv3ua/n4HDnWXuOs8/vvXp6
         /P1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774022474; x=1774627274;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mMm4wBnmSeubt2uXZ01V3PsbZvesaIurFwFXvpVAv2s=;
        b=UUPUdqG2YDT2WgHg/1RbrOkdioHiw/78PvPYxUo7Qs3U3bYkKeNkp0tYEDk9NFI5i9
         bTQp67ug5KV8NBu/EqfkjYO5jX0nZT33FfFwEHYbLdko/v+D4KsDlh8KA0EBjwAa/VSD
         pAbx3UDCyhHvMrzXtHgwsAqLN62MjMyLnHQ+iEh8jyaDWhfwt2VhtwG46R23ZcyYE+GD
         FLhhgkGCuF0n+0JKnp8Iu1LvZxI7p2syoxLXKiYv3c2F9wvTXbXO+JbAoYwaVsFF6Lfk
         MGcEPTZ8mAHrhMAF45a4suc27jSFm8BNIzFCnpw2r1ryZijmBgAiy5hbIeG/Ixw+C5SJ
         C9qA==
X-Forwarded-Encrypted: i=1; AJvYcCWHU4akI5bcKZPEraFIkLWBp5SmmD8Lrd4SGFysxrlgyb09b3wDFBOWW0zOPI9h0kgvpeok1Tt/cg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLVKeDEH9Aomv6vsnWDTSLHSiqTr07ZGGt96SZnvegagiY2GT9
	6K8V/KmLfg5+sLjX2F1KYdahAL1nVa/y3dl5x4IwdwJ/XKO/FCoCagPvzZLe33ECcmvG2a+93f+
	GU9fst750l6uyiQ==
X-Received: from dybia20.prod.google.com ([2002:a05:7301:314:b0:2c0:f494:8a43])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:9f0c:b0:2b8:4c95:365d with SMTP id 5a478bee46e88-2c1095f54afmr1848097eec.10.1774022473627;
 Fri, 20 Mar 2026 09:01:13 -0700 (PDT)
Date: Fri, 20 Mar 2026 09:00:52 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320160055.4114055-1-wusamuel@google.com>
Subject: [PATCH v1 0/2] *** Support BPF traversal of wakeup sources ***
From: Samuel Wu <wusamuel@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>
Cc: andrii@kernel.org, memxor@gmail.com, bpf@vger.kernel.org, 
	Samuel Wu <wusamuel@google.com>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patchset adds requisite kfuncs for BPF programs to safely traverse
wakeup_sources, and puts a config flag around the sysfs interface.

Currently, a traversal of wakeup sources require going through
/sys/class/wakeup/* or /d/wakeup_sources/*. The repeated syscalls to query
sysfs is inefficient, as there can be hundreds of wakeup_sources, with each
wakeup source also having multiple attributes. debugfs is unstable and
insecure.

Adding kfuncs to lock/unlock wakeup sources allows BPF program to safely
traverse the wakeup sources list. The head address of wakeup_sources can
safely be resolved through BPF helper functions or variable attributes.

On a quiescent Pixel 6 traversing 150 wakeup_sources, I am seeing ~34x
speedup (sampled 75 times in table below). For a device under load, the
speedup is greater.
+-------+----+----------+----------+
|       | n  | AVG (ms) | STD (ms) |
+-------+----+----------+----------+
| sysfs | 75 | 44.9     | 12.6     |
+-------+----+----------+----------+
| BPF   | 75 | 1.3      | 0.7      |
+-------+----+----------+----------+

On the memory side, between kernfs, dentry, and kmalloc, each wakeup source
removed from sysfs saves at least 10kB.

The initial attempts for BPF traversal of wakeup_sources was with BPF
iterators [1]. However, BPF already allows for traversing of a simple list
with bpf_for(), and this current patchset has the added benefit of being
~2-3x more performant than BPF iterators.

[1]: https://lore.kernel.org/all/20260225210820.177674-1-wusamuel@google.com/

Samuel Wu (2):
  PM: wakeup: Add kfuncs to lock/unlock wakeup_sources
  PM: Add config flag to gate sysfs wakeup_sources

 drivers/base/power/Makefile |  3 +-
 drivers/base/power/power.h  | 14 +++++++++
 drivers/base/power/wakeup.c | 63 +++++++++++++++++++++++++++++++++++--
 kernel/power/Kconfig        | 13 ++++++++
 4 files changed, 90 insertions(+), 3 deletions(-)

-- 
2.53.0.959.g497ff81fa9-goog

