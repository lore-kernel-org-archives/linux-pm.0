Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793128556;
	b=b5/iUpD0+2H0a3JkWJDFEzk1iGoVZGKdyQdl0A/2eEInd8QA1+tw728wGPJOEnR6cbVX
	 X7rb0XqVQYxDodihRg7jj5k7h5kitABGL/tsR2cmn9Es2StDdf8KyV0+G48ZBq+yebjDb
	 dBsU+Ilo1xOePLsgSHDv9IimuB/9u+7W3elc3fEVX2eyyyc8Iz0yUk4Nacxkk6FPAiSSU
	 ebofRzOIeivx/719jeHuy3wi/kSeB+urCxhoGZqApow0xsOQuVtP9y8n7AWQdeLnpQmDk
	 PxYS8eLkJX0ewLkIbSOhj7fvKZ8i/Gw/FrCZC7yWQqxlGQI6sBMydyx3clp63eKxPuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793128556;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PGVTAF7iIungW5z9kPDkJNStXW4ErI+UZp+jvf+bGJs=;
	b=bKzTfJGempNpb+vDtJDwi8yd0e9sNkCx+ht9pE/ncfElfPJEh0OOrl9wMhvIdu3EQYMK
	 YVFHTwowB5pGKtv+L1dYGiI0ceeDaaePO8XSgrozCRLwo086gShnhsVCJ2osgk9ECqfgz
	 nLHt9KvzhoRwOnNtnWrP45mpiGY5HtimBkxx53MnKwDZiR73iR/fPZsdhtPSr4U8byBT5
	 3z/QL8apS1MafYCRLKKHxZJo9yD+UtCmzBD3y/ON7ckyVsIdglNEecHD1KzCN3fG5kQ/y
	 mqKXUdEdVbwczqtgieW2+9YC/2/q1T7vW7fsv/yeP6EiKnUtUOTGDOkCArxlTiJEv0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QXwz10ER;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07042606A31A
	for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 19:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QXwz10ER
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA1701F01825;
	Tue, 27 Oct 2026 19:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793128555;
	bh=PGVTAF7iIungW5z9kPDkJNStXW4ErI+UZp+jvf+bGJs=;
	h=From:To:Cc:Subject:Date;
	b=QXwz10ER+VPDzmiZbG5grLiWsi7+/39fABTj42xv0W3hHQ1vrgKZx9qd4Et0CIjfm
	 8fk2JToc3cvDFCZnmSufrSZTMK2nZReV0rCOBtKGAN71246SiML4vERl999bRFkLi5
	 7NjNdrsp1bYRpOMS+SvdBvAGVk5G5KZxnjhoEJfoBUfTbrh49Pymi+UfwIrYNmMImH
	 8TbHkF3EiXuwyZtpgYJC25BibmBgcGhifcHPOkiD4iDMwN12eL/icvueDemmeIEvsF
	 PiMJyxdYrf81GjjlwTsg/AOc0xKdKWV90bso3CJ/hc2V2zuSNNiqASbV8VIt6qShSK
	 KE110nySb0/hw==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v2 0/16] x86_energy_perf_policy cleanups
Date: Tue, 27 Oct 2026 15:01:54 -0400
Message-ID: <20261027191550.369122-1-lenb@kernel.org>
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

These patches have changed since v1:

[PATCH 01/16] x86_energy_perf_policy: Rewrite Linux/Android MSR path
	This combines the old patch 1 and patch 2, which didn't
	really stand on their own.

	Andy, I took your reviewed-by off of #1
	because it wasn't on the old #2.

[PATCH 03/16] x86_energy_perf_policy: Harden with strtol()
	Updated to address human and AI comments.

[PATCH 07/16] x86_energy_perf_policy: Bound package iteration
[PATCH 08/16] x86_energy_perf_policy: Cleanup: Define
	Andy, These had RB, but resending b/c AI review asked for some tweaks.

[PATCH 09/16] x86_energy_perf_policy: Cleanup: Define BCLK_MHZ
	Updated per Andy comments.

[PATCH 13/16] <I combined the previous trivial #14 & #15 Constify patches>

[PATCH 15/16] x86_energy_perf_policy: Simplify write_sysfs() return
	Re-written due to review comments
