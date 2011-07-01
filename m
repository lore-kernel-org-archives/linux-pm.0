From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: runtime PM usage_count during driver_probe_device()?
Date: Fri, 1 Jul 2011 22:53:19 +0200
Message-ID: <201107012253.19988.rjw__36989.5475022078$1309553603$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1107011123590.1988-100000@iolanthe.rowland.org>
	<87pqlu3sy3.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87pqlu3sy3.fsf@ti.com>
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

Hi,

On Friday, July 01, 2011, Kevin Hilman wrote:
> Alan Stern <stern@rowland.harvard.edu> writes:
> 
> > On Fri, 1 Jul 2011, Kevin Hilman wrote:
> >
> >> OK, so the ->probe() part has been explained and makes sense, but I
> >> would expect ->remove() to be similarily protected (as the documentation
> >> states.)  But that is not the case.  Is that a bug?  If so, patch below
> >> makes the code match the documentation.
> >
> > I suspect it is a bug, but it's hard to be sure.  It's so _blatantly_ 
> > wrong that it looks like it was done deliberately.
> 
> heh

I seem to remeber having a problem with the pm_runtime_put_sync() after
drv->remove(dev) ...

So the code in question was introduced by

commit e1866b33b1e89f077b7132daae3dfd9a594e9a1a
Author: Rafael J. Wysocki <rjw@sisk.pl>
Date:   Fri Apr 29 00:33:45 2011 +0200

    PM / Runtime: Rework runtime PM handling during driver removal

with a long changelog explaining the reason why.  Which seems to make sense. ;-)

So I'm not sure.

Thanks,
Rafael
