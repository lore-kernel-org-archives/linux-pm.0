From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 15/21] kernel/power/: use pr_<level> and add
	pr_fmt(fmt)
Date: Tue, 6 Oct 2009 00:37:57 +0200
Message-ID: <200910060037.57546.rjw@sisk.pl>
References: <cover.1254701151.git.joe@perches.com>
	<200910052143.37985.rjw@sisk.pl>
	<1254774687.1799.566.camel@Joe-Laptop.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1254774687.1799.566.camel@Joe-Laptop.home>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Joe Perches <joe@perches.com>
Cc: Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday 05 October 2009, Joe Perches wrote:
> On Mon, 2009-10-05 at 21:43 +0200, Rafael J. Wysocki wrote:
> > On Monday 05 October 2009, Joe Perches wrote:
> > > Added #define pr_fmt(fmt) "PM: " fmt
> > > Converted printk(KERN_<level> to pr_<level>(
> > > Removed "PM: " prefix
> > > Added pr_fmt() to __initdata strings
> > 
> > Well, can you please tell me what actually is wrong with the current code?
> 
> Not much.  There were a couple of trivial corrections,
> but perhaps the changes add a bit more flexibility and
> regularity.
> 
> Effective trivial changes:
> 
> o Added KERN_CONT (pr_cont) to a couple of messages
> o Added "PM: " (pr_info) to an #ifdef'd message
> o Added "PM: " (pr_info) to a printk "Syncing filesystems ..."
>   in power/user.c

The patch as is conflicts with the changes I have queued up for 2.6.33
(they'll appear in linux-next after I've fixed all build issues, hopefully
tomorrow).  For one example, we're dropping swsusp.c altogether.

Also, I'm not a big fan of automatic conversions from printk() to
pr_something() other than pr_debug().

Thanks,
Rafael
