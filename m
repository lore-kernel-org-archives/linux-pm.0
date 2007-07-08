From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Mon, 09 Jul 2007 07:03:32 +1000
Message-ID: <1183928612.3388.289.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0707072224270.10912-100000@netrider.rowland.org>
	<1183871661.3388.282.camel@localhost.localdomain>
	<200707082115.27363.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707082115.27363.rjw@sisk.pl>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org, Kyle Moffett <mrmacman_g4@mac.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sun, 2007-07-08 at 21:15 +0200, Rafael J. Wysocki wrote:
> On Sunday, 8 July 2007 07:14, Benjamin Herrenschmidt wrote:
> [--snip--]
> > 
> > I just think that the freezer approach, as it is, is backward. We can't
> > have a 3rd party try to discriminate what to freeze and what not, it
> > will always get something wrong, and in some cases with the wrong timing
> > or ordering.
> 
> Nice discussion, except for one thing: the freezer doesn't decide what to
> freeze.  For example, even right now kernel threads decide if they want to be
> frozen.

Somewhat... userspace doesn't and workqueues are a gray area.

Also, I've been thinking this "icebox" idea a bit more and it seems in
fact a bit racy in some areas, at least for use by things like drivers,
unless we end up doing something aking to an RCU on suspend, waiting for
all tasks to reach userland once, but that has the same annoyances as
the current freezer.

Thus I'm tempted to go back to saying that driver can handle things
locally :-)

Ben.
