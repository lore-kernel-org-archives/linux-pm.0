From: Yu Chen <yu.chen.surf@gmail.com>
Subject: Re: [PATCH 00/11] fs: use freeze_fs on suspend/hibernate
Date: Fri, 1 Dec 2017 00:50:55 +0800
Message-ID: <CADjb_WR=bs_fa2wstY=9hgQaOKGqvWqz3mtZeeoHvmLWomv4mA@mail.gmail.com>
References: <20171129232356.28296-1-mcgrof@kernel.org> <CADjb_WRG8hxJB3zY5_XnZqeQbCy3jYW5xJaS63_7FGztZymLzg@mail.gmail.com>
 <nycvar.YFH.7.76.1711301740000.11505@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <nycvar.YFH.7.76.1711301740000.11505@cbobk.fhfr.pm>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, viro@zeniv.linux.org.uk, bart.vanassche@wdc.com, ming.lei@redhat.com, tytso@mit.edu, darrick.wong@oracle.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-fsdevel@vger.kernel.org, boris.ostrovsky@oracle.com, jgross@suse.com, todd.e.brandt@linux.intel.com, nborisov@suse.com, jack@suse.cz, martin.petersen@oracle.com, ONeukum@suse.com, oleksandr@natalenko.name, oleg.b.antonyan@gmail.com, Dan Williams <dan.j.williams@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, linux-block@vger.kernel.org, linux-xfs@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Dec 1, 2017 at 12:41 AM, Jiri Kosina <jikos@kernel.org> wrote:
> On Fri, 1 Dec 2017, Yu Chen wrote:
>
>> BTW, is nfs able to be included in this set? I also encountered a
>> freeze() failure due to nfs access during that stage recently.
>
> The freezer usage in NFS is magnitudes more complicated, so it makes sense
> to first go after the lower hanging fruit to figure out the viability of
> the whole aproach in practice.

Ok, thanks!
