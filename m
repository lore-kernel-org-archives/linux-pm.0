From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: NAK new drivers without proper power management?
Date: Sat, 10 Feb 2007 10:28:10 +1100
Message-ID: <1171063690.1484.113.camel@nigel.suspend2.net>
References: <1171058269.1484.64.camel@nigel.suspend2.net>
	<200702092344.14984.rjw@sisk.pl>
	<1171061489.1484.100.camel@nigel.suspend2.net>
	<200702100012.17430.rjw@sisk.pl>
Reply-To: nigel@nigel.suspend2.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200702100012.17430.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.osdl.org>, LKML <linux-kernel@vger.kernel.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi.

On Sat, 2007-02-10 at 00:12 +0100, Rafael J. Wysocki wrote:
> > > I think if CONFIG_PM_DEBUG is set, the core should warn about drivers=
 not
> > > having .suspend or .resume routines.
> > =

> > The only problem with that is, not everyone turns on CONFIG_PM_DEBUG.
> > CONFIG_PM instead?
> =

> Well, I can imagine a driver that doesn't need a .suspend routine, for ex=
ample,
> and I don't think we should make the kernel always complain about that.

How about...

#ifdef CONFIG_PM_PARANOIA
static int empty_suspend_routine(struct device *dev, pm_message_t state)
{
	return 0;
}
#define empty_suspend empty_suspend_routine
#else
#define empty_suspend NULL
#endif

...

	.suspend =3D empty_suspend;
...


Then CONFIG_PM_PARANOIA can be enabled by default for now, and when we
eventually device it's not needed anymore, someone can submit a patch
replacing either turning off the CONFIG by default or removing the whole
mechanism.

> I think if someone doesn't set CONFIG_PM_DEBUG, we can ask him to set it
> and report back.

We can, but the whole point to the suggestion was to make your life and
mine easier, as well as those of our users.

Making it dependent on CONFIG_PM instead achieves that by:
- Saving you, I and distro people from having to tell their users to
enable the option (and how to)
- Saving the users the problem of going through all the steps, making
mistakes, potentially ending up with unbootable systems because they
make mistakes and so on.

This way, they just need to look in dmesg.

Regards,

Nigel
