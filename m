From: Adam Belay <abelay@novell.com>
Subject: Re: [RFC] A New Power Management API
Date: Sun, 17 Apr 2005 16:25:17 -0400
Message-ID: <1113769518.3451.87.camel@localhost.localdomain>
References: <1113533193.3451.40.camel@localhost.localdomain>
	<200504161027.53592.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============38228910376999875=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200504161027.53592.david-b@pacbell.net>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============38228910376999875==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2005-04-16 at 10:27 -0700, David Brownell wrote:
> On Thursday 14 April 2005 7:46 pm, Adam Belay wrote:
> 
> > The new API uses a power container/domain model. 
> 
> I like that as a basic organizing principle, and I don't think
> anyone has problems with the notion that the power relationships
> can't always map directly to the physical device tree.
> 
> Could you describe a bit about how the containers behave?  For
> example, when a device drops its power consumption, how does it
> notify its container?  And when sets of devices -- e.g. all USB
> devices, all PCI devices -- support the same power states, how
> will that code be shared?  Would "struct power_device" be the
> driver model replacement for "struct power"?

Here are my current thoughts:

When greatest common denominator of power requirements is lowered (as a
result of a power_device lowering its state), the policy manager of the
container "struct power_device" will be notified.  Code for the same
states will not be shared, because the method of transitioning these
states is different.  Also their meanings are often different.  However,
if the states are the same, the mappings will likely be simplistic.

Every "struct device' will have a "struct power_device", but not every
"struct power_device" must have a "struct device".  "struct
power_device" will be the base unit of power management topologies.

> 
> Also, I'd rather see "struct system_power_state *" everywhere
> you're now passing "int system_state" in the API.
> 
> - Dave

Fixed.  Thanks for the suggestion.

Adam



--===============38228910376999875==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============38228910376999875==--
