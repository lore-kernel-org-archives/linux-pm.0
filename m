From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: syncing the disks when entering sleep
Date: Thu, 11 Feb 2010 18:28:18 +0100
Message-ID: <201002111828.18861.rjw@sisk.pl>
References: <76FA3B279DD9DA48896E2B404944957204E0B241@USA7061MS02.na.xerox.net>
	<201002102019.26518.rjw@sisk.pl> <20100211150049.GB1434@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100211150049.GB1434@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.linux-foundation.org, Nigel Cunningham <ncunningham@crca.org.au>, "Leisner,
	Martin" <Martin.Leisner@xerox.com>
List-Id: linux-pm@vger.kernel.org

On Thursday 11 February 2010, Pavel Machek wrote:
> 
> > > Really? If so then it is misdesigned.
> > > 
> > > Before the "don't sync" proposal, it was okay to have multiple
> > > power managers.
> > > 
> > > Actually I have three on zaurus. There's in-kernel suspend on battery
> > > critical, then there's somehing userspace in desktop environment, and
> > > then I'm triggering suspends by hand using echo.
> > 
> > To be precise, 1 and 3 are things that override the power manager.
> > 
> > And if you override the power manager, you're supposed to know what you're
> > doing, aren't you?
> 
> I know what I'm doing, but I'd prefer traps not being set for me.

What are you talking about?  Either you set the knob or you don't.  If you
don't, nothing changes.

> > > > So really, I don't see anything wrong with a knob that will turn the kernel
> > > > sync off entirely, because that basically means "my user space is
> > > > not broken".
> > > 
> > > Because, very easily, parts of my users space may be broken.
> > 
> > How exactly would they be broken?
> 
> I have 3 power managers.

You don't.

> You called that broken before.

Because it is so.  Think about user space suspend hooks, for example, like
s2ram.  Surely your kernel emergency suspend can't use anything like this?

> How is power manager expected to work on zaurus, which suspends from
> kernel on battery critical? echo no > sync; sync; echo mem > state;
> echo yes > sync?
> 
> Its still racy..

Please refer to my reply to Oliver.

> > Why don't we just assume that the user who sets the knob knows what he's doing?
> >
> 
> Because better alternatives exist. Like 'echo mem:nosync > state'.

That is a sledgehammer.

I really don't understand your objections here and none of the "alternatives"
you've been talking about so far would be acceptable to me.

Rafael
