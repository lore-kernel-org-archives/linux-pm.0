Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175D02D0C62
	for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2026 17:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496462; cv=none; b=i5gVDEHLHHLaxkwueQWXPR6/j5xsXOENuB6OeIVzerWUcqnSlP1a32Fnet4ZLuqQrNi7uC3MiC7kF3Odhcw18Nrp1+mOdZCMFnp2k2Y34Uvupj05qoHvcEGslfSKGQZ4g5iD5UxHuFLLynWAnmOVit3rpnFlGM8KK+zwm+F0XQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496462; c=relaxed/simple;
	bh=Ht5mz5iY/NG0SVoMITIipCLXayAlGaDGHJdBjuk5Ok4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=idXaJ7Lwex5BfQ3RPdnxCWZUdtcHw6Cx1PByq8mph6qMP09xWlsgNGRjJKFzlZPVQ0kqasszkgBp9XkNTPWRkDphbgwDI0xmLu2aQpCCwZsxgUJLP8/rOdk5+YWASrDJMrILMcmMhaYHFz6CWD8/EqYCpd0FRQiXB/b27Bp8JGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZoSd9gtr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZoSd9gtr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C79E41F00A3A
	for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2026 17:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782496460;
	bh=x/SgCR+HaHhSO+yqoBtBQASbMYmwZy/53Q9iajJvgow=;
	h=From:Date:Subject:To:Cc;
	b=ZoSd9gtryT2rHhEakGI2yt6KE6wZSK9kpA4fU7vnVwu381W36dbzT/7gjm7E4rJJs
	 HjhVGPtK7LUKoq6nvfhFOKrA5RB/YJSAzuULzmXOs90zMOwz64LR/LrviY+pJBF6UE
	 uRCVd1M8ta++PZBjdj3cKZ5n3lpgRQPoMjF1mrkAzr8sozyaeiDUTBiuaxwgPU8wx+
	 zci66hijyK3lkg/nKFDxIeTIBB61++TvrjtCtxr+1UM6AiJmzLn6/d8Cpl6DRK3Xyx
	 cnAKa/0E87J85hDLtFr3DaSqK0zKhRtAqSPDvQuT00T88IM+3QOHvB40Q/RLMxIh3a
	 utpgkCduUiZVA==
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-59f8a140a51so963487e0c.3
        for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2026 10:54:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rr8efIFMtjSMKlgiGZP95TfM1aQUQGA215zZ8NA+XcorPy4RR+UlOQi0QMXGR/Z8NNMkTP1I2t9Kw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMzLzzguPPhLS7naXxRiRQqoT15Thu7PCoMoaw50scDXByrwl8
	E9qKTk8xw0gocqq73ImV6Z4gYsJi1tKWgTzSqBlSSQq/3pPhIsyYIjFApALUszCob/qJb8H/Kgn
	+Qw2vJF9SSnL3XWitFzuySz0JjVxAzkA=
X-Received: by 2002:a05:6122:551:b0:56f:22ad:f5c9 with SMTP id
 71dfb90a1353d-5bd69c4a4a2mr3947907e0c.2.1782496460087; Fri, 26 Jun 2026
 10:54:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 26 Jun 2026 19:54:06 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0juZ6YJVALVEi1s_O0qgcr_o880TJbRHXWsd-Drb-sUXQ@mail.gmail.com>
X-Gm-Features: AVVi8CfAO1jyVAGmDFNyo5xG30shivNUG5b6heAKo8R0i3NRQiSjQ-YsEda-PAs
Message-ID: <CAJZ5v0juZ6YJVALVEi1s_O0qgcr_o880TJbRHXWsd-Drb-sUXQ@mail.gmail.com>
Subject: [GIT PULL] ACPI support fixes and cleanups for 7.2-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-7.2-rc1-2

with top-most commit cf1e70d021343d33728e54a6227607925c8d5419

 Merge branches 'acpi-sysfs', 'acpi-resource', 'acpi-driver' and
'acpi-processor'

on top of commit eed451031f6ac098ca04ebdd63d34e083ba2d6f6

 Merge tag 'acpi-7.2-rc1' of
gitolite.kernel.org:pub/scm/linux/kernel/git/rafael/linux-pm

to receive fixes and cleanups related to ACPI support for 7.2-rc1.

These fix assorted issues and do cleanups in the ACPI support code,
which includes a fix for tools build breakage related to strncpy()
removal:

 - Unbreak ACPICA tools builds after switching over to using
   strscpy_pad() that is kernel-specific (Rafael Wysocki)

 - Fix module parameter file paths in comments in the ACPI code managing
   the general sysfs attributes (Zenghui Yu)

 - Update kerneldoc comments in the ACPI resource management code to
   follow the common style (Andy Shevchenko)

 - Fix inverted interface check in ipmi_bmc_gone() that may cause ACPI
   IPMI interfaces to be mishandled (Xu Rao)

 - Add __cpuidle annotation to idle state management functions related
   to ACPI _LPI to avoid trace-induced RCU warnings (Li RongQing)

Thanks!


---------------

Andy Shevchenko (1):
      ACPI: resource: Amend kernel-doc style

Li RongQing (1):
      ACPI: processor_idle: Mark LPI enter functions as __cpuidle

Rafael J. Wysocki (1):
      ACPICA: Unbreak tools build after switching over to strscpy_pad()

Xu Rao (1):
      ACPI: IPMI: Fix inverted interface check in ipmi_bmc_gone()

Zenghui Yu (1):
      ACPI: sysfs: Fix path of module parameters in comments

---------------

 drivers/acpi/acpi_ipmi.c        |  2 +-
 drivers/acpi/acpica/utnonansi.c |  9 +++++++++
 drivers/acpi/processor_idle.c   |  4 ++--
 drivers/acpi/resource.c         |  6 +++---
 drivers/acpi/riscv/cpuidle.c    |  2 +-
 drivers/acpi/sysfs.c            | 14 +++++++-------
 6 files changed, 23 insertions(+), 14 deletions(-)
