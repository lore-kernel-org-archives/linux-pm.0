From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] dynamic device power management proposal
Date: Thu, 22 Mar 2007 12:41:19 -0700
Message-ID: <200703221241.20166.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0703191135360.14222-100000@iolanthe.rowland.org>
	<200703220042.20471.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703220042.20471.lenb@kernel.org>
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
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 21 March 2007 9:42 pm, Len Brown wrote:

> > >      2. The device dependence varies from different systems especially
> > >         for embedded system. The idea is dpm framework handles device
> > >         dependence (like, resume a device=E2=80=99s parent before res=
ume the
> > >         device itself),

The driver model PM framework **ALREADY DOES THAT** so nothing new
is required ...


> I'm skeptical about an additional framework in the kernel to track
> dependencies,

The clock framework and driver model tree already handle a big chunk
of those dependencies.  Of course, they're also not an "additional"
framework (except maybe from the x86 perspective, where the clock
framework isn't available).


> as I don't think we should even try to track embedded system =

> dependencies in the kernel.

That approach seems unlikely to work, unless one wants to make it
even harder to use Linux on embedded systems.  On the other hand,
I'd hate to see a "dependency tracking API" rather than something
focussed on solving specific problems.  (Solve first, then maybe
generalize later.)


> This is the "intelligent device driver" model -- the driver actually has =
a clue
> and can do the work internally.  Probably we need some combination of this
> plus the simple timeout/user-policy-manager for dumber drivers if we are =
to
> cover the whole system.

Yes, those two approaches should cover large chunks of the driver space.

- Dave
