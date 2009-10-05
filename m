From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 15/21] kernel/power/: use pr_<level> and add
	pr_fmt(fmt)
Date: Mon, 05 Oct 2009 13:31:27 -0700
Message-ID: <1254774687.1799.566.camel@Joe-Laptop.home>
References: <cover.1254701151.git.joe@perches.com>
	<17906d40d7b002380e893d49639ba3f1e7bdb3a0.1254701151.git.joe@perches.com>
	<200910052143.37985.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200910052143.37985.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2009-10-05 at 21:43 +0200, Rafael J. Wysocki wrote:
> On Monday 05 October 2009, Joe Perches wrote:
> > Added #define pr_fmt(fmt) "PM: " fmt
> > Converted printk(KERN_<level> to pr_<level>(
> > Removed "PM: " prefix
> > Added pr_fmt() to __initdata strings
> 
> Well, can you please tell me what actually is wrong with the current code?

Not much.  There were a couple of trivial corrections,
but perhaps the changes add a bit more flexibility and
regularity.

Effective trivial changes:

o Added KERN_CONT (pr_cont) to a couple of messages
o Added "PM: " (pr_info) to an #ifdef'd message
o Added "PM: " (pr_info) to a printk "Syncing filesystems ..."
  in power/user.c

cheers, Joe
