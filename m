From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 0/4] Fix forcedeth hibernate/wake-on-lan
	problems
Date: Wed, 4 Jun 2008 19:38:01 -0700
Message-ID: <200806041938.02045.david-b__28536.0319227495$1212633720$gmane$org@pacbell.net>
References: <20080518125715.GA19229@yamamaya.is-a-geek.org>
	<200805271432.12881.david-b@pacbell.net>
	<20080531072036.GC5405@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080531072036.GC5405@ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: Ayaz Abdulla <aabdulla@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Tobias Diedrich <ranma+kernel@tdiedrich.de>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, Stephen Hemminger <shemminger@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Saturday 31 May 2008, Pavel Machek wrote:
> =

> > Yeah; under ACPI, PCI does not act like it does everywhere else.
> > Nor does wakeup in general.
> > =

> > After sending patches to fix that for a couple years now, I'm
> > well past being tired of doing that. =A0I suggest it's overdue for
> > the ACPI team to get this part of their act together.
> =

> I'm afraid you expect too much from the acpi team.

I'm likewise "afraid" that may be too much to expect.

If that's true, it's going to be even harder making
the cross-platform Linux PM framework do what it needs
to do.  Having various devices (not just laptop lids or
power buttons, or RTC alarms) wake systems from low power
states is pretty fundamental to the "P" part of ACPI.
And it's not like wakeup events are unique to ACPI.


> If you can't merge =

> patches yourself, perhaps someone interested (Tobias? me?) can push
> them for you?

I kind of think the ACPI team needs to just become more
responsive.  They helped Windows do this stuff; why has
Linux only seen delays and obstacles in this area?
