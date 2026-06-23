Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A0333987F;
	Tue, 23 Jun 2026 16:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782233866; cv=none; b=SosNLLhnFqugooywvPA9v+hO6xNbvfQEl/Clrla3xCzelyfI345lDBaHQ/JYElGIdoelLAHaJY/HKvtJC+FbIGpK+J/Z/g3VNE5UwhpML0xNpb8C6jtmvedNS2wBWKm/XfWtG2UHaWyVfxl6POGUqf5drtZopzOOTZmHdGRh4DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782233866; c=relaxed/simple;
	bh=VHgVxNRN5Im5XBJRawmCLnEIE/6ghqAsJ9LHh99k79k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iowfuLn+tm0WlEjR9MRNbSAkCa4EavMoiGNhKHMlw5RsDiw39nAfPUAhV25tN5alNi8QpqJ5C4CS9D+FTM+1rmsBl7OkPfbizRuJyR0IgbQ0B/HfgR7qczsDsQVxopnSlQfrU1GtDNmRVV4mZBSVsGVMPqsSZEVZa0vjJZZDcdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Ht6r0UDL; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Ht6r0UDL"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 6D44426748;
	Tue, 23 Jun 2026 18:57:44 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yjv_c5iy2xcw; Tue, 23 Jun 2026 18:57:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1782233863; bh=VHgVxNRN5Im5XBJRawmCLnEIE/6ghqAsJ9LHh99k79k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ht6r0UDLXdnRiQ6tc4PoO6MTi81kzgSbbKG+PxSpdeNzK/NyPqS6OZ5yML2kEuPIN
	 k72E//WppQRML9G2tGmBVIrWB/JcTq20ldBNftccNbT6R+X3iesQnsuuoqlx70L+OV
	 aPZlI+LNTZH14bcOags1WC53R4pATxuV3PX30kwzriCUlu+Hr/+iZ/4yaCn6hF5gJX
	 RkHxtF0W/iHWuw2RjO+oVZ0Qo/+/F7BUqEZlK7/7TW1IIYloF6De0SUjtXl0CGguuJ
	 pBSP4K4rNDyxBTOdMLzEfMjHF4/pRK2UZJtEzKSUCj0bazEE1glV2mIRPbhhisAELy
	 KUdCh2MOb5qPw==
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
Subject: [PATCH v2 4/4] Documentation: Document hibernate=relaxed_memmap parameter option
Date: Tue, 23 Jun 2026 18:47:30 +0200
Message-ID: <20260623165724.10753-5-scardracs@disroot.org>
In-Reply-To: <20260623165724.10753-1-scardracs@disroot.org>
References: <cd45c7c8-4df9-4963-b847-02cf72bcc039@ukf.sk>
 <20260623165724.10753-1-scardracs@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the new 'relaxed_memmap' option under the 'hibernate=' kernel
boot parameters.

Assisted-by: Antigravity:gemini-3.5-flash

Signed-off-by: Marco Scardovi <scardracs@disroot.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b5493a7f8f22..107935c585e4 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1967,6 +1967,11 @@ Kernel parameters
 		protect_image	Turn on image protection during restoration
 				(that will set all pages holding image data
 				during restoration read-only).
+		relaxed_memmap	[x86] Relax E820 memory map integrity check.
+				Instead of aborting resume on any mismatch,
+				only verify that the usable RAM layout remains
+				identical, and warning-only for shifts/changes
+				in reserved or ACPI ranges.
 
 	hibernate.compressor= 	[HIBERNATION] Compression algorithm to be
 				used with hibernation.
-- 
2.54.0

