From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: acpi_idle and max_cpus
Date: Fri, 15 Jun 2012 17:28:31 +0200
Message-ID: <4FDB549F.1020002@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


Hi all,

I have a dual core Intel T9500.

I boot the cpu with the acpi_idle driver and intel_idle enabled in the
config.

The kernel is booted with maxcpus=3D1.

After the system has boot, I put cpu1 online via sysfs.

But I don't see any 'cpuidle' directory in the cpu's sysfs entry:

/sys/devices/system/cpu/cpu1/cpuidle (?)

When I look at the code I see the notifier is present for hotplug in
processor_driver.c and the cpuidle intel init routine should be called
there.

I am wondering is it a bug or an expected behavior ?

Thanks
  -- Daniel

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
