From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC] input: syfs switches for SKE keypad
Date: Tue, 12 Oct 2010 19:30:08 +0100
Message-ID: <20101012183008.GJ30933__3951.55292139879$1286908616$gmane$org@rakim.wolfsonmicro.main>
References: <20101012174942.GB10861@sirena.org.uk>
	<Pine.LNX.4.44L0.1010121425330.1705-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1010121425330.1705-100000@iolanthe.rowland.org>
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

On Tue, Oct 12, 2010 at 02:27:21PM -0400, Alan Stern wrote:
> On Tue, 12 Oct 2010, Mark Brown wrote:

> > This isn't *really* about saving power in the individual device; it's
> > more about stopping the device generating events that disrupt the rest
> > of the system.  Suspending the device can be one way of doing that and
> > is useful if it can be done but is not really the immediate goal here.

> Runtime PM is _not_ a reliable way of preventing a device from 
> generating events.  It is meant for saving energy, nothing else.

Right, yes.

> If that's what this is about, then the answer is simple: Don't use 
> runtime PM to try to suppress events.

I tend to agree that runtime PM usage ought to fall out of the disabling
of the input device rather than the other way around.
