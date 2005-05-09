From: Adam Belay <ambx1@neo.rr.com>
Subject: [RFC] Disabling Devices
Date: Sun, 8 May 2005 22:15:29 -0400
Message-ID: <20050509021528.GB27448@neo.rr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============26657099808060192=="
Return-path: <linux-pm-bounces@lists.osdl.org>
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
List-Id: linux-pm@vger.kernel.org

--===============26657099808060192==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


One potentially important aspect of power management is the ability for the
user to disable a device that he or she does not intend to use.  Our current
model does not allow for this.  Calling PMSG_SUSPEND won't cut it, because it
might enable wake events and is expecting the system to sleep.  It seems we
need to implement something specifically for this case.  Also, there is the
posibility of resource rebalancing, which requires yet another slightly
different behavior.

Consider if a user wanted to disable a pci bus...  If the bus was just
suspended, it would be straightforward, put all the children to sleep and
then turn off the bus.  However, in the case of disabling it (as in "do not
use me") all of the child devices would actually need to be unregistered.

Furthermore, take an ethernet controller as an example.  When suspending, just
run the driver specific logic.  When disabling, you actually want to unregister
from the net class interface.

Unbinding the driver may not be the solution, because the driver may be
retaining configuration state information lost during the power-down.

"Disabling" is just one possible user preference.  Selective-suspending a
device is another.  For example, if a user was using an ethernet interface on
a laptop, the wireless interface should probably reduce power consumption.
The kernel may be able to take care of this automatically via idle timers etc.

I'm interested in any opinions.  Should we try to support something like
this?  How might we go about it?

As another issue, how should we handle surprise removal between suspend and
resume?  It seems like we would need to tell the resume method about this.

Thanks,
Adam

--===============26657099808060192==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============26657099808060192==--
