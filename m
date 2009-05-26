From: Nigel Cunningham <nigel@tuxonice.net>
Subject: Re: [TuxOnIce-devel] [RFC] TuxOnIce
Date: Tue, 26 May 2009 10:39:34 +1000
Message-ID: <1243298374.16743.161.camel__31737.5458348126$1243298324$gmane$org@nigel-laptop>
References: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
	<200905252343.23744.rjw@sisk.pl>
	<1243288705.16743.129.camel@nigel-laptop>
	<200905260039.43626.rjw@sisk.pl>
Reply-To: nigel@tuxonice.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200905260039.43626.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, tuxonice-devel@lists.tuxonice.net, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi.

On Tue, 2009-05-26 at 00:39 +0200, Rafael J. Wysocki wrote:
> [Restored CCs.]

Oh, sorry.

> On Monday 25 May 2009, Nigel Cunningham wrote:
> > Hi.
> > 
> > On Mon, 2009-05-25 at 23:43 +0200, Rafael J. Wysocki wrote:
> > > On Monday 25 May 2009, Nigel Cunningham wrote:
> > > > On Sat, 2009-05-09 at 01:43 +0200, Rafael J. Wysocki wrote:
> > > > > > On Sat, 2009-05-09 at 00:46 +0200, Rafael J. Wysocki wrote:
> > > > > > > On Friday 08 May 2009, Nigel Cunningham wrote:
> > > > > > > > On Fri, 2009-05-08 at 16:11 +0200, Rafael J. Wysocki wrote:
> > > > > > > > > On Friday 08 May 2009, Nigel Cunningham wrote:
> > > > > > > > And the code includes some fundamental differences. I freeze processes
> > > > > > > > and prepare the whole image before saving anything or doing an atomic
> > > > > > > > copy whereas you just free memory before doing the atomic copy. You save
> > > > > > > > everything in one part whereas I save the image in two parts.
> > > > > > > 
> > > > > > > IMO the differences are not that fundamental.  The whole problem boils down
> > > > > > > to using the same data structures for memory management and I think we can
> > > > > > > reach an agreement here.
> > > > > > 
> > > > > > I think we might be able to agree on using the same data structures, but
> > > > > > I'm not so sure about algorithms - I think you're underestimating the
> > > > > > differences here.
> > > > > 
> > > > > Well, which algorithms do you have in mind in particular?
> > > > 
> > > > Sorry for the slow reply - just starting to catch up after time away.
> > > 
> > > NP
> > > 
> > > > The main difference is the order of doing things. TuxOnIce prepares the
> > > > image after freezing processes and before the atomic copy. It doesn't
> > > > just do that so that it can store a complete image of memory. It also
> > > > does it because once processes are frozen, the only thing that's going
> > > > to allocate storage is TuxOnIce,
> > > 
> > > This is quite strong statement.  Is it provable?
> > 
> > Yes - just account for memory carefully. Check that everything that gets
> > allocated by hibernation code (or code it calls) gets freed and compare
> > the amount of memory free at the start of a cycle with the amount at the
> > end. I haven't done it for a while, but it was perfectly doable.
> 
> Well, this really doesn't answer my question.
> 
> What you're saying is basically "we can verify experimentally that in the
> majority of cases the statement holds", but I doesn't really mean "it always
> holds", which I'd like to be sure of.

Well, we can never be sure that it always holds or will always hold,
because we're playing on a constantly changing pitch.

> So, in fact, we'll need to think about safeguards that may be necessary in case
> it doesn't hold in some strange, presumably very rare and very improbable
> situation.
> 
> Assume for a while that there is a situation in which something other than
> us is allocating storage during hibernation.  How can we protect ourselves from
> that?

The possibilities I see are:

1) Assume we can't know exactly how much but can allow a ball-park
figure (current method)
2) Implement a means by which components that might allocate memory can
tell us how much they might allocate (currently used internally by
tuxonice - part of the modular design). I'd love to see this for the
drivers' suspend code.

