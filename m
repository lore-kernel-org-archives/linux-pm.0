Received: from sender-of-o59.zoho.eu (sender-of-o59.zoho.eu [136.143.169.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A084314BE;
	Wed,  5 Aug 2026 11:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785930227; cv=pass; b=UkflYEj0Mk+tZft21zNC8OucRoyaBxZlBmlNXYJiDY6hluCxqijRcY9DX1TBbZ2fuv+Xln0ud8AQJZhZ1NiBlAVcH0i969RnZs+ZVDSKp0/0z/g+4Z8wQKF6KMzZA7WuB0V6WxnPwI0Uhh4F7YVf4FtCJMQWR/7fORDHyzNCtA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785930227; c=relaxed/simple;
	bh=a1ZEXs/jEWhGbS90fO1hZyDIxf8zSjg3EiwnSobkJ84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mUda9LqUW7W7w9ZOwWMvDRUOkfIGcsyQZB2l1hHWKIv3Ylr4XrjAN+tOn7CcaEWtF8l/e6B8RCJsnb4Qd4ge362KXXG975z3PB2q4hghm4160HQJH8OmWTvpl+89pSg+FtcyvH9036h7/tEZQdt2q0Dxexw28KdMrJPrCfzARfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=ZNGOqkHr; arc=pass smtp.client-ip=136.143.169.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="ZNGOqkHr"
ARC-Seal: i=1; a=rsa-sha256; t=1785930196; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=M4gxeZOY5E5DEicQWl43xYrYg8Cr++bXEgNm5ft1P0CusSNsze7y95HCXnfLqIpglQvRDjXYgNbeAwsE1W1zG0C8VHfxBKfK4zPAV/otvgTTnf5LmYqGYG+kyMYWeIApJwFM6HrAaUn3VfUz94lf48INhO/RnMZu69rFCkrlzag=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1785930196; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Uv5+SKQf7vdpSJjBODoV6HXbRfjFjNuMti5OjJOt0po=; 
	b=JKYxTKPXntu2lBfDuD66KOTHy2ELYY4XKat/F0sB0q3H2okFGqrZ3nzNFXlL3LzO0gVaC704v+2q3QvcHKDjWPw8p5nvmcTSlZOCy/QpRRxdbokbpFoVLyW68HXCSM+qi6vX8XsYREW3GZiqz1sfjVJ2llYHsdxepUiXwlLHXtc=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785930196;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Uv5+SKQf7vdpSJjBODoV6HXbRfjFjNuMti5OjJOt0po=;
	b=ZNGOqkHrzXNkJmFWiNJ+SEKpab34rwseVffVaekZHWMxdAZN/dn46B0MkCb1tuvx
	fqRxXzjkCY7mI89WRM4MbxO3xKwm9YKEpfseFgHB9mtHTOFZv6oKsXDSJoVs6J+IUiY
	9NoLKW2kAdAXEm5fRoHkNZVLPOzJA2F0VbkqgxMg=
Received: by mx.zoho.eu with SMTPS id 1785930194849857.8845775690994;
	Wed, 5 Aug 2026 13:43:14 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Shuah Khan <skhan@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Thomas Renninger <trenn@suse.com>,
	"John B . Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] cpupower: fix topology array handling
Date: Wed,  5 Aug 2026 11:43:05 +0000
Message-ID: <20260805114305.97160-1-ali@iusegentoo.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <b503143a-4716-4af2-a754-9fcef9eced35@linuxfoundation.org>
References: <20260803175215.117518-1-ali@iusegentoo.com> <b503143a-4716-4af2-a754-9fcef9eced35@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On Tue, 4 Aug 2026 14:45:48 -0600 Shuah Khan wrote:
> Did you think about a scenario when the following check will be tru - i.e
> core == -1 is trur?

I went looking for one and could not find it, so that branch may well be
dead. What I checked:

On the architectures using drivers/base/arch_topology.c, reset_cpu_topology()
does start every possible CPU at core_id = -1, but store_cpu_topology()
overwrites it for any CPU that comes up without firmware topology:

	if (cpuid_topo->package_id != -1)
		goto topology_populated;
	cpuid_topo->thread_id = -1;
	cpuid_topo->core_id = cpuid;
	cpuid_topo->package_id = cpu_to_node(cpuid);

and it is called from the bring-up paths, arch/arm64/kernel/smp.c and
arch/riscv/kernel/smpboot.c. On x86 core_id is either derived from the apic
id in arch/x86/kernel/cpu/topology_common.c or set to 0 in smpboot.c, so it
is never negative either.

A CPU with no topology at all does not show up as -1 either. The topology
attribute group is created from a CPU hotplug prepare callback in
drivers/base/topology.c, so a CPU that never comes up has no topology
directory and the read fails outright rather than returning -1.

That last case is the one that matters here, and it takes one of the two
earlier continue branches rather than the one you quoted.

> Can you elaborate on a real scenario where this could happen after
> replacing malloc() with calloc() and making sure core_cpu_list is
> initialized to "-1" like in the above conditional?

Those two branches set pkg and core to -1 and leave core_cpu_list untouched,
so under calloc it stays empty, and the count is still wrong. I ran this
against a fake sysfs tree with the CPU count pinned, cpu0 with real topology
and cpu1 with no topology files at all:

  unpatched            cores=2
  patch 1 only         cores=2
  patch 1 and 2        cores=1

and with three CPUs, cpu0 and cpu1 real and cpu2 unreadable:

  patch 1 only         cores=3
  patch 1 and 2        cores=2

The reason is the seed, not the buffer contents:

	last_cpu_list = cpu_top->core_info[0].core_cpu_list;
	cpu_top->cores = 1;

An empty string and "-1" both sort ahead of a real cpu list, so after the
qsort entry 0 is an incomplete one, and cores is seeded to 1 from it without
ever looking at pkg. The pkg != -1 check inside the loop only guards the
entries that follow, never the one the count started from. That is why
initializing the buffer to "-1" does not help: it changes what entry 0
contains, not the fact that it is counted.

One consequence worth stating rather than leaving for you to find. If no CPU
has usable topology at all, the count changes:

  patch 1 only         cores=1
  patch 1 and 2        cores=0

That direction looks like the consistent one rather than a regression, since
pkgs already reports 0 in that case today, so the current code prints
"Packages: 0 - Cores: 1" and after patch 2 it prints "Packages: 0 -
Cores: 0". The only in-tree consumer of cores is the dprint() in
cpupower-monitor.c, so nothing there divides by it or sizes an allocation
with it, but cores is in the installed cpupower.h so I cannot speak for
out-of-tree users of the library.
