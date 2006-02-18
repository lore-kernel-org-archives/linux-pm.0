From: Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [PATCH 2/5] [pm] Add state field to pm_message_t (to
 hold actual state device is in)
Date: Fri, 17 Feb 2006 22:56:52 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0602172239570.30097-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0602171757360.30811-100000@monsoon.he.net>
	<20060217210900.514b5f4c.akpm@osdl.org>
	<Pine.LNX.4.50.0602172136240.6792-100000@monsoon.he.net>
	<20060217221009.30f29aa2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============36282157871688492=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060217221009.30f29aa2.akpm@osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

--===============36282157871688492==
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Fri, 17 Feb 2006, Andrew Morton wrote:

> Would it make sense to enumerate these low-power states, rather than a bare
> u32?

The number, name, and meaning of the power states differ on a bus-by-bus
basis. PCI has D0-D3, which are well defined by the PCI spec. ACPI defines
states of the same name, but less rigidly defined, for various devices.
I believe USB has only "on" and "off".

One generality in all buses that I've seen so far consider state '0' to be
on and functioning. The low-power states increment from there - the higher
the number, the less power is being consumed and the longer it takes to
bring the device back to a functioning state. Even buses with 2 states
fall into this category, since "on" maps to 0, and "off" maps to anything
non-zero.

To answer your question: yes, it would make sense to enumerate the number,
but only on a per-bus basis. Ideally, the bus would export the states that
it supports, either directly to userspace or via the driver core and the
per-device state file in sysfs.

But, we're not to that point yet. For now, the writer of the file needs to
know what range of values the bus and/or device is expecting. It would be
nice to have a silly little program that could make this easier on a
user..

> How, from the above message, is the driver to know that it's being asked
> for a low-power state rather than an `off' state?   Via `state' I guess.

For PCI drivers at least, each driver's suspend function calls
pci_choose_state() to let the PCI core decide what the actual PCI power
state is that the device should enter. Before these patches, the PCI core
would always return PCI_D3hot on a suspend request. Now, it looks at
'state' and uses that as a hint - if it's set and within range, then it's
treated as a PCI D state; otherwise, the driver gets back PCI_D3hot.

> I can see that the kernel would have trouble asking a device to go into a
> particular low-power state because of the variation in capabilities between
> devices.  Perhaps the kernel should send the driver some higher-level piece
> of information informing it what's going on, let the driver choose an
> appropriate power state?

The kernel only chooses the state on a system suspend transition, and
that's exactly what happens - the driver maps a SUSPEND request,
regardless of what .state will be to the lowest power state it supports.

However, these patches are for device power transitions initated from
sysfs. With these, there is a user/utility/daemon on the other side that
knows what power states the device supports and when a good time to enter
them is. IOW, it's a policy decision that uses the sysfs interface (and
this plumbing) as the mechanism for implementing it.


	Pat

--===============36282157871688492==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============36282157871688492==--
