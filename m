From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM / i915: Skip kernel VT switch during
 suspend/resume if KMS is used
Date: Tue, 26 Jan 2010 23:08:17 +0100
Message-ID: <20100126220816.GB19163__47010.8830872507$1264543778$gmane$org@elf.ucw.cz>
References: <201001240055.59479.rjw@sisk.pl> <201001252254.37635.rjw@sisk.pl>
	<20100126141726.GA1437@ucw.cz> <201001261947.46015.rjw@sisk.pl>
	<20100126145842.GA11295@ucw.cz> <4B5F6299.6090903@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4B5F6299.6090903@zytor.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: airlied@linux.ie, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Eric Anholt <eric@anholt.net>, pm list <linux-pm@lists.linux-foundation.org>, dri-devel@lists.sourceforge.net, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Tue 2010-01-26 13:46:01, H. Peter Anvin wrote:
> On 01/26/2010 06:58 AM, Pavel Machek wrote:
> >>
> >> That would have to be done using suspend notifiers and should depend on what
> >> driver actually controls the screen at the moment.  And I guess the only case
> >> in which we actually _need_ to do the kernel VT switch is when the hardware
> >> is controlled by X and without KMS.
> > 
> > We need vt switch when display is controlled by userland app directly
> > accessing hw. It may or may not be X (svgalib anyone?,
> > gtk-on-framebuffer? qtopia?).
> > 
> > Ideally, userspace should explicitely tell us. KD_KERNEL_GRAPHICS
> > console mode?
> 
> It seems that the kernel would already know if it's in control of the
> mode switch, no? 

No, I do not think so. IIRC KD_GRAPHICS means "console is under
userland control"; X will use it even if it does not directly talk to
the hardware.

IOW kernel knows if userland *may* be in control of graphics hardware.

(And yes, not switching consoles when console is in KD_TEXT should be
easy and obvious optimalization).

Currently we have 

#define         KD_TEXT         0x00
#define         KD_GRAPHICS     0x01
#define         KD_TEXT0        0x02    /* obsolete */
#define         KD_TEXT1        0x03    /* obsolete */

I guess KD_KERNEL_GRAPHICS (or KD_INDIRECT_GRAPHICS or
KD_GRAPHICS_BUT_KERNEL_CAN_DO_CONSOLE_SWITCHING or something like
that) would be needed so that userland can indicate that no, cursor is
no longer welcome on the screen but no, it is not accessing hw
directly.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
