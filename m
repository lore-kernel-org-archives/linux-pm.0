From: Andrew Morton <akpm@osdl.org>
Subject: Re: Flames over -- Re: Which is simpler?
Date: Sun, 19 Feb 2006 23:29:26 -0800
Message-ID: <20060219232926.256665d6.akpm@osdl.org>
References: <43F89F55.5070808@cfl.rr.com>
	<200602192144.57748.oliver@neukum.org>
	<20060219130243.52af0782.akpm@osdl.org>
	<200602200755.57699.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200602200755.57699.oliver@neukum.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Oliver Neukum <oliver@neukum.org>
Cc: alon.barlev@gmail.com, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, psusi@cfl.rr.com, torvalds@osdl.org, mrmacman_g4@mac.com
List-Id: linux-pm@vger.kernel.org

Oliver Neukum <oliver@neukum.org> wrote:
>
> Am Sonntag, 19. Februar 2006 22:02 schrieb Andrew Morton:
> > Oliver Neukum <oliver@neukum.org> wrote:
> > >
> > > Am Sonntag, 19. Februar 2006 21:02 schrieb Andrew Morton:
> > > > For a), the current kernel behaviour is what we want - make the t=
hing
> > > > appear at a new place in the namespace and in the hierarchy. =A0T=
hen
> > > > userspace can do whatever needs to be done to identify the device=
, and
> > > > apply some sort of policy decision to the result.
> > >=20
> > > How? If you have a running user space the connection to the open fi=
les
> > > is already severed, as any access in that time window must fail.
> >=20
> > That's a separate issue, which we haven't discussed yet. =A0We have a=
 device
> > which has gone away and which might come back later on. =A0Presently =
we will
> > return an I/O error if I/O is attempted in that window. =A0Obviously =
we'll
> > need to do something different, such as block reads and block or defe=
r writes.
>=20
> But how do you handle memory management?
> If you simply block writes, the system will stall random tasks launderi=
ng
> pages, including those needed to make progress. Even syncing before
> suspend won't help you, as a running user space may dirty pages.

Well of _course_ that will happen.  If we have dirty pages we need to
either keep them in memory or lose them.  If someone wants to run a massi=
ve
memory stresstest, unplug the disks in the middle of it and have the
machine serenely sail along as if nothing happened then they're being
unreasonable.

> And what about the rootfs?

If you disconnect that then everything stops until you reconnect it, prov=
ided
all the tools needed to handle the reconnect are in the correct place - i=
f
the system providers got that wrong then the machine is obviously toast.

Your questions boil down to "what if the user is crazy or the implementat=
ion
is buggy?".   Let's assume neither is true, OK?
