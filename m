From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Nested suspends; messages vs. states
Date: Wed, 23 Mar 2005 18:45:55 -0800
Message-ID: <200503231845.55392.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0503211436020.1241-100000@ida.rowland.org>
	<200503231058.54311.david-b@pacbell.net>
	<1111620276.16224.107.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============51479750462180984=="
In-Reply-To: <1111620276.16224.107.camel@gaston>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--===============51479750462180984==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 23 March 2005 3:24 pm, Benjamin Herrenschmidt wrote:
> On Wed, 2005-03-23 at 10:58 -0800, David Brownell wrote:
> > On Monday 21 March 2005 8:21 pm, Benjamin Herrenschmidt wrote:
> > > 
> > > Yup, the model we are desinging now should allow for arbitrary
> > > transitions I suppose as long  as the target state is legal vs. the
> > > dependencies.
> > 
> > Leading to the question:  how are the dependencies identified and
> > enforced?
> 
> I have proposed something, if you read my other mails, that should deal
> with most of the usual cases.

Some of those notions made sense to me, not all.  So far it's fair
to say there's more handwaving (from everyone!) than anything else;
no single concrete proposal to be refined, and made workable.


> > My current thought is that it's wrong to expect the PM core code to
> > do all this.  Discussion on this list strongly suggests to me that
> > we'll never achieve a Grand Unified Theory of PM into which every
> > device, bus, platform, and board will fit ... unless we give up
> > on the notion that _everything_ be centrally controlled.  The key
> > will be having good ways to delegate all the important issues.
> 
> The problem with your approach is since you have in mind those extremely
> weird embedded setups that can't fit in any sane model, you decide to
> reject any model that does anything useful at the core. I don't agree
> with your logic.

I hardly know where to start, given that baseless misrepresentation
of what I said.  I objected to centralizing "_everything_" and you
replaced those commonsense words with wild allegations about sanity.
Calm down; switch to de-caff...


Well, considering that I'm using examples from PCI and USB too,
I certainly couldn't characterize what I "have in mind" as all
"extremely wierd embedded setups".  And for that matter, taking
examples from widely used ARM hardware really doesn't seem to
be "extremely wierd" ... though it's certainly embedded.  

I'm just expecting that if there's going to be a common Linux
PM framework, it had better work for more than PCI and swsusp.
Even on typical PC hardware (which includes Mac/PPC!!), stuff like
USB wakeup events seems "extremely *mainstream*" in terms of what
the hardware does.

And the fact that some of those USB models fit well with more
embedded approaches ... hmm, interesting.  Paying attention to
those issues should thus be a general win...


> > So for example it would make sense to have device suspend() logic
> > verify any dependencies for the target state, and then just fail
> > cleanly if they're not satisfied.
> 
> How ? It doesn't have the necessary knowledge unless we start moving a
> lot of burden into drivers. And every time we'll move some algorithmic
> requirements like that to drivers, 99% of them will get it wrong.

99% of them have no dependencies to worry about!!  The remaining ones
are bridge drivers, which are already deeply worried about such stuff.
(And not getting a heck of a lot of support from Linux PM, either...)

(Oh, and only 83.7% of statistics are made up.)


> > That'll mostly be an issue for bridge drivers ... like PCI
> > bridges, host adapters for things like USB, hubs, and so on.
> 
> Bridges/busses have no knowledges of device states, they can't verify
> dependencies unless the devices expose their state list & dependency
> information in a meaningful way, which is exactly what I'm proposing.

I've proposed similar things too.   For those reasons; and others.


> > But it also shows a way to handle custom hardware, which may
> > not be as regular as the PC and server centric developers want
> > the world to be...
> 
> Yah, I know those, I have been doing embedded dev too, and in most
> cases, they aren't _that_ bad. And if they are ? well, they'll hack
> around like they do today.

No, not that bad.  But if the PM framework tries to delude itself
into thinking everything fits into one nice neat dependency tree, it
makes those solutions harder, uglier, and more error prone than
necessary.  The same kind of stuff happens on PCs too.


> > So, two types of request to drivers then.  The main one would be to
> > become compatible with a given system power state; flexible.  The
> > inflexible one would be to go into a specific device power state.
> 
> But a device power state has an impact on childs of this device, thus
> the dependency issue. I am not talking about system states here. Unless
> you want to completely phase out dyamic PM of busses...

If you've hogtied your system by forcing some devices ("busses") into
certain states that prevent others from working, it seems only fair to
me that it stay hogtied.

I suspect you're actually agreeing with me there that some of the
drivers need flexibility to manage their power states.  And maybe
even that such modes will be the main ones of interest...

My answer to the question of how those parent/child dependency
details should be managed was to ensure that the parent can do
what it needs to.  That is, decentralize those issues.  I don't
understand why you seem to dislike that approach, when so many
of your examples seem to confirm it would work.


> > The handful of drivers that deal with dependencies can be responsible
> > for that ordering.  They should be able to delegate much of the work
> > to PM core code (else why have a PM core?).
> 
> No, I don't agree. That would be huge code duplication with different
> kinds of bugs in <name all busses in linux, and that is a LOT> 

Now you're assuming that "delegate to the PM core" isn't fundamentally
about reusing only the code that _can_ be common.  Why is that?  It's
pretty opposite to how I read those words.  There's going to have to
be bus-specific ("bridge-specific") code.  And we need a way to draw
boundaries between that and the more reusable code in pmcore.

- Dave


--===============51479750462180984==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============51479750462180984==--
