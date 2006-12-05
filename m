From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Suspend-devel] [PATCH -mm 2/2]: PM: SMP-safe freezer
Date: Tue, 5 Dec 2006 12:14:47 +0100
Message-ID: <200612051214.47380.rjw@sisk.pl>
References: <200612032318.29030.rjw@sisk.pl> <20061204194401.GA4199@ucw.cz>
	<200612042143.19264.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200612042143.19264.david-b@pacbell.net>
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
To: David Brownell <david-b@pacbell.net>
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, linux-pm@lists.osdl.org, Stephen Hemminger <shemminger@osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 5 December 2006 06:43, David Brownell wrote:
> [ off $SUBJECT ]
> =

> On Monday 04 December 2006 11:44 am, Pavel Machek wrote:
> > > But I think I'll need to add TIF_FROZEN for all architectures, becaus=
e suspend
> > > to RAM is supposed to work on all of them, isn't it?
> > =

> > Well, yes, it should be added, but no, I do not think s2ram works on
> > that many machines.
> =

> Userspace "s2ram" !=3D PM_SUSPEND_MEM ("suspend-to-RAM") though.
> =

> I'm not even sure there's a globally acceptable definition of
> what PM_SUSPEND_MEM indicates, beyond the fact that one expects
> it saves more power than PM_SUSPEND_STANDBY.
> =

> Yes, the Documentation/power/states.txt regurgitates ACPI spec text.
> But lots of non-ACPI systems don't have any reason to do things
> like ACPI says.  And in terms of latency, I've seen a lot of that
> be due to the PM framework taking so long to walk the device tree,
> with no substantial difference between "standby" and "str" costs.

Well, in this particular case the question is only which architectures will
actually use the freezer. :-)

Greetings,
Rafael


-- =

If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King
