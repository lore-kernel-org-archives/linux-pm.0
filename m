Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F011E1DFF0
	for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 19:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773774990; cv=none; b=tPeYuKj+7KpKLBOCPeJnpQ5H4Aqqje6VM9flcRKTGnr/6+Nu1LYTcODkslSFwR9ptfIT9dagmFwzMnv94a3Q5A56M6JQIfa15fIKk8pSa38yHXckOjtmV01Ia8yGmSxgsB3yQgHNQYZES/a2N5LZYIMIUsEkD0+0GXsFFZAmvd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773774990; c=relaxed/simple;
	bh=58R4nmzFqZXvVO7rPj6//HNd4IBpuV+RDoFdKrOt564=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=f2pRaP+gWf5sztEQxHhEHGvyfBsuDnNgaDrYKu3g5Y+885+8MhE7e+DenM6Cd650SYlNRwUZDLAMUHY5KGgwiyegHmVkEUjvpIgPPJWTBHKXjmoe8ac1JaajtezdrTkfrR/KO7loiwK12i+aA/22CR88wo459xSSoWWnIX7Yk9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OAv7URM4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OAv7URM4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF31C2BC9E;
	Tue, 17 Mar 2026 19:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1773774989;
	bh=58R4nmzFqZXvVO7rPj6//HNd4IBpuV+RDoFdKrOt564=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OAv7URM4gS6KWb27UemNJmbekO9vk4EqLova3KvwicJypcAJgHj2snI3j/m3cFZ+1
	 5+deLzSDXgFrTErYM0HYxsPmmwZh7cpb7Fke0vFV0kVgKPj9T0wxobDw235Bqmine4
	 7fC5IrFq/OXVpOLFrAYq6Nsz25WDXQfD3sPAsAsM=
Date: Tue, 17 Mar 2026 12:16:28 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Youngjun Park <youngjun.park@lge.com>
Cc: rafael@kernel.org, chrisl@kernel.org, kasong@tencent.com,
 pavel@kernel.org, shikemeng@huaweicloud.com, nphamcs@gmail.com,
 bhe@redhat.com, baohua@kernel.org, usama.arif@linux.dev,
 linux-pm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 0/3] mm/swap, PM: hibernate: fix swapoff race and
 optimize swap
Message-Id: <20260317121628.abc7f555ec78963b1d705fd9@linux-foundation.org>
In-Reply-To: <20260317181318.2517015-1-youngjun.park@lge.com>
References: <20260317181318.2517015-1-youngjun.park@lge.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Mar 2026 03:13:15 +0900 Youngjun Park <youngjun.park@lge.com> wrote:

> Currently, in the uswsusp path, only the swap type value is retrieved at
> lookup time without holding a reference. If swapoff races after the type
> is acquired, subsequent slot allocations operate on a stale swap device.

Has this race been experienced or at least demonstrated?  Or is this
patchset derived from reading the code?

