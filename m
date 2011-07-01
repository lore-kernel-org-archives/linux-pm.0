From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: runtime PM usage_count during driver_probe_device()?
Date: Fri, 1 Jul 2011 10:43:34 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1107011040570.1988-100000__33339.1079017476$1309531550$gmane$org@iolanthe.rowland.org>
References: <87k4c3dktm.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87k4c3dktm.fsf@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-pm@lists.linux-foundation.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 30 Jun 2011, Kevin Hilman wrote:

> Another curiosity is that, contrary to the above documentation, there is
> no usage_count increment before the bus/driver ->remove() (although
> there is a _get_sync/_put_sync around the sysfs_remove and notifier just
> before the bus/driver->remove().

I hadn't noticed that.  There may be a reason for using get_sync 
instead of get_noresume, but it isn't explained anywhere.  And it 
certainly looks like a mistake for the put_sync to occur before the 
->remove() call instead of after.

This needs to be fixed.

Alan Stern
