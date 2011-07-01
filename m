From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 7/10 v6] PM / Domains: Don't stop wakeup
	devices during system sleep transitions
Date: Fri, 1 Jul 2011 22:06:42 +0200
Message-ID: <201107012206.42475.rjw__47159.5323681415$1309551040$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1107011043410.1988-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1107011043410.1988-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday, July 01, 2011, Alan Stern wrote:
> On Fri, 1 Jul 2011, Rafael J. Wysocki wrote:
> 
> > So the only way forward I can see is to add a special PM domain callback,
> > say .active_wakeup(), that will return "true" if the device is to be left
> > active if wakeup-enabled.  So the check you don't like will become
> > something like:
> > 
> > if (device_may_wakeup(dev) && genpd->active_wakeup
> >     && genpd->active_wakeup(dev))
> >         return 0;
> > 
> > Would that be better?
> 
> Another option, less flexible but perhaps easier to use, would be to 
> set a couple of bitflags indicating whether the device needs power or 
> clocks to handle wakeup signals.

Well, I agree, but I've decided to add the new callback after all.

Thanks,
Rafael
