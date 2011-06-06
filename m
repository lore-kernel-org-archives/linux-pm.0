From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/5] PM / Runtime: Support for generic I/O
	power domains (v4)
Date: Mon, 6 Jun 2011 20:48:31 +0200
Message-ID: <201106062048.31663.rjw__13354.2023286738$1307388644$gmane$org@sisk.pl>
References: <201104290154.12966.rjw@sisk.pl> <201105280117.17883.rjw@sisk.pl>
	<Pine.LNX.4.64.1106020920360.4067@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.1106020920360.4067@axis700.grange>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, June 02, 2011, Guennadi Liakhovetski wrote:
> On Sat, 28 May 2011, Rafael J. Wysocki wrote:
> 
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Introduce common headers, helper functions and callbacks allowing
> > platforms to use simple generic power domains for runtime power
> > management.
> > 
> > Introduce struct generic_power_domain to be used for representing
> > power domains that each contain a number of devices and may be
> > master domains or subdomains with respect to other power domains.
> > Among other things, this structure includes callbacks to be
> > provided by platforms for performing specific tasks related to
> > power management (i.e. ->stop_device() may disable a device's
> > clocks, while ->start_device() may enable them, ->power_off() is
> > supposed to remove power from the entire power domain
> > and ->power_on() is supposed to restore it).
> 
> I've got a generic question to this: do we have any examples of 
> power-domain specific ->start_device() and ->stop_device() callbacks? A 
> common case is, when these callbacks start and stop clocks, associated 
> with the device, but this is not power-domain specific, right? Do we have 
> any examples of different power domains in a system, having different 
> these calbacks, but all devices in one power-domain, having the same ones?

No, we don't have any at the moment.

Thanks,
Rafael
