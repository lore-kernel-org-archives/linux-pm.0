From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/5] introduce .wakeup_event ops
Date: Mon, 24 Aug 2009 20:49:08 +0200
Message-ID: <200908242049.08189.rjw__2179.66530840403$1251140007$gmane$org@sisk.pl>
References: <20090819115210.GC12216@srcf.ucam.org>
	<20090824082722.GA32264@srcf.ucam.org>
	<1251103572.24336.8.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1251103572.24336.8.camel@sli10-desk.sh.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: pm list <linux-pm@lists.linux-foundation.org>, linux acpi <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday 24 August 2009, Shaohua Li wrote:
> On Mon, 2009-08-24 at 16:27 +0800, Matthew Garrett wrote:
> > On Mon, Aug 24, 2009 at 04:21:50PM +0800, Shaohua Li wrote:
> > > On Mon, 2009-08-24 at 16:09 +0800, Matthew Garrett wrote:
> > > > I don't agree - the wakeup GPE will generate a standard notify, and the 
> > > > notification handler has to be at the device or bus layer to handle 
> > > > device-specific requests.
> > > Then we will have duplicate code at each device or bus.
> > 
> > I think that's inevitable, unless the notification infrastructure is 
> > made more fine grained.
> At least we need some check and maybe gpe handling and we need some
> "ifdef ACPI" staff at each device or bus.

Why would we need that?

> There isn't big difference device/bus register a notification handler or
> register a .wakeup_event. And .wakeup_event is more simple in device/bus
> level.

As Matthew said, there is.

To make things clear, we're not going to add .wakeup_event().

Thanks,
Rafael
