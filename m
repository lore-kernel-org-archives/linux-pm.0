From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] power trees
Date: Sun, 21 Aug 2005 12:15:24 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0508211205180.28564-100000@netrider.rowland.org>
References: <20050821140034.GA3039@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============88932734704178307=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050821140034.GA3039@openzaurus.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Adam Belay <abelay@novell.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============88932734704178307==
Content-Type: TEXT/PLAIN; charset=US-ASCII

Sorry it's taken me so long to respond to this.

> > My implementation has two primary goals:
> > 
> > 1.) To help device drivers track and control their device's power state
> > 
> > 2.) To bubble power state dependency changes from a leaf node to the
> > last affected parent node in the chain.
> > 
> > The basic unit of the tree is referred to as a "pm_node".  Each
> > "pm_node" has a list of states it supports, a current state, and a
> > driver to handle state transitions.  Any "pm_node" can have children and
> > therefore act as a power container.

I think it's a mistake to make this a tree.  The natural structure is a 
DAG, where nodes can have multiple parents.  It might not be worthwhile 
trying to store the parent/child/sibling pointers in the structures.

> > struct pm_state {
> > 	char			*name;
> > 	unsigned long		index;
> > 	unsigned long		link_req;
> > 	void			*link_data;
> > };
> > 
> > "index" is a driver specific value that indicates the state.  "link_req"
> > is a set of flags that indicate requirements from the parent "pm_node".
> > "link_data" provides additional requirement information.

Given that there can be multiple parents, the link_* members of this 
structure won't be useful.  Also, I don't see that index expresses any 
information not already present in name.

> > struct pm_node {
> > 	struct semaphore	sem;
> > 	struct list_head	children;
> > 	struct list_head	child_list;
> > 	struct pm_node		*parent;
> > 	struct pm_node		*tmp_path;
> > 	struct device		*dev;
> > 
> > 	struct pm_node_driver	*drv;
> > 	unsigned int		current_state;
> > 	unsigned int		target_state;
> 
> Would not it be cleaner to have struct pm_state *current_state, target state?

I don't see the point of having target_state at all.

> > "states" is a list of power states sorted from most functional to least
> > functional.

In general it's not possible to sort states in that way.  Some states 
might permit one subset of the complete set of functions while other 
states permit a different, partially overlapping, subset.

> >   "current_state" and "target_state" are index values for
> > that list.
> > 
> > struct pm_node_driver {
> > 	int (*set_state) 	(struct pm_node *node);
> > 	int (*raise_event)	(struct pm_node *domain,
> > 				 struct pm_node *child,
> > 				 unsigned long *new_state);
> 
> struct pm_state here, too?
> 
> > 	void (*lower_event)	(struct pm_node *domain);
> > };
> > 
> > "raise_event" notifies the power domain when a child has increased its
> 
> "Increase" == went more power hungry?

There's no need to have separate raise_event and lower_event entry points.  
In fact you might not want to have those entry points at all, since the 
information they convey will be so bus-specific.  It might be better to 
rely on bus-specific entry points.  I'm not sure about this.

Alan Stern


--===============88932734704178307==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============88932734704178307==--
