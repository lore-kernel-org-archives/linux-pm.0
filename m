Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46371E1E04;
	Thu, 12 Feb 2026 13:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770903205; cv=none; b=Oz3UdzYMVUE6UZQC+SRO/XDhuWkwnx5A/tqqdIuZfE2XbFi1A8kIqxqG8iY3QMRGw4QYvX2AN5qkxdifqZkz2rl179eGXWCT5NLVuInVhuHSqvUZeRxJHL82CJ9gOxVfbmyyBNX18A8m1xDMmQGSYSx9jEyXQBHRR9KBNZHCgGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770903205; c=relaxed/simple;
	bh=D3j10vAWBz/7t8XavRl6eY+30mXIb1Gyd9sDiMxOgLc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JBozW+FCN9hCg82i7IVDFVeAL/qGfn9UGtoSi9x8S2pp6+K1X3GDEhaoO5tSqJm3lKcrKSH/tRVtEVre4WZzfju74NchWpYz4iIKlw8F3Mni65yllNojS4HhTTmPfoN8Ibk+GKS25GTK968Qcb0WGgIfbmVGq0bZym2E+436gc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfuNpZnM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfuNpZnM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6065CC16AAE;
	Thu, 12 Feb 2026 13:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770903205;
	bh=D3j10vAWBz/7t8XavRl6eY+30mXIb1Gyd9sDiMxOgLc=;
	h=From:To:Cc:Subject:Date:From;
	b=nfuNpZnMOd//B2tpZ59pjYI4+YuXgPKsVKn6Cm9HqH90OlzNJTo2AyxnPNFnJqmF3
	 L8lPeesAtCZELpFESTAUYXTtBB04oHadwS7+nQ/frdrp8ETLu06yqkqRycOkSj4VLQ
	 5i4D3fulwgvwrL6hw9HEgNSWBo+96DnPjYrHk2rZcY57KZbelDpr21PDPWZXlWYxkd
	 FDJ7bH7mAyzrFqB4uAnb89gV0h109tMcF0GX5eV0sPeHqutEAqnSmdTLJGbNaiHF0B
	 llzWscsAYMBl7RC9HxnDaRmeP3ijx6bAgGRHBteLKioduZH7KWbHI1QN2ZEJ/tdX1p
	 q2A4y4nN3ru0A==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH v1 0/2] ACPI: button: Cleanups after recent changes
Date: Thu, 12 Feb 2026 14:29:58 +0100
Message-ID: <2400697.ElGaqSPkdT@rafael.j.wysocki>
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

The following two patches clean up the ACPI button a bit after the changes
made to it recently.  They are not expected to alter functionality.

They apply on top of

https://web.git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=linux-next&id=abbdf22e0a8f23207cedf9065512620971794ff5

Thanks!



