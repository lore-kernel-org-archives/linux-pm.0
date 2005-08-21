From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] power trees
Date: Sun, 21 Aug 2005 16:00:35 +0200
Message-ID: <20050821140034.GA3039@openzaurus.ucw.cz>
References: <1123735844.4380.64.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============91639912372182031=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1123735844.4380.64.camel@localhost.localdomain>
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
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============91639912372182031==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> My implementation has two primary goals:
> 
> 1.) To help device drivers track and control their device's power state
> 
> 2.) To bubble power state dependency changes from a leaf node to the
> last affected parent node in the chain.
> 
> The basic unit of the tree is referred to as a "pm_node".  Each
> "pm_node" has a list of states it supports, a current state, and a
> driver to handle state transitions.  Any "pm_node" can have children and
> therefore act as a power container.
> 
> struct pm_state {
> 	char			*name;
> 	unsigned long		index;
> 	unsigned long		link_req;
> 	void			*link_data;
> };
> 
> "index" is a driver specific value that indicates the state.  "link_req"
> is a set of flags that indicate requirements from the parent "pm_node".
> "link_data" provides additional requirement information.
> 
> struct pm_node {
> 	struct semaphore	sem;
> 	struct list_head	children;
> 	struct list_head	child_list;
> 	struct pm_node		*parent;
> 	struct pm_node		*tmp_path;
> 	struct device		*dev;
> 
> 	struct pm_node_driver	*drv;
> 	unsigned int		current_state;
> 	unsigned int		target_state;

Would not it be cleaner to have struct pm_state *current_state, target state?

> "states" is a list of power states sorted from most functional to least
> functional.  "current_state" and "target_state" are index values for
> that list.
> 
> struct pm_node_driver {
> 	int (*set_state) 	(struct pm_node *node);
> 	int (*raise_event)	(struct pm_node *domain,
> 				 struct pm_node *child,
> 				 unsigned long *new_state);

struct pm_state here, too?

> 	void (*lower_event)	(struct pm_node *domain);
> };
> 
> "raise_event" notifies the power domain when a child has increased its

"Increase" == went more power hungry?

> I apologize for the unpolished/untested state of the code as it's
> primarily intended to illustrate a concept.  I'll need to look over the
> problem more carefully if we decide this is the right direction.  Power

Seems ok to me.

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         


--===============91639912372182031==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============91639912372182031==--
