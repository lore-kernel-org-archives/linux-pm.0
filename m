Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E734948C8C4
	for <linux-pm@vger.kernel.org>; Wed,  2 Sep 2026 12:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788353004; cv=none; b=mNSfvI0tqkAI7YJY4kEs6zW4xXzTrMHg1J2Sgs8/frcvipC3+zeAQmVFOs9eMNvcEtBrU3gDaMRaqVbBSHIW4eRtYzyJLWplVAg2vtpkS+xC6dosMh2b3KRsLB36Aqi9KxGzg+uxrnvlFoRkbEX47xy52uqTzcV5pjDNOi6KcUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788353004; c=relaxed/simple;
	bh=KWxeaw4SqgJJYFipoOgPLMzIlFPH9Zm4+s1jmrG8vBA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jre+MVOsHQctVS3SeaJr4Q6PIiNZy+IZItBrcxBDmAiVisNZj0MoJzC6O+9GbqyEhDsgeFB27r2XLwTmgPRg0R81za63fVUiuwYLVa0apVbizlCZqLPTcUXU89UfU38RMW4z1wZM/PTktntBk7hMO/HECo6B7wQZ3v8XeBBg7CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=aeK9264Z; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="aeK9264Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1788352989;
	bh=RIYFal+fK1qzQK9RpT8qrCUAIsMarf0Kb/q1Y0aaglQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=aeK9264Z8Y1P2g4PtaNEGi12AEZueIMQ3WHgGyPZkIAtl2VkA3z3KdWJw5WFzg2fv
	 a9Qd1ceE4JZu+2V4MBMfgilrNoAXLE+yUeW5eBwGCi81UL+I/Yk0QC7wZC4necufiH
	 7XpTyZSLbHsFPWQ2rTbpaNhlPiUavkTB5I+iEi7g=
X-QQ-mid: esmtpsz11t1788352985tf7711f1c
X-QQ-Originating-IP: hOX3m1P1K98ryeLZYaywOoYyspy7Wn2eDC55Gnk+wAs=
Received: from SW-U22IC-015.dc.com ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 02 Sep 2026 20:43:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14759197496904960009
EX-QQ-RecipientCnt: 13
From: Peixin Xie <peixin.xie@linux.spacemit.com>
To: rafael@kernel.org
Cc: andriy.shevchenko@linux.intel.com,
	hansg@kernel.org,
	helgaas@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	lukas@wunner.de,
	mika.westerberg@linux.intel.com,
	peixin.xie@linux.spacemit.com,
	sakari.ailus@linux.intel.com
Subject: Re: [PATCH v1 0/7] ACPI: scan: Address power management initialization and PCI devices handling
Date: Wed,  2 Sep 2026 20:42:05 +0800
Message-Id: <20260902124205.1458089-1-peixin.xie@linux.spacemit.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <3435655.aeNJFYEL58@rafael.j.wysocki>
References: <3435655.aeNJFYEL58@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NMGzQWUSIfvTteGTh+l0GykwvA4KWvbxHz2TrvADUloKZTGne/rEZepB
	HECXvWkNg7+ju1S2ttnv14rfyL7PKrxQiRl8zx5MSby3hbP2+6hkEmlgymw2QNY10E2mDbL
	RQ+j2hIc2RB0NRv6iGQlhBRRk/FZgoGTzPeLfsulzreuYddWJqavESFC65dGaNureFIOBQW
	AmVM4S6XjQ5YvSSC8TymR8dRRru+S9siNm3FACgmK+NuG3Bk5pYG0wI55F0FVZ4T3hYGPI+
	Rp0gsJ2a/RNC1PBBczcufdGGRpDvGjupDzgWrgNXiFvOm6taZYXIfe+DXQx9mCyOIdHutSM
	NtykN2OPZQY7dPErqIMNjnc6Sx0938rooOlg5aQZXugZwG5riTyBFiSNEjJ9JFi0B8VSeih
	98UyJxWqfywg15xrg90UGCAoCOkr2d53cqKXSaSzbJRjgCuRqGkdbWZX1ZxVAK6Muc5t/Uo
	Z8GQifdImU8cuc4Cm8lt7R7twa2LckgyrKS3swj//A8/D4Klh2McnQWQtzT2jAxfJ11vYsi
	6DMp4SpFbcaILB9aYbSvV/MF5HiGB5WfuDYnYNfO2cq/MwIpN2M7UuQYvO+sKNXUYTXINPF
	4hDbkwT7CWuG+PSjKhUcYOgJQXwhpYTXRhS+qV7b47N37c7lxJm8Mp40E/Hi5OUtEu3sOID
	2Z0T3D1hnenQV8EbF1fUffRQJ2DmnTjC53hTKdWDU93Tm3WcYF2qNXSRC5072a3BDMe6G7Q
	oydgJhEn+IUGhBfqXfcvKi+kBO1KTukNVXKL6e77tRDeS7ewWpzW/DVSbppRFU2vc0XR6PU
	7eP79FCRn6JOn9uNQaUCKEeM6nEo5bnn0oersodO8gCEOaeDT65AeyfChfURvnOzcWn8d22
	zpJEIxMBmQKvwu1zVVmzHf6GX3X+LKM2ZCUr3mCNdMWaGWzQfVfW6LhnRudPcn0vg3bMw8x
	KWG7H3sTF05bq902F3/9iyMM2HFRvBHMXCdwReHjcV237tKJWoDXsemfpt7YOBy/W9V92MT
	vd6YMqaZvm9f9SrMXMnk0IuYoBS+pEhTiR7PNJ/NjZq29Xy1Hr20uMygS3oa/ikyIhPWcxu
	wZXPD/T9KkHQh6iFLy8H3E=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

Hi Rafael,

On Mon, Aug 31, 2026 at 06:20:42PM +0200, Rafael J. Wysocki wrote:
> Hi All,
> 
> This series aims at addressing a few issues present in the core ACPI device
> enumeration code, mostly related to the acpi_bus_attach() function (that
> gets renamed in one of the patches).
> 
> The first one is that, on some systems, ACPI power management is initialized
> twice for devices that have missing dependencies to start with.  An attempt
> to address this issue had been made during the 7.3 merge window, but it had
> to be reverted [1].  The approach used here is roughly the same as in the
> reverted commit, but it takes PCI devices (which are a special case) into
> account.
> 
> The other issues are that flags are unnecessarily cleared by acpi_bus_attach()
> for devices with missing dependencies, the "initialized" ACPI device object
> flag is not particularly useful, the "visited" ACPI device object flag is
> used for two different things which is confusing at best, and that PCI
> devices are handled by acpi_bus_attach() like any other devices which is
> a mistake.
> 
> Please see the changelogs of individual patches for details.
> 
> I have tested this series on a couple of machines, but let's see what
> Sashiko has to say about it.
> 
> Thanks!

I tested the complete series on the SpacemiT K3 RISC-V Pico-ITX platform
where the original duplicate ACPI PowerResource reference issue was
observed.

The power resource left on by firmware is now turned off as unused after
the namespace scan. After the device dependency is satisfied, the power
resource is turned on once for the device and is turned off normally
during runtime suspend. Runtime resume also works correctly.

Tested-by: Peixin Xie <peixin.xie@linux.spacemit.com>

-- 
Best Regards,
Peixin Xie
