From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [PATCH 26/27] kernel/power/swap.c: use bio_get_base_vec()
Date: Tue, 5 Apr 2016 21:19:32 +0800
Message-ID: <CACVXFVNScDZCt2weJBNU4JW9RYQjGftFwaQSBh=68wueCEDtvA@mail.gmail.com>
References: <1459858062-21075-1-git-send-email-tom.leiming@gmail.com>
	<1459858062-21075-12-git-send-email-tom.leiming@gmail.com>
	<20160405125630.GE11986@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160405125630.GE11986@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@fb.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org, Boaz Harrosh <boaz@plexistor.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 5, 2016 at 8:56 PM, Christoph Hellwig <hch@infradead.org> wrote:
> I really don't like all these bio_get_base_vec uses.  The end_io
> handlers generall want to iterate over all pages in the bio, with
> a special case where all of them is the fixed number one.
>
> So What I think we'll need is a bio_for_each_page, and if there is
> any good justification for it as special version of the single
> page case.

I thought about that too, and bio_get_base_vec() can be thought as
the special version too, IMO.  Actually it is just about the name of
the helper, do you have a better name or other idea for such issue?

There are about ten such usages, as found in this patchset.


Thanks,
Ming Lei
