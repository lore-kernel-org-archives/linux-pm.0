From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Subject: [RFC] PowerOP, Intro 0/3
Date: Tue, 08 Aug 2006 05:34:06 +0400
Message-ID: <44D7EA0E.4070303@gmail.com>
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
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

What's changed highlights:

- PowerOP Core is completely arch independent
- PowerOP Core provides interface to create/destroy, get/set
  operating points
- PowerOP Core maintains list of operating points  which can
  be referenced by names
- PowerOP Core allows an upper layer to operate on arbitrary
  subset of power parameters available on a certain platform
- More integration with cpufreq and omap cpufreq driver clean up
  (hw access code is removed)

PowerOP is a system power parameter management API submitted for
discussion.

This patch set is a follow-up to the PowerOP/cpufreq integration
discussion in the PM summit back in April and the continued discussion
of the small PM group and linux-pm list.

Overall proposed PM framework picture is the following:

                                                           user space
-----------------------------------------------------------------
        ----------                                      kernel space
     | CPU freq |
       ----------        =

          ^                =

           |                =

          v              =

  ------------------------
|          PowerOP       |
  -------------------------
                                               arch independent
------------------------------------------------------------------------
                                               arch specific
 --------------------------
|         PM Core         |
 -------------------------
  ------------------------------
|     Clock/Voltage FW    |
  ------------------------------

In the whole, PowerOP is designed to be completely arch independent
and and allows to create, write and read power parameters in a
form adopted by a layer above PowerOP (cpufreq for example).

PM Core provides access to all power parameters available on a
certain platform and in a pair with PowerOP allows for a power
control layer above PowerOP operates by arbitrary subset of
power parameters (cpufreq for ex. uses 2 out of 8 power parameters
available on an omap1 platform what will be shown in follow-up
patch but one can imaging other layer which utilize from 1 upto 8
power parameters).

Nowadays Linux has clock framework - well established interface to access
hw clocks and the layer which handles clocks interdependencies. Similar
voltage framework is on the way. Such combined clock/voltage framework
provides a good interface to get/set clock and voltage hw registers.
Clock/voltage framework utilization gives significant advantage in
power management providing dynamic clocks/voltages control in
addition to "on demand" power parameters settings capability provided by
PowerOP.

This reference implementation is an example of integrating cpufreq and
PowerOP on the OMAP 1710.