> > > > and the only things that are going to allocate RAM are TuxOnIce and the
> > > > drivers' suspend routines.
> > > 
> > > Hmm.  What about kernel threads that are not frozen?
> > 
> > As I said above, I haven't done it for a while, but when I did, they did
> > not seem to allocate any memory - at least not for any significant
> > period of time. Even if they do, small amounts can also be covered by
> > the allowance for memory for drivers' suspend routines.
> 
> I don't think experimental verification is really sufficient in this case too.
> 
> Either we're sure that something is impossible, in which case we need to know
> exactly why it is impossible, or we aren't, in which case we should do
> something to protect ourselves in case it _does_ happen after all.

I agree - that's the extra pages allowance. We need to think also about
the consequences if our assumptions aren't met: retry / abort etc (not
oops!)

> > > > The drivers' routines are pretty consistent - once you've seen how much is
> > > > used for one invocation, you can add a small margin and call that the
> > > > allowance to use for all future invocations. The amount of memory used
> > > > by the hibernation code is also entirely predictable - once you know the
> > > > characteristics of the system as it stands (ie with processes frozen),
> > > > you know how much you're going to need for the atomic copy and for doing
> > > > I/O. If you find that something is too big, all you need to do is thaw
> > > > kernel threads and free some memory until you fit within constraints or
> > > > (heaven forbid!) find that you're not getting anyway and so want to give
> > > > up on hibernating all together.
> > > > 
> > > > If, on the other hand, you do the drivers suspend etc and then look to
> > > > see what state you're in, well you might need to thaw drivers etc in
> > > > order to free memory before trying again. It's more expensive. Right now
> > > > you're just giving up in that case - yes, you could retry too instead of
> > > > giving up completely, but it's better IMHO to seek to get things right
> > > > before suspending drivers.
> > > > 
> > > > Oh, before I forget to mention and you ask - how to know what allowance
> > > > for the drivers? I use a sysfs entry - the user then just needs to see
> > > > what's needed on their first attempt, set up a means of putting that
> > > > value in the sysfs file in future (eg /etc/hibernate/tuxonice.conf) and
> > > > then forget about it.
> > > 
> > > OK, this is reasonable.
> > > 
> > > Still, I think your approach is based on some assumptions that need to be
> > > verified, so that either we are 100% sure they are satisfied, or we have some
> > > safeguards in place in case they aren't.
> > 
> > Well, the 'extra pages allowance' as I call the memory for drivers'
> > suspend routines is the safeguard. I'll see if I can find some time to
> > get some real-life numbers to prove my argument.
> 
> I don't really think it's a good idea to focus on testing in this case, because
> our testing will only cover several specific configurations.
> 
> Instead, I'd like to design things so that the assumptions are verified as we
> progress and something special is done if they happen to be not satisfied.
> If you think they are almost surely satisfied in all practically relevant
> situations, that "something" may be to fail hibernation and roll back to the
> working state.  If it never happens in practice, that's just fine.  Still, IMO
> we can't just say "this never happens" without saying why _exactly_ this is the
> case.

I certainly agree with trying to make things as predictable and
verifiable as possible, but we're not going to achieve that aim
perfectly here - there are too many other factors in play.

The best I can say is that using an extra pages allowance has worked for
myself and TuxOnIce users for at least a few years. Once you've done a
cycle or two, you know what to expect. I know this isn't absolute
certainty, but as I said above, we're interacting with other kernel
components that are blackboxes - at least at the moment.

Here's a sample from my current uptime:

[12332.828552] - Extra pages    : 925 used/2000.
[70306.923183] - Extra pages    : 733 used/2000.
[122425.410490] - Extra pages    : 1071 used/2000.
[126085.467695] - Extra pages    : 813 used/2000.
[132305.803287] - Extra pages    : 813 used/2000.
[132405.761118] - Extra pages    : 842 used/2000.
[140444.647812] - Extra pages    : 930 used/2000.
[204239.996133] - Extra pages    : 832 used/2000.

Regards,

Nigel
