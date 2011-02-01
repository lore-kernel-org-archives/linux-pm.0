From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] Power domains for platform bus type
Date: Tue, 1 Feb 2011 19:39:49 +0100
Message-ID: <201102011939.49793.rjw__27068.1916772903$1296585826$gmane$org@sisk.pl>
References: <201101300107.19389.rjw@sisk.pl> <201102011158.46312.rjw@sisk.pl>
	<87sjw7wvjl.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87sjw7wvjl.fsf@ti.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, February 01, 2011, Kevin Hilman wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> [...]
> 
> > Also, I'm going to move the power domain hook to the struct device level, so
> > that we have:
> >
> > struct device {
> >     ...
> >     struct power_domain *domain;
> >     ...
> > };
> >
> > struct power_domain {
> >     struct dev_pm_ops ops;
> > };
> >
> 
> Great, thanks.
> 
> Any opinion on my idea to name this 'struct dev_power_domain' to avoid
> confusion with existing powerdomain structs in SoC code?  For example,
> on OMAP we already have a 'struct powerdomain'.

Fine by me.

Thanks,
Rafael
