From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 9/10] introduce intel_menlow platform
	specific driver
Date: Thu, 24 Jan 2008 16:39:33 -0500
Message-ID: <200801241639.33898.lenb__12209.8443833695$1201210917$gmane$org@kernel.org>
References: <1200556278.2935.118.camel@acpi-sony.sh.intel.com>
	<20080121095331.GA5333@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080121095331.GA5333@infradead.org>
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
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-acpi@vger.kernel.org, sujith.thomas@intel.com, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday 21 January 2008 04:53, Christoph Hellwig wrote:
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
> >  drivers/misc/intel_menlow.c |  527 ++++++++++++++++++++++++++++++++++++++++++++
> 
> Why is this in drivers/misc?  I don't have a thermal.h in mainline, but
> if this is a new subsystem your adding care to create a directory under
> drivers/ for it?

Hi Christoph,

I'm sure it was me who suggested putting intel_menlo.c under drivers/misc.

A while back I refused to let any new platform specific drivers under
drivers/acpi, and asked that the ones here already move out.
This is because they happne to use ACPI, but are not actually
part of the ACPI sub-system (any more than ATA is).
Also, I wanted the maintainer roles to be clear -- these
drivers have primary maintainers other than me, and those
guys are in the heroic, but tragic, business of writing
platform-specific drivers for systems with no documentation or vendor support.

drivers/misc/asus-laptop.c
drivers/misc/fujitsu-laptop.c
drivers/misc/msi-laptop.c
drivers/misc/sony-laptop.c
drivers/misc/thinkpad_acpi.c
drivers/misc/sony-laptop.c

intel_menlo.c fits in with this group, the only difference is that
its primary maintainers actually have documentation:-)

is there a better place than drivers/misc for this group?

thanks,
-Len
