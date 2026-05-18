Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A13405C33
	for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 20:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779135653; cv=none; b=VPnxdkCMP89Ihzgp+crAYQJowz043HAvBcrWYlaebHchhXWqKQ92SoQ1eTMNZQPGzRu0WKYl6I1psD3qLqPbudOZTbcQEi7bpuWrbHRU9/apGr7nsrW9WJRESm9m6Own0/tB7qHAyO7YW2SJNydOUlN/K8jT8zwM5CAfJrDkASw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779135653; c=relaxed/simple;
	bh=6LkdFlmk3CgCdymG0GU1oS+psGZ/ost9QMbdIcrw9Rw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sqoaohGwr5uOqWTi6juE6zKnrZ7xjfRfFe5zOFQZ6WkasVYkBf2KimoT540O6H7H7LJD05WUAz+8j8dwyTHHATvYob+yCVtiJIEjeNKGnz3NjNcrCi+UD0hBmUl2I469tcnhnOSQ3DiA8SZyLMx/bsZQ8BOOSzTxwQtBNBfE7o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=taUkxBnW; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="taUkxBnW"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-48fd8162ed7so21344775e9.2
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 13:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779135651; x=1779740451; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mE9J24ZIKiIJrzUDfxiR2ZliFW1zd6YjsXv6l2fJKwI=;
        b=taUkxBnWdeGN1LanW678iHR2tEbPjp1ysTbZ4whBKoY6GpLx9j4rzw7kDExIyN651D
         IWlGYEFLhdXnAE0HDbiJoe+2z4f8jmDPTZtCwU3fY14XqSyCwjrybGe1hdDIhaIEUrCn
         RAsJa+uIPnDC09k6GjewWJnpQl0ojbxf66W2hXo1PUybzARKshmAiAT3KofWZCiUrQm1
         BkbCZwiFrmpNInjCvKIpwKh4t0ScUBszn2NTlzSWZug7jRdxZUoHW1rncA82N84egR57
         8M+otRtcF09MRJkEaCL+dbNlppob9oYKzlnDWAk3+fT4xDJVG/U7HJrjrGj2aKcLMe4Y
         ho3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779135651; x=1779740451;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mE9J24ZIKiIJrzUDfxiR2ZliFW1zd6YjsXv6l2fJKwI=;
        b=joWZS/+JFei2vqlt8FgMf+N27soSchFUl6moPzAsSH+zFiWksTlkk+LSxRB6Lvgtyn
         lznnurg+62HeP3Qyb/3+g2LChahHdHfUHG4TutlFt2b1gBjKid8dqV/NhAkh0STNmMAh
         UAAOEpuMXBBY3Ju+kbI8e+7ImmvbsM81WwRKifJc+fLwmuGpckNdbAOIiU9YmFldiVkg
         7ImL3hqNAfmIg7w4Zt2/VjExgemUzvxTDblcsdqNVykFrfpsndWwUaeYaFs9cDtE3ShQ
         OEQxiq/e4P+zPASVVW0IjN0wZmM97RpwT50u6L08UYwdVykdtMAqd34qY7165wEhGxUd
         G0Gg==
X-Forwarded-Encrypted: i=1; AFNElJ/7DdHV794CkGzYc7fYGO5Pl7o2bO9uD6dbByFMqwn8PifNsYc5BI3HyTiPSKM0V7rYExR6gYK7HQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyU69FAe/uZC8IPmBgzofDLeYdCOvQKw6SqVustbCyFa+kmbNNE
	j8vXa0+K+DD6guzWs1HSJgvQzknYYElOVHNGqRvJpWkSOmxVyX7rYoAFGXZAt1wyMYEMAe5oJs7
	2FulLt+i+5WWdrg==
X-Received: from wmrc10.prod.google.com ([2002:a05:600c:aca:b0:485:3a2f:2f7e])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:2d82:b0:48a:53ea:140b with SMTP id 5b1f17b1804b1-48fe6898017mr153226065e9.28.1779135650990;
 Mon, 18 May 2026 13:20:50 -0700 (PDT)
Date: Mon, 18 May 2026 20:20:50 +0000
In-Reply-To: <20260518111546.3baebae99dc3f2a4fd65e605@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260513-page_alloc-unmapped-prep-v1-0-dacdf5402be8@google.com> <20260518111546.3baebae99dc3f2a4fd65e605@linux-foundation.org>
X-Mailer: aerc 0.21.0
Message-ID: <DIM2YAI5ORUU.2YLTV7PWKE516@google.com>
Subject: Re: [PATCH 0/4] mm: misc cleanups from __GFP_UNMAPPED series
From: Brendan Jackman <jackmanb@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Brendan Jackman <jackmanb@google.com>
Cc: Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, <linux-mm@kvack.org>, 
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon May 18, 2026 at 6:15 PM UTC, Andrew Morton wrote:
> On Wed, 13 May 2026 12:35:12 +0000 Brendan Jackman <jackmanb@google.com> wrote:
>
>> In v2 of the __GFP_UNMAPPED series [0], we realised that some of the patches
>> could potentially be merged as independent cleanups.
>> 
>> These are all independent of one another, if you think some are useful
>> cleanups and others are pointless churn, it should be fine to just pick
>> whatever subset you prefer.
>> 
>> No functional change intended.
>
> Thanks, Brendan.  I added this to mm.git's mm-new branch for testing,
> along with a note that [4/4] may be getting an update arising from
> Vlastimil's feedback.

Cool thanks, (also I got the "added to mm-new branch notification" and
realised why I missed it last time, broken mail filter).

The 4/4 update is already up, in reply to the thread.
