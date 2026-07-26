Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A113242DF
	for <linux-pm@vger.kernel.org>; Sun, 26 Jul 2026 11:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785065672; cv=none; b=XV7bhAqxjsXxO8ZHJblLSXLj6ua4TB6wA2EOPPMU5bc05VDlVJ61pY/ko3j4W7OIGBS/j/VYZ7p4Vnzj3/tYmX06+BrTZNoci2ZWALlXtTIHvrTntqT8coIZrRIIyFPfbwnBg1Op4T6EoHVMzbQf8hS2rjFh6FsvSv7mAOGzxVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785065672; c=relaxed/simple;
	bh=aBMMPvXQJryZdwPrZ7v2MDCwRygwJMIfyk5bZtaLlzs=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Agce8YJqdHBOhI2tqJi98543NNhpw+W7XsM9X8C2rWdKkK7PnRh2lMtLE6XeZfxa6beOzOvGt97yqm6+9l2vEdRVzZ+e9c3Wg1XF+Cak8QnJllkvAKlXD2BRZVNfoYc9UbjOK9GcD9r5EYHdwKHXH5Z+RwjD0a1vVAz5e6mfZxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l417c2aL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l417c2aL"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B158AC2BCFA
	for <linux-pm@vger.kernel.org>; Sun, 26 Jul 2026 11:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785065671;
	bh=aBMMPvXQJryZdwPrZ7v2MDCwRygwJMIfyk5bZtaLlzs=;
	h=From:To:Subject:Date:From;
	b=l417c2aLFK2l92xCveiGct+ZVFYBYrnHAxDXAwG5FvlJVndvDDVSdOoPtkcYLVYYc
	 7AjVxN294MznRo5QyaYepf5idPpLmamEoYdnK0h7NwS+GgVoT6iOHfwrGYyutxJwto
	 2Sg7v0bwjA4ElJoMjXgjlUNh0vcFLb7mQpbctPAD77r4sHohuSwmpnDhPeOBZXsiYa
	 Q2epUOHXU8cliSDQ/SrA1GxWzjij3AwShzm/vsqJ5Uc1yv35kLrXfUGaY5VfJzDGIl
	 SC+apFgHT06r/L0OSPxJBxN0o26hYOWJ8DYxWA9hK3Z01PG5BWqswP3qetK06a/C9E
	 bMO6KNeyLH8vw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 95389C41612; Sun, 26 Jul 2026 11:34:31 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221795] New: amd-pstate: max_perf stuck at nominal_perf after
 boot on Ryzen AI 9 HX 370
Date: Sun, 26 Jul 2026 11:34:31 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mogdad@yahoo.Com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-221795-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D221795

            Bug ID: 221795
           Summary: amd-pstate: max_perf stuck at nominal_perf after boot
                    on Ryzen AI 9 HX 370
           Product: Power Management
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: mogdad@yahoo.Com
        Regression: No

Created attachment 310511
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D310511&action=3Dedit
a full state dump taken in the performance profile: uname, cmdline, firmwar=
e=20=20
version, cpupower frequency-info, lscpu -ae, every relevant cpufreq and=20=
=20
acpi_cppc sysfs value, MSR HWCR, and the system

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
FORM FIELDS
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

Product:        Power Management
Component:      cpufreq
Kernel Version: 7.1.4-1-cachyos
Hardware:       x86-64
OS:             Linux
Severity:       normal
Summary:        amd-pstate: max_perf stuck at nominal_perf after boot,
single-threaded frequency capped to base clock (Ryzen AI 9 HX 370)

(If "Power Management / cpufreq" is not available in the dropdown, use
 Product "Drivers" and the closest power-management component.)

Suggested CC: the amd-pstate maintainers listed in MAINTAINERS
              (Mario Limonciello, Perry Yuan, Gautham R. Shenoy)


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
DESCRIPTION
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

Note: I am not a kernel developer. My laptop felt slower than it should and=
 I
worked through the diagnosis with an AI assistant, which suggested the tests
and helped interpret the output. All measurements below were taken on my own
machine and are reproducible; the interpretations may be wrong. Corrections
welcome, and I am happy to re-run anything or test patches.

