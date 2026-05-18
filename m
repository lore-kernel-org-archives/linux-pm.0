Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6263C381AEB;
	Mon, 18 May 2026 18:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779128147; cv=none; b=rioAW1+nHbXwAuZ778AuhDA9IwlAFTkfTHhqW9xBZF+aMfemsW6COqTTzLkqp0ANurWmgAbw1NJNu3IHExnpRmQwNzm+8g2hJB/ecBCp51ygHoNc1XXARXyG696ZcAcOAcd3Di1kal7xk+heD+iW4wGPiikXIp9VCk19iNu+F8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779128147; c=relaxed/simple;
	bh=ru4p7XQSqRvvGJrY0kKH+1TvzjzUr/MW6q3YX4REiMk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mMTAXxix94dGVwLJUGBafdppIHWt7aCEydKxSz6VXsrinmY1H+2z1G+9OepKIdQn+CuAMoLBuuLJSZyiS/bgPKFIF4HgAdFfJb+advAylOOBdKya+2GWAVZLDRuIhDfqx9AkNMg1wugVdMmHJsTjIiGpD1gYm+VL7x36Q5QxfXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HHdUXecE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HHdUXecE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9DBC2BCB7;
	Mon, 18 May 2026 18:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1779128147;
	bh=ru4p7XQSqRvvGJrY0kKH+1TvzjzUr/MW6q3YX4REiMk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HHdUXecEEoIvxx+Pmc+9DuKO0vZwFqzLVCkEP2vHBoMzZk0YFoxQFpR1N4Yy8/Q6H
	 z8TCWSU9YuEqc7G85toV30dn2H3CiyKUVZtjDf3WFRdUZahWXiW/3gFJpSRemLPcDT
	 PBXm+I39YQjUd69a6NbP+a6qCP7kU9825GJQ0ky4=
Date: Mon, 18 May 2026 11:15:46 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Brendan Jackman <jackmanb@google.com>
Cc: Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, Shakeel
 Butt <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>, Axel
 Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei
 Xu <weixugc@google.com>, David Hildenbrand <david@kernel.org>, Lorenzo
 Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil
 Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Len Brown <lenb@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan
 <ziy@nvidia.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/4] mm: misc cleanups from __GFP_UNMAPPED series
Message-Id: <20260518111546.3baebae99dc3f2a4fd65e605@linux-foundation.org>
In-Reply-To: <20260513-page_alloc-unmapped-prep-v1-0-dacdf5402be8@google.com>
References: <20260513-page_alloc-unmapped-prep-v1-0-dacdf5402be8@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 May 2026 12:35:12 +0000 Brendan Jackman <jackmanb@google.com> wrote:

> In v2 of the __GFP_UNMAPPED series [0], we realised that some of the patches
> could potentially be merged as independent cleanups.
> 
> These are all independent of one another, if you think some are useful
> cleanups and others are pointless churn, it should be fine to just pick
> whatever subset you prefer.
> 
> No functional change intended.

Thanks, Brendan.  I added this to mm.git's mm-new branch for testing,
along with a note that [4/4] may be getting an update arising from
Vlastimil's feedback.

