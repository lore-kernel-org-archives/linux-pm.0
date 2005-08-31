From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC] power trees
Date: Wed, 31 Aug 2005 13:42:44 +0300
Message-ID: <20050831104243.GB6496@atomide.com>
References: <Pine.LNX.4.44L0.0508211205180.28564-100000@netrider.rowland.org>
	<20050827024256.81A0AC1644@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============83181859071938957=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050827024256.81A0AC1644@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org, abelay@novell.com, pavel@ucw.cz
List-Id: linux-pm@vger.kernel.org

--===============83181859071938957==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* David Brownell <david-b@pacbell.net> [050827 05:43]:
> > > > My implementation has two primary goals:
> > > > 
> > > > 1.) To help device drivers track and control their device's power state
> 
> What do you see happening with "struct dev_pm_info", which is the current
> (and needs-work) approach for this?
> 
> 
> > > > 2.) To bubble power state dependency changes from a leaf node to the
> > > > last affected parent node in the chain.
> > > > 
> > > > The basic unit of the tree is referred to as a "pm_node".  Each
> > > > "pm_node" has a list of states it supports, a current state, and a
> > > > driver to handle state transitions.  Any "pm_node" can have children and
> > > > therefore act as a power container.
> >
> > I think it's a mistake to make this a tree.  The natural structure is a 
> > DAG, where nodes can have multiple parents.  It might not be worthwhile 
> > trying to store the parent/child/sibling pointers in the structures.
> 
> Plus, the current driver model already builds a power tree, with node
> type "struct dev_pm_info".  What would be the goal of adding another,
> normally parallel, tree?  Rather than just sorting out how to use
> that one, and dev_pm_info.pm_parent.  (Which we need to do anyway!)

I agree. I think we should do this in the driver model. And considering
that a lot of the PM device states are machine specific, we should register
the driver specific PM states and limitations as resources.

This allows defining machine specific driver PM states and limitations
withouth having to shove them into the driver code. And it should be
also easy to add new PM states via sysfs if needed.

Regards,

Tony

--===============83181859071938957==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============83181859071938957==--
