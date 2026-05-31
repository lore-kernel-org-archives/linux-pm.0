Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1805B233722;
	Sun, 31 May 2026 19:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780257576; cv=none; b=TkhhQSD1Vb68uGgENaP4WDRskAIH4Is7esoZ5eMtsJovNYlluB4C/XfOKGG2IyKFkeNJy+6THe4IDZqPkXClhLGdU8E5BEwwUfR04xV8nm1+LUgF22gFqsbg1w8RtjcPdh3+LpUnj6QXQz+UFAN+Q//Gfa4RMtzQ+ygToQxKq50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780257576; c=relaxed/simple;
	bh=T9rRPMpybN9m0ox+SaBf83u000r5pd8VlzP3lCnHFkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QqfI1ZUOZ9Dcrv3QrF+67yu0cWw4veH2S8TeYe3o0ctIib3Chr3V0rR1HRyW39oEfdupjuRK7A1KquVJ5dHrx+SiW+ndnam6LDQ8UhmnYYaI3wkGw0n3psQbD/GRYvTq1tDjkJIxZn6azdieKRRKyGwYbV3AMucUahPOkFwjpyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=CjBzLxKb; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="CjBzLxKb"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id BDEE327155;
	Sun, 31 May 2026 21:59:31 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5e5bsnbmZYND; Sun, 31 May 2026 21:59:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1780257570; bh=T9rRPMpybN9m0ox+SaBf83u000r5pd8VlzP3lCnHFkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CjBzLxKbaHqff5MsGxShk/ZIi4vT1IELZqL+ofc3JE5GtOrzb43ERButGqK8AKXRg
	 d+HMbnlK8pRaKm5bh//1wgEGdgmWBgNYu/6/I12OA5tFUWeQ84x4QW4gGkQLof2x1Q
	 vjh3PpojcwJoDSAS+v3DZxmWryHOMGjMgq9F6XGEP6wS49wZtQHQqlr2LfT5d8xTCA
	 akrNpJ0hhP35znmF2wJVhNnsC8JoaE/zyubwZim6O4zra7tuiNRb4CBaFeRsG8ti1v
	 MBV1vDEOm0IeO4/az+R04R6o9YtgI+nC8E2yWrY5BI5kjBUqgJwmZgYZ72K++kw6nf
	 Ii7lKsjAL5wOg==
From: Marco Scardovi <scardracs@disroot.org>
To: superm1@kernel.org
Cc: kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	perry.yuan@amd.com,
	stuartmeckle@gmail.com
Subject: Re: [PATCH] cpufreq/amd-pstate: Allow EPP to be set to 0 under performance policy
Date: Sun, 31 May 2026 21:56:07 +0200
Message-ID: <20260531195917.3823-1-scardracs@disroot.org>
In-Reply-To: <20260530154121.1670781-1-superm1@kernel.org>
References: <20260530154121.1670781-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Mario,
as you saw in bugzilla I reached a similar result to yours and in the end
I can confirm both work normally so you have my vote for it.

Let me know what do you think about the other patch I posted in
https://bugzilla.kernel.org/show_bug.cgi?id=221473

If you think it's good enough feel free to take it over, I don't mind it
as long as it helps.

Reviewed-by: Marco Scardovi <scardracs@disroot.org>
Tested-by: Marco Scardovi <scardracs@disroot.org>
