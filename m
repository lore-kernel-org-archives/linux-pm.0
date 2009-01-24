From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: BISECTED: 2.6.29-rc2 regression: hibernation hang on
	eeepc-701
Date: Sat, 24 Jan 2009 21:53:47 +0100
Message-ID: <200901242153.48095.rjw__34904.2201684371$1232830648$gmane$org@sisk.pl>
References: <9b2b86520901180345j434eacbdn7386958991ee50b@mail.gmail.com>
	<497AF845.2000002@tuffmail.co.uk>
	<200901240827.05557.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200901240827.05557.jbarnes@virtuousgeek.org>
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
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pm@lists.linux-foundation.org, kernel-testers@vger.kernel.org, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@suse.cz>
List-Id: linux-pm@vger.kernel.org

On Saturday 24 January 2009, Jesse Barnes wrote:
> On Saturday, January 24, 2009 3:15 am Alan Jenkins wrote:
> > Rafael J. Wysocki wrote:
> > > On Friday 23 January 2009, Alan Jenkins wrote:
> > >> Rafael J. Wysocki wrote:
> > >>> On Thursday 22 January 2009, Alan Jenkins wrote:
> > >>>> Rafael J. Wysocki wrote:
> > >>>>> On Thursday 22 January 2009, Alan Jenkins wrote:
> > >>>>>> Alan Jenkins wrote:
> > >>>>>>> Hibernation hangs just after writing the image.  With s2disk I can
> > >>>>>>> see this from the console messages.  The same hang happens with
> > >>>>>>> kernel swsusp ('echo disk | sudo tee /sys/power/state'), and I can
> > >>>>>>> see that the image has been written from the HDD led.
> > >>>>>>>
> > >>>>>>> In either case, I can still hard-power-off and resume from
> > >>>>>>> hibernation.
> > >>>>>>>
> > >>>>>>> It doesn't hang if I use the shutdown method (either 'echo shutdown
> > >>>>>>> | sudo tee /sys/power/disk' or  's2disk -P "shutdown
> > >>>>>>> method=shutdown"').
> > >>>>>>
> > >>>>>> I've bisected this to commit
> > >>>>>> 571ff7584bb9e05fca0eb79752ae55a46faf3a98. It doesn't revert cleanly
> > >>>>>> from RC2.
> > >>>>>>
> > >>>>>> I think it's distinct from the other two reported suspend
> > >>>>>> regressions. I'm not using acpi-cpufreq, and the issue doesn't
> > >>>>>> affect resume.
> > >>>>>
> > >>>>> It looks distinct.
> > >>>>>
> > >>>>> Do you suspend this box to RAM and does it work?
> > >>>>
> > >>>> Yes, I do use STR on it occasionally, and it still works in RC2.
> > >>>>
> > >>>>> Please retest with the appended patch applied.
> > >>>>
> > >>>> That fixes it.
> > >>>
> > >>> OK, it won't hurt to apply it.
> > >>>
> > >>> Still, the hardware or the BIOS in your box seems to be broken, or
> > >>> both, so I'd like to debug it a bit more if you don't mind.
> > >>>
> > >>> Can you please test the patch below instead of the previous one?
> > >>
> > >> It hangs at the same point as the unpatched RC2.  As before, it doesn't
> > >> hang if I use "shutdown" instead of "platform".
> > >>
> > >> Going by sysfs, I have 4 PCI devices without a kernel driver.
> > >>
> > >> 8086:2592   Mobile 915 Express Graphics Controller
> > >> 8086:2792   Mobile 915 Express Graphics Controller (driven by X)
> > >> 8086:2448   82801 Mobile PCI Bridge
> > >> 8086:2641   82801FBM (ICH6M) LPC Interface Bridge
> > >
> > > The bridges shouldn't be affected, so I bet on the graphics.
> > >
> > > It seems that the BIOS doesn't expect it to be in D3 while entering S4,
> > > although it apparently doesn't mind it to be in D3 while entering S3.
> > >
> > > I blame the Asus BIOS writers. ;-)
> >
> > Wouldn't Windows normally put it into D3?  There are many reports of
> > successful hibernation under Windows on this hardware.  The motivation
> > being that S3 drains the battery in <24 hours.  (Fewer people hibernate
> > on linux because you only have a 4G SSD, so a swap partition wastes a
> > lot of space, and most installers can't set up swap files).
> 
> Sounds like the BIOS pokes at gfx during S3 (then hopefully puts it into D3) 
> but doesn't bother when going into S4, that's kind of strange, but maybe it's 
> spec'd somewhere.

Well, I think the BIOS doesn't touch the graphics during suspend to RAM and
resume, because it wants to save time.  ISTR, there is a limit on the amount
of time the BIOS can spend initializing devices and it doesn't get Windows
certification if that limit is not satisfied.

There's no such limit for hibernation, though, and the BIOS probably tries to
do something with the graphics before entering S4, but it should first check if
it's already in D3.

Thanks,
Rafael
