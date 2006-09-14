From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Subject: [RFC] CPUFreq PowerOP integration, Intro 0/3
Date: Thu, 14 Sep 2006 18:42:26 +0400
Message-ID: <45096A52.40706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750865AbWINOmT@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: pm list <linux-pm@lists.osdl.org>
Cc: Matthew Locke <matt@nomadgs.com>, Amit Kucheria <amit.kucheria@nokia.com>, Igor Stoppa <igor.stoppa@nokia.com>, kernel list <linux-kernel@vger.kernel.org>
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

Please note, that all userspace/kernel governor concepts, legacy sysfs cpufreq
interface remain untouched and SMP case is accounted in the resulting code as
well.

Highlights:

cpufreq.c
- get rid of cpufreq driver calls. the calls are replaced be calls to arch
independent freq_helpers (freq_helpers.c)
- available frequencies sysfs interface now can be handled in arch independent
way
- cpufreq_sysdev_driver now serves only cpufreq core internal needs upon cpu
add/remove events (since all hw related is handled by PM Core)
- cpufreq_powerop_call() is added to handle operating point registration in the
kernel by an independent module at arbitrary moment

freq_table.c (now freq_helpers.c)
- get rid of cpufreq_frequency_table structures as input parameter and made the
code arch independent by leveraging PowerOP interface
- routine remain the same but are no longer used by arch dependent code but by
cpufreq core arch independent code instead
- all routines are arch independent; the only shared knowledge is platform
power parameter names (string)
- target() method expects power parameter names "freqN", "vN" are supported by
PM Core for cpu N
- setpolisy() method expects power parameter names "hfreqN", "lfreqN", "vN" are
supported by PM Core for cpu N
