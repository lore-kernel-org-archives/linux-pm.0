From: Dongsu Park <dongsu.park@profitbricks.com>
Subject: Re: [RFC PATCH 16/17] fs: convert buffer head etc. to use immutable
 biovecs API.
Date: Tue, 23 Dec 2014 13:33:28 +0100
Message-ID: <20141223123328.GH15080@gmail.com>
References: <cover.1419241597.git.dongsu.park@profitbricks.com>
 <4287748e7d1a0fce1c951567a7688821f1a21e5e.1419241597.git.dongsu.park@profitbricks.com>
 <20141223105128.GE27600@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141223105128.GE27600@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Kent Overstreet <kmo@daterainc.com>, Ming Lin <mlin@minggr.net>, Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 23.12.2014 02:51, Christoph Hellwig wrote:
> On Mon, Dec 22, 2014 at 12:48:43PM +0100, Dongsu Park wrote:
> > From: Kent Overstreet <kmo@daterainc.com>
> > 
> > Increase bio->bi_remaining instead of calling bio_get(),
> > and call bio_end() instead of bio_put() upon buffer_head submission.
> 
> Nees an explanation on why this is done.

Right.

> > Also make bio submission in kernel/power/block_io.c to properly submit
> > bios by checking whether bio_chain is available or not.
> 
> Should be a separate patch.
> 
> And of course both should go into the preparation series of cleanups.

Yep, agreed.
I'll split it up and also move them to the prep series.

Thanks,
Dongsu
