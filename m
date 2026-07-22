Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F346335C1AE;
	Wed, 22 Jul 2026 09:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784710920; cv=none; b=h2YRK7YQhfqPyQyogpSU8OUKoCEzNbAnfQ/Cp60sYjQ5DH+Ua1ba163iaRU2yyxe3NpdN4O5YBg2xtrbJJvRmvD6xktfEumUxB6+cx98LVPH0goYtr5gHSrdhRkcOi0VqcL43SdTVaGH4Bithq59nDLI33OOiRO9uwCRkjC2s/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784710920; c=relaxed/simple;
	bh=NJJc1TDIHui25kQcxM8ye8j+l0JqvfgJEsS7CVvvlOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vni3XjD/Q/kwS709N1k9My0RCYlNFo1tHfaYpSaHt3ofXqI9asgNMz6ONjM7nn60KiqcyRBZiRe3gjAU9suDrZcUZSt2mdGMFgca96OH9bl3tenrmk5sMDwkhicR1fFvVSn64F908+N76+H17TQsB2TNwyvwTir1zN007GhXfvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nXi812y/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nXi812y/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FTh00APo8EGstTD3iAnTpw5yojuos6lc1cCoIrOclew=; b=nXi812y/kVC1Ih1dyCuZ1LAv/c
	jj8VKobX0v99xTs+qK2Xcece+sIvRrk7PqFGlUFH7An3Ni7CRcnBjqlOrvSnNXekzp8h9q9hzOC4m
	DN9H5Gr7AAqwtVUL7UOkz6tcQGbc6/Rbo9wQvl49VTfoTBnNjFNWsp5PnfAgx76ON4Yqm8Epe9gH/
	93tszyy0NaNmui1/h/ATVUhCnsSHXb009pv3MHnzScLO6m4e0Du41wSXOvqPpGaPo5kFXvuUahFdj
	hkjYH+E2sR/7wBm9JYo/vhMp7QKzn7Ae904ylLooTEx3HB7rv5VvBujJCxqSQy/Q5tAZSdMVC8tU5
	TrYdzbWA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmSpt-0000000BK3b-2Bvw;
	Wed, 22 Jul 2026 09:01:53 +0000
Date: Wed, 22 Jul 2026 02:01:53 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Xuewen Yan <xuewen.yan@unisoc.com>, lukasz.luba@arm.com,
	rafael@kernel.org, pavel@kernel.org, lenb@kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	ke.wang@unisoc.com
Subject: Re: [RFC PATCH 1/2] PM: EM: Export em_table_alloc/free
Message-ID: <amCHAZgQQkgDSQYo@infradead.org>
References: <20260710082447.5160-1-xuewen.yan@unisoc.com>
 <alSVBRoPnyVHLcEJ@infradead.org>
 <CAB8ipk-cVZVLHdh_9y_E0wTZeFYqy-smCm0KgxYbak1S8U=F_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB8ipk-cVZVLHdh_9y_E0wTZeFYqy-smCm0KgxYbak1S8U=F_A@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jul 21, 2026 at 07:10:38PM +0800, Xuewen Yan wrote:
> we use it in android vendor specific ko, and the ko is not upstream.
> We use them with em_dev_update_perf_domain(), Just like
> em_dev_update_perf_domain() was exported, export the
> em_table_alloc/free.

As you've probably been told many times exporting symbols without
in-tree users that are in the same series or at least directly
references is a no-go, and continuing to post them is considered
extremely offensive.  Don't do this.

