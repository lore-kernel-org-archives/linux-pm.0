Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD5A3BB11A
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 11:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779793997; cv=none; b=MODRm0w0Wrrkh4LCnhzlXteHmEUWAwE9xUvwYN/BDpT7vqBStJ0bshHvwHd21fNgbgbdmxyMPf1z3y88Wx+oA3ALlPX6D8LtWZ/sRdgPJJpO3RopbkhNznuInS2KeqqMe+90/X74gAno5Tj8CqRZLRY4X8MlzZFN1EJD5i7KgVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779793997; c=relaxed/simple;
	bh=ahWeOXN5CcSCy55poUbMW4AnXz8eEDd0o8bq34pDmXk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=lINKRi7Gy2lhH2r7oeVutaeXSVFc1S6Fjxn7THk41Y4xN53BvLM8ZS/7Z6+fJ08RVirFg+0g8c/+bVdte6//CeOjL1nwm2tZqMoQPGTIr++/puYOBGpE1LulgSGLNJ3U+83gOufEU7S7WzOpEhb4KeO78gEugElp4SF4k6Fqqe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tJNfFhBb; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tJNfFhBb"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779793992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TjpF0orjvF0V7w7odDBpl4riq79fYXZGW3boLcM3Ji8=;
	b=tJNfFhBb6nEZkjaV1nORtu55FFe2fYeAVJ4+u4AENQjmULOJXH9njHDAvgtJGgUE0hUv0o
	0Q2BpR/Shg0RjQmXJSdKpM4bEwKinKU742K3ZAoozqHT8nCTlfifnDfU15QwxWOH2sYP9L
	5AhJJcaHC7uZjY8bLBqNgU1qKdXBBks=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 May 2026 13:13:07 +0200
Message-Id: <DISKBALN21QH.32PUYTB5LZLJ1@linux.dev>
Subject: Re: [PATCH 0/4] mm: misc cleanups from __GFP_UNMAPPED series
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Brendan Jackman" <brendan.jackman@linux.dev>
To: "Andrew Morton" <akpm@linux-foundation.org>, "Vlastimil Babka (SUSE)"
 <vbabka@kernel.org>
Cc: "Brendan Jackman" <jackmanb@google.com>, "Kairui Song"
 <kasong@tencent.com>, "Qi Zheng" <qi.zheng@linux.dev>, "Shakeel Butt"
 <shakeel.butt@linux.dev>, "Barry Song" <baohua@kernel.org>, "Axel
 Rasmussen" <axelrasmussen@google.com>, "Yuanchu Xie" <yuanchu@google.com>,
 "Wei Xu" <weixugc@google.com>, "David Hildenbrand" <david@kernel.org>,
 "Lorenzo Stoakes" <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 "Mike Rapoport" <rppt@kernel.org>, "Suren Baghdasaryan"
 <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Pavel Machek" <pavel@kernel.org>, "Len Brown"
 <lenb@kernel.org>, "Johannes Weiner" <hannes@cmpxchg.org>, "Zi Yan"
 <ziy@nvidia.com>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>
References: <20260513-page_alloc-unmapped-prep-v1-0-dacdf5402be8@google.com>
 <20260518111546.3baebae99dc3f2a4fd65e605@linux-foundation.org>
 <DIM2YAI5ORUU.2YLTV7PWKE516@google.com>
 <20260518134811.b2b78352779d7519e8123597@linux-foundation.org>
 <CA+i-1C1THr6fH=wdTKEngbCSD_DMS5tGroN64BEf3L56DH2XWA@mail.gmail.com>
 <cd721e44-05cf-470b-ae92-d86791778c28@kernel.org>
 <20260522201154.26bc14524c36df15e40c3470@linux-foundation.org>
In-Reply-To: <20260522201154.26bc14524c36df15e40c3470@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT

On Sat May 23, 2026 at 5:11 AM CEST, Andrew Morton wrote:
> On Fri, 22 May 2026 09:59:49 +0200 "Vlastimil Babka (SUSE)" <vbabka@kerne=
l.org> wrote:
>
>> >> > Cool thanks, (also I got the "added to mm-new branch notification" =
and
>> >> > realised why I missed it last time, broken mail filter).
>> >> >
>> >> > The 4/4 update is already up, in reply to the thread.
>> >>
>> >> Is that "mm/page_alloc: tidy up pindex helpers"?
>> >>
>> >> For some reason I didn't receive that email, directly or via any
>> >> mailing list.  I do have the similar "mm/page_alloc: remove ifdefs fr=
om
>> >> pindex helpers" from May 13.
>>=20
>> Found it, seems to be threaded well with In-reply-to: too, maybe it's th=
e
>> different subject?
>>=20
>> https://lore.kernel.org/all/20260517230556.590677-1-jackmanb@google.com/
>>=20
>> Should be fine to replace the current "mm/page_alloc: remove ifdefs from
>> pindex helpers" in mm.git with that.
>
> I could attempt to do that by my confidence that I got it right would
> be low.
>
> Brendan, please send us a v2 of the series "mm: misc cleanups from
> __GFP_UNMAPPED series", thanks.

Sorry for the delay, was travelling - it looks like you have already
applied the current patches, I will send a separate patch to remove
the VM_BUG_ONs.
