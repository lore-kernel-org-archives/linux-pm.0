From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: NAK new drivers without proper power management?
Date: Sat, 10 Feb 2007 09:51:29 +1100
Message-ID: <1171061489.1484.100.camel@nigel.suspend2.net>
References: <1171058269.1484.64.camel@nigel.suspend2.net>
	<1171059433.8675.195.camel@laptopd505.fenrus.org>
	<1171059968.1484.90.camel@nigel.suspend2.net>
	<200702092344.14984.rjw@sisk.pl>
Reply-To: nigel@nigel.suspend2.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200702092344.14984.rjw@sisk.pl>
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

On Fri, 2007-02-09 at 23:44 +0100, Rafael J. Wysocki wrote:
> On Friday, 9 February 2007 23:26, Nigel Cunningham wrote:
> > Hi.
> > =

> > On Fri, 2007-02-09 at 23:17 +0100, Arjan van de Ven wrote:
> > > On Sat, 2007-02-10 at 08:57 +1100, Nigel Cunningham wrote:
> > > > Hi.
> > > > =

> > > > I don't think this is already done (feel free to correct me if I'm
> > > > wrong)..
> > > > =

> > > > Can we start to NAK new drivers that don't have proper power manage=
ment
> > > > implemented? There really is no excuse for writing a new driver and=
 not
> > > > putting .suspend and .resume methods in anymore, is there?
> > > =

> > > =

> > > to a large degree, a device driver that doesn't suspend is better than
> > > no device driver at all, right?
> > =

> > I'm not sure it is. It only makes more work for everyone else: We have
> > to help people figure out what causes their computer to fail to resume
> > (which can take quite a while), then get them them complain to driver
> > author, and the driver author has to submit patches to fix it.
> > =

> > All of this is avoided if they'll just do it right in the first place.
> > =

> > > now.. if you want to make the core warn about it, that's very fair
> > =

> > That's probably a good idea too, since I'm only suggesting this for new
> > drivers.
> =

> I think if CONFIG_PM_DEBUG is set, the core should warn about drivers not
> having .suspend or .resume routines.

The only problem with that is, not everyone turns on CONFIG_PM_DEBUG.
CONFIG_PM instead?

Regards,

Nigel
