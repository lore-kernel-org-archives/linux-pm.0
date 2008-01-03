From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch] hibernation: utilize ACPI hardware signature
Date: Thu, 3 Jan 2008 18:04:29 +0100
Message-ID: <200801031804.30947.rjw__33356.4997571104$1199379821$gmane$org@sisk.pl>
References: <1199257162.14632.4.camel@sli10-desk.sh.intel.com>
	<200801021505.39789.rjw@sisk.pl>
	<1199338595.1642.3.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1199338595.1642.3.camel@sli10-desk.sh.intel.com>
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
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Pavel Machek <pavel@suse.cz>
List-Id: linux-pm@vger.kernel.org

On Thursday, 3 of January 2008, Shaohua Li wrote:
> 
> On Wed, 2008-01-02 at 22:05 +0800, Rafael J. Wysocki wrote:
> > On Wednesday, 2 of January 2008, Shaohua Li wrote:
> > > ACPI defines a hardware signature. BIOS calculates the signature
> > > according to hardware configure, if hardware changes, the signature
> > will
> > > change, in this case, S4 resume should fail.
> > 
> > The idea is fine, but I'd prefer to do that in a more straightforward
> > way.
> > Namely, we can just:
> > * write the signature into a variable in, for example,
> >   acpi_hibernation_prepare() (then, the "old" signature value will be
> >   automatically saved in the image)
> > * compare it with a the "new" value read from the BIOS in
> >   acpi_hibernation_leave() and panic if there's a mismatch
> > * add a configuration option to disable this behavior (just in case)
> > This way we can avoid modifying the entire generic interface to add
> > the feature
> > specific to ACPI.
> it would be better we do the check in boot kernel.

Franky, I think we should also check in the image kernel, in case the boot
one doesn't support ACPI as I said.

> Why is so bad to do it in generic code?

I just don't like adding more callbacks for this purpose.

> Other platforms can implement it too, like calculating the signature in OS.
> 
> > Still, if you want the boot kernel to check the signature, which will
> > be more
> > elegant (but please note that on x86-64 the boot kernel need not
> > support ACPI
> > at all), you can use the (recently introduced) architecture part of
> > the image
> > header for this purpose, without modifying the generic interface.
> Where can I get the code with architecture image header support? appears
> can't find it.

Please have a look at arch_hibernation_header_save() and
arch_hibernation_header_restore() in arch/x86/kernel/suspend_64.c.

They are used by init_header_complete() and check_image_kernel() defined
in kernel/power/power.h .

Currently only x86_64 defines these functions, but I'm going to implement
them on i386 too.

Thanks,
Rafael
