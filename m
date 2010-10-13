From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC] input: syfs switches for SKE keypad
Date: Wed, 13 Oct 2010 10:57:37 +0100
Message-ID: <20101013095737.GI6424__3882.58670359409$1286963974$gmane$org@rakim.wolfsonmicro.main>
References: <20101012174942.GB10861@sirena.org.uk>
	<Pine.LNX.4.44L0.1010121425330.1705-100000@iolanthe.rowland.org>
	<33A307AF30D7BF4F811B1568FE7A9B180468A9419A@EXDCVYMBSTM006.EQ1STM.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <33A307AF30D7BF4F811B1568FE7A9B180468A9419A@EXDCVYMBSTM006.EQ1STM.local>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Sundar R IYER <sundar.iyer@stericsson.com>
Cc: "samu.p.onkalo@nokia.com" <samu.p.onkalo@nokia.com>, Linus WALLEIJ <linus.walleij@stericsson.com>, Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 13, 2010 at 08:16:20AM +0200, Sundar R IYER wrote:

> >> This isn't *really* about saving power in the individual device; it's
> >> more about stopping the device generating events that disrupt the rest
> >> of the system.  Suspending the device can be one way of doing that and
> >> is useful if it can be done but is not really the immediate goal here.

> >Runtime PM is _not_ a reliable way of preventing a device from
> >generating events.  It is meant for saving energy, nothing else.

> >If that's what this is about, then the answer is simple: Don't use
> >runtime PM to try to suppress events.

> I think it is unfair to discriminate here about saving power and turning off
> events. I believe putting the device into power save leads to, if device permits
> preventing generating events is valid to hook up run time PM.

This is the opposite way around to expectations - the expectation is
that runtime power management will flow from the device becoming idle
enough to turn off rather than the other way around.
