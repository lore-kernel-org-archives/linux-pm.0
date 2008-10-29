From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 3/4] x86 hibernate: Mark ACPI NVS memory
	region at startup
Date: Wed, 29 Oct 2008 12:18:37 +0100
Message-ID: <20081029111837.GA20466__19506.0176928111$1225279353$gmane$org@atrey.karlin.mff.cuni.cz>
References: <200810222249.20629.rjw@sisk.pl> <200810222253.16264.rjw@sisk.pl>
	<20081026121404.GC1607@ucw.cz> <200810261329.16260.rjw@sisk.pl>
	<1225272091.2665.4.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1225272091.2665.4.camel@rzhang-dt>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > > +static int __init e820_mark_nvs_memory(void)
> > > > +{
> > > > +	int i;
> > > > +
> > > > +	if (efi_enabled)
> > > > +		return 0;
> > > 
> > > Aha, not unrelated... why is that? EFI does not use acpi? 
> > 
> > With EFI we are not supposed to do that.  Rui knows the details.  Rui?
> > 
> well, 
> about EFI nvs memory, I only get
> "EfiACPIMemoryNVS: The OS and loader must preserve this memory range in
> the working and ACPI S1???S3 states." in the ACPI spec 3.0b.
> whether we should save/restore this piece of memory is not clear.
> I'd prefer not to touch it currently.

EFI is a bootloader. Why should we change our runtime behaviour
depending on bootloader?

EFI should be still compatible with normal ACPI, right? ...like you
should be able to boot the same kernel with the same ACPI BIOS using
EFI or EFI w/ legacy emulation.

So special-casing it here does not seem right.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
