From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Xen-devel] [PATCH] PM / Hibernate: Introduce
	CONFIG_HIBERNATE_INTERFACE
Date: Tue, 29 Mar 2011 21:39:35 +0200
Message-ID: <201103292139.35645.rjw__40633.0665493899$1301427624$gmane$org@sisk.pl>
References: <201103261229.44770.rjw@sisk.pl>
	<1301414013.18413.29.camel@zakaz.uk.xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1301414013.18413.29.camel@zakaz.uk.xensource.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ian Campbell <Ian.Campbell@citrix.com>
Cc: Shriram Rajagopalan <rshriram@cs.ubc.ca>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, March 29, 2011, Ian Campbell wrote:
> Hi Rafael,
> 
> On Sat, 2011-03-26 at 11:29 +0000, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Xen save/restore is going to use hibernate device callbacks for
> > quiescing devices and putting them back to normal operations and it
> > would need to select CONFIG_HIBERNATION for this purpose.  However,
> > that also would cause the hibernate interfaces for user space to be
> > enabled, which might confuse user space, because the Xen kernels
> > don't support hibernation.  Moreover, it would be wasteful, as it
> > would make the Xen kernels include a substantial amount of code that
> > they would never use.
> > 
> > To address this issue introduce new power management Kconfig option
> > CONFIG_HIBERNATE_INTERFACE, such that the hibernate interfaces for
> > user space and the image-handling code will depend on it and it will
> > select CONFIG_HIBERNATION.  Then, Xen save/restore will be able to
> > select CONFIG_HIBERNATION without dragging the entire hibernate code
> > along with it.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Were you planning to put this forward for 2.6.39 or are you waiting for
> 2.6.40?

I'm goint to push it for 2.6.39.  In fact, I'm going to send the pull request
shortly.

Thanks,
Rafael
