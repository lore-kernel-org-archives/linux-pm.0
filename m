From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: NAK new drivers without proper power management?
Date: Fri, 9 Feb 2007 23:44:14 +0100
Message-ID: <200702092344.14984.rjw@sisk.pl>
References: <1171058269.1484.64.camel@nigel.suspend2.net>
	<1171059433.8675.195.camel@laptopd505.fenrus.org>
	<1171059968.1484.90.camel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1171059968.1484.90.camel@nigel.suspend2.net>
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
To: nigel@nigel.suspend2.net
Cc: pm list <linux-pm@lists.osdl.org>, LKML <linux-kernel@vger.kernel.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Friday, 9 February 2007 23:26, Nigel Cunningham wrote:
> Hi.
> =

> On Fri, 2007-02-09 at 23:17 +0100, Arjan van de Ven wrote:
> > On Sat, 2007-02-10 at 08:57 +1100, Nigel Cunningham wrote:
> > > Hi.
> > > =

> > > I don't think this is already done (feel free to correct me if I'm
> > > wrong)..
> > > =

> > > Can we start to NAK new drivers that don't have proper power manageme=
nt
> > > implemented? There really is no excuse for writing a new driver and n=
ot
> > > putting .suspend and .resume methods in anymore, is there?
> > =

> > =

> > to a large degree, a device driver that doesn't suspend is better than
> > no device driver at all, right?
> =

> I'm not sure it is. It only makes more work for everyone else: We have
> to help people figure out what causes their computer to fail to resume
> (which can take quite a while), then get them them complain to driver
> author, and the driver author has to submit patches to fix it.
> =

> All of this is avoided if they'll just do it right in the first place.
> =

> > now.. if you want to make the core warn about it, that's very fair
> =

> That's probably a good idea too, since I'm only suggesting this for new
> drivers.

I think if CONFIG_PM_DEBUG is set, the core should warn about drivers not
having .suspend or .resume routines.

Greetings,
Rafael


-- =

If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King
