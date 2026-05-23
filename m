Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532477081E;
	Sat, 23 May 2026 03:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779505917; cv=none; b=Qxa1C4K0fYOxSnSelcDrwVyvg/7BdGwmO3z3VBTjkJARPK4EdIH/T2QH5jN96+6bFZrWnAJME4B34vEHcYc4yQCAti6NxrCKldDZhGx92flpzfUF/iCOah9t3JyEAUO7GH1omyN40lXRaSEByYdLa98lmCRIl3wnSWrgM3R+INo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779505917; c=relaxed/simple;
	bh=8iT1RGFmhASM6P+uNeG43xT+Y8wEeN7mKNfpqh+8iLU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GmyvFPMT0vJ0nt1cuVyXJoHF4y67gk72XHqnY50ceh3x4kz+wkKqr15vbzNXImcBwi+OEdSUp02EgVhzd9Dy1GTyfj4eM6nk3BrpYCrnlgzp9Egr0ZGMCX0/i8TOka+uNTrqgcA/fSc3ZiYcL1pIrSeCZpHOmQXSdmJcb556NGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZPOfCqk6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZPOfCqk6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 408911F000E9;
	Sat, 23 May 2026 03:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1779505915;
	bh=sMUGnr5lHTpi/aIvehDV4/RDimJryM73ojahq5q8smY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZPOfCqk64xq9JunmbwUf+mkNecd1SuMFKItRdiNSl2Chh5Sov1fL6jV9APSuX5Gvp
	 CAM7Q0a9rhxjQ7tHv+w1DepxNO3JTi9lO+fXpq3TSOah09XlL3ZNJH0bmJwqQU7qWG
	 Wi61IEYUTS7aVBA+MYGMJoAJwnpfFX6eyRjj59VA=
Date: Fri, 22 May 2026 20:11:54 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Brendan Jackman <jackmanb@google.com>, Kairui Song <kasong@tencent.com>,
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Barry
 Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>,
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, David
 Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Len Brown <lenb@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan
 <ziy@nvidia.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/4] mm: misc cleanups from __GFP_UNMAPPED series
Message-Id: <20260522201154.26bc14524c36df15e40c3470@linux-foundation.org>
In-Reply-To: <cd721e44-05cf-470b-ae92-d86791778c28@kernel.org>
References: <20260513-page_alloc-unmapped-prep-v1-0-dacdf5402be8@google.com>
	<20260518111546.3baebae99dc3f2a4fd65e605@linux-foundation.org>
	<DIM2YAI5ORUU.2YLTV7PWKE516@google.com>
	<20260518134811.b2b78352779d7519e8123597@linux-foundation.org>
	<CA+i-1C1THr6fH=wdTKEngbCSD_DMS5tGroN64BEf3L56DH2XWA@mail.gmail.com>
	<cd721e44-05cf-470b-ae92-d86791778c28@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 May 2026 09:59:49 +0200 "Vlastimil Babka (SUSE)" <vbabka@kernel.org> wrote:

> >> > Cool thanks, (also I got the "added to mm-new branch notification" and
> >> > realised why I missed it last time, broken mail filter).
> >> >
> >> > The 4/4 update is already up, in reply to the thread.
> >>
> >> Is that "mm/page_alloc: tidy up pindex helpers"?
> >>
> >> For some reason I didn't receive that email, directly or via any
> >> mailing list.  I do have the similar "mm/page_alloc: remove ifdefs from
> >> pindex helpers" from May 13.
> 
> Found it, seems to be threaded well with In-reply-to: too, maybe it's the
> different subject?
> 
> https://lore.kernel.org/all/20260517230556.590677-1-jackmanb@google.com/
> 
> Should be fine to replace the current "mm/page_alloc: remove ifdefs from
> pindex helpers" in mm.git with that.

I could attempt to do that by my confidence that I got it right would
be low.

Brendan, please send us a v2 of the series "mm: misc cleanups from
__GFP_UNMAPPED series", thanks.

