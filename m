From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] 3c59x: Get rid of "Trying to free
	already-free IRQ"
Date: Fri, 25 Sep 2009 01:30:39 +0400
Message-ID: <20090924213039.GA15904__43562.204068485$1253827913$gmane$org@oksana.dev.rtsoft.ru>
References: <20090924183152.GA30254@oksana.dev.rtsoft.ru>
	<200909242230.33881.rjw@sisk.pl>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200909242230.33881.rjw@sisk.pl>
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
Cc: netdev@vger.kernel.org, linux-pm@lists.linux-foundation.org, David Miller <davem@davemloft.net>
List-Id: linux-pm@vger.kernel.org

On Thu, Sep 24, 2009 at 10:30:33PM +0200, Rafael J. Wysocki wrote:
> On Thursday 24 September 2009, Anton Vorontsov wrote:
> > Following trace pops up if we try to suspend with 3c59x ethernet NIC
> > brought down:
> 
> Patch looks good, but IMO it'd be a little effort to convert the driver to
> dev_pm_ops while you're at it (please see r8169 for a working example).

I'd like to avoid putting irrelevant stuff into bugfixes.

Apart from delights as bisecting and revert-only-offending-piece,
keeping bugfixes small and self-sufficient helps to back-port the
fixes to stable/distro kernels. Think of not so old kernels that
don't have dev_pm_ops.

Converting this driver (and others that I'm interested in) to
dev_pm_ops is on my todo list though.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
