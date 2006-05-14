From: David Brownell <david-b@pacbell.net>
Subject: Re: Re: [PATCH/rfc] schedule /sys/device/.../power for
	removal
Date: Sun, 14 May 2006 10:48:05 -0700
Message-ID: <200605141048.08424.david-b@pacbell.net>
References: <20060512100544.GA29010@elf.ucw.cz>
	<200605120652.55658.david-b@pacbell.net>
	<1147566116.21291.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============44446118683202851=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1147566116.21291.25.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============44446118683202851==
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Saturday 13 May 2006 5:21 pm, Benjamin Herrenschmidt wrote:
> 
> > I think both Patrick Mochel and Alan Stern have sent patches at
> > various times to let individual drivers provide a list of named
> > states they support,  In some cases (like PCI) those lists could
> > be delegated to bus-specific code.
> 
> I've several times expressed my opinion there that it's not bus states
> that should be exposed by a driver but the actual states that the
> driver/device combination supports _regardless_ of what bus state they
> map to (if any). Bus states simply mean nothing at this point (Unless
> you are the bus driver).

I mostly agree ... you can have a pm-stupid driver for a given device,
or a very smart one, and they might need to expose different PM models
through any /sys/devices/.../power/state type files.

My disagreement is with the assumption that none of those states
will ever map directly to bus states.  (For those busses which define
them; not all do, but PCI does.)  Or perhaps with the assumption
that the driver must not name its states after the bus states they
use, even in common scenarios without one-to-many confusions.


> Of course we need both top-down and bottom-up 
> dependency mecanisms to handle state changes, but at the user level, a
> given PCI driver shouldn't expose something like "D1", "D2" and "D3"...
> those are PCI states that don't have a well defined semantics (and may
> not be all supported by the device/driver). 

Well certainly if the device doesn't implement PCI_D1 in hardware, then
that name shouldn't be used for a driver state.  But if it has only one
driver state that uses PCI_D2, why rule out calling that state PCI_D2?
Lots of PCI drivers don't even try to subdivide the PCI states, so every
driver state directly corresponds to one PCI state.

The PCI state semantics are well enough defined, but as I recall you want
device-specific details going beyond what the spec covers.  That is a
rather different issue.


> However, it's whatever 
> functional states that device/driver supports that shall be exposed.
> Those can be "idle" and "suspended" for example, or there could be
> several levels of "suspended".

And it would be less confusing to name those "suspended" levels with
names that make sense on multiple levels, like "PCI_D2" etc, than to
needlessly proliferate other names for those states.


> Now of course, there is the problem that while such descriptive names
> might have a sense to a user (and even then, only in one language,
> english) they aren't very useful to some automated power management
> mecanism.

Depends on the mechanism, surely.  And "PCI_D2" is already in that
language-neutral "doesn't get translation" category anyway.  Regardless,
userspace tools should just compare tokens.

 
> That's the whole problem that needs solving, possibly by exposing as
> much as the state dependencies as possible, along eventually with
> informations such as can the device automatically trigger a transition
> out of this state, eventually informations relative to max power
> consumed in this state 

I consider all those issues orthogonal to the issues addressed by
the /sys/devices/.../power/state files:  (a) reporting the power
state the driver is currently maintaining, and (b) changing that
to another state supported by that driver.

- Dave

--===============44446118683202851==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============44446118683202851==--
