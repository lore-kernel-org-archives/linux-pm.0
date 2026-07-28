Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A8235F5E7;
	Tue, 28 Jul 2026 08:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785226658; cv=none; b=lx3uRh1cymLNQblRaUboEXq+wSY3HiLUjKSrvB/YO7y/2pBajlT70DGWTjUXI0id7VN+o0avR6HK7/GVVqF7Rebv3H0tjJzfFhBbKaFYtzGYkPY7mxok7jHfBq2S5hFw5CqW+AnuLTZTcPdDQbvaDbmt+OPSsma4+OSoak1LvVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785226658; c=relaxed/simple;
	bh=oKauIEhrBdo4kzLON070gJzPlzaSdIHO4QNQ7VxBs0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOUEJ4Ym+DUx2dNcDmc4klo0+7LN/Fj2AyzwDNc1GLoI4iajGpBhwRiWtyM0Ce4l/eePB6CPC5sQzD+2OPXLYhGb99aaHLgzLp88IavoWip+AqxTpQ0gOMdOAxPoCmJ7FiIuB/OKeAj6yMhhf3woXYXyslA49ygOIA9MWbJfzQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=b+V0keRE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b+V0keRE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oR4WSpgziwnJtBrABwM9y67FOWyP++cy8HjjmJGocHI=; b=b+V0keREz3lC6pzXYOUwUlQBYr
	5SihnyW60wmWiJm8gh0g6hqz91f8jqmn1rgzlRlMjja0Z/Equ4IDEYPDr6t+Dh5mfpC7Cvq6BWXGE
	ga7Hge2QZp8Juqypfu07HMKPtXwUwrJ+lvkufpsBIig2z4unN37jV3I3WCosz/3Oo0A+TBMWdL5ID
	U0MU7mV0x+FV9iyymIJjByGdAbLNzQcC2M0MizC2gyWaKOo3LKIAkH/YJWoOKyEhuxA38+7IaTyZK
	bJdcA66Q7+hQOvu8gtJQh/2qRjh/GchZOji4jRLBbM/bWaCgXmR4mdn9lGSTnvjxHSElLrnUp9ZaI
	nWfnkiZg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wod0G-00000004hQE-2KOu;
	Tue, 28 Jul 2026 08:17:32 +0000
Date: Tue, 28 Jul 2026 01:17:32 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	Xuewen Yan <xuewen.yan@unisoc.com>, rafael@kernel.org,
	pavel@kernel.org, lenb@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, ke.wang@unisoc.com
Subject: Re: [RFC PATCH 1/2] PM: EM: Export em_table_alloc/free
Message-ID: <amhlnGzigkRfWgx6@infradead.org>
References: <20260710082447.5160-1-xuewen.yan@unisoc.com>
 <alSVBRoPnyVHLcEJ@infradead.org>
 <CAB8ipk-cVZVLHdh_9y_E0wTZeFYqy-smCm0KgxYbak1S8U=F_A@mail.gmail.com>
 <amCHAZgQQkgDSQYo@infradead.org>
 <82e71c8f-7755-43f6-9518-209525f5acbc@arm.com>
 <amgjsFwIQB01NhQZ@infradead.org>
 <ca94527a-e807-4ea5-a577-707e7ea9736e@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca94527a-e807-4ea5-a577-707e7ea9736e@arm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jul 28, 2026 at 09:07:43AM +0100, Lukasz Luba wrote:
> 
> 
> On 7/28/26 04:36, Christoph Hellwig wrote:
> > On Mon, Jul 27, 2026 at 09:03:04AM +0100, Lukasz Luba wrote:
> > > It's a bit more complex situation IMHO.
> > 
> > It's not.  And if you think stupid Android decisions that are 100%
> > contrary to upstream policies should in any way relevant, you should
> > spend your time on RTOS BSPs and not argue on Linux mailing lists.
> > 
> 
> We will make a driver using that and the export would be attached to
> the series.

And that is the way to do it.

> I won't recommend you to spend your time on RTOS BSPs
> but I would to spend on your sub-system. It would benefit more from
> your experience than this EAS+EM complex world.

And this still shows that you're in the wrong place here..

> 
