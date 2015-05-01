From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3 4/4] PM: submit bio in a sane way in cases without
 bio_chain
Date: Fri, 1 May 2015 10:21:56 -0700
Message-ID: <20150501172156.GA29624@infradead.org>
References: <1429830275-6792-1-git-send-email-mlin@kernel.org>
 <1429830275-6792-5-git-send-email-mlin@kernel.org>
 <20150424161726.GA21763@infradead.org>
 <20150430173441.GA23579@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:39060 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007AbbEARV6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 May 2015 13:21:58 -0400
Content-Disposition: inline
In-Reply-To: <20150430173441.GA23579@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Christoph Hellwig <hch@infradead.org>, Ming Lin <mlin@kernel.org>, linux-kernel@vger.kernel.org, Kent Overstreet <kent.overstreet@gmail.com>, Jens Axboe <axboe@kernel.dk>, Dongsu Park <dongsu.park@profitbricks.com>, linux-pm@vger.kernel.org, rjw@sisk.pl, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Thu, Apr 30, 2015 at 07:34:41PM +0200, Pavel Machek wrote:
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Tested-by: Pavel Machek <pavel@ucw.cz>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> 
> (thinkpad x60 in shutdown mode, platform mode has some problems, but
> they are probably not related).

Thanks!  Rafeal, do you want to take this through the pm tree, or can we
include it with the block patches?
