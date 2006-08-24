From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Subject: [RFC] CPUFreq PowerOP integration, Intro 0/3
Date: Thu, 24 Aug 2006 05:23:32 +0400
Message-ID: <44ECFF94.3030506@gmail.com>
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

Integrating CPUFreq and PowerOP was discussed at the Linux PM summit
and in recent emails exchanges.  Some say keep them separate and some
say they must be integrated.  There is actually a very natural point
where integration makes sense - cpufreq_driver. This patchset presents
that integration point and is submitted for discussion.

The patches do not change the functionality of the cpufreq core.
Instead the idea is to redesign the tightly coupled interfaces of
cpufreq to clearly separate the arch dependent and independent pieces
layers.  This enables cpufreq to become arch independent and can start
to use the named operating points in all its layers.

PowerOP  replaces cpufreq driver as the h/w independent interface for
operating points.  PM core handles the h/w specific details for
defining the power parameters and setting the power parameters in h/w
registers.  Operating point definition/registration is now independent
of cpufreq.

Please note, that all userspace/kernel governor concepts, legacy sysfs cpuf=
req
interface remain untouched and SMP case is accounted in the resulting code =
as
well.

Highlights:

cpufreq.c
- get rid of cpufreq driver calls. the calls are replaced be calls to arch
independent freq_helpers (freq_helpers.c)
- available frequences sysfs interface now can be handled in arch independe=
nt
way
- cpufreq_sysdev_driver now serves only cpufreq core internad needs upon cpu
add/remove events (since all hw related is handled by PM Core)
- cpufreq_powerop_call() is added to handle operting point registration in =
the
kernel by an independent module at arbitrary moment

freq_table.c (now freq_helpers.c)
- get rid of cpufreq_frequency_table structures as input parameter and made=
 the
code arch independent by leveraging PowerOP interface
- routine remain the same but are no longer used by arch dependent code but=
 by
cpufreq core arch independent code instead
- all routines are arch independent; the only shared knowledge is platform
power pameter names (string)
- target() method expects power parameter names "freqN", "vN" are supported=
 by
PM Core for cpu N
- setpolisy() method expects power parameter anmes "hfreqN", "lfreqN", "vN"=
 are
supported by PM Core for cpu N
