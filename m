From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC 0/3] Runtime PM support for named power states
Date: Tue, 04 Oct 2005 23:04:35 -0700
Message-ID: <20051005060435.628B0EA5EC@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
References: <Pine.LNX.4.44L0.0509301536560.4470-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============11389691765899634=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0509301536560.4470-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: stern@rowland.harvard.edu, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============11389691765899634==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> Although it may not show up very clearly, these patches -- especially the 
> first -- are running up against the limitations and bad design choices 
> originally made for the PM core.

I think some parts just "grew"; not everything was "designed".  :)


> Particularly vexing was the use of a pm_message_t to store a device's
> current state.  The event field in pm_message_t doesn't represent a power
> state; it represents a _reason_ for a state transition.  Nevertheless, the
> current code insists on using it to identify states.

I suspect only driver code should ever care about device states.

The PM core should just tell drivers to become compatible with some
new constraint (like ACPI S3, generally implying devices in PCI D2
or D3; while S1 doesn't) ... and not worry about whether that involves
a state change or not.

Maybe they're already _in_ that state for example.


> Finally, there's no obvious mapping between the PM_EVENT_FROZEN and 
> PM_EVENT_SUSPENDED values and the new named states.  Obviously devices 
> will be left in _some_ state, but the PM core can't tell which.

The PM core shouldn't need to care.  If the driver is in a state
compatible with that message, all is fine; the driver should be
able to ignore the message.

That said, there's still confusion between FREEZE (which seems
more like a "standby" with focus on quick time to full-ON) and
SUSPEND (which for spinning up a disk would take part of a minute
to get back to full-ON).

- Dave


--===============11389691765899634==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============11389691765899634==--
