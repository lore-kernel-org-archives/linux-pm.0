From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 3/4] x86 hibernate: Mark ACPI NVS memory
	region at startup
Date: Fri, 31 Oct 2008 00:59:46 +0100
Message-ID: <200810310059.47564.rjw__27241.2454746247$1225411156$gmane$org@sisk.pl>
References: <200810222249.20629.rjw@sisk.pl>
	<1225272091.2665.4.camel@rzhang-dt>
	<20081029111837.GA20466@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20081029111837.GA20466@atrey.karlin.mff.cuni.cz>
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
To: Pavel Machek <pavel@suse.cz>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 29 of October 2008, Pavel Machek wrote:
> Hi!
> 
> > > > > +static int __init e820_mark_nvs_memory(void)
> > > > > +{
> > > > > +	int i;
> > > > > +
> > > > > +	if (efi_enabled)
> > > > > +		return 0;
> > > > 
> > > > Aha, not unrelated... why is that? EFI does not use acpi? 
> > > 
> > > With EFI we are not supposed to do that.  Rui knows the details.  Rui?
> > > 
> > well, 
> > about EFI nvs memory, I only get
> > "EfiACPIMemoryNVS: The OS and loader must preserve this memory range in
> > the working and ACPI S1???S3 states." in the ACPI spec 3.0b.
> > whether we should save/restore this piece of memory is not clear.

Well. it's clear enough.  Section 15.3.2 evidently refers to E820 and the EFI's
GetMemoryMap() on equal footing.

> > I'd prefer not to touch it currently.
> 
> EFI is a bootloader. Why should we change our runtime behaviour
> depending on bootloader?
> 
> EFI should be still compatible with normal ACPI, right? ...like you
> should be able to boot the same kernel with the same ACPI BIOS using
> EFI or EFI w/ legacy emulation.
> 
> So special-casing it here does not seem right.

I agree.

I'm going to send an updated patch to Len.

Thanks,
Rafael
