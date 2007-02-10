From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Re: NAK new drivers without proper power
	management?
Date: Sat, 10 Feb 2007 20:50:27 +0100
Message-ID: <200702102050.28218.rjw@sisk.pl>
References: <fa.xSKPgY66Q+DPCZ1pszFFfdrJ0To@ifi.uio.no>
	<200702101130.44471.rjw@sisk.pl>
	<Pine.LNX.4.64.0702101231281.20138@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0702101231281.20138@iabervon.org>
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
To: Daniel Barkalow <barkalow@iabervon.org>
Cc: Robert Hancock <hancockr@shaw.ca>, Jeff Garzik <jeff@garzik.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, 10 February 2007 18:52, Daniel Barkalow wrote:
> On Sat, 10 Feb 2007, Rafael J. Wysocki wrote:
> =

> > On Saturday, 10 February 2007 11:02, Nigel Cunningham wrote:
> >
> > > Well, the original desire was to stop new drivers getting in without
> > > proper power management.
> > =

> > I know, but I agree with the argument that having a driver without the
> > suspend/resume support is better than not having the driver at all.
> =

> How about if "proper power management" is defined to include the driver =

> explicitly preventing suspend? It seems to me like the current problem is =

> that driver writers don't think about power management at all, and the =

> result is that, after suspend/resume, the system doesn't come back. It =

> would be better if driver writers had to think about power management jus=
t =

> enough to realize that it's not going to work, and make this information =

> available to the system. At that point, it's relatively easy for the =

> system to do something useful about it.

Actually, it is easy for the driver authors to do this right now.  They can
just make the .suspend() routine always return an error.

Well, I think this is a good idea: if the device in question requires speci=
fic
power management during the suspend/resume, but it is not implemented by the
driver, we should require the author of the driver to define the .suspend()
routine that returns -ENOSYS (preferably, with an explanatory warning in
dmesg).

Thoughts?

> > Also, I think there are quite some drivers already in the tree that don=
't
> > support suspend/resume explicitly and honestly we should start from add=
ing the
> > suspend/resume routines to these drivers _before_ we ban new drivers li=
ke that.
> =

> It'd be relatively quick to modify all the current drivers that don't =

> explicitly support suspend/resume to explicitly not support it. (Or to =

> explicitly support it trivially; /dev/null obviously doesn't need =

> anything.)

The problem is we have to review quite a lot of drivers for this purpose.
Still it looks like we should do this anyway.

Greetings,
Rafael


-- =

If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King