Also note: this is a CachyOS kernel, which carries out-of-tree patches. I h=
ave
not yet confirmed the behaviour on a vanilla mainline kernel. Please treat =
the
report accordingly; I can test a vanilla build if that helps.


SUMMARY
-------

amd-pstate initialises correctly at boot: shortly after startup,
scaling_max_freq reads 5157895, the true hardware maximum. But by the time =
the
desktop session is up, scaling_max_freq has dropped to the nominal frequency
(2000000) on all 24 policies while cpuinfo_max_freq still reports 5157895.
Single-threaded workloads then run at exactly 2.0 GHz instead of ~4.9 GHz.

The trigger is a platform_profile change, which the desktop session performs
shortly after login. Every subsequent platform_profile change re-applies the
clamp. This happens on every boot and after every suspend/resume cycle, so =
in
practice the machine is always clamped by the time a user would notice.

Re-registering the driver (writing "guided" then "active" back to
/sys/devices/system/cpu/amd_pstate/status) restores the correct limits and
makes the system immune to the trigger for the rest of the session.

Impact: Geekbench 7 single-core went from 1100 to ~2450. Idle power managem=
ent
also improved (package now reaches 2.1 W in power-saver, which it never did
before).


SYSTEM
------

Kernel:            7.1.4-1-cachyos
CPU:               AMD Ryzen AI 9 HX 370 (Strix Point, 4x Zen 5 + 8x Zen 5c,
                   12C/24T)
Machine:           ASUS Zenbook S 16 UM5606WA
BIOS:              UM5606WA.321, 10/14/2025
amd_pstate/status: active (amd-pstate-epp)
Governor:          performance
EPP:               performance
platform_profile:  performance
cpufreq/boost:     1 (global and per-policy)
Kernel cmdline:    quiet nowatchdog splash rw root=3DUUID=3D...
                   (no amd_pstate parameter)
Running:           power-profiles-daemon, asusd
Not running:       tlp; sched_ext disabled


SYMPTOM 1: single-threaded workloads capped at exactly nominal
--------------------------------------------------------------

Pinned to CPU 0 (a Zen 5 core, highest_perf =3D 208), continuous load, no
migration possible:

  $ taskset -c 0 perf stat -e cycles,task-clock -- stress-ng --cpu 1 --time=
out
10s

      20 058 634 429      cycles:u
           10 015,23 msec task-clock:u

20058634429 / 10.015 s =3D 2.003 GHz. The HX 370 base clock is 2.0 GHz.


SYMPTOM 2: the driver knows the real maximum but does not use it
----------------------------------------------------------------

  $ grep .
/sys/devices/system/cpu/cpu0/cpufreq/{scaling_max_freq,cpuinfo_max_freq}
  scaling_max_freq:2000000
  cpuinfo_max_freq:5157895

All 24 policies report scaling_max_freq =3D 2000000.

Writing cpuinfo_max_freq back into scaling_max_freq on every policy is acce=
pted
without error but silently reverted: a subsequent read still returns 200000=
0,
and the measured frequency stays at 2.002 GHz. The driver actively re-impos=
es
the clamp.


SYMPTOM 3: boost is enabled everywhere, including in firmware
--------------------------------------------------------------

  $ cat /sys/devices/system/cpu/cpufreq/boost
  1
  $ grep . /sys/devices/system/cpu/cpufreq/policy*/boost | sort -u
  ... all report 1

  $ sudo rdmsr -a 0xc0010015 | sort -u
  1c9006011

MSR HWCR bit 25 (CpbDis) is 0 on every core, so Core Performance Boost is
enabled at firmware level. This is not a BIOS setting.


SYMPTOM 4: the clamp is not honoured under multi-core load
-----------------------------------------------------------

With scaling_max_freq =3D 2000000 on all 24 policies:

  $ perf stat -e cycles,task-clock -- stress-ng --cpu 24 --timeout 10s

     642 698 375 128      cycles:u
          238 108,23 msec task-clock:u

642698375128 / 238.108 s =3D 2.70 GHz average per thread, i.e. above the
advertised 2.0 GHz ceiling, with observed peaks around 3.1 GHz.

