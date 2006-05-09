From: David Brownell <david-b@pacbell.net>
Subject: Re: suspend and hibernate nomenclature
Date: Tue, 9 May 2006 08:57:06 -0700
Message-ID: <200605090857.07853.david-b@pacbell.net>
References: <1147024930.16057.3.camel@localhost.localdomain>
	<200605081647.55275.david-b@pacbell.net>
	<1147160320.2120.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============22344787495296314=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1147160320.2120.10.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: richard@hughsie.com
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============22344787495296314==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 09 May 2006 12:38 am, Richard Hughes wrote:
> Ohh, standby exists, but I don't think a user needs to understand this
> (or use this -- see below) in a desktop context.

I don't think I saw a real explanation for that "below".  You implied
that "standby" was mostly meaningful for embedded hardware; not so.

If the state is there and used, users will be aware of the distinction
between the two suspend states ("standby" and "suspend to RAM").  One
is quick to enter/exit, the other isn't.

Of course what I _would_ like to see is Linux distros that autosuspend,
entering "standby" after they're idle for a while and then, if they're
not woken up quickly enough, entering "suspend-to-RAM".  No point in
having laptops burn all that energy all the time, after all ... or
automagically inflicting long resume-from-STR latencies on them.

Admittedly we do have issues getting either of those states to work
lately in Linux, but at least "standby" should be trivial given even
a small fraction of the effort that's gone into swsusp/"hibernate".


> If you guys used a sleep name in the kernel
> sleep_for_not_longer_than_6_minutes_but_more_that_2_seconds() I really
> don't mind -- but if the user has to click a button, I would rather the
> button was marked suspend or hibernate :-)

Well "not_longer_yadda_yadda()" would be a bizarre model.  The user-visible
issue is the latency to suspend or resume ... where "standby" is quick, and
"suspend-to-RAM" is relatively slow.  Where "quick" is on the order of time
for users to finish switching their mental context, while "slow" is on the
order of doing that _plus_ doing something else to fill the wait time.  How
long the system stays in a given suspend state is immaterial to any issue
beyond how much power is saved.  (Which is only indirectly user visible,
e.g. stretching battery life out one more hour vs eight more.)

The "suspend" button could be more menu-like, and users could choose to
override whatever their default "suspend depth" is ... and set the default
to match their impatience (vs power savings).

- Dave




--===============22344787495296314==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============22344787495296314==--
