From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] input: syfs switches for SKE keypad
Date: Tue, 12 Oct 2010 14:27:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1010121425330.1705-100000__40078.14623551$1286908354$gmane$org@iolanthe.rowland.org>
References: <20101012174942.GB10861@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20101012174942.GB10861@sirena.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "samu.p.onkalo@nokia.com" <samu.p.onkalo@nokia.com>, Linus WALLEIJ <linus.walleij@stericsson.com>, Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>, Sundar R IYER <sundar.iyer@stericsson.com>
List-Id: linux-pm@vger.kernel.org

On Tue, 12 Oct 2010, Mark Brown wrote:

> On Tue, Oct 12, 2010 at 11:34:18AM -0400, Alan Stern wrote:
> 
> > Of course, if the device is idle then it's natural to ask why it isn't 
> > already in low-power mode.  Maybe it's waiting for an autosuspend 
> > timer to expire; anything else doesn't make much sense.
> 
> This isn't *really* about saving power in the individual device; it's
> more about stopping the device generating events that disrupt the rest
> of the system.  Suspending the device can be one way of doing that and
> is useful if it can be done but is not really the immediate goal here.

Runtime PM is _not_ a reliable way of preventing a device from 
generating events.  It is meant for saving energy, nothing else.

If that's what this is about, then the answer is simple: Don't use 
runtime PM to try to suppress events.

Alan Stern
