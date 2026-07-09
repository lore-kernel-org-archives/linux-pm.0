Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16693D88FA;
	Thu,  9 Jul 2026 22:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783635231; cv=none; b=CjR6nnLj79nW73qsX3EgO6PPMqYWLozVrAsHT69OOFfkPUWWCwJp+ICaG1pTjVW96RofkbL5AUfiGN/den2icECmgYSh0ICHddOqYtOCeeKUZPQNYpnLG1Wrh1fkH3HxJiUdfDVLt8AZDHjcP6Y/USWIHCq3oQaNRKNoVJiSnGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783635231; c=relaxed/simple;
	bh=p0GHSp7IAcM2yagmRIEOLqh9Gbx85IPV73V8DZdiW10=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ApDm+pyVfW11yc9bpWe2pNplb6TcTJWbKpLhF1wviVj/6SAv/C0LAQzGhSbPf2VJPwVDHliDF+DF0gV8poq+uloxfgsWtEtxu9c3azJFZKxc70mCADN3OBi2Ozq+i71Ipn0WTN38HyWRbnzVHaGQVTkCzoAacQKE/J0flUgnnGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=bj2Yagi0; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="bj2Yagi0"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DC2A1682;
	Thu,  9 Jul 2026 15:13:44 -0700 (PDT)
Received: from u200865.usa.arm.com (U203867.austin.arm.com [10.118.30.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B4DB3F66F;
	Thu,  9 Jul 2026 15:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783635228; bh=p0GHSp7IAcM2yagmRIEOLqh9Gbx85IPV73V8DZdiW10=;
	h=From:To:Cc:Subject:Date:From;
	b=bj2Yagi0Hy1mDinEcnZTKVj9F9dIkQ/H8VdUdlwCjlgq9FuzzHWB9EsjbS4wCmyWD
	 /gyTbQMFguawEXj3kxVkjaJfSO5Wr/VsSRdaP1VfnJMrYaHJ7nUGeA1e9XWxw/kf6q
	 clNcae8lDYsm0mlM9i7Xqa0hrzk+990t7xJi0SsE=
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-pm@vger.kernel.org
Cc: trenn@suse.com,
	shuah@kernel.org,
	jwyatt@redhat.com,
	jkacur@redhat.com,
	kaushlendra.kumar@intel.com,
	sashal@kernel.org,
	fj5851bi@fujitsu.com,
	rui.zhang@intel.com,
	linux-kernel@vger.kernel.org,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH 0/3] cpupower: Improve arm64 frequency and CPPC reporting
Date: Thu,  9 Jul 2026 17:13:41 -0500
Message-ID: <20260709221344.1919794-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On x86, cpupower can report both kernel requested frequency
information and hardware reported frequency information, along with
CPPC related performance limits when available.

Arm64 platforms using ACPI CPPC, expose similar standardized
information, but cpupower does not currently make it visible.

This set adds a generic CPPC performance display based on the
standardized ACPI CPPC sysfs fields, wires it up for non AMD
processors, and updates debug frequency output so cpupower prints both
kernel reported and hardware reported current frequencies when both
are available.

Jeremy Linton (3):
  cpupower: Add generic CPPC performance display
  cpupower: Build and call CPPC information on non-AMD processors
  cpupower: Print kernel and hardware frequency information

 tools/power/cpupower/Makefile                |  2 +-
 tools/power/cpupower/utils/cpufreq-info.c    | 11 ++--
 tools/power/cpupower/utils/helpers/cppc.c    | 56 ++++++++++++++++++++
 tools/power/cpupower/utils/helpers/helpers.h |  2 +
 4 files changed, 65 insertions(+), 6 deletions(-)
 create mode 100644 tools/power/cpupower/utils/helpers/cppc.c

-- 
2.54.0

