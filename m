From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH] PM: Document requirements for basic PM
	support in drivers (rev. 2)
Date: Tue, 13 Feb 2007 22:38:51 +0100
Message-ID: <200702132238.52384.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pm list <linux-pm@lists.osdl.org>, Nigel Cunningham <ncunningham@linuxmail.org>, Alan <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

Hi,

Appended is the second version of the patch document the requirements with
respect to the basic PM support in drivers and the testing of that.  I have
cleaned it up a bit and included some comments from Nigel.

Greetings,
Rafael


---
 Documentation/SubmittingDrivers         |   10 ++
 Documentation/power/drivers-testing.txt |  146 +++++++++++++++++++++++++++=
+++++
 2 files changed, 156 insertions(+)

Index: linux-2.6.20-git4/Documentation/SubmittingDrivers
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20-git4.orig/Documentation/SubmittingDrivers
+++ linux-2.6.20-git4/Documentation/SubmittingDrivers
@@ -87,6 +87,16 @@ Clarity:	It helps if anyone can see how =

 		driver that intentionally obfuscates how the hardware works
 		it will go in the bitbucket.
 =

+PM support:	Since Linux is used on many portable and desktop systems, your
+		driver is likely to be used on such a system and therefore it
+		should support basic power management by implementing, if
+		necessary, the .suspend and .resume methods used during the
+		system-wide suspend and resume transitions.  You should verify
+		that your driver correctly handles the suspend and resume, but
+		if you are unable to ensure that, please at least define the
+		.suspend method returning the -ENOSYS ("Function not
+		implemented") error.
+
 Control:	In general if there is active maintainance of a driver by
 		the author then patches will be redirected to them unless
 		they are totally obvious and without need of checking.
Index: linux-2.6.20-git4/Documentation/power/drivers-testing.txt
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ linux-2.6.20-git4/Documentation/power/drivers-testing.txt
@@ -0,0 +1,146 @@
+Testing suspend and resume support in drivers
+	(C) 2007 Rafael J. Wysocki <rjw@sisk.pl>
+
+Unfortunately, to effectively test the support for the system-wide suspend=
 and
+resume transitions in a driver, it is necessary to suspend and resume a fu=
lly
+functional system with this driver loaded.  Moreover, that should be done =
many
+times, preferably many times in a row, and separately for the suspend to d=
isk
+(STD) and the suspend to RAM (STR) transitions, because each of these cases
+involves different ordering of operations and different interactions with =
the
+machine's BIOS.
+
+Of course, for this purpose the test system has to be known to suspend and
+resume without the driver being tested.  Thus, if possible, you should fir=
st
+resolve all suspend/resume-related problems in the test system before you =
start
+testing the new driver.
+
+I. Preparing the test system
+
+1. Testing suspend to disk (STD)
+
+To verify that the STD works, you can try to suspend in the "reboot" mode:
+
+# echo reboot > /sys/power/disk
+# echo disk > /sys/power/state
+
+and the system should suspend, reboot, resume and get back to the command =
prompt
+where you have started the transition.  If that happens, the STD is most l=
ikely
+to work correctly, but you need to repeat the test at least a couple of ti=
mes in
+a row for confidence.  This is necessary because some problems only show u=
p on a
+second attempt at suspending and resuming a driver.  You should also test =
the
+"platform" and "shutdown" modes of suspend:
+
+# echo platform > /sys/power/disk
+# echo disk > /sys/power/state
+
+or
+
+# echo shutdown > /sys/power/disk
+# echo disk > /sys/power/state
+
+in which cases you will have to press the power button to make the system
+resume.  If that works, you are ready to test the STD with the new driver
+loaded.  Otherwise, you have to identify what is wrong.
+
+a) Test mode of STD
+
+To verify if there are any drivers that cause problems you can run the STD
+in the test mode:
+
+# echo test > /sys/power/disk
+# echo disk > /sys/power/state
+
+in which case the system should freeze tasks, suspend devices, disable non=
boot
+CPUs (if any), wait for 5 seconds, enable nonboot CPUs, resume devices, th=
aw
+tasks and return to your command prompt.  If that fails, most likely there=
 is
