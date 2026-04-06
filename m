Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EA738AC6F;
	Mon,  6 Apr 2026 16:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775492240; cv=none; b=YAm/2247AznXvuJqEMX462WRssVctUrICisEllyw3a1qr+YAMUeP7Nrd6oGybsoSDany1HEZRMGkYSFXb/T78FaM7mnb7J3iePAs5e/VABUziTFYOm/ZkXqZNvH0nSe6saApzWdnOFUDxHOrDv9j6dWuuSj6pc7zcfwZ19SqcMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775492240; c=relaxed/simple;
	bh=e9+3n94PiLg5Viz5mK9ks1IHwd6ZYIC/M6xmU14pCr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KatY8t0c1lsJ3cNwdnS6pR1cZNswcBa4W4fRnOWAc4Bv2bol4D/CYpyE2jT1V3JtprRxmCxQpAU1+QqtFPDCPLWu7Dyw5BbkGfmU8ZsuctUblJchyfdSp77WthjDPaEIOYODj3LmQEzZj2KsUkUqk6cORQt+K8ZYwdrB169KTg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tIAiif81; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tIAiif81"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83883C19421;
	Mon,  6 Apr 2026 16:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775492240;
	bh=e9+3n94PiLg5Viz5mK9ks1IHwd6ZYIC/M6xmU14pCr8=;
	h=From:To:Cc:Subject:Date:From;
	b=tIAiif818RqKj66nn2LRWdigWZc86kFiuiGmt/QoDW6KjNTJV/oLt6MW0Hu90tA5B
	 nfRL4JIrWBkSrdO0zdHjYp3b3Mf9cHPEk2dTiXs3eED1fmiweMoYGxrdg30kx6Y+dq
	 cGJfEPU3vdhCf0ROJAalGsRcX5BaPtPk7LbRBlRNURLdTRlx7TnziO7+W8KlrpYeYO
	 PLZFBSsHR7QAZypOkWQUkGeIJrJ850DlIBiNqxsSfp9E+cKNU5uhJwzAT7uFb6pEDZ
	 pyUEFPTRVIAeeymEiKsBdRh6F3ibpL1goGv+hGoorqjS24UeYbjMypyLzDBzz6gffq
	 gFPy/lZjta9MA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Armin Wolf <w_armin@gmx.de>
Subject: [PATCH v3 0/6] thermal: core: Fixes,
 simplifications and suspend/resume relocation
Date: Mon, 06 Apr 2026 18:04:56 +0200
Message-ID: <5119690.31r3eYUQgx@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi All,

This is an update of

https://lore.kernel.org/linux-pm/6277980.lOV4Wx5bFT@rafael.j.wysocki/

that adds two fixes to it and updates the last two patches of the
original series.

This series is intended for 7.1 (it applies on top of linux-next).

If fixes the thermal zone removal and registration rollback path by
addressing race possible race conditions and a memory leak in that
core (patches [1-2/6]), removes a redundant check (patch [3/6]), changes
the thermal workqueue to an unbound and non-freezable one (patch [4/6]),
changes the allocation of thermal_class to static (patch [5/4]), and
relocates the suspend and resume of thermal zones closer to the suspend
and resume of devices, respectively (patch [6/6]).

Thanks!



