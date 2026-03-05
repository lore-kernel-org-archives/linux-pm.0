Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02881FF7B3
	for <linux-pm@vger.kernel.org>; Thu,  5 Mar 2026 20:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772742264; cv=none; b=OwDvlpg8PLQzYsXdc9IShzhkGD6oPk6/3ChwNFa+5Emr62vAduLOONjeGvz8IM2E2KcskwNjMkgdCyHZ19Q/Xu/55y/woVEm4sbFD34KWjORLNprnW0x2i/FawcgFK4VoXleXGoRl54mc3F7nH1CEGF7pKiJxn7Mx9JOYs4u3/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772742264; c=relaxed/simple;
	bh=xdY8MLKtL7iezdtBmG7p3ZtPy9zVMN4MvTKHbayVyf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fYqI8iEGvCIhswi31Qxdxpx4ShBbDJkP6MC6QAXwftFexGiJa5IUL37R0w8iM9vAR+1GSBdHCHtfDjnMR1xsdJbe6m2N1R5eg5uQgKwYjL9cp6b1rOew855vo6aXiGDCB1HrPb5RrLCS5ASAEAqQff6MH+GRzZaZI0eItzkhfCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=psK4wZaX; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="psK4wZaX"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772742261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BH82XF0wTs4O8E0ts/qJuVTlWmsqTS6pY4Qf35UCzxM=;
	b=psK4wZaX0AmqORIgObeuNszbt4Pdwr0bMkPwaWwRwIBjVysaU8pBe4d787ivtWp7tUxiqY
	OkkErAEvNgWYky73318wD6+bPwz88xYnByfkrTyDzCRbV8TVgnWf7qT1gn5T9QEjpp/vYD
	n8hkJKvQnTrW5/s639LPUxPugJvPLns=
From: Usama Arif <usama.arif@linux.dev>
To: Youngjun Park <youngjun.park@lge.com>
Cc: Usama Arif <usama.arif@linux.dev>,
	linux-pm@vger.kernel.org,
	linux-mm@kvack.org,
	rafael@kernel.org,
	lenb@kernel.org,
	pavel@kernel.org,
	akpm@linux-foundation.org,
	chrisl@kernel.org,
	kasong@tencent.com,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	baohua@kernel.org
Subject: Re: [RFC PATCH 0/2] kernel/power: fix swap device reference handling in hibernation swap path
Date: Thu,  5 Mar 2026 12:24:12 -0800
Message-ID: <20260305202413.1888499-1-usama.arif@linux.dev>
In-Reply-To: <20260302165334.1278479-1-youngjun.park@lge.com>
References: 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Tue,  3 Mar 2026 01:53:32 +0900 Youngjun Park <youngjun.park@lge.com> wrote:

> This series addresses two issues in the hibernation swap path.
> 
> First, grabbing and releasing the swap device reference on every slot
> allocation is inefficient across the entire hibernation swap path.
> 
> Second, in the uswsusp path, only the swap type value is retrieved at
> lookup time without holding a reference. If swapoff races after the
> type is acquired, subsequent slot allocations operate on a stale swap
> device.
> 
> The fix is to hold the swap device reference from the point the swap
> device is looked up, and release it once at each exit path.
> 
>   Patch 1: Release the reference immediately after each slot allocation
>             as a preparatory step.
>   Patch 2: Lift the reference acquisition to the lookup site and place
>             put_swap_device_by_type() at all relevant cleanup paths in
>             swap.c and user.c.

Hello!

I cant comment on the feasibility of the approach, but for proper series,
you would need to squash the 2 commits, otherwise it would break git
bisectability.

Thanks
