From: Yu Chen <yu.chen.surf@gmail.com>
Subject: Re: [PATCH 00/11] fs: use freeze_fs on suspend/hibernate
Date: Fri, 1 Dec 2017 00:36:46 +0800
Message-ID: <CADjb_WRG8hxJB3zY5_XnZqeQbCy3jYW5xJaS63_7FGztZymLzg@mail.gmail.com>
References: <20171129232356.28296-1-mcgrof@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-block-owner@vger.kernel.org>
In-Reply-To: <20171129232356.28296-1-mcgrof@kernel.org>
Sender: linux-block-owner@vger.kernel.org
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: viro@zeniv.linux.org.uk, bart.vanassche@wdc.com, ming.lei@redhat.com, tytso@mit.edu, darrick.wong@oracle.com, jikos@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-fsdevel@vger.kernel.org, boris.ostrovsky@oracle.com, jgross@suse.com, todd.e.brandt@linux.intel.com, nborisov@suse.com, jack@suse.cz, martin.petersen@oracle.com, ONeukum@suse.com, oleksandr@natalenko.name, oleg.b.antonyan@gmail.com, Dan Williams <dan.j.williams@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, linux-block@vger.kernel.org, linux-xfs@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 30, 2017 at 7:23 AM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> This is a followup from the original RFC which proposed to start
> to kill kthread freezing all together [0]. Instead of going straight
> out to the jugular for kthread freezing this series only addresses
> killing freezer calls on filesystems which implement freeze_fs, after
> we let the kernel freeze these filesystems for us on suspend.
>
>
>   o xfs
>   o reiserfs
>   o nilfs2
>   o jfs
>   o f2fs
>   o ext4
>   o ext2
>   o btrfs
>

Thanks for your work on this!  I'll test xfs part first.
BTW, is nfs able to be included in this set? I also encountered a
freeze() failure
due to nfs access during that stage recently.
-- 
Thanks,
Yu
