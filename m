From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: Re: [patch 2.6.25-rc2-git] crosslink ACPI and "real"
	device nodes
Date: Tue, 26 Feb 2008 06:10:22 +0800
Message-ID: <1203977422.10256.91.camel__19018.6967178763$1204009211$gmane$org@acpi-hp-zz.sh.intel.com>
References: <200802222154.25204.david-b@pacbell.net>
	<1203976028.10256.87.camel@acpi-hp-zz.sh.intel.com>
	<200802252245.43282.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200802252245.43282.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


On Tue, 2008-02-26 at 14:45 +0800, David Brownell wrote:
> On Monday 25 February 2008, Zhang, Rui wrote:
> > > +       if (!ACPI_FAILURE(status)) {
> > > +               int ret;
> > > +
> > > +               ret = sysfs_create_link(&dev->kobj,
> &acpi_dev->dev.kobj,
> > > +                               "firmware_node");
> > > +               ret = sysfs_create_link(&acpi_dev->dev.kobj,
> &dev->kobj,
> > > +                               "physical_node");
> > > +       }
> >
> > ret is not needed here...
> 
> But what compiler warnings do you see when you omit it?  :)
I tried but NO warnings at all

thanks,
rui
