From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] power trees
Date: Fri, 26 Aug 2005 19:42:56 -0700
Message-ID: <20050827024256.81A0AC1644@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
References: <Pine.LNX.4.44L0.0508211205180.28564-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============43259381945148878=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0508211205180.28564-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: stern@rowland.harvard.edu, abelay@novell.com
Cc: linux-pm@lists.osdl.org, pavel@ucw.cz
List-Id: linux-pm@vger.kernel.org

--===============43259381945148878==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> > > My implementation has two primary goals:
> > > 
> > > 1.) To help device drivers track and control their device's power state

What do you see happening with "struct dev_pm_info", which is the current
(and needs-work) approach for this?


> > > 2.) To bubble power state dependency changes from a leaf node to the
> > > last affected parent node in the chain.
> > > 
> > > The basic unit of the tree is referred to as a "pm_node".  Each
> > > "pm_node" has a list of states it supports, a current state, and a
> > > driver to handle state transitions.  Any "pm_node" can have children and
> > > therefore act as a power container.
>
> I think it's a mistake to make this a tree.  The natural structure is a 
> DAG, where nodes can have multiple parents.  It might not be worthwhile 
> trying to store the parent/child/sibling pointers in the structures.

Plus, the current driver model already builds a power tree, with node
type "struct dev_pm_info".  What would be the goal of adding another,
normally parallel, tree?  Rather than just sorting out how to use
that one, and dev_pm_info.pm_parent.  (Which we need to do anyway!)

My pet problem case can best be called "multiple parents".  That's pretty
common; one subassembly (part of a board, chip, etc) has PM interactions
with a bunch of other components.  For discussion, I'll say that uses a
"composite driver" ... it's usually built out of a few other drivers.
(One real-world example would be a USB OTG subsystem.  Typically that
combines drivers for an I2C transceiver, USB host, USB peripheral, OTG
controller, and parts of a battery charger.  They work together.)


The interesting question to me is then how to fit composite drivers into
today's driver/PM core code ... such subassemblies will show up in more
than one place in the driver model (e.g. four drivers, on platform and
I2C busses), plus elsewhere (e.g. the clock tree), and per-device driver
model PM calls normally need to access composite driver state ...

Maybe if the dev_pm_info.pm_parent pointed to a

	struct composite_device {
		struct device		container;
		struct list_head	components;
		/* plus private device-wide state */

		/* didn't someone propose a call like this recently?
		 * it'd be the child notifiying the container.
		 * container used component->{suspend,resume}?
		 */
		int (*notify_state_change)(
				struct composite_device *container,
				struct device *component,
				void *data);
	};

on some bus or other, would offer the right kind of structure.  Especially
if the PM core morphed component->suspend() to pm_parent->suspend(), and
likewise for resume(), so individual components wouldn't need their own PM code.



> > > struct pm_state {
> > > 	char			*name;
> > > 	unsigned long		index;
> > > 	unsigned long		link_req;
> > > 	void			*link_data;
> > > };
> > > 
> > > "index" is a driver specific value that indicates the state.  "link_req"
> > > is a set of flags that indicate requirements from the parent "pm_node".
> > > "link_data" provides additional requirement information.
>
> Given that there can be multiple parents, the link_* members of this 
> structure won't be useful.  Also, I don't see that index expresses any 
> information not already present in name.

Better yet, the "struct pm_state" pointer could itself be the state
identifier.  We don't need to keep creating more of those.  :)

Who would use these state cookies though?  I think I'd like to see
a "roles and responsibilities" description of these API components.

I consider defining PM states to be the responsibility of the device;
and in some standardized environments (like PCI or USB), they may also
be constrained by the bus.  And while a bus may have some role in
managing power for its devices, that's not always the case.  (Example:
switching power for a platform device may involve some i2c requests.
Neither bus -- platform or i2c -- has PM responsibilties there.)


> > > struct pm_node {
> > > 	struct semaphore	sem;
> > > 	struct list_head	children;
> > > 	struct list_head	child_list;
> > > 	struct pm_node		*parent;
> > > 	struct pm_node		*tmp_path;
> > > 	struct device		*dev;
> > > 
> > > 	struct pm_node_driver	*drv;
> > > 	unsigned int		current_state;
> > > 	unsigned int		target_state;
> > 
> > Would not it be cleaner to have struct pm_state *current_state, target state?
>
> I don't see the point of having target_state at all.

In fact, I don't see any reason not to pass the "struct pm_state" pointer
directly from whatever code has the "chooses device state transitions" role.


> > > "states" is a list of power states sorted from most functional to least
> > > functional.
>
> In general it's not possible to sort states in that way.  Some states 
> might permit one subset of the complete set of functions while other 
> states permit a different, partially overlapping, subset.

Why would you want to expose one particular ordering of states at the
API level?  Any code responsible for such states is going to know what
the states mean, and how to order them for the task at hand.  If it
won't work with a randomized ordering, it's broken.  :)

With multiple variables (start with two voltages, three frequencies, and
four subcomponents to turn on/off) it's easy to see there can be multiple
orderings that may be meaningful from a given state ... including states
that can't currently be entered.

- Dave



--===============43259381945148878==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============43259381945148878==--
