From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM / Wakeup: Fix initialization of
	wakeup-related device sysfs files
Date: Mon, 25 Apr 2011 22:10:16 +0200
Message-ID: <201104252210.16719.rjw__352.186177815561$1303762325$gmane$org@sisk.pl>
References: <201104212357.43052.rjw@sisk.pl> <20110425195811.GA3407@mac.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110425195811.GA3407@mac.home>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tino Keitel <tino.keitel@tikei.de>, Greg Kroah-Hartman <gregkh@suse.de>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday, April 25, 2011, Tino Keitel wrote:
> Hi,
> 
> the patch works fine on top of current git
> (8f7544682c488dfc4117b37ed10435bb2d3d8d73). Wakeup using the keyboard
> works.

Great, thanks for testing.

Greg, are you fine with https://lkml.org/lkml/2011/4/21/404 ?

Rafael
