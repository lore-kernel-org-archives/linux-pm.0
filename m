From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 7/10 v6] PM / Domains: Don't stop wakeup
 devices during system sleep transitions
Date: Fri, 1 Jul 2011 10:45:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1107011043410.1988-100000__7187.71029864929$1309531707$gmane$org@iolanthe.rowland.org>
References: <201107010125.25875.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201107010125.25875.rjw@sisk.pl>
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
Cc: linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 1 Jul 2011, Rafael J. Wysocki wrote:

> So the only way forward I can see is to add a special PM domain callback,
> say .active_wakeup(), that will return "true" if the device is to be left
> active if wakeup-enabled.  So the check you don't like will become
> something like:
> 
> if (device_may_wakeup(dev) && genpd->active_wakeup
>     && genpd->active_wakeup(dev))
>         return 0;
> 
> Would that be better?

Another option, less flexible but perhaps easier to use, would be to 
set a couple of bitflags indicating whether the device needs power or 
clocks to handle wakeup signals.

Alan Stern
