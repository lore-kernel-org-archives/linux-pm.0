From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 15/21] kernel/power/: use pr_<level> and add
	pr_fmt(fmt)
Date: Sat, 10 Oct 2009 18:49:35 -0700
Message-ID: <1255225776.16347.352.camel@Joe-Laptop.home>
References: <cover.1254701151.git.joe@perches.com>
	<200910060037.57546.rjw@sisk.pl>
	<1255060436.16347.36.camel@Joe-Laptop.home>
	<200910102328.37108.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200910102328.37108.rjw@sisk.pl>
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

On Sat, 2009-10-10 at 23:28 +0200, Rafael J. Wysocki wrote:
> On Friday 09 October 2009, Joe Perches wrote:
> > Added #define pr_fmt(fmt) "PM: " fmt
> > Converted printk(KERN_<level> to pr_<level>(
> > Converted printks without KERN_ to pr_info or pr_cont
> > Removed hard coded "PM: " prefix from message strings
> > Added pr_fmt() to __initdata strings
> > Integrated multiple line strings
> > All logging messages are now output prefixed with "PM: "
> Does this patch depend on any other patch that haven't been merged yet?

No.  I think it's OK to merge.

The idea is to eventually have smaller objects without
prefixes, just a single stored prefix string that printk
would insert and a bit more consistent output.

cheers,  Joe
