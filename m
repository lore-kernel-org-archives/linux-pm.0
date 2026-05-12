Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A477360EEA;
	Tue, 12 May 2026 12:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778590758; cv=none; b=Lx1RmHHCzued+2V6XtwafkaKbR4PEfuYRBds8aAGXAS5MdikjwQcRy5pjAZFioxA6t66vAM1p0l5VAvuu8nUy1D/2I4j7fFNQDH7wrg4fuxDWwUIGSp+WYbsLxPDFoUvHu2o5WpAaL9kq208VWGeS18uYZtC0Ior/V9bhOckPcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778590758; c=relaxed/simple;
	bh=8k/X+GBcN3HecsH9d0ZY/G38JCz9EdOaVsc9Cwpw0Tw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ob4+iMFpl4fYej3eB3JQLbptomHqPOEpfJefj7ZFvsNLBSVh+Ug8rzgPYKoHFvM47CjSwleJnZCtgpwYogyzKrfkxwtUc8dleORzRv08qdONze/rJokh3V8esXhtB60s/PWTITkxQ03j1OfBCwzc6jZ9MEE2IXJMxxcJ/ewbknE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=P5Od2HGZ; arc=none smtp.client-ip=139.138.61.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="P5Od2HGZ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1778590756; x=1810126756;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8k/X+GBcN3HecsH9d0ZY/G38JCz9EdOaVsc9Cwpw0Tw=;
  b=P5Od2HGZB9IAOU5LyUSwSP9luvp8NHYKITSaosgk+G1gNlcYkpW7Uh04
   zrBIXiPqABpzGzTY18JRaAzRbD/YrDjZzhaolr9/cc97IkT5wyJD/zqKa
   wqRxNtqVXR3ho8f068PTJFK/DKPZj5Gd5JOU5KdUfagc5MNn7vJ4EckJe
   nF/dMda979b6l4xsyQiYTT3/DD8An0owM8qwrlp72PReuPrcRAZ+Qbg9x
   XJXoCCU0wS/DSuOSHXJk4k1YIiwHKMYFP8gH7tH8/bBIM3wFW9pmwPpXE
   eYrYIe9f2ez44LqA5rWtmoeHm2Gbs81bhWVyomTXTT+/aY1om5wTQcy3P
   A==;
X-CSE-ConnectionGUID: 0kPhNcvWQ32WScYsAXMHQA==
X-CSE-MsgGUID: hPstsACCTgCfjMfKf7gCrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="218970910"
X-IronPort-AV: E=Sophos;i="6.23,230,1770562800"; 
   d="scan'208";a="218970910"
Received: from gmgwuk01.global.fujitsu.com ([172.187.114.235])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 21:58:05 +0900
Received: from az2uksmgm4.o.css.fujitsu.com (unknown [10.151.22.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwuk01.global.fujitsu.com (Postfix) with ESMTPS id 3309BC000A2;
	Tue, 12 May 2026 12:58:05 +0000 (UTC)
Received: from az2uksmom1.o.css.fujitsu.com (az2uksmom1.o.css.fujitsu.com [10.151.22.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgm4.o.css.fujitsu.com (Postfix) with ESMTPS id E049A140036C;
	Tue, 12 May 2026 12:58:04 +0000 (UTC)
Received: from dhcp-portal (unknown [10.172.107.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by az2uksmom1.o.css.fujitsu.com (Postfix) with ESMTPS id 88AB01800A41;
	Tue, 12 May 2026 12:58:03 +0000 (UTC)
Received: from isar2.ecs00.fujitsu.local (unknown [10.172.183.27])
	by dhcp-portal (Postfix) with ESMTP id D3033608BB;
	Tue, 12 May 2026 14:58:02 +0200 (CEST)
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
Date: Tue, 12 May 2026 14:57:59 +0200
Message-Id: <20260512125759.30007-1-tomasz.wolski@fujitsu.com>
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

Hello Smita,

Do you plan to address the remaining minor comments from Dan and Jonathan in the next revision?
https://lore.kernel.org/linux-cxl/69c1a8d1c0fa9_7ee3100a1@dwillia2-mobl4.notmuch/
https://lore.kernel.org/linux-cxl/20260323181331.000018f2@huawei.com/

Best regards,
Tomasz
