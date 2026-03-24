Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7DE241695
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 03:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774321413; cv=none; b=L9hruTuhvr3GUqzu3BbUYvlQ0XHTPDP62aXBphnaYadsMB59sdWldB496RWd52p0/gWS/deT8QZb6Vbn3A+KUtfqOJLrFiNXRp4yLxYbAIRJ7BnZqGZTkuk82PssTv9BlfV9+uuGJyF+mvj377UAjfYH7NzW99+g0vBXLrxwbGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774321413; c=relaxed/simple;
	bh=mbffRXJqfeHte+9FqyeO0hvUKNPE3a2bHTWGX7bo13U=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YlJbYQ7khyafxePHzYrFOkjBoi5L1vhUzCQe1QG5lJsTT81C0YdA+uwzWfWRgdbFQ7BuNcc/18BUlONd1BPPmZ9LVpHqL9ipMNZ7ao+ejbt5PlHKED1KJ0vtKx4GxALQzNMuOEeKvBupuViKF2zJxQcLvKEb/1YpQetzoS0qgzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VItKk1Lt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VItKk1Lt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F343C4CEF7;
	Tue, 24 Mar 2026 03:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774321413;
	bh=mbffRXJqfeHte+9FqyeO0hvUKNPE3a2bHTWGX7bo13U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VItKk1LtX/WIJFoGz5ssYX377NIxD1Yoj+OYROfdFqcpdSijoq+VkKNbeENZHQsLK
	 i8oVDm7ZHyW6hA1yc8Vehd8FtA84/5Hq8X97dym8BqYYWk6f+TLeV3iELU2W6dTLeN
	 EnHJmcK2mVB7X759JaPwYtbBI+1zGhHU1qRkXnko=
Date: Mon, 23 Mar 2026 20:03:32 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: YoungJun Park <youngjun.park@lge.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>, Pavel Machek <pavel@kernel.org>, Kemeng
 Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He
 <bhe@redhat.com>, Barry Song <baohua@kernel.org>, Usama Arif
 <usama.arif@linux.dev>, linux-pm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v8 0/2] mm/swap, PM: hibernate: fix swapoff race in
 uswsusp by pinning swap device
Message-Id: <20260323200332.75962255d46fd06be3a23511@linux-foundation.org>
In-Reply-To: <acH8IKWyv9gW9YFU@yjaykim-PowerEdge-T330>
References: <20260323160822.1409904-1-youngjun.park@lge.com>
	<20260323154833.045b732a5865b11b5b4e539e@linux-foundation.org>
	<acH8IKWyv9gW9YFU@yjaykim-PowerEdge-T330>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Mar 2026 11:51:12 +0900 YoungJun Park <youngjun.park@lge.com> wrote:

> > We'll hit a conflict in linux-next and Mark will tell us and we can
> > flag that to Linus when merging into mainline, usual stuff.
> > 
> > Or we can park this until the next cycle, depends on how serious the
> > bug is.  How serious is the bug?
> 
> Hi Andrew,
> 
> In my opinion, this bug is unlikely to occur and does not appear to be serious. 
> It may be better to park this for the next cycle.

Great, thanks.  I'll await Rafael's input and let's see how much damage
Mark encounters.

