From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 5/9] PM: suspend_block: Add debugfs file
Date: Sun, 25 Apr 2010 11:15:17 -0700
Message-ID: <20100425181517.GA22676__25563.7291273617$1272219336$gmane$org@kroah.com>
References: <1271984938-13920-1-git-send-email-arve@android.com>
	<1271984938-13920-2-git-send-email-arve@android.com>
	<1271984938-13920-3-git-send-email-arve@android.com>
	<1271984938-13920-4-git-send-email-arve@android.com>
	<1271984938-13920-5-git-send-email-arve@android.com>
	<1271984938-13920-6-git-send-email-arve@android.com>
	<20100423135853.478af057.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100423135853.478af057.randy.dunlap@oracle.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, Apr 23, 2010 at 01:58:53PM -0700, Randy Dunlap wrote:
> On Thu, 22 Apr 2010 18:08:54 -0700 Arve Hj?nnev?g wrote:
> 
> > Report active and inactive suspend blockers in
> > /sys/kernel/debug/suspend_blockers.
> 
> 
> This looks more like user interface information than it does debug information.
> If that's correct, it shouldn't be in debugfs.

It's debug-like information, and has more than one value per file, so
debugfs seems like the proper place for it.  I have no objection to it
going there.

thanks,

greg k-h
