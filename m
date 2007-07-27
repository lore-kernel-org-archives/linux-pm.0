From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Power Management framework proposal
Date: Fri, 27 Jul 2007 12:04:54 +0000
Message-ID: <20070727120453.GE11895__30452.573989942$1185559791$gmane$org@ucw.cz>
References: <1185091022.19678.28.camel@localhost.localdomain>
	<Pine.LNX.4.64.0707220057210.6350@asgard.lang.hm>
	<1185105911.29238.43.camel@localhost.localdomain>
	<Pine.LNX.4.64.0707221156210.6350@asgard.lang.hm>
	<1185145766.2714.27.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.64.0707221914550.6350@asgard.lang.hm>
	<1185162647.2714.35.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.64.0707222054060.6350@asgard.lang.hm>
	<1185164357.2714.49.camel@laptopd505.fenrus.org>
	<20070723085636.GA4123@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20070723085636.GA4123@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ondrej Zajicek <santiago@crfreenet.org>
Cc: david@lang.hm, linux-pm <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > let me give you a real world example then, and the numbers I'm using are
> > ballpark the same as you'll find in a (mobile) core 2 duo datasheet, I
> > just rounded them a little so that the math works out nice.
> > 
> > power at full speed: 34W
> > power at half speed: 24W
> > power at idle: 1W
> 
> I have usually seen different numbers, for example:
> 
> http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/30430.pdf

Trust Arjan, modern cpus work as he describes.

> Although this paper speaks about thermal design power instead of power
> consumption, i suppose that it should be roughly equal.
> 
> For example Athlon 64 3700 (ADA3700AEP5AR):
> 
> 2.4 GHz, 1.5 V -> 89 W
> 2.2 GHz, 1.4 V -> 72 W
> 2.0 GHz, 1.3 V -> 53 W
> 1.8 GHz, 1.2 V -> 39 W
> 1.0 GHz, 1.1 V -> 22 W

I guess that means athlon 64 is 'old'.

> Even my measurement on PC (Athlon X2, VIA K8T890) of complete PC power
> consumption shows that it is more efficient to be busy for 2 time units
> on 1 GHz than be busy for 1 time unit and be idle for 1 time unit
> on 2 GHz.
> 
> 1 GHz:
> both cores idle:	48 W
> one core busy:		57 W
> two cores busy:		66 W

2 sec decoding video at both cores: 132J

> 2 GHz:
> both cores idle:	54 W
> one core busy:		78 W
> two cores busy:		95 W

1 sec decode @ 2GHz + 1 sec idle @ 1GHz: 143J

So even on your hw difference is not too big... and take a look at
numbers from core2duo.

Actually...

4 sec decode @ 1 core @ 1GHz: 57*4=228J
1 sec decode @ 2 cores @ 2GHz, then idle: 95 + 48*3 = 142+95 = 235J...

Ok, so it is still 	 win, but even smaller one..
							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
