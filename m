From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Thu, 22 Jun 2006 11:04:10 +1000
Message-ID: <1150938250.16303.102.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0606211422450.8272-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0606211422450.8272-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Brownell <david-b@pacbell.net>, Linus Torvalds <torvalds@osdl.org>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Wed, 2006-06-21 at 14:53 -0400, Alan Stern wrote:
> In brief, I agree with almost everything you say...
> =

> On Wed, 21 Jun 2006, Linus Torvalds wrote:
> =

> > Well, naming this op seems to be really hard. In the end, I don't reall=
y =

> > care.
> > =

> > What I want is really to haev modular, independent calls, that tell dri=
ver =

> > writers _exactly_ what is going on, and why they should do so. =

> =

> Isn't it true the only a small minority of drivers need to do anything
> special during the save_state() callback?  In most cases all the necessary
> state is already stored in the driver.  So instead of making this a
> callback in struct device, how about creating a pre_suspend notifier chain
> for drivers to register on?  And ditto for freeze()/unfreeze() -- almost
> no drivers need to handle them.

I don't like notifier chains because of ordering issues :) Freeze on
some drivers implies stopping processing of requests (heh, just like
suspend !) at least on things like USB bus controllers, thus needs some
ordering between parent and child that is provided by the device-tree
walking, not by notifiers.

> There already is code present to manage this.  See the "wakeup" section
> in drivers/base/power/sysfs.c.

It's not very useable "generically" in practice in my experience.

> Hmm.  Be careful here.  The power level really isn't part of the "state"  =

> that gets saved by save_state(), is it?  After all, it is still subject to
> change from userspace after save_state() has finished.  It seems to me
> that (for STD at least) you would want to restore the power level as of
> the time immediately preceding the userspace/upper-layer freeze, not the
> power level at the time of save_state().

That and everything else. See my reply to Linus.

Ben.
