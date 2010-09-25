From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC 1/7] sysfs: add sysfs_merge_group and
	sysfs_unmerge_group
Date: Sat, 25 Sep 2010 23:43:18 +0200
Message-ID: <201009252343.19073.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1009231712410.1667-100000@iolanthe.rowland.org>
	<201009242205.03382.rjw@sisk.pl> <20100924202018.GA19024@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100924202018.GA19024@kroah.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Greg KH <greg@kroah.com>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday, September 24, 2010, Greg KH wrote:
> On Fri, Sep 24, 2010 at 10:05:03PM +0200, Rafael J. Wysocki wrote:
> > On Friday, September 24, 2010, Greg KH wrote:
> > > On Thu, Sep 23, 2010 at 05:23:08PM -0400, Alan Stern wrote:
> > > > This patch (as1420) adds sysfs_merge_group() and sysfs_unmerge_group()
> > > > functions, allowing drivers easily to add and remove sets of
> > > > attributes to a pre-existing attribute group directory.
> > > > 
> > > > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > > 
> > > Looks good to me:
> > > 	Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
> > > 
> > > Rafael, this will go through your tree, right?
> > 
> > Yes, it will, if that's fine with you.
> 
> Fine with me, merge away :)

Thanks, I appled this patch to suspend-2.6/linux-next.

Rafael
