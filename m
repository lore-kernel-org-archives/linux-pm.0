From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 28 May 2010 16:24:57 +0100
Message-ID: <20100528162457.6f655695__35225.0877338976$1275059961$gmane$org@lxorguk.ukuu.org.uk>
References: <Pine.LNX.4.44L0.1005271730180.3239-100000@iolanthe.rowland.org>
	<20100527230806.4deb6de3@lxorguk.ukuu.org.uk>
	<20100527220949.GB10602@srcf.ucam.org>
	<20100527232357.6d14fdb2@lxorguk.ukuu.org.uk>
	<AANLkTil6Bo7qZltbLzHJjIDyruKHFQEURpe5LPJEpTws@mail.gmail.com>
	<20100528101755.7b5f6b8a@lxorguk.ukuu.org.uk>
	<AANLkTilYHKKmQePBGW3LVLjUZy7HXHQku2Iub-LWGBm6@mail.gmail.com>
	<20100528132138.2d802d77@lxorguk.ukuu.org.uk>
	<20100528123110.GA23930@srcf.ucam.org>
	<20100528145420.1c06e4a3@lxorguk.ukuu.org.uk>
	<20100528140237.GD25798@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-14"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100528140237.GD25798@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Mailing List <linux-omap@vger.kernel.org>, Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux@smtp1.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>, Peter@smtp1.linux-foundation.org, Linux PM <linux-pm@lists.linux-foundation.org>, felipe.balbi@nokia.com
List-Id: linux-pm@vger.kernel.org

On Fri, 28 May 2010 15:02:37 +0100
> Ok, I think I've misunderstood you. You're actually saying that only =

> applications that are trusted to behave well are allowed to receive =

> wakeup events? Yes, that makes implementation significantly easier. If =


To receive them in a manner that they are permitted to defer a suspend.
There is non reason why bouncing cows shouldn't get to see an event, but
there is always the miniscule possibility that we choose to suspend as it
gets the event.

That to me seems fine. Our starting basis was

- Bouncing cows is not trusted

Android's reaction was

- We reserve the right to suspend bouncing cows where it likes it or not

The caveat becomes

- Bouncing cows may get suspended then get an event when the phone wakes
  back up. So I might press "Moo" just before a suspend and get the noise
  when it resumes.

Given the untrusted cows could respond to the event otherwise by blocking
the suspend for as long as permitted with a suspend blocker or similar
that seems no worse. In this case probably better [oof zap! as opposed to
60 seconds of 'event, no sorry got a cow to draw at 100% CPU')

As the app is untrusted we can't assume they would get suspend blockers
right even if they had any.

You can still be nice to the cows app and when the phone is put down send
it a 10 second warning via dbus or Android equivalents.

Your trusted call handling app can still request (by QoS or big hammers)
that the phone does not suspend even if the app goes idle (because you
have a wakeup latency QoS)

A na=EFve trusted app will behave according to power management idling to
suspend and get stopped

A na=EFve untrusted app that is doing sane things will spend most of its
life asleep and behave.
