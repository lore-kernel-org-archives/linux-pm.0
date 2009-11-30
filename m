From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 1/2] Input: gpio-keys - allow platform
	to	specify exact irq flags
Date: Mon, 30 Nov 2009 01:16:56 -0800
Message-ID: <20091130091656.GF10295__10489.9314967499$1259572679$gmane$org@core.coreip.homeip.net>
References: <87skbx34ba.fsf@tac.ki.iif.hu>
	<Pine.LNX.4.44L0.0911291103070.3165-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0911291103070.3165-100000@netrider.rowland.org>
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
Cc: linux-pm@lists.linux-foundation.org, Ferenc Wagner <wferi@niif.hu>, Mika Westerberg <mika.westerberg@iki.fi>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Nov 29, 2009 at 11:04:57AM -0500, Alan Stern wrote:
> On Sun, 29 Nov 2009, Ferenc Wagner wrote:
> 
> > Hi,
> > 
> > I thought we'd better ask our friends over at linux-pm, if they've got
> > some interface for this task.  To summarize: an embedded application
> > wants to go into a "locked" state, where some input devices (gpio keys
> > in this case) are "muted", ie. they don't even generate interrupts to
> > minimize power consumption.  This could be solved by adding a new
> > interface to gpio-keys, but the problem seems more general, so I wonder
> > if something like the USB selective runtime suspend is already available
> > (or preferable to develop) for such tasks.
> > 
> > (I hope I got the summary right; Mika will provide the missing bits if I
> > didn't.) 
> 
> See Documentation/power/runtime_pm.txt.  I don't know to what extent 
> the input layer has implemented any runtime PM.

Input layer is not implementing any PM since it consists of virtual, not
physical devices, and leaves PM for the appropriate bus drivers (USB,
serio, platform, etc.).

Also, it is not really runtime PM but rather user-initiated action of
putting device into lower poer state we are talking about here.

-- 
Dmitry
