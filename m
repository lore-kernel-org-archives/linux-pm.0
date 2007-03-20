From: David Brownell <david-b@pacbell.net>
Subject: Re: Alternative Concept
Date: Tue, 20 Mar 2007 13:17:45 -0700
Message-ID: <200703201317.46550.david-b@pacbell.net>
References: <44ECFF94.3030506@gmail.com> <45FFF697.8080101@gmail.com>
	<1174405005.25744.108.camel@Dogbert.NOE.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1174405005.25744.108.camel@Dogbert.NOE.nokia.com>
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
To: Igor Stoppa <igor.stoppa@nokia.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Tuesday 20 March 2007 8:36 am, Igor Stoppa wrote:

> Your approach is to just label policy what you want to kick out of the
> driver =3D) Nice one!

I had a similar reaction ... although, I was also wondering exactly
what benefit would come from kicking that stuff out of drivers, and
thus needing to rewrite/retest a lot of them.


> > Ok, seems you are happy with current clock framework and advocating it
> > to be as is.
>
> As I wrote several times i haven't seen yet a reason to replace it;
> certainly there is space for improvement but so far this proposal has
> not been on the lines of: how to improve the clk fw

Yes.  This thread is unfortunately very much a "where's the beef".
I was afraid that was what would happen, given the complete lack
of interface proposal.

I suspect that until some non-troll content is provided, I'll tune out.


> > Are you against addition some features to it, such as enable/disable =

> > "turn the unused clock off" rule,

That'd be what we call a "misfeature", or "bug".  Are you suggesting
this be done to the IRQ subsystem too?  It has a rule that unused
IRQs must be turned off.  Likewise that IRQs not used as wake events
shouldn't be enabled as wake events.  I hope you're not restricting
your addition of misfeatures to just the clock framework!


> > Besides that it is meaningless for you, do you have any technical
> > objections for that?
>
> Do you mean apart from the fact that it means hijacking the fw?
> Noooo, not at all.

I take it that was meant to be sarcasm...

Me, yes I have already presented technical objections, all of which
appear to have been ignored.


> But why is it meaningful to you? Why can't you interact with the entity
> that is actually controlling a certain clock, rather than with the clock
> itself?

Good question.  I hope that one doesn't get ignored, too.

- Dave