+a driver that fails to either suspend or resume (in the latter case the sy=
stem
+may hang or be unstable after the test, so please take that into considera=
tion).
+To find this driver, you can carry out a binary search according to the ru=
les:
+- if the test fails, unload a half of the drivers currently loaded and rep=
eat
+(that would probably involve rebooting the system, so always note what dri=
vers
+have been loaded before the test),
+- if the test succeeds, load a half of the drivers you have unloaded most
+recently and repeat.
+
+Once you have found the failing driver (there can be more than just one of
+them), you have to unload it every time before the STD transition.  In tha=
t case
+please make sure to report the problem with the driver.
+
+It is also possible that a cycle can still fail after you have unloaded
+all modules. In that case, you would want to look in your kernel configura=
tion
+for the drivers that can be compiled as modules (testing again with them as
+modules), and possibly also try boot time options such as "noapic" or "noa=
cpi".
+
+b) Testing minimal configuration
+
+If the test mode of STD works, you can boot the system with "init=3D/bin/b=
ash"
+and attempt to suspend in the "reboot", "shutdown" and "platform" modes.  =
If
+that does not work, there probably is a problem with a driver statically
+compiled into the kernel and you can try to compile more drivers as module=
s,
+so that they can be tested individually.  Otherwise, there is a problem wi=
th a
+modular driver and you can find it by loading a half of the modules you no=
rmally
+use and binary searching in accordance with the algorithm:
+- if there are n modules loaded and the attempt to suspend and resume fail=
s,
+unload n/2 of the modules and try again (that would probably involve reboo=
ting
+the system),
+- if there are n modules loaded and the attempt to suspend and resume succ=
eeds,
+load n/2 modules more and try again.
+
+Again, if you find the offending module(s), it(they) must be unloaded ever=
y time
+before the STD transition, and please report the problem with it(them).
+
+c) Advanced debugging
+
+In case the STD does not work on your system even in the minimal configura=
tion
+and compiling more drivers as modules is not practical or some modules can=
not
+be unloaded, you can use one of the more advanced debugging techniques to =
find
+the problem.  First, if there is a serial port in your box, you can set the
+CONFIG_DISABLE_CONSOLE_SUSPEND kernel configuration option and try to log =
kernel
+messages using the serial console.  This may provide you with some informa=
tion
+about the reasons of the suspend (resume) failure.  Alternatively, it may =
be
+possible to use a FireWire port for debugging with firescope
+(ftp://ftp.firstfloor.org/pub/ak/firescope/).  On i386 it is also possible=
 to
+use the PM_TRACE mechanism documented in Documentation/s2ram.txt .
+
+2. Testing suspend to RAM (STR)
+
+To verify that the STR works, it is generally more convenient to use the s=
2ram
+tool available from http://suspend.sf.net and documented at
+http://en.opensuse.org/s2ram .  However, before doing that it is recommend=
ed to
+carry out the procedure described in section 1.
+
+Assume you have resolved the problems with the STD and you have found some
+failing drivers.  These drivers are also likely to fail during the STR or
+during the resume, so it is better to unload them every time before the STR
+transition.  Now, you can follow the instructions at
+http://en.opensuse.org/s2ram to test the system, but if it does not work
+"out of the box", you may need to boot it with "init=3D/bin/bash" and test
+s2ram in the minimal configuration.  In that case, you may be able to sear=
ch
+for failing drivers by following the procedure analogous to the one descri=
bed in
+1b).  If you find some failing drivers, you will have to unload them every=
 time
+before the STR transition (ie. before you run s2ram), and please report the
+problem with them.
+
+II. Testing the driver
+
+Once you have resolved the suspend/resume-related problems with your test =
system
+without the new driver, you are ready to test it:
+
+1. Build the driver as a module, load it and try the STD in the test mode
+(cf. 1a)).
+
+2. Compile the driver directly into the kernel and try the STD in the test=
 mode
+(cf. 1a)).
+
+3. Build the driver as a module, load it and attempt to suspend to disk in=
 the
+"reboot", "shutdown" and "platform" modes (cf. 1).
+
+4. Compile the driver directly into the kernel and attempt to suspend to d=
isk in
+the "reboot", "shutdown" and "platform" modes (cf. 1).
+
+5. Build the driver as a module, load it and attempt to run s2ram (cf. 2).
+
+6. Compile the driver directly into the kernel and attempt to run s2ram (c=
f. 2).
+
+Each of the above tests should be repeated several times and if any of them
+fails, the driver cannot be regarded as suspend/resume-safe.
