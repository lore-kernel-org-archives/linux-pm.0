Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F6027F010;
	Mon, 26 Jan 2026 19:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769457097; cv=none; b=APE440oQB6D14aQ2FqtVrzDgVLeN3ELWIt3zlXnJfAuIg9PnKETiCPBHw3lezTrD4ZxvyEJUd3CrtaBgH/LdrctTiObulsqDuHE7d36KgUAK1hGYrn+BJj1muFtzVPbSkbJ+u0NnF8p157hrI5UAtMefgKTQ+lhtng4SKuNvUgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769457097; c=relaxed/simple;
	bh=Ol8aDY3Q49xnXUpvEH4jYDb4zehR7zBug6joZMftA1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FjJKDL2Es+vGSQbD5UFyUSX8KXBWkbeomSvBLiYUIUh4MHrEWIzCCI2gCkEmw6q+S7it5vDBaUeHGoQu1sh4U5k+VUBHckGchEfGRsevJIQjRG+yySvMNbcucF/fDFR6sJ5iMszSL/kwKx+pLm90JKPGd/xXNi5AhU2K4RLoku0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQPVtOck; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQPVtOck"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F59C116C6;
	Mon, 26 Jan 2026 19:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769457097;
	bh=Ol8aDY3Q49xnXUpvEH4jYDb4zehR7zBug6joZMftA1U=;
	h=From:To:Cc:Subject:Date:From;
	b=tQPVtOckVBcwLkjFD2vX7Jw+x6rT1+luLK6HcN2dJWkQ5tnEvKYJTPeu15nAXX1uc
	 Rxx8TLqNKi8slIUbXJc44DO5pz01GDOfoMZXkKh9jeRf4a75WqDBRem1N5EgOg7NJf
	 CG7oc/9j5KijqM2QulKnQz+RMgBod8zPElU0LbqyMz3erdJQc9ishPH8EhfGUGPmV2
	 ya3i9ir/PGw709e5P4ED2d74BMF2WP5786FdOW7fYrB2bNfHm8fqOHNJnbGXzjKD7B
	 9W0DBKYVLF+TAmBv9aEpIdpP9ckJpvmg/zE+Smd7s3PEGDX4vMC94oqKswJ7ZEsDKS
	 FuyN6IgmTM/kw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Doug Smythies <dsmythies@telus.net>
Subject:
 [PATCH v2 0/2] cpuidle: governors: teo: Wakeup events classification change
 and refinement
Date: Mon, 26 Jan 2026 20:41:25 +0100
Message-ID: <12831359.O9o76ZdvQC@rafael.j.wysocki>
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

This is a follow-up to

https://lore.kernel.org/linux-pm/2257365.irdbgypaU6@rafael.j.wysocki/

including new versions of patches [4-5/5] in that series.  The other patches
from it have been already queued up for 6.20.

Patch [1/2] changes the criteria used for classifying wakeup events as hits
or intercepts to (hopefully) make the classification work better for large
state bins.

Patch [2/2] refines the idle state lookup based on intercepts to first
consider the state with the maximum intercepts metric, so that state is
always taken into consideration.

Please see the individual patch changelogs for details.

Thanks!



