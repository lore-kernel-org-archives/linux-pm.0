From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Nested suspends; messages vs. states
Date: Wed, 23 Mar 2005 21:27:19 -0800
Message-ID: <200503232127.19576.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0503211436020.1241-100000@ida.rowland.org>
	<200503231845.55392.david-b@pacbell.net>
	<1111640590.16224.180.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============19966614205880129=="
In-Reply-To: <1111640590.16224.180.camel@gaston>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============19966614205880129==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 23 March 2005 9:03 pm, Benjamin Herrenschmidt wrote:
> On Wed, 2005-03-23 at 18:45 -0800, David Brownell wrote:
> 
> > If you've hogtied your system by forcing some devices ("busses") into
> > certain states that prevent others from working, it seems only fair to
> > me that it stay hogtied.
> 
> No. For example, I'm a host controller. I notice I didn't get any
> request for a while, I want to enter a suspended state. That means going
> through dependencies of my childs so they can all enter a state
> compatible with me going to suspend.

That's a different example though:  you've given the host controller
flexibility.  You have _not_ hogtied it.

The model we seem to be aiming towards in USB land is a bit different
than that though.  When autosuspend is the goal, it bubbles up from
the bottom ... nodes (like HC) don't force children into idle, they
wait for the children to idle themselves and then take the opportunity
to snooze themselves.  That's a model with wide applicability...


> > I suspect you're actually agreeing with me there that some of the
> > drivers need flexibility to manage their power states.  And maybe
> > even that such modes will be the main ones of interest...
> >
> > My answer to the question of how those parent/child dependency
> > details should be managed was to ensure that the parent can do
> > what it needs to.  That is, decentralize those issues.  I don't
> > understand why you seem to dislike that approach, when so many
> > of your examples seem to confirm it would work.
> 
> I want to have the driver in control, yes. But I also want to have a
> core that removes the burden from driver writers in the "generic" cases.
> It's all a tradeoff to find :)

And I don't want to aim for an all-singing/all-dancing pm core that
really can't deliver what's needed, because it's trying to centralize
things that are easier to address in a decentralized way.  :)


--===============19966614205880129==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============19966614205880129==--
