Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8617C37F320;
	Mon, 24 Aug 2026 17:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787594011; cv=none; b=Izouh+EGmLp5hMTo6xfc63GHD604Cmmnp3DlxZhVhhHS2YOi+lq3WVsvUsvRcJHcGESUkcXSvm86P9sTK0Lhx0cbeb/AkRR8COhNuprDPOM5qdW0vFgx5hWAM9WhHAXf7P0OUjwP1JYe8oXc98Ck7IP+uEh8DKDKXq5oyku7Zqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787594011; c=relaxed/simple;
	bh=qq11iVf5Lqveu6+/4KKzO+tS456A1gIXXQExPh5yaA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QSgQg1L7GTfFjI8g3QhLj8glC2j8KR0ASyLuPGij5ji/DPTuCD5Ueyxwk8TgqSlf7kTd9fiuKsBGRBriemc5moe8GaKn1YMreQLJmogEHxlP+Y6J6oLREDo7BJTpDd9Uaf0GNgG4j/gHp75DXR4MLRCzQ1Lj9SyDXJj3iPonpwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBJTf8Rw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBJTf8Rw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748A81F000E9;
	Mon, 24 Aug 2026 17:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787594010;
	bh=qq11iVf5Lqveu6+/4KKzO+tS456A1gIXXQExPh5yaA0=;
	h=From:To:Cc:Subject:Date;
	b=RBJTf8RwLcwICzFF0fxIwJ5Z2cJRd7FNB72olKsld+1GHSPpM86oGxXO/ISQRT6OT
	 uG2c17d8SIWFqN0M/cxTke4Z6Eof2lwvhFBpFeB1xi/0zCvafBhdmF1e8xtO7DDDSP
	 SET9gSp27abqkSVhK2BuBrdF0mTiniIBq/GJRpkxFIDFsAGpP3WYG0rBGd9of82myj
	 NW6maxv4Sv6G91bfRksLJFMV7LxjhqdEayfXerW2zxhPzWYkzZ0VpDfNo4g5A3xmZN
	 Ec4V+A7zjRGhhXw/LplEKcmVr4pqPsWm7pYEttK5h1cMiA5CUK+dJOHlVbcrF7D1bK
	 ratmAxsKVjuVg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Linux Driver Core Development <driver-core@lists.linux.dev>
Subject:
 [PATCH v1 0/2] thermal: core: Revert two cosmetic update that go against
 driver core changes
Date: Mon, 24 Aug 2026 19:50:52 +0200
Message-ID: <12960456.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi All,

Two recent thermal core commits restored the usage of class_create()
into the thermal core as a cleanup matter, but that goes against the
driver core plans to get rid of that function.

Revert these two commits and let class_create() be eliminated.

Thanks!



