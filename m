From: Pavel Machek <pavel@suse.cz>
Subject: Re: Runtime device power management in userspace
Date: Mon, 26 Dec 2005 23:33:25 +0100
Message-ID: <20051226223325.GE1974@elf.ucw.cz>
References: <20051223143047.GC16463@f192.suse.de>
	<Pine.LNX.4.50.0512230706530.13289-100000@monsoon.he.net>
	<20051224004029.GC16043@elf.ucw.cz>
	<Pine.LNX.4.50.0512261234350.12383-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============097477370192079027=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.50.0512261234350.12383-100000@monsoon.he.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============097477370192079027==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Po 26-12-05 12:43:43, Patrick Mochel wrote:
> > Is there enough locking in driver core to make this safe?
> 
> The issue I stated is actually orthogonal to locking the device; but the
> answer to your question is: probably not. We should probably be taking the
> per-device semaphore to prevent against competing events that are trying
> to add/remove a device or driver.

Ok, thanks. That means that some races are still there, but they
probably don't matter for non-hotpluggable stuff like PCI, right?

> > Ouch and BTW *right* value is _2_, today... because state_store() uses
> > value from user as a pm_message_t.event. We should at least supply
> > some hint that it is runtime suspend in pm_message_t.flags --
> > unfortunately we do not have pm_message_t.flags yet.
> 
> And I don't think that we want it. I think that we want a completely
> different API for doing runtime PM. Using the same API will make the
> drivers more complicated by having to have a repeated control sequence for
> determing what state (and under what conditions) the device is entering.
> 
> Also, recall that the actual states the device and driver support could be
> different than any other device or driver (even when the device or driver
> are the same). What we need is a way for a driver to easily export the
> states that it supports and a way to enter those exported states (e.g. an
> array or linked list of state names and callbacks, like has been mentioned
> a few times before).
> 
> To that effect, the per-device power file and its semantics should go away
> completely and replaced with something that supports this new API.

Noone uses .../power API just now (except Holger :-), so I think we
can still change it. Currently it is horribly broken -- taking 0/2 and
passing it directly to pm_message_t.event. I don't think we can solve
worlds hunger today... but what about at least changing interface so
that it lists two states ("on" and "suspend") that are more or less
common to all drivers?
								Pavel

-- 
Thanks, Sharp!

--===============097477370192079027==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============097477370192079027==--
