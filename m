From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Async suspend-resume patch w/ completions (was: Re:
 Async suspend-resume patch w/ rwsems)
Date: Sat, 19 Dec 2009 16:09:07 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912191557320.3712__26303.4590207555$1261267800$gmane$org@localhost.localdomain>
References: <Pine.LNX.4.44L0.0912091729530.2672-100000@iolanthe.rowland.org>
	<200912200040.18944.rjw@sisk.pl>
	<alpine.LFD.2.00.0912191542570.3712@localhost.localdomain>
	<200912200053.45988.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912200053.45988.rjw@sisk.pl>
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
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org



On Sun, 20 Dec 2009, Rafael J. Wysocki wrote:
> > 
> > Why would it be?
> 
> The embedded controller may depend on it.

Again, I say "why?"

Anything can be true. That doesn't _make_ everything true. There's no real 
reason why PnP/ACPI suspend/resume should really care.

We can try it. Not for 2.6.33, but by the 34 merge window maybe we'll have 
a patch-series that is ready to be tested, and that aggressively tries to 
do the devices that matter asynchronously.

So instead of you trying to make up some idiotic cross-device worries, 
just see if those worries have any actual background in reality. So far I 
haven't actually heard anything but "in theory, anything is possible", 
which is such a truism that it's not even worth voicing.

That said, I still get the feeling that we'd be even better off simply 
trying to avoid the whole keyboard reset entirely. Apparently we do it for 
a few HP laptops. It's entirely possible that we'd be better off simply 
not _doing_ the slow thing in the first place.

For example, we may be _much_ better off doing that whole keyboard reset 
at resume time than at suspend time. That's what we do when we probe 
things on initialization - and the resume-time keyboard code is actually 
already asynchronous, it does that atkbd_reconnect asynchronously by 
queuing it as an event.

So again, all these problems may not at all be fundamnetal problems: the 
keyboard driver does certain things, but there is no guarantee that it 
_needs_ to do those things. Turning the driver async may be totally the 
wrong thing to do, when we could potentially fix latency problems at the 
driver level instead.

			Linus
