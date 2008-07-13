From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFT] x86 acpi: normalize segment descriptor
	register on resume
Date: Sun, 13 Jul 2008 22:29:41 +0200
Message-ID: <200807132229.43140.rjw__38938.7341020212$1215981068$gmane$org@sisk.pl>
References: <200807010148.02135.rjw@sisk.pl> <200807132115.08230.rjw@sisk.pl>
	<487A617B.80707@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <487A617B.80707@firstfloor.org>
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
To: Andi Kleen <andi@firstfloor.org>
Cc: Andy Lutomirski <luto@myrealbox.com>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, public-kernel-testers-u79uwXL29TY76Z2rM5mHXA@lo.gmane.org, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sunday, 13 of July 2008, Andi Kleen wrote:
> Rafael J. Wysocki wrote:
> > On Sunday, 13 of July 2008, Andi Kleen wrote:
> >> Andy Lutomirski wrote:
> >>> Matthew Garrett wrote:
> >>>> On Sun, Jul 13, 2008 at 11:15:24AM +0200, Ingo Molnar wrote:
> >>>>
> >>>>> we still need to find the HAL quirk and disable it, right?
> >>>> Not without understanding what the cause is. If the video BIOS calls
> >>>> are generically broken, then we have a problem.
> >>>>
> >>> The HAL quirk is the very first one here:
> >>>
> >>> http://gitweb.freedesktop.org/?p=hal-info.git;a=blob;f=fdi/information/10freedesktop/20-video-quirk-pm-lenovo.fdi
> >>>
> >>>
> >>> I removed it from the HAL config and suspending w/ the hardware button
> >>> works fine now with -rc9-wl and on Ubuntu's stock .24 kernel.
> >> Hmm, but the change was not supposed to break the s3 bios. Something
> >> fishy is going on. It sounds like the s3 bios relies on some earlier
> >> segment register setup.
> > 
> > Well, we changed the (visible) parts of the segment registers before anyway.
> > 
> > This means that it could only depend on the hidden parts.  However, in that
> > case if it depended on the hidden part of SS, our stack would be broken,
> 
> We're in real mode for now nd should not care about the hidden state.

That's the point of commit 4b4f7280.

Without that commit we used to reset segment registers, but there were
some post-protected mode garbage in the hidden part of SS on some systems, so
things broke.

We now make sure the hidden parts of all segment registers are reset.
If anything fails as a result of that, it's broken beyond repair IMO.

> > so the quirk wouldn't work (it uses 'call' to run a BIOS routine).  In turn, if it
> > depended on the hidden part of DS, our data register would be broken, so the
> > resume code itself wouldn't work.
> > 
> > This means it could only depend on the hidden part of ES.
> >  
> >> If true this means the segment register reset would need to be moved
> >> later after S3 bios ran.
> > 
> > We can't do that.  If SS contains garbage, the BIOS call itself will reboot
> > the box and if DS contains garbage, well ...
> 
> But it's apparently not garbage for the s3 bios. So somehow the "garbage"
> needs to be kept impact until the S3 BIOS ran.

We can't do that on all systems, because some (I'd say many) of them don't
work if we do.

If s3_bios depends on the (invalid) contents of the hidden part of any segment
register, it's just terminally broken.

But.

We didn't modify %cx before - may that matter?

Thanks,
Rafael
