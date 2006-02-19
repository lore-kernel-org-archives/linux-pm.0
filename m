From: Andrew Morton <akpm@osdl.org>
Subject: Re: Flames over -- Re: Which is simpler?
Date: Sun, 19 Feb 2006 13:02:43 -0800
Message-ID: <20060219130243.52af0782.akpm@osdl.org>
References: <43F89F55.5070808@cfl.rr.com>
	<Pine.LNX.4.44L0.0602191142290.9165-100000@netrider.rowland.org>
	<20060219120221.1d11cee0.akpm@osdl.org>
	<200602192144.57748.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200602192144.57748.oliver@neukum.org>
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
> Am Sonntag, 19. Februar 2006 21:02 schrieb Andrew Morton:
> > For a), the current kernel behaviour is what we want - make the thing
> > appear at a new place in the namespace and in the hierarchy. =A0Then
> > userspace can do whatever needs to be done to identify the device, an=
d
> > apply some sort of policy decision to the result.
>=20
> How? If you have a running user space the connection to the open files
> is already severed, as any access in that time window must fail.

That's a separate issue, which we haven't discussed yet.  We have a devic=
e
which has gone away and which might come back later on.  Presently we wil=
l
return an I/O error if I/O is attempted in that window.  Obviously we'll
need to do something different, such as block reads and block or defer wr=
ites.

So an overall picture would be something like:

- When device is not present, reads block and writes are deferred or bloc=
k

- When device appears (at a new point in the namespace) the hotplug
  scripts will go off and will identify it and will apply some policy bas=
ed
  upon that identification.  That policy could be one of:

  a) accept device at its new address

  b) accept device at its new address, abandon the old address (all
     those blocked reads and writes suddenly return -EIO).

  c) remove device from its new address, splice it back to where it
     used to be, permit those blocked reads and writes to proceed.

- For devices which are absent-and-blocked, provide some ability for both
  a timeout and manual cancellation, to unblock all those readers and
  writers, make them get -EIO.

The number of potential races is, of course, huge.
