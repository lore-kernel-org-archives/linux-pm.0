From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Subject: [RFC] CPUFreq PowerOP integration, Issues/TODO 3/3
Date: Thu, 24 Aug 2006 05:38:57 +0400
Message-ID: <44ED0331.2030005@gmail.com>
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

- speedstep-centrino.c and speedstep-centrino-pm_core.c are no longer relev=
ant =

to CPUFreq - need to be moved out cpufreq folder
- drivers/acpi/processor_perflib.c: needs cleanup. Now it is used by PM Core
but is compiled under CONFIG_CPU_FREQ and containd CPUFreq dependent code
- cpufreq.c code needs fixing to handle creation of operatin points at
arbitrary moment ( to function properly on empty points list). For the time =

being assumed initialization order is: acpi, pm core, powerop, points =

registration, cpufreq core
- cpufreq statistics is broken
- hotplug/sysdev_driver needs investigation
- pm core needs hotplug support
- expample of dependent operating point registration module
- is any functionality affected by removing flags export from legacy cpufreq
driver
- suspend/resume
