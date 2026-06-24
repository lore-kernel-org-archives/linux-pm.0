Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993CD3DD53F;
	Wed, 24 Jun 2026 17:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782322595; cv=none; b=ERoXYGCKBAH/AakxUxwgIWOp1vF2evyRWYyt8hTxkJmFODfm19vI8ZbwYZ5mziOetn8Va/aeQMKddW6xhkje9RV/ChEY/V4AkCbImwXnHQHicOw9trOEqiVz8z7CI2EZop1Lxj/iF4JLxb71u0GS+Dwi/nWT1MCOyXPTlMVT758=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782322595; c=relaxed/simple;
	bh=JIBOf0/hjv2rLl9fo8Zy6qcS341PC2Bx1coOCpK/v6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GXHgE2BUgUwZAQuZXN5VQQdX/mc3HH5aCXQsf+9e7waytfw2hARsuWBlh8maGgfm+XkA7ZP6V8K6erfx1A1jRFpmeDjii62bO49sTdJoHqwUOJ1BtBMvx7VFERhyvLHo8HyOLD35pfUtS5EQKKSLBdcMPdd+tNuaodg1TK1eojY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1erPNOU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1erPNOU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4669C1F000E9;
	Wed, 24 Jun 2026 17:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782322594;
	bh=AchmX5ES4DpsfLCRKvyjdsdRYqLkcMd3sq9qWijTDIo=;
	h=From:To:Cc:Subject:Date;
	b=f1erPNOUGf9T39aWKCBp5qvAmvROvXUf/rK8TlzXoLeTtEJUNr50NReCSLzBvTTEU
	 KksiiOU1x1D3di0jPJqJPztTM4DZdmtRbOdtEVQp1dLh8IfUtbo0DM3EApZfgMyVrW
	 0xmt3Oh1XMiOcMhqoMKi+HKmtY5t/9NHNtFk57cfdmV1MJh8iZX6Ydb2L3Ej4mFU0d
	 zXslBb3qPculITOgYZUWVNMZOUKFsBo8q2f7gMkebsBgeMYrxGx9jvOVLePnYTu/FJ
	 vXl64BlKfPkXjp1N0d27CkCogBPCvBAP1BV5oAPnfo6eBy4m47OAb6+frZEZBpLHUF
	 6bpgAiNHBbBlw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Doug Smythies <dsmythies@telus.net>
Subject: [PATCH v3 0/4] cpufreq: intel_pstate: A fix and some cleanups
Date: Wed, 24 Jun 2026 19:32:03 +0200
Message-ID: <4752842.LvFx2qVVIh@rafael.j.wysocki>
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

This replaces

https://lore.kernel.org/linux-pm/6005456.DvuYhMxLoT@rafael.j.wysocki/

and drops the most significant change in it which was making intel_pstate
set cpuinfo_min_freq to a lower value with HWP enabled.  That change
went too far and needs to be reconsidered.

The other changes in the series, and in particular the fix in the first
patch, are useful and will facilitate further improvements, so here
they go.

This series is independent of

https://lore.kernel.org/linux-pm/6286434.lOV4Wx5bFT@rafael.j.wysocki/

and applies to Linux 7.1.

Thanks!



