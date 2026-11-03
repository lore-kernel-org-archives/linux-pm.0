Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793735397;
	b=JyB2VDQLHRWWjzoYn+buUUDmrlryIdSizQkZs39mKa4nylEjCR86Hm87M4c29go48zUm
	 bR8+xtp+B08jaUGeptI0JK3qqSb76AIeawzH7c5OioTa3MzlV/5cFX5xzW7ZpKQXd2gkd
	 7ydBSkc5EheRNxzAob+nZcURbqGICIWKzQNilBtewCOQF/ZnTU/26Sl4O4tjBSYooLv1T
	 hckjes+isBTVxUXxOwo9v96x6zvbSD3z3OV1wmzIXQXPpfOvHqXIfqxu6rtBLxl7ueueF
	 iNVUekUCV9J0XUva64dxaCY/EABtjM1L5MpjoOM/YlyTZIVFtxjISDx3Hoc63rCi8zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793735397;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 Organization:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=wKAI3AugdS09ubbyJWDaIJ3DpAqmm/D5rL6jq7M9MsQ=;
	b=x7AM1p+Q1v+smqeVARPluJQ6A5rZ35zUJZHy9ucbQips7tv5xvO5Z1AKUqX1bN9C7PWL
	 y+NFGZMGO83nE9yF8OuvUOPqFAtYferbGZRpcKy188hjCmWfDn253SdhViz3Llf/1X2Wj
	 +VCqRX9g/lEMXuicwUrXa46A5aJZzfEKI7990XLdmAbRuEYnLWTyc4KfDZixixwVGijZU
	 P527F8C+gl3jo6MLdBTUE9g4z/O6NkxHPLhQlTyNCxAc7AaTjblXZeqIfRCuMcAnkP5Us
	 Taes+u0wov4XqYp5q0pyJXtk97OhKzJHhRChHQbkDPKqqZ8AipBG3t2d9HQBVRJhmCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MAFX+1EA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBB8606A31B
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 19:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MAFX+1EA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1FF51F00919;
	Tue,  3 Nov 2026 19:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793735396;
	bh=wKAI3AugdS09ubbyJWDaIJ3DpAqmm/D5rL6jq7M9MsQ=;
	h=From:To:Cc:Subject:Date;
	b=MAFX+1EAHBRmWpH2G7nEWzHdogqyQQeH8yv9H8O2tOFjonWZB9rrt6xHr6rZg8rqm
	 Ynpv9q1TzidwNr8qEuUC4pPPjmv1y4/Dm3TCfhmN/tg2X94ta1JGaRwR/fFjDt/fCa
	 +R+Zjo6PsaKJFuSg5sXgeTY024dc+Uxt1EApWQNUtfr6ojv9FGrlYfQzbQza6N07tM
	 sfKG1U8QfEDMd70DhWPsFts4maHhjethH317szIGvL3cgP6X+cQcTRh7hOBJTCKyqa
	 WoIIjsP17n1RzmOsfLFjc6m/LgVKb/KGNhleYwRL3YbFN0ygLRAYuojkfeq8YeNM74
	 GrxMOuysBKhLw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Doug Smythies <dsmythies@telus.net>, Zak <zakbrightonknight@gmail.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Mario Limonciello <superm1@kernel.org>
Subject:
 [PATCH v2 0/3] cpufreq: Fix synchronization with system suspend/resume
Date: Tue, 03 Nov 2026 20:42:10 +0100
Message-ID: <6065833.DvuYhMxLoT@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi,

This is an update of

https://lore.kernel.org/linux-pm/5162355.31r3eYUQgx@rafael.j.wysocki/

that modifies the first two patches in the series (to address Sashiko
findings) and drops the last one.

This series fixes issues related to the synchronization between cpufreq
and the intel_pstate driver with system suspend/resume mentioned here:

https://lore.kernel.org/linux-pm/CAJZ5v0hT6aoX4tuJM+rO_5iequFc_7rEXCoaFnHoJBaH3JP4KA@mail.gmail.com/

The first patch actually prevents governor operations from being
carried out on suspended cpufreq policies.

The second one forces the driver .target() callback to be invoked on
the first frequency update after cpufreq policy resume.

The third one causes intel_pstate to invalidate the cached last
P-state value during suspend.

Thanks!



