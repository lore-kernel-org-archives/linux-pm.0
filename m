Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1C031E823
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 17:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778521809; cv=none; b=BuCDIiJhgTMjrKlo7rd5wsgqPj93fXdA7doh7ogXu3hqGgi8PUb3K6RFpKv8nFJ++9sOUiMujH4mEH+6dQgdckq6F0n8BTsJUwost1tJmRb7BT98Pp8xE5ESqgZienFBP2pM90Tc9aJKxi2m6kr83F48ob3wtMzjJFw9pdMa9tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778521809; c=relaxed/simple;
	bh=g1G/+PoWZdAvQmXojSHIDbtBFrtB6n8uPkg6HEziu0I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nEOpka+W5fzowd66udSH2vcKaipedgIkGsIjKupZ9ywRG0ma+1KfUNlQVR9HrQQgp8/0MtTmo3LTU9N1pMCSwi22VIJNcMyWiQXl7mxtldkRvLEjZZkrboxwBwUUwO48cR7+a0kBSuEXtvFlt8UcTof3wkLgkRaY6G4V8hNpxbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YX8qbPQF; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YX8qbPQF"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bda35eab74so3756356eec.0
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 10:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778521807; x=1779126607; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F3SSM/7OmGT1DQhDHuFPYpuDPGpRg8FSNXFpqlLPkoo=;
        b=YX8qbPQFuxrP3RQRrJxvUSFsjDfM7kSkA2R8elGiHDepCtquMaq5t2sk3du0ILffT9
         qkl3XvSIwPvMCV5l9hviHDPvTF6mJenOIUEYnMJiBpMQt1q7l7Q7UJ3lwaman0y5ZQtK
         tYJBS2baMTV6Wni+CUo8hMIXTpEI+7TeU5eSy0uoOEYfYJKVc7TdF0alM51v9ShKOULs
         2jOIfNY4csPn2JIqo/y1uQsvvp0gMMsqLnaE2pU8ub38Y0Bi6P14eCWEGHc7z5HXUp5n
         PjYunRhoKdvKPbSWLHEZcqf3Fggl9eRxtktyD6UnwLbc/X8xTub7qStEPoUcPchReEWK
         DmgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778521807; x=1779126607;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F3SSM/7OmGT1DQhDHuFPYpuDPGpRg8FSNXFpqlLPkoo=;
        b=L1c3m4sCrifHTMfHi0sBSsUOIy/tnYaBXXRAznyGWozgH7yAMKgd/KXPyDPewPY/U8
         HEnc9b4qiza9xtFVHUSCTRebNKpsabI96k6xDg+FfQ4yc4pUI7rwj+sMIFHpaJ3+D2qg
         HVCWsdisYN8lKxn0LgARVa7xoWwg7AF43dFYP7yq1/lD9QrwF6H23HbxMDo1ow0u5GXn
         qoKS/qiGxd3TNVmU4N13bbV+vy0VIyJGUTnmI81zBIjfvmAJTUUHXEdAa/tN3DwYTnLg
         O9RbUbsujr48EvvhLxgUvLzZD+uItDPAbaed+Bz9XI7FN7xmzLI7Ucmj+62ct5eSomnU
         EznA==
X-Forwarded-Encrypted: i=1; AFNElJ81gV/NrAx3qfmI1UlwTsIS4J4f3Tm95BbBdoQnMAverIy7NtAx7rEy4gl64QJ8tj73tB1NIqqzJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcoiXhyXQnj6yDIOZUSWvDnPNkvljTtE+t28CulFHv3AlHYcRF
	XDbsguOAiks06xvL89qQgIWfzQKsYufYzHZQw4DGFrJVIAOIqS5ZFViQcsBrIF0dFMgbOMGKz2H
	H3MvxKJC6TJb/lQ==
X-Received: from dybdf6.prod.google.com ([2002:a05:7300:b586:b0:2da:4e8f:1752])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:5807:b0:2f0:ee2:f6c6 with SMTP id 5a478bee46e88-2ff95e5e234mr269219eec.19.1778521806295;
 Mon, 11 May 2026 10:50:06 -0700 (PDT)
Date: Mon, 11 May 2026 10:45:55 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260511174559.659782-1-wusamuel@google.com>
Subject: [PATCH v4 0/2] Support BPF traversal of wakeup sources
From: Samuel Wu <wusamuel@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Samuel Wu <wusamuel@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	driver-core@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patchset adds requisite kfuncs for BPF programs to safely traverse
wakeup_sources, and puts a config flag around the sysfs interface.

Currently, a traversal of wakeup sources require going through
/sys/class/wakeup/* or /d/wakeup_sources/*. The repeated syscalls to query
sysfs is inefficient, as there can be hundreds of wakeup_sources, with each
wakeup source also having multiple attributes. debugfs is unstable and
insecure.

Adding kfuncs to lock/unlock wakeup sources allows BPF program to safely
traverse the wakeup sources list, and a kfunc to get head of wakeup
sources list is needed to start traversing the list.

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

The initial attempts for BPF traversal of wakeup_sources was with BPF
iterators [1]. However, BPF already allows for traversing of a simple list
with bpf_for(), and this current patchset has the added benefit of being
~2-3x more performant than BPF iterators.

[1]: https://lore.kernel.org/all/20260225210820.177674-1-wusamuel@google.com/

Changes in v4:
- Removed `.owner = THIS_MODULE` for btf_kfunc_id_set per Greg
- Add a graceful exit in selftest if bpf_wakeup_sources_get_head() is not
  present due to kernel configs without CONFIG_PM_SLEEP (e.g. s390)
- Relaxed substr match in wakeup_source_unlock_null() selftest
- v3 link: https://lore.kernel.org/all/20260331153413.2469218-1-wusamuel@google.com/

Changes in v3:
- Changed return type of bpf_wakeup_sources_get_head() to `void *` per Alexei
- Added failure test for direct dereference of wakeup source head
- Use bpf_core_cast() instead of macros in BPF program per Kumar
- v2 link: https://lore.kernel.org/all/20260326112521.2827500-1-wusamuel@google.com/

Changes in v2:
- Dropped CONFIG_PM_WAKEUP_STATS_SYSFS patch for future patchset
- Added declarations for kfuncs to .h to fix sparse and checkpatch warnings
- Added kfunc to get address of wakeup_source's head
- Added example bpf prog selftest for traversal of wakeup sources per Kumar
- Added *_fail.c selftest per Kumar
- More concise commit message in patch 1/2
- v1 link: https://lore.kernel.org/all/20260320160055.4114055-1-wusamuel@google.com/

Samuel Wu (2):
  PM: wakeup: Add kfuncs to traverse over wakeup_sources
  selftests/bpf: Add tests for wakeup_sources kfuncs

 drivers/base/power/power.h                    |   7 ++
 drivers/base/power/wakeup.c                   |  71 ++++++++++-
 tools/testing/selftests/bpf/config            |   3 +-
 .../selftests/bpf/prog_tests/wakeup_source.c  | 118 ++++++++++++++++++
 .../selftests/bpf/progs/test_wakeup_source.c  |  92 ++++++++++++++
 .../selftests/bpf/progs/wakeup_source.h       |  22 ++++
 .../selftests/bpf/progs/wakeup_source_fail.c  |  76 +++++++++++
 7 files changed, 386 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/wakeup_source.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_wakeup_source.c
 create mode 100644 tools/testing/selftests/bpf/progs/wakeup_source.h
 create mode 100644 tools/testing/selftests/bpf/progs/wakeup_source_fail.c

-- 
2.54.0.563.g4f69b47b94-goog

