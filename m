From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH] Block on access to temporarily unavailable
	pci device
Date: Wed, 18 Oct 2006 11:14:18 -0600
Message-ID: <20061018171418.GV22289@parisc-linux.org>
References: <20061017145146.GJ22289@parisc-linux.org>
	<45354A59.3010109@us.ibm.com>
	<20061018145104.GN22289@parisc-linux.org>
	<1161186652.9363.68.camel@localhost.localdomain>
	<20061018162042.GT22289@parisc-linux.org>
	<1161189592.9363.81.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <1161189592.9363.81.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Brian King <brking@us.ibm.com>, linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, Adam Belay <abelay@MIT.EDU>
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 18, 2006 at 05:39:52PM +0100, Alan Cox wrote:
> > The current user is limited to a two-second delay and the one I'm
> > proposing introducing is a delay measued in milli- or microseconds.
> > An extra two-second delay while you BIST your IPR device and change
> > modes in X at the same time (does X really scan all devices when it's
> > changing mode settings?  That's odd) doesn't strike me as a huge failur=
e.
> =

> X scans all the devices when it sets up so only a video device one would
> hang mid mode set.

OK.  So the only possible X interaction currently is a D-state transition.

> > You fail the operation if it returns busy.  Or you loop.  It's really up
> > to you, the driver author.  You know what operation you're trying to do,
> > you know what makes more sense.
> =

> But I've no idea who, what or why and that makes it hard to handle. If
> the thing refcounts then if there are two reasons to be blocked we are
> fine and the last reason goes away we resume - it does make it more easy
> to make mistakes. If it isnt ref counting I'd prefer block repeated is a
> BUG() not a "driver figure this out"

Thinking about this a bit more, we only *need* to block userspace from
accessing a device while it's going to cause lockups if we access the
device.  And we'll cause the lockup ourselves if we try to do more than
one of these operations at a time.  So BUG_ON is clearly the right
approach.  Of course, the backtrace might well finger the wrong culprit --
if someone forgot to release the block earlier, it'll catch the second
attempt rather than the missed (or infinitely delayed) unblock.  I don't
think it matters too much, and I don't see a nice way to capture the
other task (do a backtrace to a buffer somewhere in a special debug mode
...?)
