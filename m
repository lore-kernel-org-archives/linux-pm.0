From: Roman Pen <roman.penyaev@profitbricks.com>
Subject: [PATCH 0/4] introduce new put_getdisk() call
Date: Mon,  1 Feb 2016 15:51:51 +0100
Message-ID: <1454338315-13465-1-git-send-email-roman.penyaev@profitbricks.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Roman Pen <roman.penyaev@profitbricks.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alexander Viro <viro@zeniv.linux.org.uk>, Dan Williams <dan.j.williams@intel.com>, Gi-Oh Kim <gi-oh.kim@profitbricks.com>, Jens Axboe <axboe@kernel.dk>, Len Brown <len.brown@intel.com>, Ming Lei <tom.leiming@gmail.com>, Pavel Machek <pavel@ucw.cz>, Sagi Grimberg <sagig@mellanox.com>, Tejun Heo <tj@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hello.

In this patchset in the first patch I fixed module reference leak inside
blk-cgroup.c.  In other patches I switched to a new put_getdisk() call,
which should be used if the disk was received by get_disk() or get_gendisk()
functions, which internally increase module reference.

The idea is to avoid confusion in the future and to have symmetric calls:

	alloc_disk() -> put_disk() [as it is done in all the block drivers]

and

	get_gendisk() -> put_gendisk() [if you need to find a disk by minor,major]

The second sequence internally increases disk owner module reference on
get and decreases it on put.

Roman Pen (4):
  block: fix module reference leak on put_disk() call for cgroups
    throttle
  block: introduce new call put_gendisk() in genhd.c
  block,fs: switch to a new put_gendisk() call
  hibernate: fix disk and module leak on successfull resume

 block/blk-cgroup.c       |  6 ++---
 block/genhd.c            | 59 +++++++++++++++++++++++++++++++++++++++++++++---
 fs/block_dev.c           | 24 ++++++--------------
 include/linux/genhd.h    |  1 +
 kernel/power/hibernate.c |  5 +++-
 5 files changed, 71 insertions(+), 24 deletions(-)

Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Gi-Oh Kim <gi-oh.kim@profitbricks.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Len Brown <len.brown@intel.com>
Cc: Ming Lei <tom.leiming@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Sagi Grimberg <sagig@mellanox.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: linux-block@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org

-- 
2.6.2
