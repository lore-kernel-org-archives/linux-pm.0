From: Greg KH <greg@kroah.com>
Subject: Re: [RFC 1/7] sysfs: add sysfs_merge_group and
	sysfs_unmerge_group
Date: Fri, 24 Sep 2010 13:20:18 -0700
Message-ID: <20100924202018.GA19024@kroah.com>
References: <Pine.LNX.4.44L0.1009231712410.1667-100000@iolanthe.rowland.org>
	<20100923230540.GA28714@kroah.com> <201009242205.03382.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201009242205.03382.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Sep 24, 2010 at 10:05:03PM +0200, Rafael J. Wysocki wrote:
> On Friday, September 24, 2010, Greg KH wrote:
> > On Thu, Sep 23, 2010 at 05:23:08PM -0400, Alan Stern wrote:
> > > This patch (as1420) adds sysfs_merge_group() and sysfs_unmerge_group()
> > > functions, allowing drivers easily to add and remove sets of
> > > attributes to a pre-existing attribute group directory.
> > > 
> > > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > 
> > Looks good to me:
> > 	Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
> > 
> > Rafael, this will go through your tree, right?
> 
> Yes, it will, if that's fine with you.

Fine with me, merge away :)

thanks,

greg k-h
