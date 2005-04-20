From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] Power Management API (rev 1)
Date: Wed, 20 Apr 2005 17:59:56 +0200
Message-ID: <20050420155956.GA3372@elf.ucw.cz>
References: <1113773748.3451.142.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============59078016816400458=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1113773748.3451.142.camel@localhost.localdomain>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Adam Belay <abelay@novell.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============59078016816400458==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> I've made some revisions to my new power management API.  I would
> appreciate any suggestions or comments.


> /*
>  *  pm.h - the Power Management Interface
>  *
>  */
> 
> #ifndef _LINUX_PM_H
> #define _LINUX_PM_H
> 
> #ifdef __KERNEL__
> 
> #include <linux/config.h>
> #include <linux/list.h>
> #include <asm/atomic.h>
> 
> struct device;
> 
> struct power_resource;
> struct power_driver;
> struct power_policy;
> struct power_device;
> 
> 
> /*
>  * Global System Power States
>  *
>  * Reflect the status of the overall system.
>  */
> 
> struct system_power_state {
> 	unsigned int state;

We already have int system_state... How is this different?

Please move the defines near here, and preferably add type-checking
for sparse.

> 	unsigned int flags;
> 
> 	struct list_head state_list;
> };
> 
> extern int pm_register_system_state(struct system_power_state *state);
> extern void pm_unregister_system_state(struct system_power_state *state);
> 
> extern struct system_power_state *
> pm_get_system_state_data(unsigned int state);

Having "unsigned int state" is asking for trouble.

> /*
>  * Power States
>  *
>  * These are used to define device-specific power states.
>  */
> 
> struct power_state {
> 	char * name;
> 	int available;
> 
> 	unsigned int state;
> 	unsigned int flags;

Are they same type as system_power_state.state? This should be clear,
and type-checked by sparse. Otherwise people will get it wrong.


> /*
>  * Power Devices
>  *
>  * Power devices are the core building block of a system's power management
>  * topology.  They may require power resources, but the primary dependency
>  * relationships are represented by a tree of "power devices".  This tree
>  * is based on a power domain (or container) model.
>  */
> 
> struct power_device {
> 	char			* name;
> 	struct kobject		kobj;
> 
> 	unsigned int		state;
> 	unsigned int		min_state;
> 	unsigned int		max_state;

Third "state"... Are they same type? Different?

							Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.

--===============59078016816400458==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============59078016816400458==--
