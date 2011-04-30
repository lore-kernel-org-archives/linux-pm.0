From: Greg KH <gregkh@suse.de>
Subject: Re: [Update][RFC][PATCH 1/2] PM / Runtime: Support for
 generic I/O power domains (v2)
Date: Fri, 29 Apr 2011 18:08:18 -0700
Message-ID: <20110430010818.GA32601__5642.96956076777$1304126053$gmane$org@suse.de>
References: <201104290154.12966.rjw@sisk.pl> <201104290154.56145.rjw@sisk.pl>
	<201104300254.46973.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201104300254.46973.rjw@sisk.pl>
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
Cc: linux-sh@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Apr 30, 2011 at 02:54:46AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Introcude common headers, helper functions and callbacks allowing
> platforms to use simple generic power domains for runtime power
> management.
> 
> Introduce struct generic_power_domain to be used for representing
> power domains that each contain a number of devices and may be
> master domains or subdomains with respect to other power domains.
> Among other things, this structure includes callbacks to be
> provided by platforms for performing specific tasks related to
> power management (i.e. ->stop_device() may disable a device's
> clocks, while ->start_device() may enable them, ->power_on() is
> supposed to remove power from the entire power domain
> and ->power_off() is supposed to restore it).
> 
> Introduce functions that can be used as power domain runtime PM
> callbacks, pm_genpd_runtime_suspend() and pm_genpd_runtime_resume(),
> as well as helper functions for the initialization of a power
> domain represented by a struct generic_power_domain object,
> adding a device to or removing a device from it and adding or
> removing subdomains.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
> ---
> 
> Hi,
> 
> This version of the patch fixes a bug that caused pm_runtime_suspend()
> (and equivalent) to return -EBUSY erroneously when suspending the last
> active device in a power domain.  It has been tested on an ARM shmobile
> system.
> 
> Greg, I hope your ACK is still valid. :-)

Yes, it is.
