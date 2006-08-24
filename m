From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Subject: PowerOP, Intro 0/3
Date: Thu, 24 Aug 2006 05:08:30 +0400
Message-ID: <44ECFC0E.10803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

The PowerOP Core provides completely arch independent interface
to create and control operating points which consist of arbitrary
subset of power parameters available on a certain platform.

PowerOP Core upper layer interface provides the following capabilities:
- to register an operating point by passing an idenificator of the point
represened by a string and arbitrary substet of power paremeters available =
on a
certain platform by a string (parameter name) and value pairs.
- to unregister operating point by name
- to set operating point by name
- to get values of arbitrary subset of platform power parameters associated
this  a point (point is passed by name or NULL to get current parameter val=
ues
from hw)

PowerOP get and register point APIs use name/value pairs for the power
parameters which eliminate the need for data structure sharing between
the PM core and consumers of the PowerOP API.   Earlier versions
required include/asm-xxx/power_params.h to be included in both places.

This also enables a variable argument list for the registration and get
APIs.  Some operating points may only need to work with a subset of the
power parameters.  In this case the creator of the operating point only
needs to provide the name/value pair for the parameters required for
that point.  The rest are set to a don't care value by the internals.

PowerOP is a building block for power management on systems that have a
large set of power parameter that can adjusted to maximize power and
operational efficiency.   Mobile consumer devices are examples of these
systems that require the PowerOP features.   However, PowerOP works
just as well on systems with one or two parameters.  The API allows the
h/w layer to define what parameters are available on that platform.

Operating points can be registered at anytime.  Registration can occur
from a architecture init-call, loadable kernel module or some other
layer.  Operating point registration notifiers are provided for layers,
such as cpufreq, that could take advantage of new operating
points that become available or just need to know when operating points
are loaded.

PowerOP continues to support in kernel governer concepts from cpufreq as we=
ll
as userspace policy managers.
