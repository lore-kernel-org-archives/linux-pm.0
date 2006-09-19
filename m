From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] USB device persistence across
	suspend-to-disk
Date: Tue, 19 Sep 2006 10:52:57 -0700
Message-ID: <200609191052.58196.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0609051104260.14667-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44L0.0609051104260.14667-100000@iolanthe.rowland.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: linux-usb-devel@lists.sourceforge.net
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Alan Stern <stern@rowland.harvard.edu>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 05 September 2006 8:26 am, Alan Stern wrote:
> Lots of people have asked why USB mass-storage devices don't survive
> suspend-to-disk (swsusp).  The answer is technical and not too
> interesting;

Not that technical:   "Unlike most older busses, USB monitors connection
state during suspend states.  It does this by using an active electical
circuit, which is broken by swsusp.  USB detects that broken circuit
and thus reports the device's disconnection."

And why does that matter?  For stateless devices like most mice and
keyboards, it doesn't.  For a disk with a mounted file system, it does
since (a) there's no trustworthy way to tell if a disk that's there on
resume is the same one that was there on suspend, while (b) wrongly
assuming it's the same *WILL* quickly lead to data corruption.


> what matters is that people have been forced to unmount all 
> filesystems on USB devices before doing suspend-to-disk.  On some systems
> this is necessary even for suspend-to-RAM.

Most PCs maintain the USB connections during suspend-to-RAM; ISTR seeing
some hardware design guidelines from SFT saying to do it that way, so that
remote wakeup works.  (E.g. on systems with only USB keyboards and mice,
you want wakeup to be natural.)

Some laptops (to eke out a bit more battery life) and embedded systems
(where STR is the deepest suspend state) do drop USB power during STR.
In my observation, hardly any PCs drop USB power like that.


> This patch adds the capability for USB devices to persist across such
> suspends.  You can even suspend with your root fs on a USB flash device!  
> (I think -- I haven't actually tried it.  But it _should_ work.)
> 
> It's all explained in Documentation/usb/persist.txt, added by the patch.  
> The "persist" mode is turned off by default because it can be dangerous.
> 
> The patch is based on 2.6.18-rc5-mm1.  If people like it, I'll submit it
> to Greg KH for inclusion in the USB development tree.

A mechanism that's this dangerous deserves to be discouraged much more
strongly, if it's even merged.  (I'm not a big fan of giving people
quite that much rope.)  Having it depend on CONFIG_EMBEDDED as well as
CONFIG_EXPERIMENTAL (or better yet CONFIG_DANGEROUS) seems a better route...



> + * This facility is inherently dangerous.  Although usb_reset_device()
> + * makes every effort to insure that the same device is present after the
> + * reset as before, it cannot provide a 100% guarantee.  Furthermore it's
> + * quite possible for a device to remain unaltered but its media to be
> + * changed.  If the user replaces a flash memory card while the system is
> + * asleep, he will have only himself to blame when the filesystem on the
> + * new card is corrupted and the system crashes.

I'll disagree on the "only himself to blame".  If this mechanism is trivial
to kick in, it will be kicked in even by (or on behalf of) users that have
no reason to understand how dangerous this is.
 


> --- mm.orig/Documentation/kernel-parameters.txt
> +++ mm/Documentation/kernel-parameters.txt
> @@ -1235,6 +1235,16 @@ and is between 256 and 4096 characters. 
>  			Format: { 0 | 1 }
>  			See arch/parisc/kernel/pdc_chassis.c
>  
> +	persist=	[USB] Enable USB device persistence across power loss
> +			during system suspend.
> +			Format: { 0 | 1 }
> +			See also Documentation/usb/persist.txt
> +			WARNING!!  If a USB mass-storage device or its media
> +			are changed while the system is suspended, the kernel
> +			may not realize what has happened.  If this option is
> +			enabled then filesystem corruption and a system crash
> +			may result.
                        ^^^
                        File system corruption ** WILL ** result...

> +
>  	pf.		[PARIDE]
>  			See Documentation/paride.txt.
>  
> Index: mm/Documentation/usb/persist.txt
> ===================================================================
> --- /dev/null
> +++ mm/Documentation/usb/persist.txt
> @@ -0,0 +1,154 @@
> +		USB device persistence during system suspend
> +
> +		   Alan Stern <stern@rowland.harvard.edu>
> +
> +				September 2, 2006
> +
> +
> +
> +	What is the problem?
> +
> +According to the USB specification, when a USB bus is suspended the
> +bus must continue to supply suspend current (around 1-5 mA).  This

No ... it's normally 500 uA, or for high powered devices up to 2500 uA.
The specification is a per-device average over 1 second, not per bus.

Some root hubs ("busses") support ten directly-connected devices, which
implies 25 mA would be needed on top of whatever the controller itself
is consuming.  (You'd think it only needs some comparators and trivial
unclocked logic, but for some reason that seems uncommon.)



> +Loss of power isn't the only mechanism to worry about.  Anything that
> +interrupts a power session will have the same effect.  For example,
> +even though suspend current may have been maintained while the system
> +was asleep, on many systems during the initial stages of wakeup the
> +firmware (i.e., the BIOS) resets the motherboard's USB host
> +controllers. 

That's called a BUG ... firmware shouldn't have reset any device
that the OS was managing.  And in fact during true system suspend
states, I've not heard any reports of a BIOS resetting a USB host
controller.  Do you have examples of these "many" systems??

(Any swsusp case is not one of these, since that's not a true
suspend mechanism.  The hardware really did get reset, and BIOS
init can't be bypassed if it's going to let users do basics like
using a usb keyboard to choose which OS to run.)


> +On many systems the USB host controllers will get reset after a
      ^^^^
      "some" ... by numbers, not very many since ISTR it's against
the hardware design guidelines from MSFT.

> +suspend-to-RAM.  On almost all systems, no suspend current is
> +available during suspend-to-disk (also known as swsusp).  You can
> +check the kernel log after resuming to see if either of these has
> +happened; look for lines saying "root hub lost power or was reset".
> +
> +In practice, people are forced to unmount any filesystems on a USB
> +device before suspending.  

Just like for ** ALL ** other kinds of removable media, on any system
where userspace isn't facilitating data corruption.


> +	WARNING: Using "persist=y" can be dangerous!!

You're understating this.  I really think that such a mechanism would
need to be explicitly configured into the kernel.  Distros that want
to cope with all the end-user "your kernel trashed my disk!!" service
calls could do so ... others would keep that option off, and save lots
of customer support and end user pain.



> +YOU HAVE BEEN WARNED!  USE AT YOUR OWN RISK!

Actually, most end users would never read this information, so they
will never get such a warning.

- Dave


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
