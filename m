From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] PM: Introduce new top level suspend and
	hibernation callbacks (rev. 6)
Date: Tue, 1 Apr 2008 22:23:05 +0200
Message-ID: <200804012223.07275.rjw__7884.86332535303$1207081589$gmane$org@sisk.pl>
References: <200803292317.50218.rjw@sisk.pl> <200803312329.03455.rjw@sisk.pl>
	<20080401083753.GA24983@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080401083753.GA24983@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 1 of April 2008, Pavel Machek wrote:
> > On Sunday, 30 of March 2008, Rafael J. Wysocki wrote:
> > > On Saturday, 29 of March 2008, Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > > > 
> > > > Introduce 'struct pm_ops' and 'struct pm_ext_ops' representing
> > > > suspend and hibernation operations for bus types, device classes and
> > > > device types.
> > > > 
> > > > Modify the PM core to use 'struct pm_ops' and 'struct pm_ext_ops'
> > > > objects, if defined, instead of the ->suspend() and ->resume() or,
> > > > respectively, ->suspend_late() and ->resume_early() callbacks that
> > > > will be considered as legacy and gradually phased out.
> > > 
> > > Unfortunately I forgot to set dev->power.status to DPM_PREPARING before
> > > calling ->prepare(), as documented.  Also, dpm_prepare() could cleaned up
> > > a bit.
> > > 
> > > Fixed patch follows.
> > 
> > My testing shows that some drivers tend to return error codes from their
> > ->resume() callbacks, even though the devices in question appear to work
> > correctly after the seemingly failing suspend.
> 
> The drivers should be fixed not to do that, no?

The problem is we generally don't know which drivers do that.  I know a few,
but there probably are others.

So, the idea is to allow them to do that for some time, but log error messages
indicating which drivers they are.  These messages will then allow us to fix
the drivers and once they've been fixed, we can apply a (very simple) patch to
change the behavior of the core (this patch will be easy to revert if need be,
whereas I really wouldn't like to be forced to revert the $subject patch by
predictable regressions).

Thanks,
Rafael
