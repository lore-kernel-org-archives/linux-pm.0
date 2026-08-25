Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252722B2D7;
	Tue, 25 Aug 2026 06:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787637739; cv=none; b=elMlzb8uw0n5Dfqv2c3RHaJ2pZ1kKqbYQYxTatxv4pX6oDDdD1eUr3GrQMjEV4+7vQd3pEmXMqwrrmv6RJgzgnsaHEzEKAsXeINixIIm/TX6cAw1zy5mHGzJtRxLDzmPxa7KyRbxjrdgVpLtp1fljZti+THCZdySMDG2JY+6OAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787637739; c=relaxed/simple;
	bh=se26DWJjQPw/CECKbVhpMhiM7HVx8jRRFHTlqKYJKbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhMlpVP59Ue2MGA7Io88F35lEWLlJcVU6KzbON6cVz05zp9yyo/ZpqI9M3erZa1upaHXhR1XgpANZHP11izjUGqFSZQ4dMT1Eo9Yk6Uq5jmml+2gq/yYuXYrlqjZkaxCt/WR37XpphXa4h1jvsfIGBZKBAHt6KWemvvCtX2FayY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qkDXr60S; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qkDXr60S"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Y8J0w99XhPe4za46FqlLUOlD17nHV5mOI5lax478YY8=; b=qkDXr60S52UKwkByPvrzlj8wgJ
	jhfpxBm6Y0uo3ZI6QKvK6G37tvaiUhQ235/szcP/iM2dM4E+ZKAGB40Rc1+2iPhY4I6EezIbhGnmj
	Ri9FB+lPnddo3cG/81TXFbx7KQqxlbPxzTddVzLYCOSY+jqLvk7QN/TQtl7sp4hcDwBoxPkQpoEHs
	Rwij1P8/wKMHGKI/INtbClfM7kdVCaJSfmluN5zd6KNtMGdX3ZMT3y+gmaxwiH13IUZpG2UZq2QLb
	qPb0zwjX0wbXam1+UfPpPILZcyLMdU50QdrtwxrC/gIEJ5qttE1+c+QsyKEM448BLUKFq+Aw2EUFR
	QJG8633A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wykEi-00000000Cyr-3ETB;
	Tue, 25 Aug 2026 06:02:16 +0000
Date: Mon, 24 Aug 2026 23:02:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dongbum Kim <dongbumkim75@gmail.com>
Cc: rafael@kernel.org, lenb@kernel.org, pavel@kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dongbum Kim <dongbum.kim@lge.com>
Subject: Re: [PATCH] power: use EXPORT_SYMBOL() to export symbol
Message-ID: <ao0v6G68S_W5CBz5@infradead.org>
References: <20260820034445.2562231-1-dongbum.kim@lge.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820034445.2562231-1-dongbum.kim@lge.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Aug 20, 2026 at 12:44:45PM +0900, Dongbum Kim wrote:
> Add EXPORT_SYMBOL() to mark freeze_timeout_msecs symbol as visible.
> 
> freeze_timeout_msecs defines the timeout for try_to_freeze_tasks. If
> tasks cannot be frozen within this timeout, try_to_freeze_tasks fails,
> and causes suspend or hibernation to fail.
> 
> For example, a device driver may need to perform certain operations

I think you really should know that:

 a) exports without users are a complete no-go, and sending them is
    considered a major offence
 b) even with users, exporting data (variables) is generally a bad idea
 c) non-GPL exports for new functionality are almost always a bad idea

if not please take this up with your corporate and technical leadership
to ensure the Linux training standards at LG are up to date.
