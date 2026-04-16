Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667A229ACD7;
	Thu, 16 Apr 2026 22:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776379600; cv=none; b=mBqEDfZ0CAoAUOGXz2NZF1dY6D4l7lLAicXW5iQivWiFYXpAZbkYgPhYcmOj7nMw9ZUSXXne4kqSYcDm2DVMUtrykGCIrhOOaW8scpCFSZ9Rlx05syChg9nV+oW/k6tTJgmLeFcYw2FMK61kBI55vAGNWSwaIvTY95iiabZchzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776379600; c=relaxed/simple;
	bh=C13Jb6Kbsy+FPShsH2lJidLemQxpasQcKiM9wp8dEYY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ljdhHWaNQYW6Y1O01ytwpEUdCbSChcoXjpZFl8ejQ4HozDB/yJPYych172oA0Rz4K3I9hTwhX2FtBuKB+0KdvY+Cuzon35GOp3xE/RdFUTydsJTTkWnypgxxMQ9GgdgGD7+j0+z9DxMdsY9Sj/25uns2hWXZhH6DLVQLFSe5CbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=lX7Dx5pT; arc=none smtp.client-ip=68.232.139.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="lX7Dx5pT"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1776379598; x=1807915598;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C13Jb6Kbsy+FPShsH2lJidLemQxpasQcKiM9wp8dEYY=;
  b=lX7Dx5pTNRu3iLZs7dNfvhSF6xkdSd71tTZx+Ld9GB6Vel0xbAD7GSIP
   xKyWerH86gXBwHJTKhKF0lVrvtCU+YEPYfmlloqhYSB1hUiktY9oHwF4W
   wr/kDLtJ8r2wuZSGmvCvfpWVlo9RwflqniFZeH1ChadCAMqPH2pkQXWVW
   PvYBPSJLwleXk3lAUuGj0PPeg4lVZGYp/XlvPMvqp5Fvaj49oFb/0vj6J
   v2LIM//bxsKxfbHUzMHCWrbLDI9EEFQ2MClwXCPQ9SnWJBEe+Pw9abONg
   YW82gTFyULNZb+IrZuIG3+S9gqs/P4BhOcWyYMQMTHNvW8/FfXQeRN1fo
   A==;
X-CSE-ConnectionGUID: BwErwhWSScyRI26uVacBlw==
X-CSE-MsgGUID: IeFOnt6ORZGP0nMgqvwR1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="237955104"
X-IronPort-AV: E=Sophos;i="6.23,183,1770562800"; 
   d="scan'208";a="237955104"
Received: from gmgwuk01.global.fujitsu.com ([172.187.114.235])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 07:46:31 +0900
Received: from az2uksmgm3.o.css.fujitsu.com (unknown [10.151.22.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwuk01.global.fujitsu.com (Postfix) with ESMTPS id 5BB3CC01B24;
	Thu, 16 Apr 2026 22:46:31 +0000 (UTC)
Received: from az2nlsmom3.fujitsu.com (az2nlsmom3.o.css.fujitsu.com [10.150.26.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgm3.o.css.fujitsu.com (Postfix) with ESMTPS id 12F6DC041D0;
	Thu, 16 Apr 2026 22:46:31 +0000 (UTC)
Received: from ubuntudhcp (unknown [10.172.107.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmom3.fujitsu.com (Postfix) with ESMTPS id 7B4CE1019066;
	Thu, 16 Apr 2026 22:46:29 +0000 (UTC)
Received: from isar2.ecs00.fujitsu.local (unknown [10.172.183.27])
	by ubuntudhcp (Postfix) with ESMTP id 1BAD8220477;
	Thu, 16 Apr 2026 22:46:28 +0000 (UTC)
From: Tomasz Wolski <tomasz.wolski@fujitsu.com>
To: smita.koralahallichannabasappa@amd.com
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
	terry.bowman@amd.com,
	tomasz.wolski@fujitsu.com,
	vishal.l.verma@intel.com,
	willy@infradead.org,
	yaoxt.fnst@fujitsu.com,
	yazen.ghannam@amd.com
Subject: [PATCH v8 0/9] dax/hmem, cxl: Coordinate Soft Reserved handling with CXL and HMEM
Date: Fri, 17 Apr 2026 00:46:18 +0200
Message-Id: <20260416224618.12987-1-tomasz.wolski@fujitsu.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20260322195343.206900-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20260322195343.206900-1-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Smita,

Tested on QEMU and physical setups - it worked as expected
(had to disable ACPI_PRMT/CONFIG_CXL_ATL on our physical system though)

Best regards,
Tomasz

Tested-by: Tomasz Wolski <tomasz.wolski@fujitsu.com>
