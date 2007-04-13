From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH v2] pm_ops: add system quiesce/activate hooks
Date: Fri, 13 Apr 2007 01:04:22 -0700
Message-ID: <200704130104.22635.david-b@pacbell.net>
References: <1175810054.3489.34.camel@johannes.berg>
	<461E6E07.5020408@gmail.com>
	<1176447294.7052.74.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1176447294.7052.74.camel@johannes.berg>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Johannes Berg <johannes@sipsolutions.net>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thursday 12 April 2007 11:54 pm, Johannes Berg wrote:
> On Thu, 2007-04-12 at 21:36 +0400, Dmitry Krivoschekov wrote:
> =

> > For example, I'd like to enter back to suspend mode
> > right from "activate" stage, because I've woken up just
> > to update some data and I do not want to resume all devices
> > for that, is it ok for "activate"?

That came up on the list a while back in some email from MontaVista, ISTR.
And ISTR some scientific or industrial system needed it too.


> I'd think that better be done within ->enter itself, no? Like putting a
> loop into ->enter:
> =

> do {
>   go to sleep;
> while (should sleep);

Better answer, yes.  Plus remember that the "activate" stage is at a
weird spot in the resume sequence:  some of the devices have been
resumed, but not all of them.

Surely if this "partial wakeup" scenario is needed, it's going to
be highly platform-specific which devices need to be resumed so
the relvant work can be done?


In fact, I wonder if a better way to look at this might not be
that it's not a real "system sleep" state so much as just a deep
runtime PM state ... the sort of thing that the idle loop ought
to be able to enter, in a system that's been quiesced far enough
because of NO_HZ, power-aware drivers, and general inactivity.
For some systems I'm relatively sure that'd be a good perspective: =

ones where the runtime PM is good enough.


Another solution recognized that the only work that was needed
was updating certain counters and GPIOs.  So the code that went
to sleep knew about various levels of wakeup; if it was just the
counting update, it left most clocks (and the DRAM!) off, and
went right back to sleep.  The real intelligence was in the
sleep logic called by enter().  The generalization was in that
down'n'dirty platform code; it had callouts to other code which =

also lived in the SRAM, and not every wake event caused return
from enter().

- Dave
