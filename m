From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Nested suspends; messages vs. states
Date: Wed, 23 Mar 2005 22:31:00 -0800
Message-ID: <200503232231.00561.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0503211436020.1241-100000@ida.rowland.org>
	<200503232127.19576.david-b@pacbell.net>
	<1111644123.5517.0.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============60897719188773425=="
In-Reply-To: <1111644123.5517.0.camel@gaston>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--===============60897719188773425==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 23 March 2005 10:02 pm, Benjamin Herrenschmidt wrote:
> 
> > That's a different example though:  you've given the host controller
> > flexibility.  You have _not_ hogtied it.
> > 
> > The model we seem to be aiming towards in USB land is a bit different
> > than that though.  When autosuspend is the goal, it bubbles up from
> > the bottom ... nodes (like HC) don't force children into idle, they
> > wait for the children to idle themselves and then take the opportunity
> > to snooze themselves.  That's a model with wide applicability...
> 
> It is, though it requires every children driver to have an idle
> mecanism ... do you think that will work in practice ?

When autosuspend is the goal, they'll implement it.  Otherwise it's
not a goal, so not having it will not matter at all.  And for leaf
node drivers, it's not at all tricky.  :)

It matters for example with mice on laptops.  I'm told that Intel
has measured and found that autosuspending mouse, then root hub
lets Centrino enter the C3 state, saving 2 Watts of power.  Which
can be rather significant savings...


There are other strategies too, like having some external component
try to decide things.  Maybe even users.  Every strategy has plus
and minus points.  One nice thing about autosuspend is that the
user interface is all but nonexistent.  Also, most users are already
trained to expect such mechanisms elsewhere.


--===============60897719188773425==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============60897719188773425==--
