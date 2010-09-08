From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/2] PM: Compress hibernation image with LZO
Date: Thu, 9 Sep 2010 01:45:25 +0200
Message-ID: <201009090145.25489.rjw@sisk.pl>
References: <1281407348.2618.52.camel@shrek.rexursive.com>
	<1282516434.23359.0.camel@shrek.rexursive.com>
	<1282520861.23359.1.camel@shrek.rexursive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1282520861.23359.1.camel@shrek.rexursive.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Bojan Smojver <bojan@rexursive.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday, August 23, 2010, Bojan Smojver wrote:
> On Mon, 2010-08-23 at 08:33 +1000, Bojan Smojver wrote:
> > Good point. Will change.
> 
> Here you go:
> 
>  Documentation/power/swsusp.txt |    3 +-
>  kernel/power/Kconfig           |    2 +
>  kernel/power/hibernate.c       |   10 ++
>  kernel/power/power.h           |    1 +
>  kernel/power/swap.c            |  289 +++++++++++++++++++++++++++++++++++++++-
>  5 files changed, 297 insertions(+), 8 deletions(-)

OK

I applied this patch to suspend-2.6/linux-next
(http://git.kernel.org/?p=linux/kernel/git/rafael/suspend-2.6.git;a=shortlog;h=refs/heads/linux-next)
but with some modifications, so please double check.

Thanks,
Rafael
