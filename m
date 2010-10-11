From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] input: syfs switches for SKE keypad
Date: Mon, 11 Oct 2010 12:53:11 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1010111240390.2339-100000__38865.1564521298$1286816152$gmane$org@netrider.rowland.org>
References: <20101011161546.GA5149@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20101011161546.GA5149@core.coreip.homeip.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: samu.p.onkalo@nokia.com, Linus WALLEIJ <linus.walleij@stericsson.com>, Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>, ext Sundar R IYER <sundar.iyer@stericsson.com>
List-Id: linux-pm@vger.kernel.org

On Mon, 11 Oct 2010, Dmitry Torokhov wrote:

> > > This means messing up with the currently set timeout. If userspace could
> > > have an option of "accelerating" expiring of the current timeout that
> > > would be better.
> > 
> > Accelerating the expiration of the timeout _is_ a form of messing with
> > the currently-set timeout.  It can't be "better".
> 
> I was thinking about the case where timeout is user-supplied setting.
> Instead of having application store the original value, write 0, and
> later on restore it, I thought it would be better (as in simpler) to
> have a separate sysfs entry to "expire" the original timeout
> immediately.

What you're suggesting can be added.  For example, writing a blank line
to power/autosuspend_delay_ms could be defined to have this effect.  
I'm not sure how beneficial it would turn out to be in the long run.

> > Can you give any examples where "sticky off" is really useful (other
> > than just for debugging)?
> > 
> 
> A mobile device might have a set of keys that, once device is put into
> lower power mode, should not bring the device out of that mode. This I
> would call a "sticky off" case.

But here the "sticky off" refers to the entire mobile device, not to 
any particular driver.  In other words, it isn't a runtime-PM issue.

An example of runtime-PM "sticky off" would be a mouse that gets set to
low power and is forced to remain that way even when the user moves or
clicks it.  I don't see how that would be useful.

Alan Stern
