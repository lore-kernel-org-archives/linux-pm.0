Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8478825C80E;
	Wed, 18 Feb 2026 05:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771393481; cv=none; b=j2bTa8QOpYRbTs+DU/Yg1NMPsKmZIbMePsFBCFZtIWS1SEGFZwPsEEsilfngCEHUAo6LYHM/hyCTu3RtT+7sCPb7QTPk0Zz6Z2CqqEP1i+4JgmEQc53WOy9T8XI5scf1NKqbRFF6P6/OjmCoCxKjSRQDfoh0BYoCdqH6GIY4pKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771393481; c=relaxed/simple;
	bh=kOM+91PNWBdfIfFsRQushRVlJ3caTem8c4GoHe/wF9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Knji/sj5vFFIrW8w33MY3cy4TB8QKLK6vMjUm4NdqwUAne9dUMXhW34H8Qz2eWAU97YMxPXua5UvHGyTa80vEv/njHuibTP3Bruk7TwAxCmNCv55hkUFTXz3sYeMrCUmktEZ84D5HvlXDVlvcxe6rVnhIBwHyRVtSM+BcE1NJ/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgwKizUk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgwKizUk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2741FC19422;
	Wed, 18 Feb 2026 05:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771393481;
	bh=kOM+91PNWBdfIfFsRQushRVlJ3caTem8c4GoHe/wF9o=;
	h=From:To:Cc:Subject:Date:From;
	b=UgwKizUkPYbPLWqYQe9TLixeiVBVy+bdf6Spb1+hv6tQ0HiHo2HtK0cw1G54PdcOt
	 O2Y/GNcOtSlb8Yf+PtHDF61hBaa3oddRBYRJSCoQlnn+n/AlFzYQjd9TJupYz2iTYv
	 sTY6gbcDCZ0uKpq2LUEsHctX7MKmrQBDNDXLMVcHI83ERnxmd5UdLS6uLsJ2JOyDcx
	 PSuxDw2YkVBRtIlDlQTHtk6v6Mi/obcy9l30UyEVZB19FL5wUX4h1fPaz6kOssF9Y4
	 J69Dh1IwJ0G2V9mhc8Bc/L1/qYzn68RG3L27+/8ThdqIUyJWoF2xaw5Fd5qXfz5skz
	 OZSHvx1dSJcqg==
From: Len Brown <lenb@kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL v2] turbostat-v2026.02.14+AMD
Date: Tue, 17 Feb 2026 23:36:51 -0600
Message-ID: <20260218054436.705622-1-lenb@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull this AMD turbostat regression fix.

(ignore v1 -- bisect fooled me into thinking there was 1 hunk to
revert, but it turned out there were two issues...)

Thanks for running turbostat on your AMD box.
I'll be sure to sanity check on AMD next time.

thanks!
Len Brown, Intel Open Source Technology Center

The following changes since commit 51496091dd37b405e6e399a9638da3f1da3f4c64:

  tools/power turbostat: version 2026.02.14 (2026-02-13 14:08:33 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git tags/turbostat-2026.02.14-AMD-RAPL-fix

for you to fetch changes up to ef0e60083f768b32cda17b1b0ca9519405db89a6:

  tools/power turbostat: Fix AMD RAPL regression (2026-02-17 23:27:52 -0600)

----------------------------------------------------------------
turbostat-2026.02.14-AMD-RAPL-fix

Fix a recent AMD regression due to errant code cleanup.

----------------------------------------------------------------
Len Brown (1):
      tools/power turbostat: Fix AMD RAPL regression

 tools/power/x86/turbostat/turbostat.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)
