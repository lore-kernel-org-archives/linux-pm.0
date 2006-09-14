From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Subject: [RFC] CPUFreq PowerOP integration, Issues/TODO 3/3
Date: Thu, 14 Sep 2006 18:52:33 +0400
Message-ID: <45096CB1.5030104@gmail.com>
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
Cc: kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

- speedstep-centrino.c and speedstep-centrino-pm_core.c are no longer relev=
ant
to CPUFreq - need to be moved out of cpufreq folder
- drivers/acpi/processor_perflib.c: needs cleanup. Now it is used by PM Core
but is compiled under CONFIG_CPU_FREQ and contains CPUFreq dependent code
- cpufreq.c code needs fixing to handle creation of operating points at
arbitrary moment ( to function properly on empty points list). For the time
being it is assumed that initialization order is: acpi, pm core, powerop, p=
oints
registration, cpufreq core
- cpufreq statistics is broken
- hotplug/sysdev_driver needs investigation
- pm core needs hotplug support
- example of dependent operating point registration module
- is any functionality affected by removing flags export from legacy cpufreq
driver?
- suspend/resume
