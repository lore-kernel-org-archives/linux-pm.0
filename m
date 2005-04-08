From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] Mapping Device Power States
Date: Thu, 7 Apr 2005 17:39:56 -0700
Message-ID: <200504071739.56962.david-b@pacbell.net>
References: <1112909150.21887.18.camel@linux.site>
	<200504071504.47531.david-b@pacbell.net>
	<1112918184.9568.335.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============61110806271238083=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1112918184.9568.335.camel@gaston>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Adam Belay <abelay@novell.com>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============61110806271238083==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 07 April 2005 4:56 pm, Benjamin Herrenschmidt wrote:
> On Thu, 2005-04-07 at 15:04 -0700, David Brownell wrote:
> 
> > In short:  why should there be any Linux-wide notion like that?
> > Wouldn't trying to create one just be the problem of creating a
> > "Grand Unified Theory of Power Management"?
> 
> Hrm...
> 
> Each time somebody comes up with an attempt at providing a generic model
> that could be useful enough for most driver, you come up with your
> "grand unified bla bla bla" argument as a way of dismissal... not very
> constructive.

But that doesn't answer my question now, does it?

Talk about dismissal... I've mentioned that twice now.  Yours is
a strange reaction, given that level of exposure.  Maybe it's
just too darn close for comfort?

I _do_ happen to think that much of the reason the power management
stuff has stayed such a mess is that folk have been aiming towards
a "grand scheme", and that such a thing is counterproductive.  To
have this work, things need to be decentralized, not micro-managed.


The specific question Adam asked is something I've been thinking
about off and on.  It relates to the issue of what should happen
to the sysfs power/state files.

To perhaps oversimplify things, Adam asked how to change the current
"there is such a global state" model ... and my response was more
at the level of a "that seems like the wrong model, what's the real
problem you want to address?" question.

Maybe there really is something essential in such a global model.
If that's the case, my questions will have good answers...


It's not "constructive" to attack someone for asking honest
questions now, is it???



--===============61110806271238083==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============61110806271238083==--
