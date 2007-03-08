From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 0/3] swsusp: Do not use page flags (was:
	Re: Remove page flags for software suspend)
Date: Thu, 8 Mar 2007 23:54:45 +0100
Message-ID: <200703082354.46001.rjw@sisk.pl>
References: <Pine.LNX.4.64.0702160212150.21862@schroedinger.engr.sgi.com>
	<200703082333.06679.rjw@sisk.pl>
	<1173393815.3831.29.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1173393815.3831.29.camel@johannes.berg>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Pavel Machek <pavel@ucw.cz>, linux-mm@kvack.org, Christoph Lameter <clameter@engr.sgi.com>, pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, 8 March 2007 23:43, Johannes Berg wrote:
> On Thu, 2007-03-08 at 23:33 +0100, Rafael J. Wysocki wrote:
> =

> > > Unfortunately I won't be able to actually try this on hardware until =
the
> > > 20th or so.
> > =

> > OK, it's not an urgent thing. ;-)
> =

> True :)
> =

> > Well, I don't think so.  If I understand the definition of system_state
> > correctly, it is initially equal to SYSTEM_BOOTING.  Then, it's changed=
 to
> > SYSTEM_RUNNING in init/main.c after the bootmem has been freed.
> =

> No, I think you're confusing bootmem with initmem right now.

Yes, you're right, sorry.

> If you actually look at the code then free_all_bootmem is called as part =
of
> mem_init() on powerpc, which is called from start_kernel() a long time
> before initcalls are done and system state is set.
> =

> Put it this way. By the time initcalls are done, I can no longer use
> bootmem. I tested this and it panics. But if you look at the code in
> init/main.c, system_state is only changed after initcalls are done.

That's true.

In that case your patch seems to be the simplest one and I think it should =
go
along with some code that will actually use it.

Rafael
