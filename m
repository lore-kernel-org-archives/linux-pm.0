Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC383546EB;
	Sun, 31 May 2026 16:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780246628; cv=none; b=GfVM+WOYt9V9gE0KePfqHC3cKzAuvVC4/zKNGhSPhSbM5ZrAM4C1jvWHc8eU11nfX+i2GiVGPqVuWopxyK/8WdjLSSBNv3+U4ZC0LtEpDTj3/R8kTS/hG2tLcQefzw+J1ZTLUM7F1Us8ITgAP9bdzq8WT7qj1ghY9JOJO5HWY48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780246628; c=relaxed/simple;
	bh=YxB8iq1OKxhlx8OiSPDy6fWpMVZHM57unYTBUCz4B9k=;
	h=Date:From:To:Cc:Subject:Message-ID; b=U/RDy3dhvCerHn1LzBYXyE8JrPHbTK74Ygg5wHbB4mMPYWeocJ0L6pHF7PmtiK62KwxPjho+62DXwIpXkGB+AFGodrb5m28TKcsO1Iliin4b6lvFf8TWzoXi1hZXsNMXj0pq62TunDrV5o88xpU5FOjU8fcWwDox/l0mz6MDrPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=anxaks0w; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="anxaks0w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780246627; x=1811782627;
  h=date:from:to:cc:subject:message-id;
  bh=YxB8iq1OKxhlx8OiSPDy6fWpMVZHM57unYTBUCz4B9k=;
  b=anxaks0w7IcWcWFSnMXATm12d2fwSvb04O9H4OTPZ/sy5HeI9uZh0XNm
   wno5aGziIR+MZjYyt17MhnE/BSPdKtT12wBiLAV8xM7d7pPnYi7YbHgBc
   7iU+fJbG3BDbr5n9uzpVT/+L11kXt+4qp0u/B05uFVVPo6xWW0fpBDqL6
   SyKn6TslxY435lY4khTgFwsfEm2EfuMIkPbI+sDj+zsN/7iHxa0UazR/5
   T8aQuv4IEIp4YcPm91wdyDUgN9pO732qsyra9wVlowOdtq0jSh0KHUH5U
   lV8pmFgfDdjwnvg/36+3f2Gq/wUdHKZV4NVk7IFQkB9uRpXA/mBgfqHgV
   g==;
X-CSE-ConnectionGUID: l5S5fC+4QcaIVbqbShy36A==
X-CSE-MsgGUID: KgWYUR61ReSSeKlMyu5iSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="80052730"
X-IronPort-AV: E=Sophos;i="6.24,179,1774335600"; 
   d="scan'208";a="80052730"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 09:57:06 -0700
X-CSE-ConnectionGUID: HML7du4AQKqM/795MF60SA==
X-CSE-MsgGUID: ucLD1krjQxiRCYKBpg6OgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,179,1774335600"; 
   d="scan'208";a="240357461"
Received: from igk-lkp-server01.igk.intel.com (HELO 892db79562d4) ([10.211.93.152])
  by fmviesa007.fm.intel.com with ESMTP; 31 May 2026 09:57:04 -0700
Received: from kbuild by 892db79562d4 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wTjTC-000000001PJ-18bg;
	Sun, 31 May 2026 16:57:02 +0000
Date: Sun, 31 May 2026 18:56:57 +0200
From: kernel test robot <lkp@intel.com>
To: Leo Li <sunpeng.li@amd.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 linux-doc@vger.kernel.org
Subject: [amd-pstate:superm1/backlight-property-v5 9/21] htmldocs:
 Documentation/gpu/amdgpu/display/display-manager:29:
 ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c:789: WARNING: Line
 block ends without a blank line. [docutils]
Message-ID: <202605311832.R47OfrlB-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git superm1/backlight-property-v5
head:   5f2330560c00d587cd173ee4222011b62e1ac567
commit: 4dbf62273708e62ea3d1532671b4e5c26f722b8b [9/21] drm/amd/display: Use vline2 interrupt on DCN instead of vstartup
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
docutils: docutils (Docutils 0.21.2, Python 3.13.5, on linux)
reproduce: (https://download.01.org/0day-ci/archive/20260531/202605311832.R47OfrlB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605311832.R47OfrlB-lkp@intel.com/

All warnings (new ones prefixed by >>):

   WARNING: ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c:805 function parameter 'state' not described in 'amdgpu_dm_set_vline_irq_state'
   WARNING: ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c:805 function parameter 'adev' not described in 'amdgpu_dm_set_vline_irq_state'
   WARNING: ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c:805 function parameter 'source' not described in 'amdgpu_dm_set_vline_irq_state'
   WARNING: ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c:805 function parameter 'vline_crtc_id' not described in 'amdgpu_dm_set_vline_irq_state'
   WARNING: ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c:805 function parameter 'state' not described in 'amdgpu_dm_set_vline_irq_state'
>> Documentation/gpu/amdgpu/display/display-manager:29: ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c:789: WARNING: Line block ends without a blank line. [docutils]
   Documentation/gpu/amdgpu/display/display-manager:47: ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c:61: ERROR: Unexpected section title.

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
