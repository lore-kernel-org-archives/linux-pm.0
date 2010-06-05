From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: suspend blockers & Android integration
Date: Sun, 6 Jun 2010 00:52:21 +0200
Message-ID: <201006060052.21501.rjw__41112.2740516022$1275778324$gmane$org@sisk.pl>
References: <20100603193045.GA7188@elte.hu>
	<20100605152326.7ccd5160@infradead.org>
	<AANLkTinRH52dSTPCAO9k1yEFup1LLYizeinunxeTBzbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTinRH52dSTPCAO9k1yEFup1LLYizeinunxeTBzbQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Brian Swetland <swetland@google.com>
Cc: tytso@mit.edu, Andrew Morton <akpm@linux-foundation.org>, Florian Mickler <florian@mickler.org>, Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, Neil Brown <neilb@suse.de>, James Bottomley <James.Bottomley@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux PM <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Felipe Balbi <felipe.balbi@nokia.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Sunday 06 June 2010, Brian Swetland wrote:
> On Sat, Jun 5, 2010 at 3:23 PM, Arjan van de Ven <arjan@infradead.org> wrote:
> >>
> >> We clearly have different standards for what we consider good. We
> >> measure time suspended in minutes or hours, not seconds, and waking up
> >> every second or two causes a noticeable decrease in battery life on
> >> the hardware we have today.
> >
> > I guess I'm spoiled working with (unreleased) hardware that knows how
> > to power gate ;-)
> 
> I'm continually surprised by answers like this.  We run on hardware
> that power gates very aggressively and draws in the neighborhood of
> 1-2mA at the battery when in the lowest state (3-5mA while the radio
> is connected to the network and paging).  Waking up out of that lowest
> state and executing code every few seconds or (worse) several times a
> second) will raise your average power consumption.  Being able to stay
> parked at the very bottom for minutes or hours at a time when nothing
> "interesting" is happening is very useful and can have a significant
> impact on overall battery life.

Yes, and if you look at the approach I proposed in this very thread
(http://lkml.org/lkml/2010/6/4/368), it goes exactly in this direction.

And I think it is superior to the opportunistic suspend framework you have
right now, because, for example, it doesn't require you to carry out full
system resume and full system suspend every once a while to check battery
status.

And guess what, suspending and resuming the whole system actually uses energy.

Rafael
