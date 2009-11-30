From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v2 1/2] Input: gpio-keys - allow platform to
 specify exact irq flags
Date: Mon, 30 Nov 2009 10:00:19 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0911300956400.4478-100000__2410.09989190406$1259593380$gmane$org@iolanthe.rowland.org>
References: <20091130091656.GF10295@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091130091656.GF10295@core.coreip.homeip.net>
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
Cc: linux-pm@lists.linux-foundation.org, Ferenc Wagner <wferi@niif.hu>, Mika Westerberg <mika.westerberg@iki.fi>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 30 Nov 2009, Dmitry Torokhov wrote:

> On Sun, Nov 29, 2009 at 11:04:57AM -0500, Alan Stern wrote:
> > On Sun, 29 Nov 2009, Ferenc Wagner wrote:
> > 
> > > Hi,
> > > 
> > > I thought we'd better ask our friends over at linux-pm, if they've got
> > > some interface for this task.  To summarize: an embedded application
> > > wants to go into a "locked" state, where some input devices (gpio keys
> > > in this case) are "muted", ie. they don't even generate interrupts to
> > > minimize power consumption.  This could be solved by adding a new
> > > interface to gpio-keys, but the problem seems more general, so I wonder
> > > if something like the USB selective runtime suspend is already available
> > > (or preferable to develop) for such tasks.
> > > 
> > > (I hope I got the summary right; Mika will provide the missing bits if I
> > > didn't.) 
> > 
> > See Documentation/power/runtime_pm.txt.  I don't know to what extent 
> > the input layer has implemented any runtime PM.
> 
> Input layer is not implementing any PM since it consists of virtual, not
> physical devices, and leaves PM for the appropriate bus drivers (USB,
> serio, platform, etc.).
> 
> Also, it is not really runtime PM but rather user-initiated action of
> putting device into lower poer state we are talking about here.

This is in fact the definition of runtime PM -- except for the
"user-initiated" restriction (runtime PM can be initiated by anything
or anybody).  So it really _is_ runtime PM.

But if you prefer to implement it without using the runtime PM 
framework, that's fine.

Alan Stern
