From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Re: NAK new drivers without proper power
	management?
Date: Sat, 10 Feb 2007 12:52:15 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702101231281.20138@iabervon.org>
References: <fa.xSKPgY66Q+DPCZ1pszFFfdrJ0To@ifi.uio.no>
	<200702101034.04410.rjw@sisk.pl>
	<1171101723.3821.22.camel@nigel.suspend2.net>
	<200702101130.44471.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200702101130.44471.rjw@sisk.pl>
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
Cc: Robert Hancock <hancockr@shaw.ca>, Jeff Garzik <jeff@garzik.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 10 Feb 2007, Rafael J. Wysocki wrote:

> On Saturday, 10 February 2007 11:02, Nigel Cunningham wrote:
>
> > Well, the original desire was to stop new drivers getting in without
> > proper power management.
> =

> I know, but I agree with the argument that having a driver without the
> suspend/resume support is better than not having the driver at all.

How about if "proper power management" is defined to include the driver =

explicitly preventing suspend? It seems to me like the current problem is =

that driver writers don't think about power management at all, and the =

result is that, after suspend/resume, the system doesn't come back. It =

would be better if driver writers had to think about power management just =

enough to realize that it's not going to work, and make this information =

available to the system. At that point, it's relatively easy for the =

system to do something useful about it.

> Also, I think there are quite some drivers already in the tree that don't
> support suspend/resume explicitly and honestly we should start from addin=
g the
> suspend/resume routines to these drivers _before_ we ban new drivers like=
 that.

It'd be relatively quick to modify all the current drivers that don't =

explicitly support suspend/resume to explicitly not support it. (Or to =

explicitly support it trivially; /dev/null obviously doesn't need =

anything.)

	-Daniel
*This .sig left intentionally blank*
