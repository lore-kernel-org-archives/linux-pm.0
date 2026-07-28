Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF433624D7;
	Tue, 28 Jul 2026 03:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785209785; cv=none; b=gm/6u+o4+z2EHylYoBAaqurTGgHwRzBj4GTt+kf5D7H22RLk4Ilu4Q2sOlRwy0rlf3I+zePilL34R32IePuBy/l9xSRvKhv/I0/zfo9yL+fzWBvrjY+QJpXe9kd/xQheyXCFAsTEmx/pWszVq12B6b1M1v4g+3Qdk+nfx1uH3lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785209785; c=relaxed/simple;
	bh=bMmH/tEkRMi5VnD01ibMkKX8khNupfcN/q44wfH9Nqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZeXWUWUqfAMeLeb1nMlHuLll26MRqF1zYMVhOs8vTmEXPMqUBHJ/wi0xBt7YRkm4Qsf92AUCxHPAtjGwcgxIi2Z//lMRFJSzA4TGUNg8d8RooxUSZ4xJw46Otgk5WANVKop6qKbA/IBRyBupmN6i35fQE6H5DdmmxdUIBxNnP6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KHkMCQ1E; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KHkMCQ1E"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XfUaiRgAKba5yf9/X7HN2iNnJo3HtAX2yPp6vW5fWTE=; b=KHkMCQ1EISi0Qsope0xDosun19
	Z+93/sVtkj3zDOESDavUjruzw0/+7chn8lGkqLlgPOej+reCgIfm2RtvG9wsSn1Gzl3EK6Bz6G7Di
	/fT9s4Y5x8b50gp+HMYt/SCp7uulX2MgbK1kNK17LvpNgYG0sqNMAdz/W7mMOc0ttCAkJM7QW2wUI
	dpfo6KhMevxe/GyamFkNlEgwmzu0f7fZf06RRfKvnZM/1msavFfoi1O/hFrA6GtV+PzRaaEjvxKEI
	LMxmvV6GiygsXO4Dy0m0xF9vWpqc3pMYi64CFa0fk07m//Ym+TFW5ecxem1p4qul9dBiTtwObG6m8
	vKMp58RQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woYc4-00000004Kje-2c2I;
	Tue, 28 Jul 2026 03:36:16 +0000
Date: Mon, 27 Jul 2026 20:36:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	Xuewen Yan <xuewen.yan@unisoc.com>, rafael@kernel.org,
	pavel@kernel.org, lenb@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, ke.wang@unisoc.com
Subject: Re: [RFC PATCH 1/2] PM: EM: Export em_table_alloc/free
Message-ID: <amgjsFwIQB01NhQZ@infradead.org>
References: <20260710082447.5160-1-xuewen.yan@unisoc.com>
 <alSVBRoPnyVHLcEJ@infradead.org>
 <CAB8ipk-cVZVLHdh_9y_E0wTZeFYqy-smCm0KgxYbak1S8U=F_A@mail.gmail.com>
 <amCHAZgQQkgDSQYo@infradead.org>
 <82e71c8f-7755-43f6-9518-209525f5acbc@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82e71c8f-7755-43f6-9518-209525f5acbc@arm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jul 27, 2026 at 09:03:04AM +0100, Lukasz Luba wrote:
> It's a bit more complex situation IMHO.

It's not.  And if you think stupid Android decisions that are 100%
contrary to upstream policies should in any way relevant, you should
spend your time on RTOS BSPs and not argue on Linux mailing lists.

