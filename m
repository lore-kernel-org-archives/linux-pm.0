Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBB23FE670;
	Fri, 15 May 2026 15:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778858948; cv=none; b=kRxWzIiohTEFGFZOwH9DAG2JlsWWAyFn67Qt6kgTYJe1F3aVlF/mtM1QD3NwkdVnEQOim/KYeyBYIk7xUBLmsDd4fUe+9wfmyNpfI+IP7+P5yfQ9zQI6tHi8niByP4hPVyvX6I1LT4ZKgqwefk7MVSew+8dsTCwvhZfgEBnwBvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778858948; c=relaxed/simple;
	bh=ThUTdpiSZ+8umL9OOiGs71lNS12Rndy3keIYyO09rHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZEMpESzmjw/vvE2c0TDjISNyHqkR5m3dJ1gu4Dn82+i8oX5mGPyNfdcj727sMEo5ZtuKBbf7TcNv1J1GjWZ3gKC95apVlxqtUFyKdUnkioOvscmVmMH7igMKYkh02pj089YlvV7r6LnDqIWvLI+G5mxNp3DgWfBE9/4TP+HGAqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfL2zLkU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfL2zLkU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB22C2BCB0;
	Fri, 15 May 2026 15:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778858947;
	bh=ThUTdpiSZ+8umL9OOiGs71lNS12Rndy3keIYyO09rHc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kfL2zLkUf2Rn2PzYwWL6zVKwUsEGNaTFTGJbOr7mXrCAkJGcTcR9KLKcHkpnhNM2S
	 29BxO7rkQX2phATYD36HEUG89aKsoarmDEq7bwJwlVfTWeRKU6ZMzYuBxB2dagxNbT
	 p/gM3UUDh0nAFR/lYFojkRoFi5VV6VDYmAv0CO22jVNsXJif4VgsfrqTi/UHg7Kibf
	 3CPnVD9l+l+DBVPq86v360h/h+2FSmKzB4mvuh4HCANC2GbXnoXXhH1RJBPv8tB523
	 Pe1X8GEwR/PLx18yazLDsidgsKbh4dLlsOV6YZZuuE3V/G0imFmNEkoCaXHebSKzeI
	 Mfn5KiA3v6L/A==
Message-ID: <bd36e972-8900-4476-a66b-4dc218b21a4d@kernel.org>
Date: Fri, 15 May 2026 17:29:01 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] mm/page_alloc: remove ifdefs from pindex helpers
Content-Language: en-US
To: Brendan Jackman <jackmanb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Kairui Song <kasong@tencent.com>,
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>,
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Len Brown <lenb@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260513-page_alloc-unmapped-prep-v1-0-dacdf5402be8@google.com>
 <20260513-page_alloc-unmapped-prep-v1-4-dacdf5402be8@google.com>
 <4074a816-9e75-45a6-8141-25459bcc106b@kernel.org>
 <DIJA0MM2F3D2.61WBO3MJZRNQ@google.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <DIJA0MM2F3D2.61WBO3MJZRNQ@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/15/26 15:15, Brendan Jackman wrote:
> On Wed May 13, 2026 at 5:19 PM UTC, Vlastimil Babka (SUSE) wrote:
>> On 5/13/26 14:35, Brendan Jackman wrote:
>>
>> Uh yeah, VM_BUG_ONs are frowned upon now. But doing a VM_WARN_ON_ONCE here
>> makes little sense. There's no safe fallback if we end up here with a wrong
>> value. 
> 
> Isn't that grounds for upgrading them to a real BUG then? My experience

If Linus noticed, there would be yelling :)

> has been (I broke this code lots of times lol, I REALLY struggle with
> this arithmetic stuff) if something goes wrong here the machine quickly
> gets irrevocably and undebuggably borked. Crashing is the best case
> scenario.

Yeah it will crash quickly anyway if you mess it up. I guess if the check
would help you find more quickly what you messed up, a VM_WARN_ON_ONCE would
still have some value even if it can't avoid the imminent disaster. So maybe
just switch it to that.

>> And it's all internal to page alloc so I'd just drop those checks
>> completely at this point.
> 
> But, I won't die on the above hill, if people really hate BUG that much
> happy to go with the flow. 
> 
> In that case, I'd suggest we drop them as a separate patch.

