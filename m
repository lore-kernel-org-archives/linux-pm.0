From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [GIT PULL] PM updates for 2.6.33
Date: Mon, 7 Dec 2009 21:47:13 +0100
Message-ID: <200912072147.13851.rjw__16454.8653563999$1260218939$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0912060953190.4442-100000@netrider.rowland.org>
	<200912071615.34788.rjw@sisk.pl>
	<alpine.LFD.2.00.0912070832330.3560@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0912070832330.3560@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday 07 December 2009, Linus Torvalds wrote:
> 
> On Mon, 7 Dec 2009, Rafael J. Wysocki wrote:
> > 
> > > The advantage: untouched drivers don't change ANY SEMANTICS AT ALL.
> > 
> > This also was true for my patchset.
> 
> That's simply not trye.
> 
> You set async_suspend on every single PCI driver. I object very heavily to 
> it.

That was a mistake, I admit.

However, it was done in a separate patch that (1) was not necessary and (2)
shouldn't have been there.  Sorry for making the mistake of including that into
the patchset.  So I understand your objection to that and let's not get back to
this again, ok?

> You also introduce this whole big "callback when ready", and 
> "non-topoligical PM dependency chain" thing. Which I also object to.

These things are also non-essential.  Acutally they wasn't there in the initial
version of my patches and were added after people had complained that it had
not been parallel enough and hadn't take the off-tree dependecies into account.

I could remove these things either and quite easily.

> Notice how with the simpler "lock parent" model, you _can_ actually encode 
> non-topological dependencies, but you do it by simply read-locking 
> whatever other independent device you want. So if an architecture has some 
> system devices that have odd rules, that architecture can simply encode 
> those rules in its suspend() functions.

I'm not arguing against that.  In fact, my only worry were that additional
suspend/resume callbacks I really wouldn't like to introduce.  But since you've
found a way of doing things without them, I'm totally fine with this approach.

> It doesn't need to expose it to the device layer - because the device 
> layer won't even care. The code will just automatically "do the right 
> thing" without even having that notion of PM dependencies at any other 
> level than the driver that knows about it.
> 
> No registration, no callbacks, no nothing.
>
> > In my patchset the drivers didn't need to do all that stuff.  The only thing
> > they needed, if they wanted their suspend/resume to be executed
> > asynchronously, was to set the async_suspend flag.
> 
> In my patchset, the drivers don't need to either.
> 
> The _only_ thing that would do this is something like the USB layer. We're 
> talking ten lines of code or so. And you get rid of all the PM 
> dependencies and all the infrastructure - because the model is so simple 
> that it doesn't need any.

It just uses a different way of representing these things, perhaps more
efficiently.

> (Well, except for the infrastructure to run things asynchronously, but 
> that was kind of my point from the very beginning: we can just re-use all 
> that existing async infrastructure. We already have that).

So I guess the only thing we need at the core level is to call
async_synchronize_full() after every stage of suspend/resume, right?

Rafael
