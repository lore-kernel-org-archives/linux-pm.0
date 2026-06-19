Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E173A3C276D;
	Fri, 19 Jun 2026 17:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781891186; cv=none; b=XDJX4WdgYvipY0XkqqpIESkpsk6hac4RFE65/RkQFsfcZX3MYgoSsYImmXiq5ZtviQI28cK/4zPQqunK7iZB4I3nJRf59InriNWM0dbY7t/o0rt3UEsfP2c8zB0tIYeGOHDPYWd5oU1CKoGo2hTaj/Zis9KGQvbuPjYP1zLhgLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781891186; c=relaxed/simple;
	bh=vgkyvKDZyC16iSmYzwJjt+oP1Yy7yudPgu88gSlRYeI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pMOht95TEaIpcVkraFlVonUsja9gk/JDz9jgKAnqO2EOsaUVhY/ATTxJtm0C8GOid/QPNOx0FIej/ivp2MUxhM0y4zjiCxWNfcNh9Iiv4O0hGIJ7uXooua8tkXy2RrBYjzFKutkwmG1reVO6aybTAYYN7QuPQLkm9pkwGrBxNJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2BpruPu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2BpruPu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E5B71F000E9;
	Fri, 19 Jun 2026 17:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781891184;
	bh=vgkyvKDZyC16iSmYzwJjt+oP1Yy7yudPgu88gSlRYeI=;
	h=From:To:Cc:Subject:Date;
	b=O2BpruPuNdIW0289/CcMqcZfSL7Dn7J0bwzMyPMFhZpY0FGe3QRBLUVexiGwtKl7G
	 WcMPp/zaWlvwXqUbvwpsj7++5hf1ykYf49z7Tk/l8CFIoGckPx9pqOyGuWKCr7Pnqa
	 VNkOx5Nis2rkec+7vGCQCb0FFVnzCuZnRbRL5G/Dz6vh8+5VV0qnwt1fpzHC1zFghX
	 JAljl3VTh/VSvLV1MwgQwKhri9a0zY2C3VxlQ+w7F/Ku9lVLC80d21vwmpuBbYtojT
	 32XQk56Y3N3TxxQbMgDjjcf3tXzLmtvfwvWsJ0gXJYemSBSS0hXzWgA343OhZnnts8
	 nIjaWM5InTiMQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v2 0/6] cpufreq: intel_pstate: Set cpuinfo_min_freq to a lower value
 with HWP enabled plus cleanups
Date: Fri, 19 Jun 2026 19:31:42 +0200
Message-ID: <6005456.DvuYhMxLoT@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi,

This is in v2 because technically it is an update of

https://lore.kernel.org/linux-pm/2381464.iZASKD2KPV@rafael.j.wysocki/

but it contains new patches.

This series updates the intel_pstate driver to set cpuinfo_min_freq to a lower
value when HWP is enabled to support systems in which CPUs can actually run
at performance levels below the current minimum level.

It also carries out some code cleanups, mostly related to HWP, either in
preparation for the functional changes or top of them.

Thanks!



