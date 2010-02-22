From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Two problems with system sleep
Date: Mon, 22 Feb 2010 19:45:25 +0100
Message-ID: <201002221945.25891.rjw__21867.8214740523$1266864510$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1002221119590.1262-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1002221119590.1262-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, Alan <alan@lxorguk.ukuu.org.uk>, linux-kbuild@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday 22 February 2010, Alan Stern wrote:
> On Sun, 21 Feb 2010, Rafael J. Wysocki wrote:
> 
> > > > Anyway, we need to check if control gets back to acpi_suspend_enter().
> 
> Would PM_TRACE_RTC help?

In my opinion that's worth doing.

> What would I have to add in order to insert an appropriate tracepoint?

Please follow Documentation/power/s2ram.txt .

> > > > BTW, does anything change if you put acpi_sleep=sci_force_enable into the
> > > > kernel command line?
> > > 
> > > Nothing changes.  I also added "pci=use_crs", based on a suggestion in 
> > > the log, but that didn't make any difference either.
> > 
> > The failure to resume may be graphics-related, so please try to compile i915
> > statically into the kernel and set CONFIG_DRM_I915_KMS.
> 
> Odd -- when I use "make menuconfig", that part of the menu 
> doesn't show up.  Navigating through "Device Drivers -> Graphics 
> support" gives me this screen:
> 
>     <*> /dev/agpgart (AGP Support)  --->                             
>     <*> Direct Rendering Manager (XFree86 4.1.0 and higher DRI suppor 
>     -*- Lowlevel video output switch controls                        
>     -*- Support for frame buffer devices  --->                       
>     [ ] Backlight & LCD device support  --->                         
>         Display device support  --->                                 
>         Console display driver support  --->                         
>     [ ] Bootup logo  --->                                            
> 
> None of the entries in drivers/gpu/drm/Kconfig show up beyond the first 
> one.  I had to go in and edit .config by hand to set CONFIG_DRM, 
> CONFIG_DRM_KMS_HELPER, CONFIG_DRM_I915, and CONFIG_DRM_I915_KMS all to 
> "y".  Is this a bug in menuconfig?  CC'ing the mailing list...
> 
> Anyway, it didn't make any difference.  The behavior was exactly the 
> same.  Pressing the power button during suspend causes an 
> almost-instant hang, before the screen or anything else revives.
> 
> By concentrating on the video drivers, you may be missing part of 
> the problem.  Have you considered why pressing a key on the keyboard 
> doesn't wake the system up?  Nothing happens -- the power LED on the 
> desktop case just keeps on blinking.

We may just not set up the keyboard as a wakeup device.  The other option is
that the BIOS has a problem with resume handling, in which case I have no
idea what to do.

Rafael
