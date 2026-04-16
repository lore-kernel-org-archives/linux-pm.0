Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEFC242D6C;
	Thu, 16 Apr 2026 23:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776383146; cv=none; b=RQmgUuQPU51W7YcByhyDkGdniX9tZkfl5FU2Jh0cunVBxpCrqfmAhsJUq8if6XGnR5oWtWOMZsOrqJ5wEWFkFazkqaM75zegNLNiXcNgw6qvNyLLvnSn8JGVSi1pn89AbfLnDjtblVLzsTILa1QQnG2F7XsoIwS62hC6icPTaSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776383146; c=relaxed/simple;
	bh=1Djc3gqyOJjAU0LA4LBGX7z8iBreDg3IeyA8Vm/2yGI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HaPN7X1OJ+HFMMMDtRAchHeEIpUu+DCfN9DtoRRJ7ATv/lmWdG0X9kXFYH8BcpFsxDQgC7Dmq+NOlnQK59c4EqfALcMDIATkBCkzUztGVqeY51ih+0Cj5D8th11GsqS/ixQtAuU1xwR9uH7AZIpHSSkgx13prvKfculL6Zvl4LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=PqQFbobd; arc=none smtp.client-ip=207.54.90.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="PqQFbobd"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1776383143; x=1807919143;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1Djc3gqyOJjAU0LA4LBGX7z8iBreDg3IeyA8Vm/2yGI=;
  b=PqQFbobdQmE+xkU3REhiuOB0o3JeS3nV9Xs+4AzMafPQ+db5DiTx/s2B
   5bCof+m4zt+sRYEmZ97yvMP/nhockGqjgodOKSD0V6csbsXgQzw+SlxEF
   PO3qcJL0o0hnibskJ5f3wUwM3yRI7Hos9so9a2pXmjFdWTJlu6Ckb/HGC
   +e8/jfME/kwhdJRtZ2cJIiq8idvCO2WLhKeyU4VWBT18Ze3VbSHH3Ci82
   EVoNV7tY2CUT5kf5gv+lLw7GMx2hesbRJddlvVfzKd0lByXRoi+DQkmoZ
   yJOxxYiVARwAqZBbATERQkck+D+XODS9DYKzChdhRWaZP/kJx6dKTp7X8
   Q==;
X-CSE-ConnectionGUID: yW43vTexQ+uGAOeKJEX+ZA==
X-CSE-MsgGUID: /JE5XIH2SRy7k4YyP2IpGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="237192934"
X-IronPort-AV: E=Sophos;i="6.23,183,1770562800"; 
   d="scan'208";a="237192934"
Received: from gmgwuk01.global.fujitsu.com ([172.187.114.235])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 08:44:32 +0900
Received: from az2uksmgm4.o.css.fujitsu.com (unknown [10.151.22.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwuk01.global.fujitsu.com (Postfix) with ESMTPS id 670A2820C15;
	Thu, 16 Apr 2026 23:44:33 +0000 (UTC)
Received: from az2nlsmom3.fujitsu.com (az2nlsmom3.o.css.fujitsu.com [10.150.26.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgm4.o.css.fujitsu.com (Postfix) with ESMTPS id 1E144140124D;
	Thu, 16 Apr 2026 23:44:33 +0000 (UTC)
Received: from ubuntudhcp (unknown [10.172.107.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmom3.fujitsu.com (Postfix) with ESMTPS id 885DF101906C;
	Thu, 16 Apr 2026 23:44:31 +0000 (UTC)
Received: from isar2.ecs00.fujitsu.local (unknown [10.172.183.27])
	by ubuntudhcp (Postfix) with ESMTP id B00EB2206C7;
	Thu, 16 Apr 2026 23:44:30 +0000 (UTC)
From: Tomasz Wolski <tomasz.wolski@fujitsu.com>
To: tomasz.wolski@fujitsu.com
Cc: alison.schofield@intel.com,
	ardb@kernel.org,
	benjamin.cheatham@amd.com,
	bp@alien8.de,
	dan.j.williams@intel.com,
	dave.jiang@intel.com,
	dave@stgolabs.net,
	gregkh@linuxfoundation.org,
	huang.ying.caritas@gmail.com,
	ira.weiny@intel.com,
	jack@suse.cz,
	jeff.johnson@oss.qualcomm.com,
	jonathan.cameron@huawei.com,
	len.brown@intel.com,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	lizhijian@fujitsu.com,
	ming.li@zohomail.com,
	nathan.fontenot@amd.com,
	nvdimm@lists.linux.dev,
	pavel@kernel.org,
	peterz@infradead.org,
	rafael@kernel.org,
	rrichter@amd.com,
	smita.koralahallichannabasappa@amd.com,
	terry.bowman@amd.com,
	vishal.l.verma@intel.com,
	willy@infradead.org,
	yaoxt.fnst@fujitsu.com,
	yazen.ghannam@amd.com
Subject: Re: [PATCH v8 0/9] dax/hmem, cxl: Coordinate Soft Reserved handling with CXL and HMEM
Date: Fri, 17 Apr 2026 01:44:28 +0200
Message-Id: <20260416234428.13623-1-tomasz.wolski@fujitsu.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20260416224618.12987-1-tomasz.wolski@fujitsu.com>
References: <20260416224618.12987-1-tomasz.wolski@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One additional remark:
I observed one isue unrelated to this patch during tests
on our AMD machine with two CXL physical cards installed.
Region teardown with "destroy-region" fails with "Operation not permitted":

cxl region: destroy_region: region1: failed to reset decode: Operation not permitted
cxl region: decoder_region_action: region1: failed: Operation not permitted
cxl region: region_action: one or more failures, last failure: Operation not permitted
cxl region: cmd_destroy_region: destroyed 0 regions

Region lock is now correctly set by a fix "cxl: Test decoder flags as bitmasks" 
(commit 0a70b7cd397e545e926c93715ff6366b67c716f6) but I cannot see any option
how it can be unlocked to proceed with the teardown?

Without the lock I'm able to destroy regions:

>static void cxl_region_setup_flags(struct cxl_region *cxlr,
>                                   struct cxl_decoder *cxld)
>{
>        if (cxld->flags & CXL_DECODER_F_LOCK) {
>                dev_err(&cxlr->dev, "cxl_region_setup_flags: would lock, flags: %04lx\n", cxld->flags);
>        }
>        if (test_bit(CXL_DECODER_F_LOCK, &cxld->flags)) {
>                dev_err(&cxlr->dev, "cxl_region_setup_flags: setting CXL_DECODER_F_LOCK, flags: %04lx\n", cxld->flags);
>                set_bit(CXL_REGION_F_LOCK, &cxlr->flags);
>                clear_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags);
>        }
>
>        if (cxld->flags & CXL_DECODER_F_NORMALIZED_ADDRESSING)
>                set_bit(CXL_REGION_F_NORMALIZED_ADDRESSING, &cxlr->flags);
>}


[    5.155997] [     T12] cxl region0: cxl_region_setup_flags: would lock, flags: 0030
..
[    5.130070] [     T12] cxl region1: cxl_region_setup_flags: would lock, flags: 0030
