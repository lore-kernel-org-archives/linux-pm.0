From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Async suspend-resume patch w/ completions (was: Re:
	Async suspend-resume patch w/ rwsems)
Date: Sun, 20 Dec 2009 00:53:45 +0100
Message-ID: <200912200053.45988.rjw__36437.075402546$1261266881$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0912091729530.2672-100000@iolanthe.rowland.org>
	<200912200040.18944.rjw@sisk.pl>
	<alpine.LFD.2.00.0912191542570.3712@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0912191542570.3712@localhost.localdomain>
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
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sunday 20 December 2009, Linus Torvalds wrote:
> 
> On Sun, 20 Dec 2009, Rafael J. Wysocki wrote:
> > 
> > OK, so this means we can just forget about suspending/resuming i8042
> > asynchronously, which is a pity, because that gave us some real suspend
> > speedup on my test systems.
> 
> No. What it means is that you shouldn't try to come up with these idiotic 
> scenarios just trying to make trouble for yourself,

I haven't.  I've just asked Dmitry for his opinion and got it.  The fact that
you don't like it doesn't mean it's actually "idiotic".

> and using it as an excuse for crap.

I'm not sure what you mean exactly, but whatever.

> I suggest you try to treat the i8042 controller async, and see if it is 
> problematic.

I already have and I don't see problems with it, but quite obviously I can't
test all possible configurations out there.

> If it isn't, don't do that then. But we actually have no real 
> reason to believe that it would be problematic, at least on a PC where the 
> actual logic is on the SB (presumably behind the LPC controller).
> 
> Why would it be?

The embedded controller may depend on it.
 
Rafael
