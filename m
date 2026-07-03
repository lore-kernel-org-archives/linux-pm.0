Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A172C9D
	for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2026 18:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783104432; cv=none; b=pPEEYOkl7f20La7BSRKntI1dQ6F9rvg2IXSrKcJoN+2QqCzWsonfjV5RrV4+3Rln737vrD0Vf807EhUjBivc8kigYOAA+by0XY+u4Z+/qnagRVb5o5lXPqXbRCl7d81MKY8mTprNKujMu7NDunUaamMwR8cLkiC2HXxd9d1uEfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783104432; c=relaxed/simple;
	bh=p4XO1ZsrfCvm+JRvGMocTQQ7CwSGJ4XFbOeDEwwHdyo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=MpqcLnwVWIRy/sgMX9xrw/2d8shtvF0zNs+jN4Dogh0f1WKazaTlyeMyssZ13Md+LmxtXJBJsmFHLi0cbbclhOw9va0bfu8ZcvemBxSvxGpN39Qle31b9XdANbvLBUUi5qxOLjcSONwS6jQwTVhgDA5BX/SpXAygWxRduhxd+hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+X78nSt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+X78nSt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 633791F00A3A
	for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2026 18:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783104431;
	bh=WSHkPufvRxell47S5RaReeupVMfOx71kVBmiWgWD1iQ=;
	h=From:Date:Subject:To:Cc;
	b=X+X78nStVxeaL5nfx8HTBtlF+s+rK3RPaOGaKKKaBQtLLa8gNInKY+zueFxSM4Iqp
	 5BkDbzRG+e6S25XBdber0lF7S53wUL1Zz+9YaBDgoSnCSe5bPvO7Q6B5nyJnYrL2IB
	 DvRGk++DCXZ6jOYCKB7sHFHKUFMg0hbuzVsYsEYuynxU7tj9fJQLsco8czCl0pyYn7
	 brVahAYgXWWacKDy4rKRTgYNBZdEINYJgjsh01E9EMJlDujZtF1tl1jpomuobnXzJn
	 XPJX83ukFkTp09QcAsapzwUp/QAUj/altLMAmlLdKG8YMelObbja5XfqodGxjAOyzx
	 4DrvquiLkIVnw==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aeb36ed873so656890e87.0
        for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 11:47:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpZEx9sP88X6qLhx+owqnrasYb9HT1p7wZNRuo12ErHUhjLqCf4ABOW8Zt3BwXMHevID7XeHDViGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdeVavkaC5Lh4XQQd6VODSERpgiCdmqO6U3S1v9W3yjjVusTrS
	/O9zheadjsguUI4YXgTgzWeKz12B+q3vcXSwbZJNSy3wipeRzsaTKUzQ53v8ZC7cemNh5b5sXOq
	t0pRw0WNTirOUZhQgoYnqOpCZ6bYIjRI=
X-Received: by 2002:a05:6512:6416:b0:5ae:ba7a:1790 with SMTP id
 2adb3069b0e04-5aed5086ce1mr31552e87.11.1783104429901; Fri, 03 Jul 2026
 11:47:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 3 Jul 2026 20:46:57 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ic0MROqd3-CEKvVpFPf9MPDoYHW+VU3cL2_Dwi37DJLg@mail.gmail.com>
X-Gm-Features: AVVi8CeUgRVgM-oCHm1cpnM1k3L51q5X2SY13dyxn_ThSaCHUPETglsVPIpJM5Q
Message-ID: <CAJZ5v0ic0MROqd3-CEKvVpFPf9MPDoYHW+VU3cL2_Dwi37DJLg@mail.gmail.com>
Subject: [GIT PULL] ACPI support fixes for 7.2-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-7.2-rc2

with top-most commit 973772c7cf647cf4da6badd86c484f9b350eea18

 Merge branch 'acpi-tad'

on top of commit dc59e4fea9d83f03bad6bddf3fa2e52491777482

 Linux 7.2-rc1

to receive ACPI support fixes for 7.2-rc2.

These fix a coding mistake in the ACPI TAD (Time and Alarm Device)
driver introduced by one of its previous updates and get rid of the ugly
#ifdef __KERNEL__ conditional compliation in acpi_ut_safe_strncpy() by
redefining that function as an alias for strscpy_pad():

 - Add a missing ACPI_TAD_AC_WAKE capability check omitted by mistake to
   the ACPI TAD driver (Xu Rao)

 - Define acpi_ut_safe_strncpy() as an alias for strscpy_pad() which is
   viable because that function is only called from kernel code (Rafael
   Wysocki)

Thanks!


---------------

Rafael J. Wysocki (1):
      ACPICA: Define acpi_ut_safe_strncpy() as strscpy_pad() alias

Xu Rao (1):
      ACPI: TAD: Check AC wake capability before enabling wakeup

---------------

 drivers/acpi/acpi_tad.c           |  2 +-
 drivers/acpi/acpica/acutils.h     |  2 --
 drivers/acpi/acpica/utnonansi.c   | 16 ----------------
 include/acpi/platform/aclinuxex.h |  1 +
 4 files changed, 2 insertions(+), 19 deletions(-)