Loading only two Zen 5 cores is more striking still (taskset -c 0,3,12,15,
i.e. cores 0x0 and 0x3 with their SMT siblings), as seen by turbostat:

  Core    CPU     Bzy_MHz PkgWatt
  -       -       4334    18.80
  0x0     0       4440    18.79
  0x0     12      4440
  0x3     3       4440
  0x3     15      4440

4440 MHz with the ceiling still at 2000000. The switchover therefore happens
somewhere between one and two active cores: the SMU appears to honour the C=
PPC
max_perf hint only in the low-activity regime.

Multi-core performance is degraded too (2.7-3.1 GHz instead of ~4.9 GHz), j=
ust
not clamped to the exact nominal value the way single-threaded work is.


SYMPTOM 5: a multi-core load transiently lifts the clamp
---------------------------------------------------------

After running the two-core test above, a subsequent single-threaded pinned =
run
returned 4.808 GHz, while scaling_max_freq still read 2000000. So the sysfs
value does not faithfully reflect the max_perf actually written to
MSR_AMD_CPPC_REQ, and sufficient activity un-sticks the clamp on its own.

This makes the bug easy to miss and easy to lose while investigating: one
multi-core benchmark is enough to mask it until the next trigger.


SYMPTOM 6: before the driver reset, any platform_profile change re-triggers=
 it
---------------------------------------------------------------------------=
---

  $ powerprofilesctl set balanced && sleep 2 && powerprofilesctl set
performance && sleep 2
  $ taskset -c 0 perf stat -e cycles,task-clock -- stress-ng --cpu 1 --time=
out
10s
      20 030 590 526      cycles:u
           10 013,24 msec task-clock:u          -> 2.000 GHz

It also reproduces by writing the sysfs file directly, which rules out
power-profiles-daemon as the sole cause and points at the platform_profile
path itself (asus-wmi):

  $ echo balanced | sudo tee /sys/firmware/acpi/platform_profile
  $ sleep 2
  $ echo performance | sudo tee /sys/firmware/acpi/platform_profile
  $ sleep 2
  $ taskset -c 0 perf stat -e cycles,task-clock -- stress-ng --cpu 1 --time=
out
10s
      20 050 594 801      cycles:u
           10 016,86 msec task-clock:u          -> 2.002 GHz


SYMPTOM 7: after re-registering the driver, the trigger no longer works
------------------------------------------------------------------------

  $ echo guided | sudo tee /sys/devices/system/cpu/amd_pstate/status
  $ sleep 1
  $ echo active | sudo tee /sys/devices/system/cpu/amd_pstate/status
  $ cat /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq
  5157895

Repeating the platform_profile toggle afterwards no longer degrades anythin=
g:
4.800 GHz on two threads, 4.867 GHz on one.

This suggests an initialisation ordering problem at boot: asusd and/or
power-profiles-daemon setting the platform profile while amd-pstate is still
initialising leaves the driver with an inconsistent limit table. Once the
driver is re-registered after everything has settled, it behaves correctly.


SYMPTOM 8: it does not survive suspend/resume, and resume is worse
-------------------------------------------------------------------

After a suspend/resume cycle the clamp comes back.

One further complication: cpuinfo_max_freq is not a reliable reference eith=
er.
It has been observed both ways in the clamped state - still correctly repor=
ting
5157895 during the early investigation, and collapsed to 2000000 on later
occasions, both after resume and after boot once the session had applied its
power profile. When both values read 2000000, no sysfs file exposes the real
hardware maximum any more, and any workaround that compares the two to deci=
de
whether action is needed becomes a silent no-op:

  juil. 26 10:41:08 systemd[1]: Starting Reinitialise amd_pstate apres repr=
ise
de veille...
  juil. 26 10:41:10 amd-pstate-fix[10527]: Rien a faire : scaling_max_freq =
=3D
2000000 Hz
  juil. 26 10:41:10 systemd[1]: amd-pstate-fix-resume.service: Deactivated
successfully.

(that message is only printed when scaling_max_freq >=3D cpuinfo_max_freq)

The re-registration has to be applied unconditionally on resume.

