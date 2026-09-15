Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F95E3BE17E
	for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 13:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789478007; cv=none; b=gEFshotNobBVo+AEYvBOsYRcofpX50YpvJkJQizuchlxN4N0SBA2ctlDqkQqE53PmwCRI83vvYDQYllOYWxtLKEY+s8Lj2/PDb9CzswmHwkoUrxZnWn254krOiXcAZP0N5g5emKsosW33hfXQqncQmtN1r5RfvqBpQTZ5l/aZ/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789478007; c=relaxed/simple;
	bh=VH+GESYVf8Q6OE04LpS2UxRwtEinvUONnio9ltdY1y4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I6C+srZqZ7XP68587QNuhERVt8SoMcjWYRELB/30WGPvQK50k+uKjKwDodLOo6/hHleGINHMz02I8rhEeBxAnmQdYwPBKZHe3n1VEou/ZkYf/zZkROUS8ONDDJgIAIl2Wkcpsp72+ky/+p/VNxRMb+VYqwhrIV5uffgi8k/J9xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PZz9RB1N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PZz9RB1N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789478005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4jjn97CZWGNvFYIAi3C0tmCOlkV6YvQN0/hfe036mjA=;
	b=PZz9RB1N+WefilwYb2PHSNX+NiySFf4bz9CG0uSz5ULLmHr84eAk/1XU71XWuoGU2yNUdA
	CdCr+lXAgKZKdxIInW+VAXZF0+E3ttgA+hLX6rxviGBWu+B9T+IkWYbNX6n5sQr7tbkb3M
	eQ6ChglffTNHGh1z2AykP5ir3Qi9YuY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-Ew4cWI3MNs-_fqToOKtH9Q-1; Tue,
 15 Sep 2026 09:13:21 -0400
X-MC-Unique: Ew4cWI3MNs-_fqToOKtH9Q-1
X-Mimecast-MFC-AGG-ID: Ew4cWI3MNs-_fqToOKtH9Q_1789478000
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A6A841955DD9;
	Tue, 15 Sep 2026 13:13:20 +0000 (UTC)
Received: from aharivel-thinkpadp1gen3.rmtfr.csb (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B0A771956045;
	Tue, 15 Sep 2026 13:13:18 +0000 (UTC)
From: Anthony Harivel <aharivel@redhat.com>
To: linux-pm@vger.kernel.org
Cc: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	seanjc@google.com,
	pbonzini@redhat.com,
	kvm@vger.kernel.org,
	Anthony Harivel <aharivel@redhat.com>
Subject: [PATCH RFC 0/1] cpuidle: add per-CPU latency_limit_ns sysfs attribute
Date: Tue, 15 Sep 2026 15:13:06 +0200
Message-ID: <20260915131310.1053834-1-aharivel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This is an RFC for a new per-CPU sysfs attribute that lets privileged
userspace set a governor-respected upper bound on idle state exit
latency.

This follows the discussion on KVM_CAP_CSTATE_POLICY (RFC v3,
Message-ID: 20260914143702.915401-1-aharivel@redhat.com) where Sean
and Paolo concluded that per-CPU cpuidle controls are the right
abstraction rather than a KVM-level interface [1][2].

== Problem ==

Cloud operators running mixed NFV workloads want to reduce energy
consumption by disabling halt-polling (halt_poll_ns=0). When vCPUs
enter HLT, the kernel cpuidle governor picks deep C-states (C6,
~133us wakeup) by default — good for power savings, bad for
latency-sensitive VMs.

Existing per-CPU controls (stateN/disable) work but require
knowledge of the C-state table for each CPU microarchitecture.
There is no latency-based per-CPU ceiling that works portably
across Intel/AMD/ARM.

== Solution ==

New sysfs attribute:
  /sys/devices/system/cpu/cpuN/cpuidle/latency_limit_ns

When set to a non-zero value, cpuidle_governor_latency_req() returns
the minimum of the existing PM QoS constraints and latency_limit_ns.
All governors (menu, TEO, haltpoll) automatically respect it — no
per-governor modifications needed.

  # Cap CPU 4 to ~C1 wakeup latency
  echo 2000 > /sys/devices/system/cpu/cpu4/cpuidle/latency_limit_ns

  # Remove limit
  echo 0 > /sys/devices/system/cpu/cpu4/cpuidle/latency_limit_ns

The interface is latency-based (nanoseconds) rather than
C-state-index-based, making it portable across microarchitectures
without per-uarch tuning — as Sean suggested [1].

== Integration ==

For the KVM/NFV use case: userspace (OpenStack Nova, libvirt, or a
simple script) pins vCPUs to pCPUs and writes latency_limit_ns on
those CPUs. No KVM or QEMU changes needed. This also works for
non-KVM use cases (DPDK, bare-metal NFV).

== Test results ==

Tested on Dell R640 (Intel Xeon Gold 5118, intel_idle driver,
states: POLL/C1/C1E/C6).

Feature selftest (7/7 pass):

  ok 1 sysfs attribute exists
  ok 2 default value is 0
  ok 3 write/readback
  ok 4 reset to 0
  ok 5 attribute on all 48 CPUs
  ok 6 per-CPU isolation
  ok 7 functional enforcement (deep state entered 1 time with limit)

Multi-VM demo (2 VMs, 60s, stock QEMU, same host):

  VM-A: CPUs 2,4 with latency_limit_ns=2000
  VM-B: CPUs 6,8 with no limit

                    VM-A (limit=2000ns)    VM-B (no limit)
  C1 usage delta:   +24031 / +22369        +7668 / +3044
  C1E usage delta:  +0 / +0               +6888 / +7784
  C6 usage delta:   +1 / +1               +6990 / +14843

VM-A stays in C1 (C1E and C6 completely blocked). VM-B freely
enters deep C-states. Same host, same moment, stock QEMU.

== Design notes ==

- latency_limit_ns defaults to 0 (no limit, existing behavior).
- Requires CAP_SYS_ADMIN to write (same as stateN/disable).
- Integrates at cpuidle_governor_latency_req() level, so it
  composes with existing PM QoS constraints (takes the minimum).
- Does NOT reuse forced_idle_latency_limit_ns — that field bypasses
  the governor entirely (used by play_idle_precise() for idle
  injection). latency_limit_ns is a governor ceiling, not a bypass.

Looking for feedback on the approach. Happy to add a selftest or
documentation patch in a follow-up.

[1] https://lore.kernel.org/kvm/aqgRj7mfDhCUqWw4@google.com/
[2] https://lore.kernel.org/kvm/ (Paolo's reply in same thread)

Anthony Harivel (1):
  cpuidle: add per-CPU latency_limit_ns sysfs attribute

 drivers/cpuidle/governor.c | 10 +++++++++-
 drivers/cpuidle/sysfs.c    | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/cpuidle.h    |  1 +
 3 files changed, 46 insertions(+), 1 deletion(-)

-- 
2.55.0

