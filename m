From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC][PATCH] PM / Platform: Remove __weak
 definitions of runtime PM callbacks
Date: Wed, 6 Apr 2011 22:48:06 -0700
Message-ID: <20110407054806.GC6427__17755.0655477264$1302155334$gmane$org@angua.secretlab.ca>
References: <201103270058.41632.rjw@sisk.pl> <87zko3dn4b.fsf@ti.com>
	<201104070729.45484.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201104070729.45484.rjw@sisk.pl>
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
Cc: linux-sh@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 07, 2011 at 07:29:45AM +0200, Rafael J. Wysocki wrote:
> On Thursday, April 07, 2011, Kevin Hilman wrote:
> > Hi Rafael, Magnus,
> > 
> > "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> > 
> > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > >
> > > Remove the __weak definitions of platform bus type runtime PM
> > > callbacks, make platform_dev_pm_ops point to the generic routines
> > > as appropriate and allow architectures using platform_dev_pm_ops to
> > > replace the runtime PM callbacks in that structure with their own
> > > set.
> > >
> > > Convert architectures providing its own definitions of the platform
> > > runtime PM callbacks to use the new mechanism.
> > >
> > > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > I dont't think we should be adding yet another new interface for setting
> > platform-specific runtime PM ops.
> > 
> > We now have 3.  Two existing ones:
> > 
> > 1) new device power domains (presumably preferred)
> > 2) platform_bus_set_pm_ops() (disliked by many)
> 
> Hmm, I wasn't aware of that one, will have a look.
> 
> > and now the new one you create here
> > 
> > 3) platform_set_runtime_pm_ops()
> > 
> > This new one is basically the same as platform_bus_set_pm_ops(), but
> > targetted only at runtime PM ops, and also has all the same problems
> > that have been discussed before.  Namely, it overrides the pm ops for
> > *every* device on the platform_bus, instead of targetting only specific
> > devices.
> 
> This is not a problem for this particular use case.  We really want to
> replace the PM ops for all of the platform devices on that platform.

I strongly doubt that you really want to do that.  platform_devices
can appear anywhere in the system, and many of them will end up being
entirely outside the SoC, and hence outside of any SoC specific
behaviour.  What is the use case for overriding every
platform_device's PM ops?

g.
