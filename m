Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2683396585;
	Fri, 22 May 2026 07:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779436797; cv=none; b=j6xUKeJjPJCSLq5MqYfjERx6y3LJywve2Kh7SSbkayVpD320tZWibwwWe1K742QceqdBUMe5uuNQc5BovHgqDapa+vNfL+3X90a6zzaOfaSnI1rtgUy1MOuvwqG6pACcqFOFz+dMdN1XBnQRjbjuH3FkIUaMioZdFJAM3/J8Rps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779436797; c=relaxed/simple;
	bh=TB49ymwVqi36H3keDXu65BReRm8av6F/UjDy7RV949s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=onZVx+myfaAuFcDW1UzELB3G5dXXkuUuDSoX4hqwGnfoJ6SRO9puy2fVzMUnnsOOibfH4sO2F0Ali/nRPL1Zr0oq9JOhB+vRIhnWBecugA5FjY6pT7zDWhlC780cqq6rrCo/Gy4Gtcg6RWK0+vmEWsrYxSR28O1tZ5gF6B5CXg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgcu1bJN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgcu1bJN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9654E1F00A3D;
	Fri, 22 May 2026 07:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779436796;
	bh=ksWIf070K7BXXzRSN1Ju2eTiWS9mqy4PNkoshlF94P0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mgcu1bJN0Zm5cDI8nGLE+7dAKJI9KXOskAQMhFcMbp58VdxiSkMAz797u0AxYJYZr
	 6kocNK9k800jYEtIx3nmaVr4t8M0Euf0k0czqlPUEs9pu1mvRznDr7PTtg9DVJJ/TR
	 2QnUzV2BPUZtIF2DUx6czqQkLEZjJEjj75T3HBmqYujrFAsSxkKhcpZzTvAUdLPUUn
	 bVfZKSLsgVzVzh1Dy8aJ2xOW/ABuKXSlsO82wRmweyHdlHT2EogVZuICOXV+VnnAKY
	 UkS6USaW8ElY8NbUSgkTUSeTbNr68010aDiwdp9oyO4fJproRDmCyU6nmyZG/wyzAG
	 UUSNPevwk2Fkg==
Message-ID: <cd721e44-05cf-470b-ae92-d86791778c28@kernel.org>
Date: Fri, 22 May 2026 09:59:49 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] mm: misc cleanups from __GFP_UNMAPPED series
Content-Language: en-US
To: Brendan Jackman <jackmanb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260513-page_alloc-unmapped-prep-v1-0-dacdf5402be8@google.com>
 <20260518111546.3baebae99dc3f2a4fd65e605@linux-foundation.org>
 <DIM2YAI5ORUU.2YLTV7PWKE516@google.com>
 <20260518134811.b2b78352779d7519e8123597@linux-foundation.org>
 <CA+i-1C1THr6fH=wdTKEngbCSD_DMS5tGroN64BEf3L56DH2XWA@mail.gmail.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <CA+i-1C1THr6fH=wdTKEngbCSD_DMS5tGroN64BEf3L56DH2XWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/18/26 22:58, Brendan Jackman wrote:
> On Mon, 18 May 2026 at 13:48, Andrew Morton <akpm@linux-foundation.org> wrote:
>>
>> On Mon, 18 May 2026 20:20:50 +0000 Brendan Jackman <jackmanb@google.com> wrote:
>>
>> > On Mon May 18, 2026 at 6:15 PM UTC, Andrew Morton wrote:
>> > > On Wed, 13 May 2026 12:35:12 +0000 Brendan Jackman <jackmanb@google.com> wrote:
>> > >
>> > >> In v2 of the __GFP_UNMAPPED series [0], we realised that some of the patches
>> > >> could potentially be merged as independent cleanups.
>> > >>
>> > >> These are all independent of one another, if you think some are useful
>> > >> cleanups and others are pointless churn, it should be fine to just pick
>> > >> whatever subset you prefer.
>> > >>
>> > >> No functional change intended.
>> > >
>> > > Thanks, Brendan.  I added this to mm.git's mm-new branch for testing,
>> > > along with a note that [4/4] may be getting an update arising from
>> > > Vlastimil's feedback.
>> >
>> > Cool thanks, (also I got the "added to mm-new branch notification" and
>> > realised why I missed it last time, broken mail filter).
>> >
>> > The 4/4 update is already up, in reply to the thread.
>>
>> Is that "mm/page_alloc: tidy up pindex helpers"?
>>
>> For some reason I didn't receive that email, directly or via any
>> mailing list.  I do have the similar "mm/page_alloc: remove ifdefs from
>> pindex helpers" from May 13.

Found it, seems to be threaded well with In-reply-to: too, maybe it's the
different subject?

https://lore.kernel.org/all/20260517230556.590677-1-jackmanb@google.com/

Should be fine to replace the current "mm/page_alloc: remove ifdefs from
pindex helpers" in mm.git with that.

> Ooh, that's unfortunate... I used git-send-email directl to send that,
> which is not how I work most of the time, so I suspect something went
> wrong with that particular setup. Will keep an eye on that.
> 
>> Oh well, please check tomorrow's mm.git and send along whatever is
>> needed?
> 
> Ack, thanks again.

