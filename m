From: Kevin Hilman <khilman@ti.com>
Subject: Re: [Update][PATCH 7/8] PM / Domains: System-wide
	transitions support for generic domains (v3)
Date: Wed, 22 Jun 2011 14:50:51 -0700
Message-ID: <8739j1lemc.fsf__47689.2856335782$1308779507$gmane$org@ti.com>
References: <201106112223.04972.rjw@sisk.pl> <201106112239.16285.rjw@sisk.pl>
	<201106200006.07642.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201106200006.07642.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Mon, 20 Jun 2011 00:06:07 +0200")
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

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> Make generic PM domains support system-wide power transitions
> (system suspend and hibernation).  Add suspend, resume, freeze, thaw,
> poweroff and restore callbacks to be associated with struct
> generic_pm_domain objects and make pm_genpd_init() use them as
> appropriate.
>
> The new callbacks do nothing for devices belonging to power domains
> that were powered down at run time (before the transition).  

Great, this is the approach I prefer too, but...

Now I'm confused.  Leaving runtime suspended devices alone is what I was
doing in my subsystem but was told not to.  According to

    http://www.mail-archive.com/linux-omap@vger.kernel.org/msg50690.html

"it's generally agreed that _all_ devices should return to full 
power during system resume -- even if they were runtime suspended 
before the system sleep."

Kevin
