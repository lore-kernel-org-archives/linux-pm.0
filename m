From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 0/4] introduce new put_getdisk() call
Date: Mon, 1 Feb 2016 12:16:42 -0500
Message-ID: <20160201171642.GC14091@mtj.duckdns.org>
References: <1454338315-13465-1-git-send-email-roman.penyaev@profitbricks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1454338315-13465-1-git-send-email-roman.penyaev@profitbricks.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roman Pen <roman.penyaev@profitbricks.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alexander Viro <viro@zeniv.linux.org.uk>, Dan Williams <dan.j.williams@intel.com>, Gi-Oh Kim <gi-oh.kim@profitbricks.com>, Jens Axboe <axboe@kernel.dk>, Len Brown <len.brown@intel.com>, Ming Lei <tom.leiming@gmail.com>, Pavel Machek <pavel@ucw.cz>, Sagi Grimberg <sagig@mellanox.com>, Vishal Verma <vishal.l.verma@intel.com>, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 01, 2016 at 03:51:51PM +0100, Roman Pen wrote:
> Hello.
> 
> In this patchset in the first patch I fixed module reference leak inside
> blk-cgroup.c.  In other patches I switched to a new put_getdisk() call,
> which should be used if the disk was received by get_disk() or get_gendisk()
> functions, which internally increase module reference.
> 
> The idea is to avoid confusion in the future and to have symmetric calls:
> 
> 	alloc_disk() -> put_disk() [as it is done in all the block drivers]
> 
> and
> 
> 	get_gendisk() -> put_gendisk() [if you need to find a disk by minor,major]
> 
> The second sequence internally increases disk owner module reference on
> get and decreases it on put.

For the entire series,

 Acked-by: Tejun Heo <tj@kernel.org>

Nice catch, thanks!

-- 
tejun
