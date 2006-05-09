From: Richard Hughes <hughsient@gmail.com>
Subject: Re: suspend and hibernate nomenclature
Date: Tue, 09 May 2006 08:38:40 +0100
Message-ID: <1147160320.2120.10.camel@localhost.localdomain>
References: <1147024930.16057.3.camel@localhost.localdomain>
	<200605081647.55275.david-b@pacbell.net>
Reply-To: richard@hughsie.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============54219437708639662=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200605081647.55275.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org, richard@hughsie.com
List-Id: linux-pm@vger.kernel.org

--===============54219437708639662==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2006-05-08 at 16:47 -0700, David Brownell wrote:
> One thing that doesn't seem right at all:  you suggest using the same
> name for the "standby" and "suspend to RAM" states.  Those are both
> different types of "suspend" states, as distinct from "hibernate"/swsusp
> states (which are types of power-off).

Well sort of. I was trying to explain that standby and suspend-to-ram
are similar enough for the user not to worry about the differences.

My point mainly was that standby is a bad name for suspend-to-ram, which
a few users and vendors have suggested, as it's different, and has been
used differently for ACPI.

> That wiki page has an assertion that both "standby" and "suspend-to-RAM"
> are bad names.  Maybe; but they're also the names that MS-Windows users have
> been trained to expect, so fighting against them (and hiding them even in
> explanations) isn't necessarily good.

Apple have different names too.

> But they are still distinctly different states, and if you don't expose
> both of them to users, then you'd be effectively preventing use of one
> of the two states.  And if power savings is a goal, that's ungood.  On
> embedded systems, there are lots of variants of "standby", and analogues
> of "suspend to RAM" can be hard to enter.

Ohh, standby exists, but I don't think a user needs to understand this
(or use this -- see below) in a desktop context.

> One suggestion might be to talk about how deeply the system is suspended;
> "light suspend" (standby) or "deep suspend" (suspend-to-RAM).  That could
> work well with the non-PC/non-ACPI/non-ACPI type of systems too, where
> there may well be several more types of "suspend" state than just those
> two, and no analague of "hibernate".  (Noted also by Scott Preece...)

At the moment I'm aiming the nomenclature at people using acpi, pmu, apm
etc on a desktop platform, rather than embedded people as the
requirements are very different. Think of just getting KDE and GNOME to
agree on something. :-)

For embedded (I'm guessing here), the use of standby for a super-quick
sleep and the use of suspend-x where x = 1-4 for the different states
may be needed, but at the moment I think the desktop user has enough to
understand.

If you guys used a sleep name in the kernel
sleep_for_not_longer_than_6_minutes_but_more_that_2_seconds() I really
don't mind -- but if the user has to click a button, I would rather the
button was marked suspend or hibernate :-)

Thanks for your comments.

Richard.



--===============54219437708639662==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============54219437708639662==--
