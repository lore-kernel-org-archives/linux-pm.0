From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Two problems with system sleep
Date: Mon, 22 Feb 2010 11:33:47 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1002221119590.1262-100000__22939.3303547569$1266856482$gmane$org@iolanthe.rowland.org>
References: <201002212139.39746.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201002212139.39746.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, Alan <alan@lxorguk.ukuu.org.uk>, linux-kbuild@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sun, 21 Feb 2010, Rafael J. Wysocki wrote:

> > > Anyway, we need to check if control gets back to acpi_suspend_enter().

Would PM_TRACE_RTC help?  What would I have to add in order to insert
an appropriate tracepoint?


> > > BTW, does anything change if you put acpi_sleep=sci_force_enable into the
> > > kernel command line?
> > 
> > Nothing changes.  I also added "pci=use_crs", based on a suggestion in 
> > the log, but that didn't make any difference either.
> 
> The failure to resume may be graphics-related, so please try to compile i915
> statically into the kernel and set CONFIG_DRM_I915_KMS.

Odd -- when I use "make menuconfig", that part of the menu 
doesn't show up.  Navigating through "Device Drivers -> Graphics 
support" gives me this screen:

    <*> /dev/agpgart (AGP Support)  --->                             
    <*> Direct Rendering Manager (XFree86 4.1.0 and higher DRI suppor 
    -*- Lowlevel video output switch controls                        
    -*- Support for frame buffer devices  --->                       
    [ ] Backlight & LCD device support  --->                         
        Display device support  --->                                 
        Console display driver support  --->                         
    [ ] Bootup logo  --->                                            

None of the entries in drivers/gpu/drm/Kconfig show up beyond the first 
one.  I had to go in and edit .config by hand to set CONFIG_DRM, 
CONFIG_DRM_KMS_HELPER, CONFIG_DRM_I915, and CONFIG_DRM_I915_KMS all to 
"y".  Is this a bug in menuconfig?  CC'ing the mailing list...

Anyway, it didn't make any difference.  The behavior was exactly the 
same.  Pressing the power button during suspend causes an 
almost-instant hang, before the screen or anything else revives.

By concentrating on the video drivers, you may be missing part of 
the problem.  Have you considered why pressing a key on the keyboard 
doesn't wake the system up?  Nothing happens -- the power LED on the 
desktop case just keeps on blinking.

Alan Stern
