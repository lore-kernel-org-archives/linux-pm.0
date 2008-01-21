From: "Thomas, Sujith" <sujith.thomas@intel.com>
Subject: RE: [PATCH 9/10] introduce intel_menlow platform
	specific driver
Date: Mon, 21 Jan 2008 19:49:55 +0530
Message-ID: <05B550FD4BD2014E841D83547B6260080281AE80__25518.139152746$1200930711$gmane$org@bgsmsx411.gar.corp.intel.com>
References: <1200556278.2935.118.camel@acpi-sony.sh.intel.com>
	<20080121095331.GA5333@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <20080121095331.GA5333@infradead.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@infradead.org>, "Zhang, Rui" <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



> -----Original Message-----
> From: Christoph Hellwig [mailto:hch@infradead.org]
> Sent: Monday, January 21, 2008 3:24 PM
> To: Zhang, Rui
> Cc: lenb@kernel.org; linux-acpi@vger.kernel.org; linux-pm@lists.linux-
> foundation.org; linux-kernel@vger.kernel.org; Thomas, Sujith
> Subject: Re: [PATCH 9/10] introduce intel_menlow platform specific
driver
> 
> On Thu, Jan 17, 2008 at 03:51:17PM +0800, Zhang Rui wrote:
> > From: Thomas Sujith <sujith.thomas@intel.com>
> >
> > Intel menlow platform specific driver for thermal management.
> >
> > Signed-off-by: Thomas Sujith <sujith.thomas@intel.com>
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  drivers/misc/Kconfig        |   10
> >  drivers/misc/Makefile       |    1
> >  drivers/misc/intel_menlow.c |  527
> ++++++++++++++++++++++++++++++++++++++++++++
> 
> Why is this in drivers/misc?  I don't have a thermal.h in mainline,
but
> if this is a new subsystem your adding care to create a directory
under
> drivers/ for it?
This patch series adds a new "thermal" subsystem and is rightly placed
under drivers/thermal/ . intel_menlow.c isn't fully a thermal driver. It
does all the platform specific stuff (thermal is one of them). It's not
fitting under any of the subsystems hence moved to drivers/misc
> 
> > +/*
> > +*  intel_menlow.c - Intel menlow Driver for thermal management
> extension
> > +*
> > +*  Copyright (C) 2008 Intel Corp
> > +*  Copyright (C) 2008 Sujith Thomas <sujith.thomas@intel.com>
> > +*  Copyright (C) 2008 Zhang Rui <rui.zhang@intel.com>
> 
> Please add a whitespace before the * so they line up.
Will take care of this.
> 
> > +MODULE_AUTHOR("Thomas Sujith");
> > +MODULE_AUTHOR("Zhang Rui");
> 
> I've never seen a driver with two MODULE_AUTHOR statements before.
Does
> this actually work?  What does modinfo -F author say for your module?
There is nothing wrong in giving 2 MODULE_AUTHORS. Both will be
displayed in the command modinfo -F author.

:-Sujith
