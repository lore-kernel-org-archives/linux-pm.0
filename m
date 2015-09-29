From: Jacob Tanenbaum <jtanenba@redhat.com>
Subject: cpupower reports uninitialized values for offline cpus
Date: Tue, 29 Sep 2015 14:58:29 -0400
Message-ID: <560ADF55.6090901@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57204 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965174AbbI2S6a (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 29 Sep 2015 14:58:30 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: trenn@suse.com, Prarit Bhargava <prarit@redhat.com>

Hi guys,

I have found a bug in the cpupower tool. In the most recent pull of 
linus's tree cpupower reports bogus information for offlined cpus.

[root@hp-dl980g7-02 linux]# uname -a
Linux hp-dl980g7-02.rhts.eng.bos.redhat.com 4.3.0-rc3+ #1 SMP Tue Sep 29 
12:03:15 EDT 2015 x86_64 x86_64 x86_64 GNU/Linux
[root@hp-dl980g7-02 linux]#  echo 0 > /sys/devices/system/cpu/cpu150/online
[root@hp-dl980g7-02 linux]#  echo 0 > /sys/devices/system/cpu/cpu1/online
[root@hp-dl980g7-02 linux]#  echo 0 > /sys/devices/system/cpu/cpu140/online
[root@hp-dl980g7-02 linux]# cpupower monitor
               |Nehalem                    || Mperf              || 
Idle_Stats
PKG |CORE|CPU | C3   | C6   | PC3  | PC6  || C0   | Cx   | Freq || POLL 
| C1-N | C1E- | C3-N | C6-N
    0|   0|   0|  0.00| 99.24|  0.00|  0.00||  0.38| 99.62|  1596|| 
0.00|  0.00|  0.00|  0.00| 99.92
    0|   0|  80|  0.00| 99.25|  0.00|  0.00||  0.28| 99.72|  1681|| 
0.00|  0.00|  0.00|  0.00| 99.97
    0|   1|  81|  0.00| 99.47|  0.00|  0.00||  0.27| 99.73|  1711|| 
0.00|  0.00|  0.00|  0.00| 99.94
...
    7|   7| 157|  0.00| 99.47|  0.00|  0.00||  0.25| 99.75|  1735|| 
0.00|  0.00|  0.00|  0.00| 99.98
    7|   8|  78|  0.00| 99.48|  0.00|  0.00||  0.26| 99.74|  1741|| 
0.00|  0.00|  0.00|  0.00| 99.98
    7|   8| 158|  0.00| 99.47|  0.00|  0.00||  0.25| 99.75|  1726|| 
0.00|  0.00|  0.00|  0.00| 99.98
    7|   9|  79|  0.00| 99.57|  0.00|  0.00||  0.23| 99.77|  1745|| 
0.00|  0.00|  0.00|  0.00| 99.96
5472|   0|   1|******|******|******|******||******|******|******|| 
0.00|  0.00|  0.00|  0.00|  0.00 *is offline
10567|   0| 159|******|******|******|******||******|******|******|| 
0.00|  0.00|  0.00|  0.00|  0.00 *is offline
1661206560|859272560| 
150|******|******|******|******||******|******|******||  0.00| 0.00|  
0.00|  0.00|  0.00 *is offline
1661206560|943093104| 
140|******|******|******|******||******|******|******||  0.00| 0.00|  
0.00|  0.00|  0.00 *is offline


Also the number of sockets in cpu->pkgs from get_cpu_topology will be wrong.

This is because when a cpu is downed the topology directory 
/sys/devices/system/cpu/cpu[num]/ is removed and get_cpu_topology
relies on the files there to get the correct information. Patch 
404c2db6... has the loop skip acquiring the data for the offline
cpus but that causes the values to remain uninitialized. Because of the 
way cpu_top->pkgs is calculated each uninitialized and
unique cpu_top->core_info[cpu].core will erroneously increase the 
cpu_top->pkgs value.

I want to fix this bug I am just not sure how to proceed, I see three 
options...

   1. Change the code to not report any information on offline cpus
   2. When printing the results check if the cpu is offline and if it is 
obscure the incorrect information and change the cpu->pkg
      value to reflect all sockets with at least one online cpu.
   3. Change the sysfs to retain topology data for offlined cpus, may 
require adding an additional state to reflect the difference
      between a processor that has been brought down via software and a 
processor that has been removed from the machine.

I would like to submit a patch to fix this bug and not have one 
presented to me to test.

Thanks for the direction,
Jake T.

