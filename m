Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1427E327C09;
	Tue, 23 Jun 2026 16:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782233863; cv=none; b=gXpY6QCXueWQDGztqvbrhad5zkoQSH83mqdTPFg6vteGrvw6KoAbNQUrwFHoBtnJeRmlW90wCP48Z1H9KmjeSNCeouH2/OUqlYtCJZEMxd6SsMUzMg9CcZ1c+8H6AUntYPmuGzjub+jM6OlNKIFQ2QA0tPMeg4z8TV66KOmGgXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782233863; c=relaxed/simple;
	bh=5AeTwsvDNJM7u4Jhd6v4Rb0o3GL6O9eyZvuvTncwjEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MOYsUpYaZ+ss1Ok/bqdo80l+pAyzerH7xIQTUzELA4GL3ZOstQ0jO4zFEc//FV0SkPGUavR6tMZpoGxIy+kwYdnQ3x03Ri9l06kV7IVUGHEGwuWJSa2wDiASalYpItWdV2kPTsBXM9MKLEy72B8cvyENV0NkdrKpU5YiOfTITCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=hsUdQwZi; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="hsUdQwZi"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id C2A30261AB;
	Tue, 23 Jun 2026 18:57:40 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UQN4X1_LCZvV; Tue, 23 Jun 2026 18:57:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1782233860; bh=5AeTwsvDNJM7u4Jhd6v4Rb0o3GL6O9eyZvuvTncwjEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hsUdQwZi0DnwcgqOQwZaSeKsxbKlpCiL4z8NyvzAH6fki79uEapA+E3NuAHcYlQJm
	 Uz34aE74tRtZ84L5WGGchp3qxatUAk561jJhRg10svGxEiV6tkNErO0YR264j9wHix
	 Qtg5d8GSwAaNHAq/mvWOiWu2//pMHV7hJg67t/tEik6aDfFrnh5EXWUeffr4LzOFGU
	 Aq2onwy9+KuG41eENxavbCvjc7QUmHXRP0vNAJJocx4gG/9FodkGTIDgxXdMFAcYtY
	 zWLVgvmN3pDGNFTMmbIjUlHLIAEO0Ertn14inCaTyzay0wuOHCS9bjtswk79dyFOd/
	 QRdm+b03Tb3ug==
From: Marco Scardovi <scardracs@disroot.org>
To: moravec@ukf.sk
Cc: bp@alien8.de,
	crecklin@redhat.com,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	mingo@redhat.com,
	pavel@kernel.org,
	rafael@kernel.org,
	regressions@leemhuis.info,
	regressions@lists.linux.dev,
	scardracs@disroot.org,
	tglx@kernel.org,
	x86@kernel.org
Subject: [PATCH v2 0/4] PM: hibernate: Add relaxed_memmap option for x86 E820 integrity check
Date: Tue, 23 Jun 2026 18:47:26 +0200
Message-ID: <20260623165724.10753-1-scardracs@disroot.org>
In-Reply-To: <cd45c7c8-4df9-4963-b847-02cf72bcc039@ukf.sk>
References: <cd45c7c8-4df9-4963-b847-02cf72bcc039@ukf.sk>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Rafael, Milan,

> ...
>
> Hibernation in Linux simply cannot cope with a changing memory map in
> general, sorry about that.

You are totally agree. While mine is still a solution for these like @Milan
with a buggy firmware, it's not a solution to make it unconditional for every
device so I came with a solution to introduce the boot flag
hybernate=relaxed_memmap. This is still a bit hacky and I don't like it at
all at the end of the day but works better than nothing, at least until HP
releases a proper firmware with it fixed.

This v2 of the patch address hibernation E820 map integrity check failures
on UEFI platforms where firmware dynamically shifts reserved or ACPI memory
ranges across boots (such as the HP OmniBook X Flip).

In v1, I attempted to restrict the integrity check to only E820_TYPE_RAM
ranges by default. As pointed out by Rafael, this is risky because the
resumed kernel could attempt to access shifted ACPI tables or UEFI runtime
services at stale addresses, leading to post-resume crashes or corruption.

To address this feedback while still allowing hibernation to function on
affected platforms, v2 introduces the 'hibernate=relaxed_memmap' command-line
parameter.

- Patch 1: Declare the 'hibernate_relaxed_memmap' flag in the PM core header.
- Patch 2: Define the flag and add parsing logic to kernel/power/hibernate.c.
- Patch 3: Implement the relaxed E820 memory map check on x86, which compares
           a secondary RAM-only checksum if the main checksum mismatches,
           warning the user but proceeding with resume.
- Patch 4: Document the option in Documentation/admin-guide/kernel-parameters.txt.

1. By default, the E820 checksum verification remains strict to ensure
   safety for all systems.
2. If 'hibernate=relaxed_memmap' is specified, the kernel will perform
   a secondary check on only the usable RAM regions (E820_TYPE_RAM) if the
   main E820 checksum mismatches.
   - If the RAM regions differ, the resume is aborted (to prevent direct map
     mismatches and kernel paging faults during page restoration).
   - If the RAM regions match, the resume is allowed to proceed and a warning
     is logged about the non-RAM changes.

To support this, a secondary 'e820_ram_checksum' field is added to the
x86-specific 'restore_data_record', and 'RESTORE_MAGIC' is incremented to
signal the header layout change.

Marco Scardovi (4):
  PM: hibernate: Declare hibernate_relaxed_memmap
  PM: hibernate: Define and parse hibernate=relaxed_memmap parameter
  x86/power: Implement relaxed E820 memory map integrity check
  Documentation: Document hibernate=relaxed_memmap parameter option

 .../admin-guide/kernel-parameters.txt         |  5 +++
 arch/x86/power/hibernate.c                    | 40 +++++++++++++++++--
 include/linux/suspend.h                       |  1 +
 kernel/power/hibernate.c                      |  3 ++
 4 files changed, 45 insertions(+), 4 deletions(-)

-- 
2.54.0

