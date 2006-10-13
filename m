From: Adam Belay <abelay@MIT.EDU>
Subject: Re: Bug in PCI core
Date: Fri, 13 Oct 2006 12:40:31 -0400
Message-ID: <1160757632.26091.121.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0610131024340.6460-100000@iolanthe.rowland.org>
	<1160753187.25218.52.camel@localhost.localdomain>
	<1160753390.3000.494.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1160753390.3000.494.camel@laptopd505.fenrus.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, Linux-pm mailing list <linux-pm@lists.osdl.org>, Kernel development list <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Fri, 2006-10-13 at 17:29 +0200, Arjan van de Ven wrote:
> On Fri, 2006-10-13 at 16:26 +0100, Alan Cox wrote:
> > Ar Gwe, 2006-10-13 am 10:29 -0400, ysgrifennodd Alan Stern:
> > > > I'd like to propose that we have the pci config sysfs interface ret=
urn
> > > > -EIO  when it's blocked (e.g. active BIST or D3cold).  This accurat=
ely
> > > > reflects the state of the device to userspace, reduces complexity, =
and
> > > > could potentially save some memory per PCI device instance.
> > > =

> > > Could you resubmit your old patches and include a corresponding fix f=
or =

> > > this access problem?
> > =

> > And then you can fix the applications it breaks, like the X server which
> > does actually want to know where all the devices are located in PCI
> > space.
> > =

> =

> .. but which could equally well mmap the resource from sysfs ;)
> =

> =

> also the thing this patch does is ONLY when the device is effectively
> off the bus return -EIO.
> One can argue that -EAGAIN is nicer since it's only a temporary
> condition though....
> =

> =


Yeah, perhaps -EAGAIN would be more appropriate, especially in the power
state transition and BIST cases.  An interesting possibility might be to
have the file actually block, although I'm not sure if the O_NONBLOCK
flag or polling for that matter can be supported through the
sysfs/driver-core API.

-Adam
