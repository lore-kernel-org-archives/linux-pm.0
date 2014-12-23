From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH 16/17] fs: convert buffer head etc. to use immutable
 biovecs API.
Date: Tue, 23 Dec 2014 02:51:28 -0800
Message-ID: <20141223105128.GE27600@infradead.org>
References: <cover.1419241597.git.dongsu.park@profitbricks.com>
 <4287748e7d1a0fce1c951567a7688821f1a21e5e.1419241597.git.dongsu.park@profitbricks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:44944 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754411AbaLWKv3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Dec 2014 05:51:29 -0500
Content-Disposition: inline
In-Reply-To: <4287748e7d1a0fce1c951567a7688821f1a21e5e.1419241597.git.dongsu.park@profitbricks.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dongsu Park <dongsu.park@profitbricks.com>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Kent Overstreet <kmo@daterainc.com>, Ming Lin <mlin@minggr.net>, Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org

On Mon, Dec 22, 2014 at 12:48:43PM +0100, Dongsu Park wrote:
> From: Kent Overstreet <kmo@daterainc.com>
> 
> Increase bio->bi_remaining instead of calling bio_get(),
> and call bio_end() instead of bio_put() upon buffer_head submission.

Nees an explanation on why this is done.

> Also make bio submission in kernel/power/block_io.c to properly submit
> bios by checking whether bio_chain is available or not.

Should be a separate patch.

And of course both should go into the preparation series of cleanups.

