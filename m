From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: Hotplug events during sleep transition
Date: Wed, 28 Dec 2005 21:13:14 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0512282111290.3218-100000@netrider.rowland.org>
References: <Pine.LNX.4.50.0512272026140.6491-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============46781962028689783=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.50.0512272026140.6491-100000@monsoon.he.net>
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
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============46781962028689783==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Tue, 27 Dec 2005, Patrick Mochel wrote:

> When the system is back up and userspace is started again, something
> should walk the device tree and reap the devices that are no longer
> present. The core could do this, so long as the flag was in struct device,
> though I'm not sure that it would know about the hooks to trigger a
> removal on the device's bus (or would it need to?). Then, we can free all
> the memory, do all the unregistering, and generate all the hotplug events.

Why do we need to do this?  Why can't we rely on devices being 
unregistered by the same mechanism that would operate in the absence of 
any suspend/resume?

> Of course, at that point, we'll need to discover any new devices, which is
> going to be bus-speciifc. But, with a few extra bits of infrastructure
> (per-bus objects, and a ->scan() method in struct bus_type), this will
> relatively simple..

Again, why do we need anything special?  What's wrong with the existing 
method for discovering new hotplugged devices?

Alan Stern


--===============46781962028689783==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============46781962028689783==--
