From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v3 4/4] PM: submit bio in a sane way in cases without
 bio_chain
Date: Thu, 30 Apr 2015 19:34:41 +0200
Message-ID: <20150430173441.GA23579@amd>
References: <1429830275-6792-1-git-send-email-mlin@kernel.org>
 <1429830275-6792-5-git-send-email-mlin@kernel.org>
 <20150424161726.GA21763@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46666 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbbD3Res (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Apr 2015 13:34:48 -0400
Content-Disposition: inline
In-Reply-To: <20150424161726.GA21763@infradead.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lin <mlin@kernel.org>, linux-kernel@vger.kernel.org, Kent Overstreet <kent.overstreet@gmail.com>, Jens Axboe <axboe@kernel.dk>, Dongsu Park <dongsu.park@profitbricks.com>, linux-pm@vger.kernel.org, rjw@sisk.pl, "Rafael J. Wysocki" <rjw@rjwysocki.net>

Hi!

> >From af56dde07c34b203f5c40c8864bfd55697b0aad0 Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Fri, 24 Apr 2015 11:26:00 +0200
> Subject: suspend: sane block I/O handling
> 
> stop abusing struct page functionality and the swap end_io handler, and
> instead add a modified version of the blk-lib.c bio_batch helpers.
> 
> Also move the block I/O code into swap.c as they are directly tied into
> each other.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Tested-by: Pavel Machek <pavel@ucw.cz>
Acked-by: Pavel Machek <pavel@ucw.cz>

(thinkpad x60 in shutdown mode, platform mode has some problems, but
they are probably not related).

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
