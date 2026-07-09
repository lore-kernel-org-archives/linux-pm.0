Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0901B217704;
	Thu,  9 Jul 2026 12:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783601284; cv=none; b=ZL1HP2hadeZWlVqYlG4ZZo5QRDVi14O+2rCT+8E6RWlJJR2VUWa0msswxKM7L2aMh/+kVcWN6FX7FQXNcUHba6+s0+zvMt+K+MYcK+MEi05i/8WRJ2TGcMIOWbwu7HGy4E+DUK2viuFfk1iSV5K2xm7FMg6LPjTGCo3tpPHMhZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783601284; c=relaxed/simple;
	bh=dxoO/Pa+JEKfvMk4/p3O1ykEr0baJhD9aXr2Bk6sWMI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tnqRi5mj4V6pOpiIM0jiiyJB3D682pTDXPITRC0hkG/j58zGCTmkrkhmU3OXA9dzzjP2bG8V3TPi9lqur2Ai8MWtJn+RCpH+bLhg85RXHgSR01gZ+7v+xQXyG/8UgmimjefKdtZ9ifdjzvcRcdpcOwSze1rMLNSdTxcxeu66j3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l70e1qqC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l70e1qqC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37EF1F000E9;
	Thu,  9 Jul 2026 12:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783601282;
	bh=VhUP/7R7nJhiPC32y5PgnRSuN2CV8A7/bOd1FIFQ3yk=;
	h=From:To:Cc:Subject:Date;
	b=l70e1qqC9d0TvCGaUnN4uEfWHAcfoij+Rc1d+5z1mv6C3Mii/tm8639eUSR81IPov
	 WBHB0Rw4zuJeRQ4fygVIU1eMrISw1s2chQ0P/QZObPgBsASXC8yap/Mt/k66a4V7uH
	 xM1JJhu7xMbaGqK5Ku6QO1fWg77yPzQ7rrDdR5MYTHrcBNuv+Lg10TYzMBNKm+JyLG
	 ut0jqmrAnie0HwUphmBkpFg+at1UeF1+uT/x8RY5haWzlVLhek6rbfwwyVmYMfGZWj
	 YnkHTDPTqUNRCougv/CBY51WbC0AqDiQHk1QlQOTwMm/YBYIUxdZy3JV1/Pf737rs8
	 9p85fPSpN1fmQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 Sudeep Holla <Sudeep.Holla@arm.com>
Subject:
 [PATCH v1 00/17] ACPI: processor: idle/intel_idle: Add ACPI _LPI support to
 intel_idle
Date: Thu, 09 Jul 2026 14:29:38 +0200
Message-ID: <4746278.LvFx2qVVIh@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi All,

This series rearranges the ACPI _LPI processing code and adds _LPI support
to the intel_idle driver.

Patches [1-16] are preparatory, the last patch makes intel_idle actually
use _LPI if available.

Patches [1-15] update the ACPI processor driver, intel_idle changes are
introduced by the last 2 patches.

The first patch can be regarded as a fix, and the second one gets non-FFH
idle state entry method out of the picture.  Patches [3-15] are mostly
cleanups, but they also split the _LPI parsing code to separate the part
of it that is going to be used by intel_idle (and that part is moved to
the non-modular ACPI processor driver code).

Thanks!



