From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC] input: syfs switches for SKE keypad
Date: Tue, 12 Oct 2010 18:49:42 +0100
Message-ID: <20101012174942.GB10861__46891.7048223831$1286905954$gmane$org@sirena.org.uk>
References: <33A307AF30D7BF4F811B1568FE7A9B180468726AB4@EXDCVYMBSTM006.EQ1STM.local>
	<Pine.LNX.4.44L0.1010121117460.1705-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1010121117460.1705-100000@iolanthe.rowland.org>
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
Cc: "samu.p.onkalo@nokia.com" <samu.p.onkalo@nokia.com>, Linus WALLEIJ <linus.walleij@stericsson.com>, Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>, Sundar R IYER <sundar.iyer@stericsson.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 12, 2010 at 11:34:18AM -0400, Alan Stern wrote:

> Of course, if the device is idle then it's natural to ask why it isn't 
> already in low-power mode.  Maybe it's waiting for an autosuspend 
> timer to expire; anything else doesn't make much sense.

This isn't *really* about saving power in the individual device; it's
more about stopping the device generating events that disrupt the rest
of the system.  Suspending the device can be one way of doing that and
is useful if it can be done but is not really the immediate goal here.
