Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6398388E76;
	Thu,  6 Aug 2026 17:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786038758; cv=pass; b=lZn7vB96RgjurKxqeV3AkTc4tSx6ivF07HpTfwmeaBGjvpRQd6mMsG+xTW55Xu9nIat3Ooxx1BfrLNeQgqbe/RWkTVUobXRf2eJN2CbqWnEFqeCuCG4WzZj2IFbh4w8oTZjuAZIbjKtPYZ749foPB7TNJ6VkKplCABQvQQxrk/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786038758; c=relaxed/simple;
	bh=tF9QwR9LfbKgdsdcqLdYGSzFsQ4/2iYnOGNDt2YLBww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tg0D0Pf14DJzmioY/+YS5V77uSTcwhAuohCA4+RbCW603OuUsL7Dk5niN7HPUdUGb4l0p3qn1Pl8wOLko9819TcuUn9XwYhppXtdXh4hhElOvrQS2DGb1QOUpUtATKrUrM21BKxyH7Vwi3d6qM29+SaYfbamKaBC0ln5UEMu+RA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=WKMpQABB; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="WKMpQABB"
ARC-Seal: i=1; a=rsa-sha256; t=1786038743; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=js82jIQIr3LQMEX9q12fvjKOU1Og6jVLYz3k6W7jj5dHOOhAqjG1M17eIW+I7ys4MFkSA8GtcJIJVaFcHEJ5vdX59F3auUnLneSoPoNe/hMtfYP9T731aY1wJe4CaFVFmoNRZH6l2KHfCnF1KdR08OOBqkOx+CwmwnLSSAmLa9E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1786038743; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wrrwyhkqanVYo14oOQjDu4oBzTBirom3rIuCtV2Zgn0=; 
	b=Thyjfw9d7/1l3m44hWDNRPcaQ59eAUvPJdFzggHB2V4W9cG37zEJ0aDPUAS4rneb0a8O8nqUqRRMocx5DxPRFj/2U5cCc193LHwzTVMDOBfdGlMTtwcyLOi+r8t/pHZYlXeN1ZPBvRSuxpfLs/Ykzt3A7XMZ2kWywGCDYgMPedA=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786038743;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=wrrwyhkqanVYo14oOQjDu4oBzTBirom3rIuCtV2Zgn0=;
	b=WKMpQABBax/eKx3S2S9eXZtbuwLe2rPhIg31JU5LcsnFdweh9AVSPUlv7mPE8b5u
	vwPIPFBLCXc1tSqB8BUFv99ZVM7FJrY0GP4YQ/LQ5nFID6x8EbrwtH9cXHmlrEMO0nC
	jSzAWf75gXibw/iMij9WJcnl10Ta0WF5ffi3+uns=
Received: by mx.zoho.eu with SMTPS id 1786038741839425.4582269979776;
	Thu, 6 Aug 2026 19:52:21 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Shuah Khan <skhan@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Thomas Renninger <trenn@suse.com>,
	"John B . Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] cpupower: fix topology array handling
Date: Thu,  6 Aug 2026 17:51:37 +0000
Message-ID: <20260806175140.270935-1-ali@iusegentoo.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803175215.117518-1-ali@iusegentoo.com>
References: <20260803175215.117518-1-ali@iusegentoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

First, a correction. The v2 cover letter said I had no machine where a
topology attribute actually disappears during enumeration. That was wrong,
and it is the answer to your question about a real scenario: an offline CPU
is enough. The topology attribute group is added and removed by a CPU
hotplug callback in drivers/base/topology.c, so while a CPU is offline it
has no topology directory at all and both reads fail. chcpu -d, a write to
cpuN/online, or turning SMT off all get there.

Measured on a 4 CPU machine against its real sysfs, no fake tree this time,
calling get_cpu_topology() and printing what it decided:

  all four CPUs online
    unpatched                        cores=4
    v3 series                        cores=4

  cpu2 and cpu3 offlined
    unpatched                        cores=3
    with both continues removed      cores=3
    v3 series                        cores=2

Two online CPUs, one core each, so 3 is the wrong answer and 4 is
unaffected by the series.

> However, did you consider simplifying the logic in these conditionals?
> -- Is this continue necessary here?

No, they are not necessary, and removing them is the right thing. That is
patch 2. Without them the core == -1 check runs for the entries it was
written for and gives them a defined core_cpu_list of "-1", which is what
you meant by the branch being in the wrong place rather than dead.

It does not change the count on its own though, which is the third row
above. The count is seeded before anything is checked:

	last_cpu_list = cpu_top->core_info[0].core_cpu_list;
	cpu_top->cores = 1;

and "-1" sorts ahead of a real cpu list, so entry 0 after the qsort is a
placeholder and the count starts by counting it. Patch 3 is about that
seed, so the two changes are complementary rather than alternatives.

Patch 1 is unchanged from v2. Patch 2 makes the demonstrable uninitialized
read go away by itself, but calloc() is still what covers the remaining
path, a core_cpus_list read that fails and only warns, and it is the
smaller change for stable.

v2: https://lore.kernel.org/all/20260803175215.117518-1-ali@iusegentoo.com/

Ali Ahmet Memis (3):
  cpupower: zero the topology array to avoid uninitialized reads
  cpupower: let the core == -1 check handle failed topology reads
  cpupower: do not count incomplete topology entries as physical cores

 tools/power/cpupower/lib/cpupower.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)


base-commit: 0d839570765118029aa8bf4a95444c6a11aacf85
-- 
2.55.0

