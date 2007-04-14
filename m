From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH v4] pm_ops: add system quiesce/activate hooks
Date: Sat, 14 Apr 2007 15:10:23 -0700
Message-ID: <200704141510.24254.david-b@pacbell.net>
References: <1175810054.3489.34.camel@johannes.berg>
	<20070413215045.GN28264@elf.ucw.cz>
	<1176503006.5764.105.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1176503006.5764.105.camel@localhost.localdomain>
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

On Friday 13 April 2007 3:23 pm, Benjamin Herrenschmidt wrote:
> =

> > We have "drivers" for few chips every PC has, like i8259 timer,
> > interrupt controller, APIC, etc. Sysdevs and platform devices are
> > designed for hardware like that.
> > =

> > If you want to have a rule "platform device is not supposed to rely on
> > timers still working",  I think you can get that. Such low-level
> > devices should really use udelay()/mdelay() that spins and does not
> > need timer hw.
> =

> That's nonsense.

Agreed.  Platform devices are the *primary* device types on
most embedded systems.  Their suspend() and resume() methods
are allowed to use timers and sleep() just like they are with
any other bus type.

We do know that timers aren't available during the suspend_late()
and resume_early() calls, for any bus type.
