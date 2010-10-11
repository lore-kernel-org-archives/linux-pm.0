From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] input: syfs switches for SKE keypad
Date: Mon, 11 Oct 2010 17:54:27 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1010111739580.16765-100000__37513.4858339608$1286834196$gmane$org@netrider.rowland.org>
References: <20101011170733.GA27304@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20101011170733.GA27304@core.coreip.homeip.net>
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

> > > > Can you give any examples where "sticky off" is really useful (other
> > > > than just for debugging)?
> > > > 
> > > 
> > > A mobile device might have a set of keys that, once device is put into
> > > lower power mode, should not bring the device out of that mode. This I
> > > would call a "sticky off" case.
> > 
> > But here the "sticky off" refers to the entire mobile device, not to 
> > any particular driver.
> 
> Where did I say that?

Just above.  The difficulty here is caused by the fact that you used
the word "device" instead of "system".  You wrote "... should not bring
the device out of that mode", with the word "device" referring back to
"a mobile device" -- which is the entire system.  That is, we have the
mobile system and we have the keypad device; calling the mobile system
a "device" leads to confusion.

>  The device is still running, playing your favorite
> song collection for example. Still you probably do not want your car
> keys compose and e-mail for you while you are jogging, thus the main
> keypad would be forced off.

Then I can't answer this question without knowing more about how the 
keypad works.

	Does suspending the keypad truly put it in low-power mode?

	What happens if a key is pressed while the keypad is suspended?

	Do you want to prevent all the keys from working or just some 
	of them?

	How would the user un-suspend the keypad if the system no 
	longer responds to keystrokes?

Alan Stern
