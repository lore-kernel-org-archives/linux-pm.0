From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 4/4] PM: submit bio in a sane way in cases without bio_chain
Date: Mon, 04 May 2015 16:14:41 +0200
Message-ID: <9127728.yg9ESTg3qj@vostro.rjw.lan>
References: <1429830275-6792-1-git-send-email-mlin@kernel.org> <20150430173441.GA23579@amd> <20150501172156.GA29624@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64419 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751252AbbEDNtl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2015 09:49:41 -0400
In-Reply-To: <20150501172156.GA29624@infradead.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Pavel Machek <pavel@ucw.cz>, Ming Lin <mlin@kernel.org>, linux-kernel@vger.kernel.org, Kent Overstreet <kent.overstreet@gmail.com>, Jens Axboe <axboe@kernel.dk>, Dongsu Park <dongsu.park@profitbricks.com>, linux-pm@vger.kernel.org, rjw@sisk.pl

On Friday, May 01, 2015 10:21:56 AM Christoph Hellwig wrote:
> On Thu, Apr 30, 2015 at 07:34:41PM +0200, Pavel Machek wrote:
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > 
> > Tested-by: Pavel Machek <pavel@ucw.cz>
> > Acked-by: Pavel Machek <pavel@ucw.cz>
> > 
> > (thinkpad x60 in shutdown mode, platform mode has some problems, but
> > they are probably not related).
> 
> Thanks!  Rafeal, do you want to take this through the pm tree, or can we
> include it with the block patches?


Both work for me and I'm not aware of any dependencies on the PM side.

So, I guess, please go ahead and take it with the block patches.  Feel free
to add my ACK to it too.

Rafael

