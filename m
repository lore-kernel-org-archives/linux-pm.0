Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57823E1689;
	Tue, 19 May 2026 08:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779179116; cv=none; b=hcg56Zw6fnhM63s1kNG2Nx0iIRFyofdxHcsPyZkavEOTDrZ1uJL5Cygy6qQyNH9r/TgIZxn0ELWcdXhK0LPBPVxNS2+J8YWoX5AINCBQSnYmChY1HqSmoqric8znIVkcvbaiZdMy/WAYsmvIkRBhiusv47rZHtHfLZDJ2FVpdHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779179116; c=relaxed/simple;
	bh=GczDtyA7QqyhgpCt+uS5CB8iB1mmQPJ5p+3j3+yEVDU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fhO7yqjZlQdbeiBMGhSc9/xeA2EYuGLpkJK4KnKPnTSkbrRE+Ek0gLwQvnUz8phU5ZxuuvCn74+bwI2sl9U0tI2Jdw3d6pTHMNkl/cZbVkyMJqlqGq6N6x1ERGGVrjbPwpChNPUJ7a9tZeL7nxm+OTVOtSHPNpfGLYi8IqQa6Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=FBTVmONd; arc=none smtp.client-ip=139.138.36.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="FBTVmONd"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1779179115; x=1810715115;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GczDtyA7QqyhgpCt+uS5CB8iB1mmQPJ5p+3j3+yEVDU=;
  b=FBTVmONdkiCymQR2yswNyEmxJVSdKhlzGXSJLdC88E1bzl9sdKf4NojA
   RdUvNOkq5c/DoRmbjIAJ4q1liuWrMUT0gdR89wbOUfKYZAxolvg7UXRls
   ieuz3OZS8w9CdPd+6KjP3pEtng1PkVrfQqVRDll8/EDCxDEkOe6ktKDFM
   gKe2ZBdNavlYtlwSpG6NtN6qQ+1eK3pXDz7f4k8ijQHVj7uYBHl1jq9Tf
   NH85AbLZrAkM4IJ/sZ193VKHbjTM7Nmm52CfCGC185p4mB+RMptobG8d4
   KWS8QryLa90j2wAqT+SKSnpJRtswy5/9r9hoVBs1cn23aa1OYh6Ggs81p
   Q==;
X-CSE-ConnectionGUID: UBXCnxP2R4u09n3DKVCSbg==
X-CSE-MsgGUID: QiBQK/B8TMSKjTz4DoQaPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="228455610"
X-IronPort-AV: E=Sophos;i="6.23,243,1770562800"; 
   d="scan'208";a="228455610"
Received: from gmgwnl01.global.fujitsu.com ([52.143.17.124])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 17:25:07 +0900
Received: from az2nlsmgm1.o.css.fujitsu.com (unknown [10.150.26.203])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwnl01.global.fujitsu.com (Postfix) with ESMTPS id 5C2821000145;
	Tue, 19 May 2026 08:25:07 +0000 (UTC)
Received: from az2uksmom1.o.css.fujitsu.com (az2uksmom1.o.css.fujitsu.com [10.151.22.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgm1.o.css.fujitsu.com (Postfix) with ESMTPS id 010D8C03707;
	Tue, 19 May 2026 08:25:07 +0000 (UTC)
Received: from dhcp-portal (unknown [10.172.107.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmom1.o.css.fujitsu.com (Postfix) with ESMTPS id 6D5671800C07;
	Tue, 19 May 2026 08:25:05 +0000 (UTC)
Received: from isar2.ecs00.fujitsu.local (unknown [10.172.183.27])
	by dhcp-portal (Postfix) with ESMTP id B25F960A84;
	Tue, 19 May 2026 10:25:04 +0200 (CEST)
From: Tomasz Wolski <tomasz.wolski@fujitsu.com>
To: alison.schofield@intel.com
Cc: ardb@kernel.org,
	benjamin.cheatham@amd.com,
	dan.j.williams@intel.com,
	dave.jiang@intel.com,
	jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	nvdimm@lists.linux.dev,
	smita.koralahallichannabasappa@amd.com,
	tomasz.wolski@fujitsu.com
Subject: Re: [PATCH] dax/bus: Upgrade resource conflict message to dev_err() in alloc_dax_region()
Date: Tue, 19 May 2026 10:25:02 +0200
Message-Id: <20260519082502.18627-1-tomasz.wolski@fujitsu.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <agX7LCdvy38_z4Pt@aschofie-mobl2.lan>
References: <agX7LCdvy38_z4Pt@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Alison,

>> How about using request_resource_conflict() so that we can offer
>> more description in the error message?

Thanks for the hint - I will add that in v2.

Best regards,
Tomasz
