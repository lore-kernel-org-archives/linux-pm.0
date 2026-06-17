Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530A849553C;
	Wed, 17 Jun 2026 16:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781712698; cv=none; b=Q6WiA4CB5hC9G8XsWVAMxfw3YCSGh2LKz0Hz4+hcWm940SORy4VuTTiLu9jgml3/068mJkGc+Gk7FQnfgQJrLugteJRXIb5DchCZorlXzPXwechsNHgzdgRz7BL8DjfthxcBuEwkuihM2TZqzMX8HZ17AgCn8YxqXcTaQcFLVTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781712698; c=relaxed/simple;
	bh=bLmkz4TiKVfS2m8bul6gc306zHe/fDGvJGVvjxrMgeo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nCh7t+y8ISROLxVN7mATR0Y3Iu0tFjaStP8xgCZy/NAeTsGui+H2VsC2DleEGmZVSmq5caqKNFzeWxMRBnIHRYU4c9lIwTDGRcivntpVAxRevJiRNosowQ0S7q7Cw85i2oDAt227lUrw2Gjz+107DLw8N6bcA8YGSiSAaDxOY1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2g3JV88; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2g3JV88"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4F51F00AC4;
	Wed, 17 Jun 2026 16:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781712689;
	bh=bLmkz4TiKVfS2m8bul6gc306zHe/fDGvJGVvjxrMgeo=;
	h=From:To:Cc:Subject:Date;
	b=d2g3JV88qfD8ct64PE9SpnmvdKnaLnnRSWU8PAuRKka7Kt1pRuRdZUQT7LviTDIpl
	 Eypn1S4w2L/45F6HtibCdVVE30H1NSjHO3ndA8hfOd8p9iCFvYBk8Cmr6NEwyNDVcj
	 lEg5dO4n8drFn6M5/Tu7Mzb02sVZfMSF0QnJmvdBkSKpFmWYDQAt4dqZmwRrQPyj8o
	 8drk+59uZZ9rvhT/bCzRHQJ6KmTuLNq+dYp77s5EOykyghsXXn7YU+LhNMjzqlDdJh
	 vi8OvyrqszMd6k4sjluC/pk/ckOVxftzhKA4DUj8FuzbvPS11Q24DX4CX/JmIFnLMr
	 Ngz2JmGd25g8g==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v1 0/2] thermal: testing: Fix two issues related to cleanup
Date: Wed, 17 Jun 2026 18:08:48 +0200
Message-ID: <12941879.O9o76ZdvQC@rafael.j.wysocki>
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

This series fixes two issues in the thermal testing facility, one related to
thermal zone template removal and one related to module unload cleanup.

Thanks!



