From: "Preece Scott-PREECE" <scott.preece@motorola.com>
Subject: Re: community PM requirements/issues and PowerOP [Was:
	Re: So, what's the status on the recent patches here?]
Date: Wed, 13 Sep 2006 07:39:21 -0400
Message-ID: <ADE4D9DBCFC3A345AAA95C195F62B6DD01B6A3D9@de01exm64.ds.mot.com>
References: <20060913045405.BA7DD1A0084@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
In-Reply-To: <20060913045405.BA7DD1A0084@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>, pavel@ucw.cz
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

 =

> From: David Brownell [mailto:david-b@pacbell.net] =

> =

> > Date: Mon, 11 Sep 2006 21:36:37 +0200
> > From: Pavel Machek <pavel@ucw.cz>
> >
> > Kernel interface is not something to be experimented with.
> =

> Disagree.  How else to get it right??
> Try, learn, improve.  That's experimentation.
> Linux has no "stable API nonsense" ...
> =

> The point of "cathedral vs. bazaar" was that experimentation =

> and evolution are more successful processes than "get it =

> right the first time".
---

I think Pavel's point was that the userspace interface to =

the kernel (at least the syscall interface) is stable (open to
Extension by addition of syscalls, but closed to modification
or deletion of existing and that any experimentation needs to =

happen before functionality goes into the mainstream. =


That said, I do think we probably need to add a new interface to
cover operating points, because some of believe that policy needs
to be in user space and the whole point of the OP abstraction is =

that operating points are atomic. You can't just add knobs to
control more factors, because all those knobs need to be turned
at the same time. Setting an operating point is inherently an
atomic operation, not n separate operations that can be taken
serially.

scott
 =
