From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.25-rc2-git] crosslink ACPI and "real"
	device nodes
Date: Mon, 25 Feb 2008 23:17:43 -0800
Message-ID: <200802252317.43717.david-b__8970.82867236367$1204010463$gmane$org@pacbell.net>
References: <200802222154.25204.david-b@pacbell.net>
	<200802252245.43282.david-b@pacbell.net>
	<1203977422.10256.91.camel@acpi-hp-zz.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1203977422.10256.91.camel@acpi-hp-zz.sh.intel.com>
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
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday 25 February 2008, Zhang, Rui wrote:
> 
> On Tue, 2008-02-26 at 14:45 +0800, David Brownell wrote:
> > On Monday 25 February 2008, Zhang, Rui wrote:
> > > > +       if (!ACPI_FAILURE(status)) {
> > > > +               int ret;
> > > > +
> > > > +               ret = sysfs_create_link(&dev->kobj, &acpi_dev->dev.kobj,
> > > > +                               "firmware_node");
> > > > +               ret = sysfs_create_link(&acpi_dev->dev.kobj, &dev->kobj,
> > > > +                               "physical_node");
> > > > +       }
> > >
> > > ret is not needed here...
> > 
> > But what compiler warnings do you see when you omit it?  :)
>
> I tried but NO warnings at all

Really???  In <linux/sysfs.h> I found:

int __must_check sysfs_create_link(struct kobject *kobj, struct kobject *target,
                                   const char *name);

Perhaps you disabled those warnings.  (And FWIW, I don't see any
reasonable way to handle such faults, so ignoring them is thus
the right "solution".)
