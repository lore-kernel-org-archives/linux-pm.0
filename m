From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] A New Power Management API
Date: Sat, 16 Apr 2005 10:27:53 -0700
Message-ID: <200504161027.53592.david-b@pacbell.net>
References: <1113533193.3451.40.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============55974700464183713=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1113533193.3451.40.camel@localhost.localdomain>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
Cc: Adam Belay <abelay@novell.com>
List-Id: linux-pm@vger.kernel.org

--===============55974700464183713==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 14 April 2005 7:46 pm, Adam Belay wrote:

> The new API uses a power container/domain model. 

I like that as a basic organizing principle, and I don't think
anyone has problems with the notion that the power relationships
can't always map directly to the physical device tree.

Could you describe a bit about how the containers behave?  For
example, when a device drops its power consumption, how does it
notify its container?  And when sets of devices -- e.g. all USB
devices, all PCI devices -- support the same power states, how
will that code be shared?  Would "struct power_device" be the
driver model replacement for "struct power"?

Also, I'd rather see "struct system_power_state *" everywhere
you're now passing "int system_state" in the API.

- Dave

--===============55974700464183713==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============55974700464183713==--