Update: once a re-registration has actually succeeded (see symptom 9), the
immunity appears to extend across suspend/resume. A later resume found the
limits already correct before the workaround even ran:

  juil. 26 12:07:55 amd-pstate-fix[4723]: reference =3D 5157895 Hz, actuel =
=3D
5157895 Hz

On that reading, the clamp returning after resume was a consequence of the
driver never having been correctly re-registered in the first place, rather
than a separate resume-specific failure. This is a single observation so fa=
r.


SYMPTOM 9: the re-registration itself fails if applied too early after boot
---------------------------------------------------------------------------

Writing "guided" then "active" back to amd_pstate/status does not always wo=
rk.
When the clamp is already present a few seconds into the boot sequence, the
write completes without error but the limits stay at nominal:

  juil. 26 11:54:33 systemd[1]: Starting Reinitialise amd_pstate au
demarrage...
  juil. 26 11:54:33 amd-pstate-fix[1120]: avant  =3D 2000000 Hz (cpuinfo_ma=
x_freq
=3D 2000000 Hz)
  juil. 26 11:54:35 amd-pstate-fix[1120]: apres  =3D 2000000 Hz

The exact same command run manually a few minutes later, same boot, restored
5157895 immediately. The driver appears to rebuild its tables from whatever
CPPC state is current, and that state is still wrong immediately after boot.

Practical consequence: a workaround cannot rely on the write succeeding, and
has to retry until the limits actually come back.


JOURNAL EVIDENCE
----------------

The workaround script logs the value it finds, so the systemd journal recor=
ds
the state automatically at each boot and each resume.

This is the clearest single piece of evidence, because both readings come f=
rom
the same boot. The service runs a few seconds after startup, before the des=
ktop
session is up, and finds the limits correct:

  juil. 26 11:38:41 systemd[1]: Starting Reinitialise amd_pstate apres asus=
d et
power-profiles-daemon...
  juil. 26 11:38:41 amd-pstate-fix[1122]: Rien a faire : scaling_max_freq =
=3D
5157895 Hz
  juil. 26 11:38:41 systemd[1]: Finished Reinitialise amd_pstate apres asus=
d et
power-profiles-daemon.

Reading the same file manually once the desktop has loaded, same boot, no
intervening action:

  $ cat /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq
  2000000

So amd-pstate starts out with correct limits and loses them later in the bo=
ot
sequence, when the session applies a power profile. The service above found
nothing to do and therefore never re-registered the driver, which is why the
clamp was free to appear afterwards.

After a resume, the same service logs the clamped value directly. The messa=
ge
shown is only printed when scaling_max_freq >=3D cpuinfo_max_freq, so on re=
sume
both values had collapsed to 2000000:

  juil. 26 10:41:08 systemd[1]: Starting Reinitialise amd_pstate apres repr=
ise
de veille...
  juil. 26 10:41:10 amd-pstate-fix[10527]: Rien a faire : scaling_max_freq =
=3D
2000000 Hz
  juil. 26 10:41:10 systemd[1]: amd-pstate-fix-resume.service: Deactivated
successfully.


REPRODUCTION
------------

1. Boot normally with power-profiles-daemon and asusd running.
2. cat /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq
   -> 2000000, while cpuinfo_max_freq -> 5157895.
3. taskset -c 0 perf stat -e cycles,task-clock -- stress-ng --cpu 1 --timeo=
ut
10s
   -> ~2.0 GHz.
4. echo guided | sudo tee /sys/devices/system/cpu/amd_pstate/status
   sleep 1
   echo active | sudo tee /sys/devices/system/cpu/amd_pstate/status
5. Repeat step 3 -> ~4.9 GHz.

Important: step 3 must be run before any multi-core load, otherwise the cla=
mp
lifts on its own (symptom 5) and the reproduction is lost.

Always reproduce in the "performance" profile. In "power-saver",
power-profiles-daemon sets per-policy boost to 0 and the cores cap at the
nominal frequency, which looks exactly like this bug (measured: 2.000 GHz w=
ith
boost =3D 0). That is expected behaviour and not what is reported here.

