Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792422168;
	b=u98SEM9VqGxsTAxIBka4viZ1iKszZwn65ExNkj7yYZrZamgx4KgXFCPG2TvIFYHENZRH
	 BVdDmJuBgE6OYl4Icu8Ik9F4ft5qFkRkCZ+DMIZR/53QgxAW+0qHcvjU/W8OTiL3seo3p
	 VxwfjvHaGYg2HlHAyNhBefJ0r+vf8qZB1zi4mL15rtb2k3SmvCGhwA+j7KIuAKAykB3zQ
	 MKkOeHPreCDWiqsIxOPheHSmUu64hX1d5eaWZyqDcnvN5z0sfc50jIZq2CipNEHI3x4Ai
	 ox7y+87CLVIS7odH0sSQHzcfheUuWy2ks1EDCisZRyuACuNIIH78uGs+Kaw+UeV1tVA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422168;
	h=Received:Received:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=MlxFy2P7Emey1T584fWadhsVAZasHmIit/rA/nKfeH4=;
	b=FyFToXM7Z7Su3MvMiMJkhYC8Pt/tBd0aBEXI810XkD0PnMNXNN1UOZyRdDarMq8lziJy
	 dg+3pJmIuv2DrU9yX1nxf2KKy+Ux9dPW6oIZpKUhIM4w8BZ7Lk89t9218nYpgWAxJQiJx
	 0wK+Xu0JeZoy71DmM/YSHxux4bSzlHMJOSQaSBkGnzZ4kGW1VKmibOb8/+15/K4zp8UkO
	 nqXnhQRodA3FZfrTOw7lehpUihfZ0RhR+kqJ5eJZTHdBRU9CVNkAkIqyuvdjd63vtezXu
	 GKy2aMkIz/WdqE/ZsO4G7NbtZFvuaZWDftFFDBEd0fCLoRM3Zyt1gr0SQ4q68PGwZuw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ii9wpsZ6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A635607BF28
	for <linux-pm.vger.kernel.org@localhost.mlmmj>; Mon, 19 Oct 2026 15:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ii9wpsZ6
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B676513D0
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 15:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792422168; cv=none; b=BfYztvlCVYWY7Khf/RzaFPJVswi1GURex4KLl+JHmV/9anqIPzy6x0e2sSxM+d0fPMkt6wJdA69Aj5RRkjFxmu6OOxrYtrOck1KS7m60NUryn3DuJP6mUjGxenfJREVFhAlnmWqntr6FlwQtFttFh/JCX8/n7h96i0Nf+B3wdZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792422168; c=relaxed/simple;
	bh=MlxFy2P7Emey1T584fWadhsVAZasHmIit/rA/nKfeH4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=PaW/aEiewZIohCKqNKVHUnltgmxG+ApdtpBvc3U2M1FO75+09CUDWNxmN5VOdEor9d8Q0mt8AoUjxa3zUKmiDhkeLCiYo1WSb2KtMNkK/9C4C/+hVSsmBSjuR0xujIXdl0kinP2FfZ+rrhoKjdapW5I81dfhuf+vr8YpV2MzCjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ii9wpsZ6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B011F000C4
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 15:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792422167;
	bh=MlxFy2P7Emey1T584fWadhsVAZasHmIit/rA/nKfeH4=;
	h=From:To:Subject:Date;
	b=Ii9wpsZ6Ud2vdkM9mV2z3bxh6hCzkiS3ZWetRBew86oAKkYpdB/v0+lsCiTJ1ItVu
	 fMqUqGa9pzg8KDi7vnqOv82rPsPSfRrmSvCurkRqZaLGUOzJZs4fodIBwKz49/kknJ
	 ILWiJVYbttYxYVKV1tj3TmHjLEI8nvLNBbqVTYjbkmNngofyCI01gHwXW6SQifLrxz
	 hugshgDzXYwklRjeHzMOBwYWuZhoFpdlcmbMtiqncIpMTrD1b3QBO2dvqLNeJJ0h/3
	 hYdZPMLO7ObMrGE6eXWj5vrlAHvR6tOChiRqusPySKOZMt+QLHBuibjbETUqNSAmso
	 44MWsRTkMN8RA==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Subject: [PATCH 0/23] turbostat 2026.10.16
Date: Mon, 19 Oct 2026 10:38:33 -0400
Message-ID: <20261019150241.22268-1-lenb@kernel.org>
X-Mailer: git-send-email 2.45.2
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please let me know if you see troubles with any of these patches.

thanks!
Len Brown
Intel Open Source Technology Center


since 2026.09.28:

Remove hard-coded 8192-CPU limit.
Decode Uncore Frequency Agent Types.
Dump RDT (Resource Director Technology) config.
Dump RP (Resource Priority) config.
Misc cleanups and fixes.

[PATCH 01/23] tools/power turbostat: Decode Uncore Frequency Agent
[PATCH 02/23] tools/power turbostat: Cleanup: Delete unused flags
[PATCH 03/23] tools/power turbostat: Rename: Differentiate counter
[PATCH 04/23] tools/power turbostat: Cleanup: Remove hard-coded 8192
[PATCH 05/23] tools/power turbostat: Cleanup: Delete duplicate table
[PATCH 06/23] tools/power turbostat: Cleanup: Remove useless assert()
[PATCH 07/23] tools/power turbostat: Cleanup: Unify comparisons to
[PATCH 08/23] tools/power turbostat: Cleanup counter sets debug code
[PATCH 09/23] tools/power turbostat: Cleanup add_counter declaration
[PATCH 10/23] tools/power turbostat: Cleanup: consistently use
[PATCH 11/23] tools/power turbostat: Fix typo: MHz, not Mhz
[PATCH 12/23] tools/power turbostat: Cleanup: bool force_load
[PATCH 13/23] tools/power turbostat: pmt: Improve sscanf() hygiene
[PATCH 14/23] tools/power turbostat: Dump RDT CPUID.7 Support
[PATCH 15/23] tools/power turbostat: Dump RDT
[PATCH 16/23] tools/power turbostat: Dump RP-Enable MSRs
[PATCH 17/23] tools/power turbostat: Cleanup: Use one cpu_setsize for
[PATCH 18/23] tools/power turbostat: Allow multiple --cpu on cmdline
[PATCH 19/23] tools/power turbostat: Rename cpu_subset to
[PATCH 20/23] tools/power turbostat: Fix comment typo
[PATCH 21/23] tools/power turbostat: Add rugged Panther Lake support
[PATCH 22/23] tools/power turbostat: Fix --Joules when used with
[PATCH 23/23] tools/power turbostat: version 2026.10.16
