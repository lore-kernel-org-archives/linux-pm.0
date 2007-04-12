From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2] pm_ops: add system quiesce/activate hooks
Date: Thu, 12 Apr 2007 17:03:15 +0200
Message-ID: <200704121703.16206.rjw@sisk.pl>
References: <1175810054.3489.34.camel@johannes.berg>
	<20070412101653.GB26473@elf.ucw.cz>
	<1176377017.5764.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1176377017.5764.15.camel@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-pm@lists.linux-foundation.org, linux-pm <linux-pm@lists.osdl.org>, Johannes Berg <johannes@sipsolutions.net>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thursday, 12 April 2007 13:23, Benjamin Herrenschmidt wrote:
> On Thu, 2007-04-12 at 12:16 +0200, Pavel Machek wrote:
> =

> > Adding platform hook to disable interrupts just because we need one
> > platform device last is not nice, either. (And does decrementer even
> > need to come last?)
> > =

> > Anyway, platform devices may need specific ordering on more than power
> > pc, so perhaps we should just make ordering more stable so that
> > relying on it is no longer a hack?
> =

> It would be pretty hard to do cleanly without raping the core driver
> suspend/resume core.

Agreed.

> I have experience implementing suspend/resume in all sorts of
> environments, and I do strongly beleive that an arch hook right at this
> point will be useful to more than that anyway.
> =

> There are actions the arch code might need to take after drivers and
> before going to "atomic" mode (irqs off mean you can no longer sleep or
> take semaphores etc...), and in a similar vein, actions to take on
> resume just after interrupts are back and before all the drivers get
> woken up.
> =

> The decrementer is one example, there might be other processor specific
> bits or arch specific bits that are better done at that stage.
> =

> I think the way to go for 2.6.22 is to have that hook unless you can
> propose me a way to cleanly provide a platform device that is guaranteed
> to suspend last and resume first in all cases (and even then, I wouldn't
> be that happy since the proper decrementer stop procedure involves
> really wrapping the "irqs off" operation).
> =

> Why not give this added flexibility ? Archs who don't care don't need to
> bother and it will make us happy... it's not like we are about to -add-
> burden to other architectures.

Well, I think it would be reasonable to add the quiesce()/activate() hooks =
for
all of the above reasons.  However, once we've done that, it'll be quite
difficult to remove them, so we should better be sure they are really really
needed and there's no other way to implement what you need (or all of the
alternative ways are far worse).

Greetings,
Rafael
