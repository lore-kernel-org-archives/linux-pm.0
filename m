From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH -mm] kexec jump -v9
Date: Sat, 22 Mar 2008 18:45:12 +0100
Message-ID: <200803221845.13826.rjw__26292.2348491431$1206208060$gmane$org@sisk.pl>
References: <200803210040.33982.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0803202049550.11234-100000@netrider.rowland.org>
	<20080322162110.GA32058@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080322162110.GA32058@atrey.karlin.mff.cuni.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>, nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Saturday, 22 of March 2008, Pavel Machek wrote:
> > On Fri, 21 Mar 2008, Rafael J. Wysocki wrote:
> > 
> > > > > > Well, in fact ACPI has something called the NVS memory, which we're supposed
> > > > > > to restore during the resume and which we're not doing.  The problem may be
> > > > > > related to this.
> > > > > 
> > > > > No, it can't be.  ACPI won't expect the NVS memory to be restored 
> > > > > following an S5-shutdown.  In fact, as far as ACPI is concerned, 
> > > > > resuming from an S5-type hibernation should not be considered a resume 
> > > > > at all but just an ordinary reboot.
> > > 
> > > I agree here.
> > > 
> > > > > All ACPI-related memory areas in the boot kernel should be passed directly
> > > > > through to the image kernel.
> > > 
> > > However, the image kernel is supposed to restore the NVS area (from the
> > > image) before executing _WAK.
> > 
> > It's supposed to do that when resuming from an S4 hibernation, not 
> > when resuming from an S5 hibernation.
> > 
> > > > How can we pass interpretter state? I do not think we do this kind of
> > > > passing.
> > > 
> > > The interpreter state is passed withing the image.  The platform state is not.
> > 
> > For an S5 hibernation, the interpreter state within the image is wrong.  
> > The image kernel needs to have the interpreter state from the boot 
> > kernel -- I don't know if this is possible.
> 
> yes, nosave pages could be used to do this passing -- if we can put
> interpretter state into pre-allocated memory block.

On x86-64 there's no guarantee that the "nosave" pages will be at the same
locations in both the image kernel and the boot kernel.  What we could do
is to pass the data in the image header, preallocate some "safe" pages from
the boot kernel, put the data in there and pass a pointer to them to the
image kernel.

However, as far as the ACPI NVS area is concerned, this is probably not
necessary, because the spec wants us to restore the ACPI NVS before calling
_WAK, which is just after the image kernel gets the control back.  So, in
theory, the ACPI NVS data could be stored in the image and restored by
the image kernel from a location known to it (the procedure may be to copy
the ACPI NVS data into a region of regular RAM before creating the image and
copy them back into the ACPI NVS area in platform->leave(), for example), but
I suspect that for this to work we'll have to switch ACPI off in the boot
kernel, just prior to passing control back to the image kernel.

Thanks,
Rafael
