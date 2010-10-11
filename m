From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] input: syfs switches for SKE keypad
Date: Mon, 11 Oct 2010 09:15:47 -0700
Message-ID: <20101011161546.GA5149__20730.3463983864$1286813801$gmane$org@core.coreip.homeip.net>
References: <20101011031613.GA4470@core.coreip.homeip.net>
	<Pine.LNX.4.44L0.1010111156300.2339-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1010111156300.2339-100000@netrider.rowland.org>
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
Cc: samu.p.onkalo@nokia.com, Linus WALLEIJ <linus.walleij@stericsson.com>, Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>, ext Sundar R IYER <sundar.iyer@stericsson.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Oct 11, 2010 at 12:06:32PM -0400, Alan Stern wrote:
> On Sun, 10 Oct 2010, Dmitry Torokhov wrote:
> 
> > > Will the driver use autosuspend for the 30-second delay?  Then all you
> > > have to do is this: When the button is pressed, write 0 to
> > > power/autosuspend_delay_ms, causing an immediate runtime suspend.  
> > > Then before turning the display back on, write 30000 to set the delay
> > > to 30 seconds again.  You can leave power/control set to "auto" the
> > > whole time.
> > > 
> > 
> > This means messing up with the currently set timeout. If userspace could
> > have an option of "accelerating" expiring of the current timeout that
> > would be better.
> 
> Accelerating the expiration of the timeout _is_ a form of messing with
> the currently-set timeout.  It can't be "better".

I was thinking about the case where timeout is user-supplied setting.
Instead of having application store the original value, write 0, and
later on restore it, I thought it would be better (as in simpler) to
have a separate sysfs entry to "expire" the original timeout
immediately.

> 
> > > I don't like the idea of having an "off" setting in power/control.  
> > > What happens if the user turns a disk drive controller "off" and the 
> > > system needs to read or write something on that disk drive?
> > > 
> > 
> > I see. Well, for some devices "sicky off"
> 
> "sticky off"?

The device that stays off and doe snot power itself up even if it is
needed.

> 
> >  maybe the one that makes most
> > sense. For others we may need an option that would put them into low
> > power mode while allowing bringing them back if they are needed.
> 
> Can you give any examples where "sticky off" is really useful (other
> than just for debugging)?
> 

A mobile device might have a set of keys that, once device is put into
lower power mode, should not bring the device out of that mode. This I
would call a "sticky off" case.

> > In case of touchscreens/keypads they are most likely configured as
> > wakeup sources so when user actually tried to use the device they'll be
> > brought online.
> 
> I agree, but it's important to distinguish between wakeup sources in 
> particular and interrupt sources in general.  As long as the system 
> as a whole isn't suspended (it might be running or it might be in 
> cpuidle), any interrupt source can cause a runtime resume.  By 
> contrast, when the system is suspended then only wakeup sources will 
> cause anything to happen.

Right.

-- 
Dmitry
