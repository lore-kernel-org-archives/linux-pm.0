From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] PM / Wakeup: Fix initialization of
 wakeup-related device sysfs files
Date: Mon, 25 Apr 2011 13:33:39 -0700
Message-ID: <20110425203339.GA21375__4966.63368908248$1303765282$gmane$org@suse.de>
References: <201104212357.43052.rjw@sisk.pl> <20110425195811.GA3407@mac.home>
	<201104252210.16719.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201104252210.16719.rjw@sisk.pl>
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
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Tino Keitel <tino.keitel@tikei.de>
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 25, 2011 at 10:10:16PM +0200, Rafael J. Wysocki wrote:
> On Monday, April 25, 2011, Tino Keitel wrote:
> > Hi,
> > 
> > the patch works fine on top of current git
> > (8f7544682c488dfc4117b37ed10435bb2d3d8d73). Wakeup using the keyboard
> > works.
> 
> Great, thanks for testing.
> 
> Greg, are you fine with https://lkml.org/lkml/2011/4/21/404 ?

Yes, very much so, sorry for not giving my ack before:
	Acked-by: Greg Kroah-Hartman <gregkh@suse.de>


thanks,

greg k-h
