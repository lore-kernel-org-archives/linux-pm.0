Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204B51E3DE5;
	Sun, 15 Feb 2026 17:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771174958; cv=none; b=gRNJKmeYP9yKCSZbST+gKG4yiEnalVMYo/8DXBs8oMT+eF+lmHKFNYD5zc/idxzI6GsT89BtI35mz8+I8WTSasIoxa1huRaPoKZro5+grSfJ8UCBAFHhWPtmx8wJ2dCSGcZiQWnQ5TxjY2ELc1EJxb7couavRW7IbDpwgEy7x4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771174958; c=relaxed/simple;
	bh=OvAnKTaL14/r9aEBIEjJXyVSCbVNytTacNr8GtNUKxw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=OWyFl504j2Op92Z0tNI+/UFjLr6yN46G8ryMmZwXSreWuTwLBvnPjGGBNedcteLtAnlCETF4NSaBcnhOHRpRJmMjJqAe10fOZJIyen6ZHq15uozwaI2OJ6zT2uypNQJUxai0ztDdZALo9mkAvGxRtUqaa+7sy6BrLOYvwnCCSV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AHApYU/e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AHApYU/e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44765C4CEF7;
	Sun, 15 Feb 2026 17:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1771174957;
	bh=OvAnKTaL14/r9aEBIEjJXyVSCbVNytTacNr8GtNUKxw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AHApYU/er0rxf4sTDinVRbaaVZC62BCDB9x/6yklj7sMiJwBFDl6F8Q2PeP0dIb6x
	 wLAVfn+w6rAt7Xv9AtPkyavBWgoV6M1npK9nV/28uKwxaNOHZO1gg/wo82aR39kwVw
	 NYYkxd+TwicNKrxAUuBH53+hyFP4xLhklJo6ugIQ=
Date: Sun, 15 Feb 2026 09:02:36 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: kasong@tencent.com
Cc: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>,
 linux-mm@kvack.org, Chris Li <chrisl@kernel.org>, Kemeng Shi
 <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He
 <bhe@redhat.com>, Barry Song <baohua@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Carsten Grohmann <carstengrohmann@gmx.de>,
 linux-kernel@vger.kernel.org, "open list:SUSPEND TO RAM"
 <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] mm, swap: speed up hibernation allocation and
 writeout
Message-Id: <20260215090236.b546ef526b9bb6315f7884b8@linux-foundation.org>
In-Reply-To: <20260215-hibernate-perf-v2-1-cf28c75b04b7@tencent.com>
References: <20260215-hibernate-perf-v2-0-cf28c75b04b7@tencent.com>
	<20260215-hibernate-perf-v2-1-cf28c75b04b7@tencent.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Feb 2026 19:15:05 +0800 Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org> wrote:

> Since commit 0ff67f990bd4 ("mm, swap: remove swap slot cache"),
> hibernation has been using the swap slot slow allocation path for
> simplification, which turns out might cause regression for some
> devices because the allocator now rotates clusters too often, leading to
> slower allocation and more random distribution of data.
> 
> Fast allocation is not complex, so implement hibernation support as
> well.
> 
> And reduce the indent of the code too, while at it. It doesn't have to
> check the device flag, as the allocator will also check the device flag
> and refuse to allocate if the device is not writable.
> 
> Test result with Samsung SSD 830 Series (SATA II, 3.0 Gbps) shows the
> performance is several times better [1]:
> 6.19:               324 seconds
> After this series:  35 seconds

10x is a lot, so I think we should offer this to -stable kernels.

If you agree, could you please prepare a more backportable fix? 
Something minimal, separated from the [2/2] cleanup and without the
incidental whitespace alteration?

We can look at the indenting alteration and [2/2] after 7.0-rc1.
