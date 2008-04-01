From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH] PM: Introduce new top level suspend and
	hibernation callbacks (rev. 6)
Date: Tue, 1 Apr 2008 10:37:53 +0200
Message-ID: <20080401083753.GA24983__36682.4061297395$1207039175$gmane$org@atrey.karlin.mff.cuni.cz>
References: <200803292317.50218.rjw@sisk.pl> <200803292320.38378.rjw@sisk.pl>
	<200803300454.26318.rjw@sisk.pl> <200803312329.03455.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200803312329.03455.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

> On Sunday, 30 of March 2008, Rafael J. Wysocki wrote:
> > On Saturday, 29 of March 2008, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > > 
> > > Introduce 'struct pm_ops' and 'struct pm_ext_ops' representing
> > > suspend and hibernation operations for bus types, device classes and
> > > device types.
> > > 
> > > Modify the PM core to use 'struct pm_ops' and 'struct pm_ext_ops'
> > > objects, if defined, instead of the ->suspend() and ->resume() or,
> > > respectively, ->suspend_late() and ->resume_early() callbacks that
> > > will be considered as legacy and gradually phased out.
> > 
> > Unfortunately I forgot to set dev->power.status to DPM_PREPARING before
> > calling ->prepare(), as documented.  Also, dpm_prepare() could cleaned up
> > a bit.
> > 
> > Fixed patch follows.
> 
> My testing shows that some drivers tend to return error codes from their
> ->resume() callbacks, even though the devices in question appear to work
> correctly after the seemingly failing suspend.

The drivers should be fixed not to do that, no?

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