One observation muddied this and is worth recording. Immediately after a
successful re-registration, running "powerprofilesctl set power-saver" left
per-policy boost at 1 and a pinned single-threaded run measured 4.946 GHz. =
The
explanation, since verified, is that the machine was already in power-saver=
, so
the command was a no-op: the daemon does not re-apply an unchanged profile,=
 and
the boost flag was simply still set from the re-registration. Repeating the
sequence deliberately - re-register while in power-saver, then set power-sa=
ver
again - reproduces boost =3D 1 and 4.895 GHz, whereas any real profile tran=
sition
into power-saver gives boost =3D 0 and 2.000 GHz.

Note also that per-policy boost has been observed at 1 while clamped in the
performance profile, so the correlation between the boost flag and the clam=
p is
not straightforward.


REFERENCE OUTPUT
----------------

Healthy state, performance profile (cpupower frequency-info, CPU 8, a Zen 5c
core):

  driver: amd-pstate-epp
  energy performance preference: performance
  hardware limits: 605 MHz - 3.29 GHz
  current policy: frequency should be within 605 MHz and 3.29 GHz.
  boost state support:
    Supported: yes
    Active: yes
  amd-pstate limits:
    Highest Performance: 125. Maximum Frequency: 3.29 GHz.
    Nominal Performance: 76. Nominal Frequency: 2.00 GHz.
    Lowest Non-linear Performance: 23. Lowest Non-linear Frequency: 605 MHz.
    Lowest Performance: 23. Lowest Frequency: 599 MHz.
    Preferred Core Support: 0. Preferred Core Ranking: 0.

lscpu -ae in the same healthy state shows correctly differentiated maxima:
5157.8950 MHz on cores 0-3 (Zen 5), 3289.4741 MHz on cores 4-11 (Zen 5c).

In the degraded state, lscpu -ae reports MAXMHZ 2000.0000 on all 24 CPUs,
including the Zen 5c cores whose real maximum is 3.29 GHz. So this is a glo=
bal
clamp to the nominal frequency, not "stuck at the Zen 5 nominal".


WORKAROUND
----------

Three requirements, all learned the hard way:

  - the re-registration must be retried until it works (symptom 9)
  - cpuinfo_max_freq cannot be used to decide whether action is needed, sin=
ce
    it collapses too (symptom 8), so the known-good maximum is remembered i=
n a
    small state file instead
  - the systemd units need a long TimeoutStartSec, because the retry loop c=
an
    run for several minutes

/usr/local/bin/amd-pstate-fix:

  #!/bin/sh
  STATUS=3D/sys/devices/system/cpu/amd_pstate/status
  POLICY=3D/sys/devices/system/cpu/cpufreq/policy0
  REF=3D/var/lib/amd-pstate-fix.ref

  ATTEMPTS=3D10
  DELAY=3D20

  force=3D0
  [ "$1" =3D "--force" ] && force=3D1

  cur=3D$(cat "$POLICY/scaling_max_freq")
  cpuinfo=3D$(cat "$POLICY/cpuinfo_max_freq")

  ref=3D0
  [ -r "$REF" ] && ref=3D$(cat "$REF" 2>/dev/null)
  [ -z "$ref" ] && ref=3D0
  for v in "$cur" "$cpuinfo" "$ref"; do
      [ "$v" -gt "$ref" ] && ref=3D$v
  done
  echo "$ref" > "$REF" 2>/dev/null

  [ "$force" -eq 0 ] && [ "$cur" -ge "$ref" ] && exit 0

  reset_driver() {
      mode=3D$(cat "$STATUS")
      case "$mode" in
          guided) intermediate=3Dpassive ;;
          *)      intermediate=3Dguided  ;;
      esac
      echo "$intermediate" > "$STATUS"
      sleep 1
      echo "$mode" > "$STATUS"
      sleep 1
  }

  i=3D1
  while [ "$i" -le "$ATTEMPTS" ]; do
      reset_driver
      cur=3D$(cat "$POLICY/scaling_max_freq")
      [ "$cur" -ge "$ref" ] && exit 0
      i=3D$((i + 1))
      [ "$i" -le "$ATTEMPTS" ] && sleep "$DELAY"
  done
  exit 1

