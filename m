From: David Brownell <david-b@pacbell.net>
Subject: Re: Re: Power Management Policies
Date: Wed, 27 Apr 2005 09:03:50 -0700
Message-ID: <200504270903.51099.david-b@pacbell.net>
References: <1113772533.3451.131.camel@localhost.localdomain>
	<200504270722.31321.david-b@pacbell.net>
	<20050427145717.GA20602@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============63959734232139476=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050427145717.GA20602@cosmic.amd.com>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============63959734232139476==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 27 April 2005 7:57 am, Jordan Crouse wrote:
> On 27/04/05 07:22 -0700, David Brownell wrote:
> > I don't see major vendors wanting to move away from "closed" models
> > at the lower end, or in fact whereever they have the power to dictate
> > customer "preferences".  (The latter case is also known as a "market
> > failure", except by radical corporatists...)  But for higher end products,
> > or when customers truly have (or need!!) choices, then "open" is more
> > usually the answer.
> 
> Indeed.  Really, my point was that massive userland based configuration is
> better suited to systems with known configurations and vendors motivated to
> spend the time and expense to tune the system.

They _could_ apply some of that effort to in-kernel support, of course,.  :)
The question is what goes where.  Some folk talk about putting extremely low
level policies in userspace.  I'm more a fan of right-sizing/right-placing,
which means that a lot of hardware PM mechanisms won't show up in userspace.
(Except maybe for monitoring purposes, or as highlevel policy options.)


> ...
> Which is why I think that userland tuning should be an option, and not
> mandatory.  A wide majority of the users across the Linux spectrum might 
> not care what the wake up latency of their NIC is, but I think that there are
> enough that do to make a userland configuration framework useful.

Configuration framework, I agree.  Tuning, in the normal sense of
setting parameters and then going away, ditto.

There may even be a role for some "dynamic tuning", monitoring the
system and updating parameters on the fly to save power.  That's
sort of a grey zone though; such schemes can easily be abused.
I've maybe seen too many things fail because of broken userspace
policy implementations...

But there are things that don't belong in userspace, and IMO those
include many/most of the lowest level dirtiest bits of PM.  If userspace
sticks to policy selection, rather than implementing mechanism by
requiring the kernel to export low level hooks, I'll be happiest.

- Dave

 

--===============63959734232139476==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============63959734232139476==--
