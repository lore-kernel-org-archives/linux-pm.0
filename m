From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 1/2] Input: gpio-keys - allow platform
	to	specify exact irq flags
Date: Mon, 7 Dec 2009 20:22:51 -0800
Message-ID: <20091208042251.GB11147__20427.1460338079$1260246242$gmane$org@core.coreip.homeip.net>
References: <Pine.LNX.4.44L0.0911300956400.4478-100000@iolanthe.rowland.org>
	<87einfltp3.fsf@tac.ki.iif.hu> <20091206084704.GC2766@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20091206084704.GC2766@ucw.cz>
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
Cc: linux-pm@lists.linux-foundation.org, Ferenc Wagner <wferi@niif.hu>, Mika Westerberg <mika.westerberg@iki.fi>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Dec 06, 2009 at 09:47:04AM +0100, Pavel Machek wrote:
> Hi!
> 
> 
> > But runtime-pm.txt says for example:
> > 
> >     Generally, remote wake-up should be enabled for all input devices
> >     put into a low power state at run time.
> > 
> > But in this case the requirement is to suppress input events from a
> > given device, effectively muting and putting it into low power state,
> > even though it's still open by some other parties.  Runtime PM, on the
> > other hand tries not to interfere with the normal usage of the device.
> > 
> > Later:
> > 
> > (3) ->runtime_idle() and ->runtime_suspend() can only be executed for a
> >     device the usage counter of which is equal to zero _and_ [...]
> > 
> > which underlines the difference again: the usage counter (defined by
> > common sense) won't be zero in our case, because the device is
> > constantly kept open, while we want to mute it, putting it into a low
> > power state. 
> ...
> > Actually, this could be implemented by the various users cooperating in
> > closing the device, letting it go to sleep automatically.  But this
> > requires strictly cooperating parties and is more complicated that
> > flipping some master switch of the device.  We're looking for this
> > master switch, before needlessly building our own.
> 
> Please just close the device properly. I do not think we want 100
> different 'please mute keys A and G', 'please mute middle mouse button',
> ... interfaces anywhere near mainline.
> 

I do not think it is practical to simply close the device, given that
there may be several applications that have it open. I constantly see
embedded guys adding custom knobs to the devices allowing them to shut
off the device when not in use. Kind of runtame PM but user-initiated.

I would really love to have it implemented in the driver core so the
interface is the same for all drivers (that support this future).

> Or just do it as local patch.

I also see that gpio-keys is quite different in the sence that it can
shut off buttons selectively. I fact, at the moment every button can be
considered a separate device... But that would be too much overhead.

They could probably split the keys into 2 groups (critical that should
be always active) and not critical, that could be shut off, but I think
they want teh flexibility of controlling this at runtime instead of
doing it in board data.

-- 
Dmitry
