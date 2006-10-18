From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Block on access to temporarily unavailable
	pci device
Date: Wed, 18 Oct 2006 17:39:52 +0100
Message-ID: <1161189592.9363.81.camel@localhost.localdomain>
References: <20061017145146.GJ22289@parisc-linux.org>
	<45354A59.3010109@us.ibm.com> <20061018145104.GN22289@parisc-linux.org>
	<1161186652.9363.68.camel@localhost.localdomain>
	<20061018162042.GT22289@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20061018162042.GT22289@parisc-linux.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Brian King <brking@us.ibm.com>, linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, Adam Belay <abelay@MIT.EDU>
List-Id: linux-pm@vger.kernel.org

Ar Mer, 2006-10-18 am 10:20 -0600, ysgrifennodd Matthew Wilcox:
> I don't see how that's possible.  If the driver forgets to call
> pci_unblock_user_cfg_access(), that's a bug in the kernel driver.

Lets leave bugs aside thats a different problem. The goal isn't to be
bug proof

> The current user is limited to a two-second delay and the one I'm
> proposing introducing is a delay measued in milli- or microseconds.
> An extra two-second delay while you BIST your IPR device and change
> modes in X at the same time (does X really scan all devices when it's
> changing mode settings?  That's odd) doesn't strike me as a huge failure.

X scans all the devices when it sets up so only a video device one would
hang mid mode set.

> You fail the operation if it returns busy.  Or you loop.  It's really up
> to you, the driver author.  You know what operation you're trying to do,
> you know what makes more sense.

But I've no idea who, what or why and that makes it hard to handle. If
the thing refcounts then if there are two reasons to be blocked we are
fine and the last reason goes away we resume - it does make it more easy
to make mistakes. If it isnt ref counting I'd prefer block repeated is a
BUG() not a "driver figure this out"

> It seemed to me there was consensus that blocking was a better approach
> than returning a cached value or returning an error.  If we're
> decided that returning a cached value is the better approach, then
> the patch to fix it is trivial; move the pci_set_state() call from the
> pci_block_user_cfg_access() function to the IPR driver.  Done and dusted.

That would have been my choice but the blocking approach seems to be
getting somewhere so it seems worth thrashing out in full.
