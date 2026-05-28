Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68F32FE579;
	Thu, 28 May 2026 06:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779950423; cv=none; b=ra3F/Z/1INCmnXIHQ/8wsCLBIkimnbtLvzBRWWJ+u/wfJX86CLpi1TiK35stwWqaMAlNnX0OkPIy/qBgYx88txye3cO1McW2vauHbNNEMWMa/Rds6cMpz2gnTpnyMCLmJsJKKrhmrniCfjIkA1E/+lPXMu0ed62oK/89q/Tcpds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779950423; c=relaxed/simple;
	bh=Dzq99QaUsF9Zc98cd/Hd2hOxwzORJWSrqkCmv+Cz4vg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Uwi12glUpkZOste2hkFBgSzVL7BpTPv2q0cxEREiPnDkXhAGRWUc3ONwzWXmfNEc29k6I1W0sNoAB4eqjR+VU8ZUGwjqw49pNyuUW9i/xAQB6WgnvVZzsD44cm8FxGkvb8zQuQjGzhbFGk6YJZ5kKTaDOtFa6RUL7FBYhWqH8bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=W0mSlvbB; arc=none smtp.client-ip=139.138.36.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="W0mSlvbB"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1779950422; x=1811486422;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Dzq99QaUsF9Zc98cd/Hd2hOxwzORJWSrqkCmv+Cz4vg=;
  b=W0mSlvbBztjvhtYzJcDkoIv34UyxbdGCkyO7Uw3VgN6bPTFhUCGuTaWN
   Wenm7FU+1E4l79pXw2tDe5ZNejCGQlshxDLtnoLJCf3q7fxjZ2/qqF6xc
   zpTpEvK9fO/kygJujRoyOID1s6MbHY+j59nnPuv5++TUYt0X8CBB/5HOu
   E4GBt18bR58yXPWQU040dMbWI4k3p5NWYk05v0td4mZMt+tWaHqy+MKwh
   01cxlLEdkUoOHZ/rT9CWWQrwv9dvvpJnGbuCUFJ1jyRrYlFzf24aAQnW/
   usGuDPLYTIQA/lBGutd5qDmOk7VBRr4tLDwdWIT6HKxPI2SloGTwBgv7/
   g==;
X-CSE-ConnectionGUID: EB6u/lAcT8mtHfbIIWmv4A==
X-CSE-MsgGUID: 2Mc3cgGDTCedIQHKhnIg2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="228284242"
X-IronPort-AV: E=Sophos;i="6.24,172,1774278000"; 
   d="scan'208";a="228284242"
Received: from gmgwnl01.global.fujitsu.com ([52.143.17.124])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 15:40:14 +0900
Received: from az2nlsmgm3.fujitsu.com (unknown [10.150.26.205])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwnl01.global.fujitsu.com (Postfix) with ESMTPS id 0019D407578;
	Thu, 28 May 2026 06:40:13 +0000 (UTC)
Received: from az2uksmom2.o.css.fujitsu.com (unknown [10.151.22.203])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgm3.fujitsu.com (Postfix) with ESMTPS id 9D95F1941AFE;
	Thu, 28 May 2026 06:40:13 +0000 (UTC)
Received: from dhcp-portal (unknown [10.172.107.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmom2.o.css.fujitsu.com (Postfix) with ESMTPS id A9AF61400123;
	Thu, 28 May 2026 06:40:12 +0000 (UTC)
Received: from isar2.ecs00.fujitsu.local (unknown [10.172.183.27])
	by dhcp-portal (Postfix) with ESMTP id 4E39060A0E;
	Thu, 28 May 2026 08:40:12 +0200 (CEST)
From: Tomasz Wolski <tomasz.wolski@fujitsu.com>
To: alison.schofield@intel.com
Cc: ardb@kernel.org,
	benjamin.cheatham@amd.com,
	dan.j.williams@intel.com,
	dave.jiang@intel.com,
	djbw@kernel.org,
	icheng@nvidia.com,
	jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	nvdimm@lists.linux.dev,
	smita.koralahallichannabasappa@amd.com,
	tomasz.wolski@fujitsu.com
Subject: Re: [PATCH v2] dax/bus: Upgrade resource conflict message to dev_err() in alloc_dax_region()
Date: Thu, 28 May 2026 08:40:02 +0200
Message-Id: <20260528064002.21542-1-tomasz.wolski@fujitsu.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <ahc7h8zMaTW2XUMU@aschofie-mobl2.lan>
References: <ahc7h8zMaTW2XUMU@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> Hi Tomasz,
>>
>> As the person who caused the churn, I sympathize w you, but
>> as the person who will likely merge this, please send a v3 that
>> removes the Fixes tag, which was the other change in v2.
>>
>> It'll keep the history cleaner.
>>
>> Thanks!
>> Alison

Hello Alison,

No problem, I will post v3 :)

Best regards,
Tomasz

