From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Async suspend-resume patch w/ completions (was: Re:
	Async suspend-resume patch w/ rwsems)
Date: Sat, 12 Dec 2009 23:40:24 +0100
Message-ID: <200912122340.24749.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0912091729530.2672-100000@iolanthe.rowland.org>
	<alpine.LFD.2.00.0912121049390.3526@localhost.localdomain>
	<200912122334.08367.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912122334.08367.rjw@sisk.pl>
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

On Saturday 12 December 2009, Rafael J. Wysocki wrote:
> On Saturday 12 December 2009, Linus Torvalds wrote:
> > 
> > On Sat, 12 Dec 2009, Rafael J. Wysocki wrote:
> > > 
...
> 
> > And no, making _everything_ be async is _not_ the answer.
> 
> I'm not sure what you mean, really.
> 
> Speaking of PCI bridges, even though they don't "suspend" in the sense of
> being put into low power states or something, we still need to save their
> registers on suspend and restore them on resume, and that restore has to
> be done before we start to access devices below the bridge.

Of course we restore them at the early stage now so the above remark does't
apply to the patch in question, sorry.

But the one below does.

> Even if we move that all to drivers, the constraints won't go away and someone
> will have to take care of them.  Now, since _we_ have problems with reaching
> an agreement about how to do it, the driver writers will be even less likely to
> figure that out.

Rafael
