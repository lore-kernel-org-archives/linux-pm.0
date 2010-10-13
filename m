From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC] input: syfs switches for SKE keypad
Date: Wed, 13 Oct 2010 22:26:02 +0200
Message-ID: <201010132226.02933.rjw__40737.1440007866$1287001771$gmane$org@sisk.pl>
References: <AANLkTi=ouKDuPgUgLOwfBPhWKM=RCoh8hb0tY3h53i2r@mail.gmail.com>
	<AANLkTikqNNY=gNC96ZEo5ar+Adw80h=M3_XGe3A--unu@mail.gmail.com>
	<AANLkTin0cLmmCyWuQS=OyrOVp-wTEmW65PRqR7S_ez4b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTin0cLmmCyWuQS=OyrOVp-wTEmW65PRqR7S_ez4b@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Sundar <sunder.svit@gmail.com>, Alan Stern <stern@rowland.harvard.edu>
Cc: "samu.p.onkalo@nokia.com" <samu.p.onkalo@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Linus WALLEIJ <linus.walleij@stericsson.com>, Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>, Sundar R IYER <sundar.iyer@stericsson.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday, October 13, 2010, Sundar wrote:
> On Wed, Oct 13, 2010 at 11:12 PM, Sundar <sunder.svit@gmail.com> wrote:
> > On Wed, Oct 13, 2010 at 11:07 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> >>
> >> Sorry, I don't quite understand your question.  I think it would be
> >> okay to add an interface for userspace to cut short a runtime-suspend
> >> delay, but I don't think anything more is needed.

I'm not 100% sure how that interface is supposed to work.  Can you elaborate
a bit, please?

> > I was just confirming that it is agreed by all that we can definitely wrap
> > this up via the standard PM helpers; through the accelerated suspend
> > if no one has any other reservations.
> >
> 
> And I forgot one more point. Since this switch feature was one of the
> requirements for the Meego framework, wouldnt it be nice if the Meego
> people also put out their opinions on this newer solution?

Yes, it would.

There's a PM track at the Linux Plumbers conference in a few weeks and I think
it would be good to discuss the issue in there.

Thanks,
Rafael
