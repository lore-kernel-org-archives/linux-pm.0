From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 26/27] kernel/power/swap.c: use bio_get_base_vec()
Date: Tue, 5 Apr 2016 05:56:30 -0700
Message-ID: <20160405125630.GE11986@infradead.org>
References: <1459858062-21075-1-git-send-email-tom.leiming@gmail.com>
 <1459858062-21075-12-git-send-email-tom.leiming@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1459858062-21075-12-git-send-email-tom.leiming@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Boaz Harrosh <boaz@plexistor.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

I really don't like all these bio_get_base_vec uses.  The end_io
handlers generall want to iterate over all pages in the bio, with
a special case where all of them is the fixed number one.

So What I think we'll need is a bio_for_each_page, and if there is
any good justification for it as special version of the single
page case.
