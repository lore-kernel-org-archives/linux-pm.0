From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [patch] hibernation: utilize ACPI hardware signature
Date: Fri, 11 Jan 2008 09:07:12 +0800
Message-ID: <1200013632.21533.1.camel__18378.7264083096$1200015274$gmane$org@sli10-desk.sh.intel.com>
References: <1199257162.14632.4.camel@sli10-desk.sh.intel.com>
	<200801042144.20279.rjw@sisk.pl>
	<1199670409.13339.2.camel@sli10-desk.sh.intel.com>
	<200801110039.40523.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801110039.40523.rjw@sisk.pl>
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
Cc: linux acpi <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Pavel Machek <pavel@suse.cz>
List-Id: linux-pm@vger.kernel.org


On Fri, 2008-01-11 at 07:39 +0800, Rafael J. Wysocki wrote:
> On Monday, 7 of January 2008, Shaohua Li wrote:
> >
> > On Sat, 2008-01-05 at 04:44 +0800, Rafael J. Wysocki wrote:
> > > On Friday, 4 of January 2008, Shaohua Li wrote:
> > > >
> > > > On Fri, 2008-01-04 at 01:04 +0800, Rafael J. Wysocki wrote:
> > > > > On Thursday, 3 of January 2008, Shaohua Li wrote:
> > > > > >
> > > > > > On Wed, 2008-01-02 at 22:05 +0800, Rafael J. Wysocki wrote:
> > > > > > > On Wednesday, 2 of January 2008, Shaohua Li wrote:
> > > > > > > > ACPI defines a hardware signature. BIOS calculates the
> > > signature
> > > > > > > > according to hardware configure, if hardware changes,
> the
> > > > > signature
> > > > > > > will
> > > > > > > > change, in this case, S4 resume should fail.
> > > > > > >
> > > > > > > The idea is fine, but I'd prefer to do that in a more
> > > > > straightforward
> > > > > > > way.
> > > > > > > Namely, we can just:
> > > > > > > * write the signature into a variable in, for example,
> > > > > > >   acpi_hibernation_prepare() (then, the "old" signature
> value
> > > will
> > > > > be
> > > > > > >   automatically saved in the image)
> > > > > > > * compare it with a the "new" value read from the BIOS in
> > > > > > >   acpi_hibernation_leave() and panic if there's a mismatch
> > > > > > > * add a configuration option to disable this behavior
> (just in
> > > > > case)
> > > > > > > This way we can avoid modifying the entire generic
> interface
> > > to
> > > > > add
> > > > > > > the feature
> > > > > > > specific to ACPI.
> > > > > > it would be better we do the check in boot kernel.
> > > > > Franky, I think we should also check in the image kernel, in
> case
> > > the
> > > > > boot
> > > > > one doesn't support ACPI as I said.
> > > > Ok, makes sense. I changed to check the signature
> > > in .higberation_leave
> > >
> > > Thanks, comments below.
> > >
> > > > Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> > > > ---
> > > >  drivers/acpi/sleep/main.c |   20 ++++++++++++++++++++
> > > >  1 file changed, 20 insertions(+)
> > > >
> > > > Index: linux/drivers/acpi/sleep/main.c
> > > >
> ===================================================================
> > > > --- linux.orig/drivers/acpi/sleep/main.c      2008-01-03
> > > 13:37:08.000000000 +0800
> > > > +++ linux/drivers/acpi/sleep/main.c   2008-01-04
> 13:36:10.000000000
> > > +0800
> > > > @@ -256,6 +256,17 @@ static int acpi_hibernation_enter(void)
> > > >       return ACPI_SUCCESS(status) ? 0 : -EFAULT;
> > > >  }
> > > >
> > > > +static unsigned long s4_hardware_signature;
> > > > +static struct acpi_table_facs *facs;
> > > > +static int nosigcheck;
> > >
> > > Use bool perhaps?
> > >
> > > > +
> > > > +static int __init acpi_s4_nosigcheck(char *str)
> > > > +{
> > > > +     nosigcheck = 1;
> > >
> > > And "true" here?
> > >
> > > > +     return 1;
> > > > +}
> > > > +__setup("acpi_s4_nosigcheck", acpi_s4_nosigcheck);
> > > > +
> > >
> > > Please put this function at the end of the file.  Also, I'd call
> it
> > > "acpi_s4_nosig", but whatever.
> > Fixed all except this one, the routine is defined with HIBERATION
> > configed.
> 
> I've just realized that we're not doing the right thing here ...
> 
> > Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> > ---
> >  drivers/acpi/sleep/main.c |   22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > Index: linux/drivers/acpi/sleep/main.c
> > ===================================================================
> > --- linux.orig/drivers/acpi/sleep/main.c      2008-01-04
> 13:44:40.000000000 +0800
> > +++ linux/drivers/acpi/sleep/main.c   2008-01-07 09:31:42.000000000
> +0800
> > @@ -256,6 +256,17 @@ static int acpi_hibernation_enter(void)
> >       return ACPI_SUCCESS(status) ? 0 : -EFAULT;
> >  }
> > 
> > +static unsigned long s4_hardware_signature;
> > +static struct acpi_table_facs *facs;
> > +static bool nosigcheck;
> > +
> > +static int __init acpi_s4_nosigcheck(char *str)
> > +{
> > +     nosigcheck = true;
> > +     return 1;
> > +}
> > +__setup("acpi_s4_nosigcheck", acpi_s4_nosigcheck);
> > +
> >  static void acpi_hibernation_leave(void)
> >  {
> >       /*
> > @@ -263,6 +274,10 @@ static void acpi_hibernation_leave(void)
> >        * enable it here.
> >        */
> >       acpi_enable();
> > +     if (facs && s4_hardware_signature != facs->hardware_signature)
> {
> 
> ... because we should read the signature from the hardware here, while
> we're
> comparing two values read from memory.  They will always be equal. :-)
No, facs isn't a copy of ACPI FACS table (imagine how we sets
facs->waking_vector). It's mapped to BIOS table.

Thanks,
Shaohua
