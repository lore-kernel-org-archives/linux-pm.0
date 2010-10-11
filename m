From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] input: syfs switches for SKE keypad
Date: Mon, 11 Oct 2010 10:07:33 -0700
Message-ID: <20101011170733.GA27304__2869.77567379854$1286816995$gmane$org@core.coreip.homeip.net>
References: <20101011161546.GA5149@core.coreip.homeip.net>
	<Pine.LNX.4.44L0.1010111240390.2339-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1010111240390.2339-100000@netrider.rowland.org>
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

On Mon, Oct 11, 2010 at 12:53:11PM -0400, Alan Stern wrote:
> On Mon, 11 Oct 2010, Dmitry Torokhov wrote:
> 
> > > > This means messing up with the currently set timeout. If userspace could
> > > > have an option of "accelerating" expiring of the current timeout that
> > > > would be better.
> > > 
> > > Accelerating the expiration of the timeout _is_ a form of messing with
> > > the currently-set timeout.  It can't be "better".
> > 
> > I was thinking about the case where timeout is user-supplied setting.
> > Instead of having application store the original value, write 0, and
> > later on restore it, I thought it would be better (as in simpler) to
> > have a separate sysfs entry to "expire" the original timeout
> > immediately.
> 
> What you're suggesting can be added.  For example, writing a blank line
> to power/autosuspend_delay_ms could be defined to have this effect.  
> I'm not sure how beneficial it would turn out to be in the long run.
> 
> > > Can you give any examples where "sticky off" is really useful (other
> > > than just for debugging)?
> > > 
> > 
> > A mobile device might have a set of keys that, once device is put into
> > lower power mode, should not bring the device out of that mode. This I
> > would call a "sticky off" case.
> 
> But here the "sticky off" refers to the entire mobile device, not to 
> any particular driver.

Where did I say that? The device is still running, playing your favorite
song collection for example. Still you probably do not want your car
keys compose and e-mail for you while you are jogging, thus the main
keypad would be forced off.

-- 
Dmitry
