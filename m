From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 1/2] Input: gpio-keys - allow platform
	to	specify exact irq flags
Date: Wed, 9 Dec 2009 10:03:45 -0800
Message-ID: <20091209180345.GE4456__25504.4335303412$1260381936$gmane$org@core.coreip.homeip.net>
References: <Pine.LNX.4.44L0.0911300956400.4478-100000@iolanthe.rowland.org>
	<87einfltp3.fsf@tac.ki.iif.hu> <20091206084704.GC2766@ucw.cz>
	<20091208042251.GB11147@core.coreip.homeip.net>
	<1260277410.19669.84.camel@localhost>
	<20091208174218.GB14271@core.coreip.homeip.net>
	<1260343860.19669.1189.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1260343860.19669.1189.camel@localhost>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: Mika Westerberg <mika.westerberg@iki.fi>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Ferenc Wagner <wferi@niif.hu>
List-Id: linux-pm@vger.kernel.org

On Wed, Dec 09, 2009 at 09:31:00AM +0200, Artem Bityutskiy wrote:
> On Tue, 2009-12-08 at 09:42 -0800, Dmitry Torokhov wrote:
> > > > I also see that gpio-keys is quite different in the sence that it can
> > > > shut off buttons selectively. I fact, at the moment every button can be
> > > > considered a separate device... But that would be too much overhead.
> > > > 
> > > > They could probably split the keys into 2 groups (critical that should
> > > > be always active) and not critical, that could be shut off, but I think
> > > > they want teh flexibility of controlling this at runtime instead of
> > > > doing it in board data.
> > > 
> > > I suggested including this into the "abstract input device" model, but
> > > you refuse this. But I still think it is a good idea.
> > > 
> > > Indeed, if we look at an input device as at something abstract which has
> > > many keys, why we cannot assume that separate keys can be
> > > enabled/disabled? Just imagine you have a very advanced keybord :-) And
> > > we simply implement an ioctl which enables/disables a specific key. The
> > > generic layers just pass this ioctl down to the lower lever drivers. If
> > > the specific input device or driver support it - fine, if not - it
> > > returns -EINVAL or something like that.
> > 
> > I refuse it because it will be supported by exactly 1 driver in the
> > kernel - gpio-keys. It is the only driver that allows shut half of the
> > "device" (because in reality it is a group of disjoint devices). It is
> > the only case when "muting" a button means that IRQ is shut off abnd
> > thus CPU can continue to sleep if that button is pressed. For all other
> > devices that have 1 inettrupt per device, you still have to wake up,
> > because you don't know whether the button that generated event is
> > "important" or not.
> 
> Fair enough.
> 
> > Now, there is a issue of waking up userspace task, additional scheduling
> > and keeping CPU running longer than necessary for "uninteresting" keys.
> > This can be solved by implementing a subscription model which allows
> > filtering uninteresing events on a per-client basis at evdev level.
> 
> Right. And for gpio_keys, this would be dine on the driver level.

But the semantics are different - if done on driver level you'd be
affecting _all_  consumers of the device; what I want to be done only
affects owner of the file descriptor.

-- 
Dmitry
