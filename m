Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A753A7849
	for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 13:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775827719; cv=none; b=ApFgKph84OY0KKtv5JfsvzKyKC62qLwhplt/iw3m6NR9dUSvMICyd/qus6CV+fhiG0FvgxdZTgvHQnFfAagy3wF16mDieUvBlwZDdItvbY+7cpzPLfyn5P8++11V4GBqOL0wRbI/QyPe+8m/SL+0AUanSrEMOtjDpeYV+GBD7f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775827719; c=relaxed/simple;
	bh=lg5vW4TNuPzc630esjxNhLaaJQ3IabLp/Z43+zE4rcQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=mZ4kanxP2el03e81ywLhDUN5Ly5ludSRKxJGaD4ZLNxuxQ2/36o3/DeS3i43QPQdbcMpfJBu/UbGU7lQmriePHG2UZgLqtwaR3Xv6edmCsKAw5RJNqDKiB/vTyuHSiI1/q0B3xU86I+0YPxgsMuHIACEHtkuISf/IzPUhoqY6Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOQTKo3i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOQTKo3i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE84AC19421
	for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 13:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775827719;
	bh=lg5vW4TNuPzc630esjxNhLaaJQ3IabLp/Z43+zE4rcQ=;
	h=From:To:Subject:Date:From;
	b=UOQTKo3ieUHOIdRz1iLdBTupSVAeFc4mq7w4nRLqXPWsqL+ukjEt5zkUdR5s8iLdY
	 QqxP3kthxOM3kmEzubVm2djBZ8cbLyTVX72FcYTYdCqmYvQC2MH2GbWmlETjGY4D1c
	 q0+DqOuvD61M0zopXAWPYSlQsQVVoANAhqZrSMkVmyYdQYuEoteNEzuObWH0b6s+8G
	 Ht7ivRyMCo2Wwr/kGKM/B4Z5mmpYfCJgWOCusDd/d2ap1gOc55kgR46b01DxXTPD45
	 5LvwQCZPhBOFXpf9sc8GolzJvFhjAS/Shm/v9ugIEFRtlhjPGPjn9wBq7wipHiqB4o
	 5fM7dUEjcmWKw==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Subject: [PATCH 0/9] turbostat fixes for 7.0
Date: Fri, 10 Apr 2026 09:25:05 -0400
Message-ID: <20260410132836.398255-1-lenb@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please let me know if you seen any issues with these fixes.

thanks!
Len Brown, Intel Open Source Technology Center

Available here:
git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat
----------------------------------------------------------------
Artem Bityutskiy (4):
      tools/power turbostat: Consistently use print_float_value()
      tools/power turbostat: Fix incorrect format variable
      tools/power turbostat: Fix --show/--hide for individual cpuidle counters
      tools/power turbostat: Fix delimiter bug in print functions

David Arcari (1):
      tools/power turbostat: Allow execution to continue after perf_l2_init() failure

Len Brown (1):
      tools/power turbostat: Fix swidle header vs data display

Serhii Pievniev (1):
      tools/power/turbostat: Fix microcode patch level output for AMD/Hygon

Zhang Rui (2):
      tools/power turbostat: Fix illegal memory access when SMT is present and disabled
      tools/power turbostat: Eliminate unnecessary data structure allocation

 tools/power/x86/turbostat/turbostat.c | 100 ++++++++++++++++++----------------
 1 file changed, 54 insertions(+), 46 deletions(-)


