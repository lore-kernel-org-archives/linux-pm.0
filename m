From: Aishwarya Pant <aishpant@gmail.com>
Subject: [PATCH] Documentation/ABI: update cpuidle sysfs documentation
Date: Mon, 22 Jan 2018 21:39:22 +0530
Message-ID: <20180122160922.GA13380@mordor.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34190 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750997AbeAVQJ3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jan 2018 11:09:29 -0500
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Greg KH <gregkh@linuxfoundation.org>, linux-doc@vger.kernel.org
Cc: Julia Lawall <julia.lawall@lip6.fr>

Update cpuidle documentation using git logs and existing documentation
in Documentation/cpuidle/sysfs.txt. This might be useful for scripting
and tracking changes in the ABI.

Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
---
 Documentation/ABI/testing/sysfs-devices-system-cpu | 79 ++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index bfd29bc8d37a..f38e52d08be1 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -126,6 +126,85 @@ Description:	Discover cpuidle policy and mechanism
 		See files in Documentation/cpuidle/ for more information.
 
 
+What:		/sys/devices/system/cpu/cpuidle/current_driver
+What:		/sys/devices/system/cpu/cpuidle/available_governors
+What:		/sys/devices/system/cpu/cpuidle/current_governor
+Date:		September 2007
+KernelVersion:	v2.6.24
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:
+		With the cpuidle_sysfs_switch boot option enabled (meant for
+		developer testing), the following three attributes are visible
+		instead:
+
+		current_driver: (RO) Display the current idle mechanism.
+
+		available_governors: (RO) Display a space separated list of
+		available governors
+
+		current_governor: (RW) Display the current idle policy. Users
+		can switch the governor at runtime by writing to this file.
+
+
+What:		/sys/devices/system/cpu/cpuX/cpuidle/stateN/name
+What:		/sys/devices/system/cpu/cpuX/cpuidle/stateN/latency
+What:		/sys/devices/system/cpu/cpuX/cpuidle/stateN/power
+What:		/sys/devices/system/cpu/cpuX/cpuidle/stateN/time
+What:		/sys/devices/system/cpu/cpuX/cpuidle/stateN/usage
+Date:		September 2007
+KernelVersion:	v2.6.24
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:
+		The directory /sys/devices/system/cpu/cpuX/cpuidle contains per
+		logical CPU specific cpuidle information for each online cpu X.
+		The processor idle states which are available for use have the
+		following attributes:
+
+		name: (RO) Name of the idle state (string).
+
+		latency: (RO) The latency to exit out of this idle state (in
+		microseconds).
+
+		power: (RO) The power consumed while in this idle state (in
+		milliwatts).
+
+		time: (RO) The total time spent in this idle state (in microseconds).
+
+		usage: (RO) Number of times this state was entered (a count).
+
+
+What:		/sys/devices/system/cpu/cpuX/cpuidle/stateN/desc
+Date:		February 2008
+KernelVersion:	v2.6.25
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:
+		(RO) A small description about the idle state (string).
+
+
+What:		/sys/devices/system/cpu/cpuX/cpuidle/stateN/disable
+Date:		March 2012
+KernelVersion:	v3.10
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:
+		(RW) Option to disable this idle state (bool). The behavior and
+		the effect of the disable variable depends on the implementation
+		of a particular governor. In the ladder governor, for example,
+		it is not coherent, i.e. if one is disabling a light state, then
+		all deeper states are disabled as well, but the disable variable
+		does not reflect it. Likewise, if one enables a deep state but a
+		lighter state still is disabled, then this has no effect.
+
+
+What:		/sys/devices/system/cpu/cpuX/cpuidle/stateN/residency
+Date:		March 2014
+KernelVersion:	v3.15
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:
+		(RO) Display the target residency i.e. the minimum amount of
+		time (in microseconds) this cpu should spend in this idle state
+		to make the transition worth the effort.
+
+
 What:		/sys/devices/system/cpu/cpu#/cpufreq/*
 Date:		pre-git history
 Contact:	linux-pm@vger.kernel.org
-- 
2.16.0
