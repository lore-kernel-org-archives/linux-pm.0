From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] PM / i915: Skip kernel VT switch during
 suspend/resume if KMS is used
Date: Tue, 26 Jan 2010 13:46:01 -0800
Message-ID: <4B5F6299.6090903@zytor.com>
References: <201001240055.59479.rjw@sisk.pl> <201001252254.37635.rjw@sisk.pl>
	<20100126141726.GA1437@ucw.cz> <201001261947.46015.rjw@sisk.pl>
	<20100126145842.GA11295@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100126145842.GA11295@ucw.cz>
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
Cc: airlied@linux.ie, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Eric Anholt <eric@anholt.net>, pm list <linux-pm@lists.linux-foundation.org>, dri-devel@lists.sourceforge.net, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On 01/26/2010 06:58 AM, Pavel Machek wrote:
>>
>> That would have to be done using suspend notifiers and should depend on what
>> driver actually controls the screen at the moment.  And I guess the only case
>> in which we actually _need_ to do the kernel VT switch is when the hardware
>> is controlled by X and without KMS.
> 
> We need vt switch when display is controlled by userland app directly
> accessing hw. It may or may not be X (svgalib anyone?,
> gtk-on-framebuffer? qtopia?).
> 
> Ideally, userspace should explicitely tell us. KD_KERNEL_GRAPHICS
> console mode?
> 

It seems that the kernel would already know if it's in control of the
mode switch, no?  If userspace ever takes control and it doesn't already
notify the kernel that it is taking over, we would seem to have a much
bigger problem...

> Plus the switch is needed for any graphics app using fbcon -- I do not
> think we actually save the framebuffer over suspend. (This one should
> probably be fixed).

Quite.

	-hpa
