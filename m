From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 07/11] xfs: remove not needed freezing calls
Date: Thu, 30 Nov 2017 21:32:53 +0100
Message-ID: <CAJZ5v0hrEWOMi+C0Cw+ij_P7fwh=d7KVHAKWWTc=C2SSw=2nkA@mail.gmail.com>
References: <20171129232356.28296-1-mcgrof@kernel.org> <20171129232356.28296-8-mcgrof@kernel.org>
 <20171130162155.GB28180@quack2.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20171130162155.GB28180@quack2.suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jan Kara <jack@suse.cz>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, bart.vanassche@wdc.com, ming.lei@redhat.com, Ted Ts'o <tytso@mit.edu>, "Darrick J. Wong" <darrick.wong@oracle.com>, Jiri Kosina <jikos@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-fsdevel@vger.kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, Todd Brandt <todd.e.brandt@linux.intel.com>, nborisov@suse.com, "Martin K. Petersen" <martin.petersen@oracle.com>, Oliver Neukum <ONeukum@suse.com>, oleksandr@natalenko.name, Oleg Antonyan <oleg.b.antonyan@gmail.com>, Yu Chen <yu.chen.surf@gmail.com>, Dan Williams <dan.j.williams@intel.com>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 30, 2017 at 5:21 PM, Jan Kara <jack@suse.cz> wrote:
> On Wed 29-11-17 15:23:52, Luis R. Rodriguez wrote:
>> This removes superflous freezer calls as they are no longer needed
>> as the VFS now performs filesystem freezing/thaw if the filesystem has
>> support for it.
>>
>> The following Coccinelle rule was used as follows:
>>
>> spatch --sp-file fs-freeze-cleanup.cocci --in-place fs/$FS/
>
> I think your rule misses WQ_FREEZABLE flag for workqueues? That would be
> also good to get rid of...

We need that one (or equivalent) for the runtime PM workqueue at least.

Thanks,
Rafael
