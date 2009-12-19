From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Async suspend-resume patch w/ completions (was: Re:
	Async suspend-resume patch w/ rwsems)
Date: Sun, 20 Dec 2009 00:40:18 +0100
Message-ID: <200912200040.18944.rjw__1256.89157653159$1261266098$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0912091729530.2672-100000@iolanthe.rowland.org>
	<200912200010.19899.rjw@sisk.pl>
	<alpine.LFD.2.00.0912191521180.3712@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0912191521180.3712@localhost.localdomain>
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
> > Well, I guess this is the example of the off-tree dependencies that actually
> > matter Linus wanted. :-)
> 
> It's also the kind of dependency where I say "if we get into these kinds 
> of messes, then the whole async crap isn't worth it".
> 
> Really. Having to try to match things up with ACPI and PnP is a nightmare. 
> Especially since I doubt Windows does anything like this, which means that 
> there's no reason for BIOS vendors to do the tables so that we'd even 
> know.

OK, so this means we can just forget about suspending/resuming i8042
asynchronously, which is a pity, because that gave us some real suspend
speedup on my test systems.

Well, whatever.

So, seriously, do you think it makes sense to do asynchronous suspend at all?
I'm asking, because we're likely to get into troubles like this during suspend
for other kinds of devices too and without resolving them we won't get any
significant speedup from asynchronous suspend.

That said, to me it's definitely worth doing asynchronous resume with the
"start asynch threads upfront" modification, as the results of the tests show
that quite clearly.  I hope you agree.

Rafael
