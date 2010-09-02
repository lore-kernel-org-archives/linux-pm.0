From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: Prevent waiting forever on asynchronous
 resume after abort
Date: Thu, 2 Sep 2010 16:27:31 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1009021626110.1311-100000__29513.1248575219$1283459351$gmane$org@iolanthe.rowland.org>
References: <201009022146.03359.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201009022146.03359.rjw@sisk.pl>
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
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, Colin Cross <ccross@android.com>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 2 Sep 2010, Rafael J. Wysocki wrote:

> On Thursday, September 02, 2010, Alan Stern wrote:
> > On Wed, 1 Sep 2010, Colin Cross wrote:
> > 
> > > Only wait on a parent device during resume if the parent device is
> > > suspended.

> > I think it would be better to change device_pm_init() and add a 
> > complete_all().
> 
> I agree.
> 
> Who's writing the patch?

I was hoping that Colin would.  But I can do it if he doesn't want to.

Alan Stern
