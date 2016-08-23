From: lists@ssl-mail.com
Subject: Can't enable/switch to 'schedutil' governor with kernel 4.7.2 ?
Date: Tue, 23 Aug 2016 09:25:23 -0700
Message-ID: <1471969523.3010993.703762385.6A0277B5@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:40780 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754000AbcHWQZY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Aug 2016 12:25:24 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 6C1212037A
        for <linux-pm@vger.kernel.org>; Tue, 23 Aug 2016 12:25:23 -0400 (EDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Can't enable/switch to 'schedutil' governor

I'm running 

	uname -rm
		4.7.2-1.g34ba8d6-default x86_64

I'm trying to set/use the 'schedutil' governor.

On my kernel config line I add

	intel_pstate=disable

and re-exec

	grub2-mkconfig -o /boot/grub2/grub.cfg

and for startup I add

	cat /etc/systemd/system/cpupower.service
		[Unit]
		Description=CPU powersave

		[Service]
		Type=oneshot
		ExecStartPre=/sbin/modprobe cpufreq_schedutil
		ExecStart=/usr/bin/cpupower -c all frequency-set -g schedutil

		[Install]
		WantedBy=multi-user.target

After boot the cpufreq driver is loaded

	lsmod | grep cpu
		cpufreq_schedutil      16384  0
		acpi_cpufreq           24576  1

and the governor is available

	cpupower frequency-info --governors
		analyzing CPU 0:
		  available cpufreq governors: schedutil ondemand performance

but it's not loaded

	cpupower frequency-info
		analyzing CPU 0:
		  driver: acpi-cpufreq
		  CPUs which run at the same hardware frequency: 0
		  CPUs which need to have their frequency coordinated by software: 0
		  maximum transition latency: 4.0 us
		  hardware limits: 800 MHz - 2.80 GHz
		  available frequency steps:  2.80 GHz, 2.10 GHz, 1.60 GHz, 800 MHz
		  available cpufreq governors: schedutil ondemand performance
		  current policy: frequency should be within 800 MHz and 2.80 GHz.
		                  The governor "ondemand" may decide which speed to use
		                  within this range.
		  current CPU frequency: 800 MHz (asserted by call to hardware)
		  boost state support:
		    Supported: no
		    Active: no
		    Boost States: 0
		    Total States: 4
		    Pstate-P0:  2800MHz
		    Pstate-P1:  2100MHz
		    Pstate-P2:  1600MHz
		    Pstate-P3:  800MHz


and

	dmesg | grep cpu
		[    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:6 nr_node_ids:1
		[    0.000000] percpu: Embedded 35 pages/cpu @ffff88022ec00000 s103960 r8192 d31208 u262144
		[    0.000000] pcpu-alloc: s103960 r8192 d31208 u262144 alloc=1*2097152
		[    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 - -
		[    0.000000]  RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=6.
		[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=6
		[    0.576814] cpuidle: using governor ladder
		[    0.588811] cpuidle: using governor menu
		[    2.326385] ledtrig-cpu: registered to indicate activity on CPUs
		[    3.097374] systemd[1]: Mounting cgroup to /sys/fs/cgroup/cpuset of type cgroup with options cpuset.
		[    3.110386] systemd[1]: Mounting cgroup to /sys/fs/cgroup/cpu,cpuacct of type cgroup with options cpu,cpuacct.
		[   11.934611] systemd[1]: Installed new job cpupower.service/start as 193
		[   25.933005] acpi_cpufreq: overriding BIOS provided _PSD data

Trying to change it manually to 'schedutil' doesn't work either

	cpupower frequency-set -g schedutil
	cpupower frequency-info
		analyzing CPU 0:
		  driver: acpi-cpufreq
		  CPUs which run at the same hardware frequency: 0
		  CPUs which need to have their frequency coordinated by software: 0
		  maximum transition latency: 4.0 us
		  hardware limits: 800 MHz - 2.80 GHz
		  available frequency steps:  2.80 GHz, 2.10 GHz, 1.60 GHz, 800 MHz
		  available cpufreq governors: schedutil ondemand performance
		  current policy: frequency should be within 800 MHz and 2.80 GHz.
		                  The governor "ondemand" may decide which speed to use
		                  within this range.
		  current CPU frequency: 800 MHz (asserted by call to hardware)
		  boost state support:
		    Supported: no
		    Active: no
		    Boost States: 0
		    Total States: 4
		    Pstate-P0:  2800MHz
		    Pstate-P1:  2100MHz
		    Pstate-P2:  1600MHz
		    Pstate-P3:  800MHz

Am I missing some additional config or package that'd allow me to switch?

I can provide any useful current config; just let me know pls.

