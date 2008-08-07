From: Ben Collins <ben.collins@canonical.com>
Subject: Re: [PATCH 6/7] pm: Config option to disable handling of
 console during suspend/resume
Date: Thu, 07 Aug 2008 17:23:18 -0400
Message-ID: <1218144198.10040.196.camel__32508.8379242972$1218145120$gmane$org@cunning>
References: <24762.90.138.930.038.1036103001.ben.collins@canonical.com>
	<E1KKl4J-00068V-6f@swissweb.swissdisk.com>
	<20080729033309.GB12085@kroah.com> <200807292315.36511.rjw@sisk.pl>
	<1217368310.6066.56.camel@cunning> <20080730044716.GA2954@kroah.com>
	<1217427607.5976.104.camel@cunning>
	<20080804062823.GA22015@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080804062823.GA22015@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@suse.cz>
Cc: pm list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2008-08-04 at 08:28 +0200, Pavel Machek wrote:
> Hi!
> 
> > > > diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> > > > index e7bea3e..6a042f8 100644
> > > > --- a/Documentation/kernel-parameters.txt
> > > > +++ b/Documentation/kernel-parameters.txt
> > > > @@ -2247,6 +2247,11 @@ and is between 256 and 4096 characters. It is defined in the file
> > > >  	vmpoff=		[KNL,S390] Perform z/VM CP command after power off.
> > > >  			Format: <command>
> > > >  
> > > > +	vt_switch=	[PM] Switch vt's during suspend/resume
> > > > +			Format: { 0 | 1 }
> > > > +			Default is normally '1', but depends on value of
> > > > +			the PM_DISABLE_CONSOLE config option.
> > > > +
> > > 
> > > Why a build time config option?  Why not just set the command line
> > > option if you need this?  And/or make it a sysctrl?
> > > 
> > > That way we don't have to add yet-another-config-option for distros and
> > > users to get wrong.
> > > 
> > > thanks,
> > 
> > Sysctl makes sense. I would rather not have to add a cmdline option to
> > default installs (and on upgrades). I'll redo the patch that way and
> > resend.
> 
> Maybe have acpi_sleep=no_vt_switch? THat is already settable from
> userspace...?

Where is this setting?
									Pavel
