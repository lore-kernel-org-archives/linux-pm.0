From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v4] pm_ops: add system quiesce/activate hooks
Date: Sat, 14 Apr 2007 07:15:10 +1000
Message-ID: <1176498910.5764.89.camel@localhost.localdomain>
References: <1175810054.3489.34.camel@johannes.berg>
	<200704131347.30001.rjw@sisk.pl>
	<1176470819.7052.108.camel@johannes.berg>
	<200704132243.59618.rjw@sisk.pl>  <20070413205837.GG28264@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070413205837.GG28264@elf.ucw.cz>
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
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, 2007-04-13 at 22:58 +0200, Pavel Machek wrote:
> Hi!
> =

> > > For powermac, we need to do some things between suspending devices and
> > > device_power_off, for example setting the decrementer. This patch
> > > introduces pm_ops.quiesce and pm_ops.activate which will be called in=
stead
> > > of disabling/enabling irqs so platforms get control over this step.
> > > =

> > > If not assigned, these two calls will be assigned with defaults during
> > > set_pm_ops.
> > > =

> > > Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> > =

> > I have no objections.  Pavel, what do you think?
> =

> That it is same old hack it used to be. There's nothing magic about
> decrementer, and I do not think it is _neccessary_ to touch it just
> before cli. Just disable it from sysdev handler or something.

You don't know what you're talking about... so please stop being an ass
and be constructive for once.

We need to deal with the DEC -there-, and with other arch issues while
at it. A sysdev will not do. A non-sydev device will not do due to
ordering issues among other things, at least not without some
significant rework of the driver core PM code.

Thus this is the solution to make it work. Now, if you have decided that
you will refuse making it work on powermacs, then I'll have no choice
but try to push that patch through anyway since you aren't proposing any
alternative solution that would work for us.

(BTW. I still wonder how ACPI can get away without such a hook either
since they motherboard suspend/resume code needs to run with irqs on and
needs to run after all devices are suspended... if they rely on magic
ordering of devices, that would explain why the stuff isn't reliable.
Ordering of devices at the toplevel is -not- reliable in the current
model).
 =

Ben.