Driven by two oneshot units:

  # /etc/systemd/system/amd-pstate-fix.service
  [Unit]
  Description=3DReinitialise amd_pstate at boot
  After=3Dmulti-user.target power-profiles-daemon.service asusd.service
  Wants=3Dpower-profiles-daemon.service

  [Service]
  Type=3Doneshot
  ExecStartPre=3D/bin/sleep 10
  ExecStart=3D/usr/local/bin/amd-pstate-fix --force
  TimeoutStartSec=3D900
  RemainAfterExit=3Dyes

  [Install]
  WantedBy=3Dmulti-user.target

  # /etc/systemd/system/amd-pstate-fix-resume.service
  [Unit]
  Description=3DReinitialise amd_pstate after resume
  After=3Dsuspend.target hibernate.target hybrid-sleep.target
suspend-then-hibernate.target

  [Service]
  Type=3Doneshot
  ExecStartPre=3D/bin/sleep 5
  ExecStart=3D/usr/local/bin/amd-pstate-fix --force
  TimeoutStartSec=3D900

  [Install]
  WantedBy=3Dsuspend.target hibernate.target hybrid-sleep.target
suspend-then-hibernate.target

Confirmed across a reboot and a suspend/resume cycle, with no manual
intervention: scaling_max_freq stays at 5157895 and a pinned single-threaded
run measures 49789468684 cycles / 10.005 s =3D 4.977 GHz.


POSSIBLY RELATED: prefcore is disabled
---------------------------------------

  $ cat /sys/devices/system/cpu/amd_pstate/prefcore
  disabled
  $ cat /proc/sys/kernel/sched_itmt_enabled
  cat: /proc/sys/kernel/sched_itmt_enabled: No such file or directory

This is with a clean kernel cmdline (no amd_prefcore=3Ddisable) and clearly
heterogeneous rankings:

  $ grep . /sys/devices/system/cpu/cpu*/acpi_cppc/highest_perf | sort -t: -=
k2
-n
  cpu4-11, cpu16-23 : 125      # Zen 5c
  cpu1, cpu13       : 196      # Zen 5
  cpu2, cpu14       : 202      # Zen 5
  cpu0, cpu12       : 208      # Zen 5
  cpu3, cpu15       : 208      # Zen 5

cpupower reports "Preferred Core Support: 0. Preferred Core Ranking: 0." on
every CPU, so the driver does not consider preferred-core support to be
advertised, despite the clearly per-core rankings above.

Two related sysfs values that may be relevant:

  /sys/devices/system/cpu/cpu0/cpufreq/amd_pstate_highest_perf:196
  /sys/devices/system/cpu/cpu0/acpi_cppc/highest_perf:208
  /sys/devices/system/cpu/cpu0/acpi_cppc/guaranteed_perf:0

The driver caps highest_perf at 196 while ACPI reports 208 for the same cor=
e,
and guaranteed_perf reads 0 on every CPU.

Worth noting separately: amd_pstate_max_freq keeps the correct value (51578=
95)
even when cpuinfo_max_freq has collapsed to 2000000. It may be a more relia=
ble
reference than cpuinfo_max_freq for anyone writing a workaround.

Practical impact is modest (pinning Geekbench 7 single-core to a preferred =
core
only gains ~4.6%, 2357 -> 2465), but it may share a root cause with the cla=
mp,
since both involve amd-pstate misreading or mishandling the CPPC tables at
init.


POSSIBLY RELATED BUGS
---------------------

This may be a variant of the class of issues around per-policy boost_enabled
and max_perf handling in amd-pstate, e.g. the "prevent the per-policy
boost_enabled flag from getting out of sync with the actual state after boot
failures" fix that went into 6.14-rc2, and bug 218759 (highest_perf/prefcore
handling limiting performance on similar hardware).


ATTACHMENTS
-----------

Attached:

- a full state dump taken in the performance profile: uname, cmdline, firmw=
are
  version, cpupower frequency-info, lscpu -ae, every relevant cpufreq and
  acpi_cppc sysfs value, MSR HWCR, and the systemd journal for the workarou=
nd
  units across two boots and a resume
- acpidump

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
