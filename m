Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BAF38F629;
	Mon, 13 Jul 2026 07:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783928075; cv=none; b=uG43EQvCIc1sJn3lHBZQAirpULQQLSBPGnHGgvv5cLuuGa6QRA2GbZ94Wwix8t4n3hK184r1OzozcCBt4nXpxTDquUoYpSFNmhcCOLIhmWCTgkWCsv/WOZ0lQAtTh8cbXTQrXKW45axW1C48xY2jMLt8GZdxvgY2iC0/Ozs/3bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783928075; c=relaxed/simple;
	bh=jtckptQsSbCsDCj0pXMmLT3NGfXx1i4glxY+C+FAjqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYQxnZNMdM3O3DPy56gzhIj4gNLNaW2drf4o+TBKEGGvUhpvwAGsnwDktOEEDySJsj0csDEXoP9E16n/Y96xB1MEvLdNrGNKDTsstO0rgZm7DZFhfp5f7PXvixq2oOlc9+OfM7bGEX9UyEe45BFOZ4yU03xAhGs4Vy/sZFJf2Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vB69+HBe; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vB69+HBe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jtckptQsSbCsDCj0pXMmLT3NGfXx1i4glxY+C+FAjqA=; b=vB69+HBeYSw3HWJ1xWaSl13dfV
	+qTwT1tEL+YW0g6KRxnxgX2L9HbnGpFuF1erjWdBSlOvd7SrwA1+cEvE/4d+7CaOG+Wisn75H1bUO
	dVX1uYYt0AESfVeGHS/5tp4JrukzilL5F4ZSfV0XiFm75ajXMifSdgYoSzRpHub8Z8XIcC5xhc0gv
	J1AQNMatiDpqUl8eLNt+ket/vvHsZN/eytSob4On7mZvwlxACb1HGvec5xcE1WR1dOEsRnaqRffLO
	HAtgtgjf0QpRBFlz7C6XxRfVn267rdr3Tyw012kfiQtjmsrNdMoJmn8YlOXyyUZkgrTDQo0oxpjeV
	92oeDd9A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjBBO-00000008RWQ-0Sfd;
	Mon, 13 Jul 2026 07:34:30 +0000
Date: Mon, 13 Jul 2026 00:34:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Xuewen Yan <xuewen.yan@unisoc.com>
Cc: lukasz.luba@arm.com, rafael@kernel.org, pavel@kernel.org,
	lenb@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, xuewen.yan94@gmail.com,
	ke.wang@unisoc.com
Subject: Re: [RFC PATCH 1/2] PM: EM: Export em_table_alloc/free
Message-ID: <alSVBRoPnyVHLcEJ@infradead.org>
References: <20260710082447.5160-1-xuewen.yan@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710082447.5160-1-xuewen.yan@unisoc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jul 10, 2026 at 04:24:46PM +0800, Xuewen Yan wrote:
> When drivers wants to alloc a new em_perf_table to update
> their em_perf_table, they need to use em_table_alloc and
> em_table_free.
> So export the two func.

Please send this along with the driver actually using it.

