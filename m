From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] 3c59x: Get rid of "Trying to free
	already-free IRQ"
Date: Fri, 25 Sep 2009 14:35:24 +0200
Message-ID: <200909251435.24942.rjw__23458.6748564199$1253882301$gmane$org@sisk.pl>
References: <20090924183152.GA30254@oksana.dev.rtsoft.ru>
	<20090924213039.GA15904@oksana.dev.rtsoft.ru>
	<20090924.152619.260814858.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090924.152619.260814858.davem@davemloft.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-pm@lists.linux-foundation.org, avorontsov@ru.mvista.com
List-Id: linux-pm@vger.kernel.org

On Friday 25 September 2009, David Miller wrote:
> From: Anton Vorontsov <avorontsov@ru.mvista.com>
> Date: Fri, 25 Sep 2009 01:30:39 +0400
> 
> > On Thu, Sep 24, 2009 at 10:30:33PM +0200, Rafael J. Wysocki wrote:
> >> On Thursday 24 September 2009, Anton Vorontsov wrote:
> >> > Following trace pops up if we try to suspend with 3c59x ethernet NIC
> >> > brought down:
> >> 
> >> Patch looks good, but IMO it'd be a little effort to convert the driver to
> >> dev_pm_ops while you're at it (please see r8169 for a working example).
> > 
> > I'd like to avoid putting irrelevant stuff into bugfixes.
> 
> Agreed.

Well, the point is that all of the PCI core stuff the driver does is not
necessary and should better be dropped along with the IRQ thing.

Best,
Rafael
