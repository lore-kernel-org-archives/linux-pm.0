From: Adam Belay <abelay@novell.com>
Subject: [RFC] Mapping Device Power States
Date: Thu, 07 Apr 2005 17:25:50 -0400
Message-ID: <1112909150.21887.18.camel@linux.site>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============15527819024976797=="
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
To: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============15527819024976797==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


Linux supports a wide variety of hardware, each with different power
management characteristics and capabilities.  However, power management
statistics (e.g. calling a power tick for determining an idling) are
generally gathered at the class device level.  In order for class
devices to relate bus specific power states to their own state change
intentions, it may make sense to have a table mapping each bus level
power state to its corresponding generic Linux power state.

Another problem with having multiple separate states is that it is very
difficult to relate the power requirements of child devices when the
parent has a different set of bus level power states.

I would like to explore the possibility of defining a set of generic
power states, to which each bus level state can be mapped.  It might be
as follows:

functional - the device is operational.
context - the current data/operations passing through the device
configuration - resources, firmware, settings done in *probe, etc.

POWER_ON: the device is fully functional
POWER_LIGHT: device context and configuration are maintained, but device
isn't functional.
POWER_MODERATE: device configuration is maintained, but the context is
not.  The device isn't functional
POWER_DEEP: no device configuration or context is maintained, but device
is not fully off.  The device is not functional.
POWER_OFF: no power is applied to the device.  The device is not
functional.

Each lower state would save more power, but also require more latency
when returning to "POWER_ON".  When a device is in one of the above
specific power mode classes, it's up to the device driver to control
more fine grained power transitions.

Comments?

Thanks,
Adam



--===============15527819024976797==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============15527819024976797==--
