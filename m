From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: Bugs on aspire one A150
Date: Sat, 13 Dec 2008 20:04:39 +0200
Message-ID: <1229191479.13970.6.camel__47208.6891568781$1229191709$gmane$org@maxim-laptop>
References: <491506DB.1070000@gmail.com> <200812131435.34072.rjw@sisk.pl>
	<1229178097.4936.1.camel@maxim-laptop> <200812131842.28420.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200812131842.28420.rjw@sisk.pl>
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, ath5k-devel@venema.h4ckr.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sat, 2008-12-13 at 18:42 +0100, Rafael J. Wysocki wrote:
> On Saturday, 13 of December 2008, Maxim Levitsky wrote:
> > On Sat, 2008-12-13 at 14:35 +0100, Rafael J. Wysocki wrote:
> > > On Saturday, 13 of December 2008, Maxim Levitsky wrote:
> > > > 
> > > > So, big thanks for everything.
> > > > 
> > > > Now aspire one linux support is very close to perfect,
> > > > (only problem left is that wireless is limited to 18Mbits/s raw rate,
> > > > but at some point I or developers of ath5k will get to the bottom of
> > > > this)
> > > > 
> > > > I also noticed, that now the SD only card reader is always enabled
> > > > regardless of card been there while booting, and same happens in
> > > > windows, I suspect that this is permanent hardware change, which worries
> > > > me, but this reader works fine otherwise.
> > > > (This is another reason why binary bioses are evil, go and find out why
> > > > it enables it)
> > > > 
> > > > 
> > > > Also forgot to mention that both readers ignore write protect tab on SD
> > > > card, and I will report this to correct mailing list soon.
> > > > Everything else works fine
> > > > 
> > > > please include acpiphp fix in 2.6.28.
> > > 
> > > Which one is this?
> > 
> > 
> > 
> > acpiphp: Identify more removable slots
> >     
> >     According to section 6.3.6 of the ACPI spec, the presence of an _RMV
> >     method that evaluates to 1 is sufficient to indicate that a slot is
> >     removable without needing an eject method. This patch refactors the
> >     ejectable slot detection code a little in order to flag these slots as
> >     ejectable and register them. Acpihp therefore binds to the expresscard
> >     slot on my HP test machine.
> >     
> >     Signed-off-by: Matthew Garrett <mjg@redhat.com>
> > 
> > 
> > this makes acpiphp handle hotplug of (now one, sd reader is somehow
> > always present) card reader.
> 
> This is
> http://git.kernel.org/?p=linux/kernel/git/jbarnes/pci-2.6.git;a=commit;h=db9fe9a7230d65916c9938c4f91c75f9c5e00cb7
> in the PCI tree.
> 
> It's scheduled for 2.6.29 and may be included into 2.6.28 -stable, but please
> remember to notify the stable team as soon as this patch gets merged into the
> mainline.

I will, sure.


Just to note, that I might not need that patch as I told that now one of
readers is permanently enabled, I don't know why but this seems to be
hardware failure.

I disconnected power/battery, no cards are in slots, and yet on boot
there is a sd reader in lspci.
Same happens in windows.
It could happen due to suspend/resume, If I remember correctly I put
card once in slot, and then for whole week system wasn't rebooted, but
instead went through suspend/resume cycles.

One thing for sure, nobody will fix this (I mean no point to call acer
support, this is too minor problem)


What I worry about is that second one could show same behavier.
I like this hotplug, as it allows me to test pci hotplug code for real.
Besides, this isn't done without purpose, device might draw less power
this way.


Best regards,
	Maxim Levitsky
