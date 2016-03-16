From: Laura Abbott <labbott@redhat.com>
Subject: [REGRESSION] 774ac8b7eff6 ("Thermal: initialize thermal zone device
 correctly") causes performance drop
Date: Wed, 16 Mar 2016 15:27:57 -0700
Message-ID: <56E9DDED.7000805@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Javi Merino <javi.merino@arm.com>, Chen Yu <yu.c.chen@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Manuel Krause <manuelkrause@netscape.net>, szegad <szegadlo@poczta.onet.pl>, prash <prash.n.rao@gmail.com>, amish <ammdispose-arch@yahoo.com>, Matthias <morpheusxyz123@yahoo.de>, linux-pm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

Fedora received a bug report (https://bugzilla.redhat.com/show_bug.cgi?id=1317190)
of a major performance drop on various bench marks and general system
sluggishness with the 4.4.4 kernel update. The benchmarks were showing
a reduction to about 18% performance (not minor).

Bisection showed the first bad commit was

commit 774ac8b7eff69e0786970157de2157e68b22f456
Author: Zhang Rui <rui.zhang@intel.com>
Date:   Fri Oct 30 16:31:47 2015 +0800

     Thermal: initialize thermal zone device correctly
     
     commit bb431ba26c5cd0a17c941ca6c3a195a3a6d5d461 upstream.
     
     After thermal zone device registered, as we have not read any
     temperature before, thus tz->temperature should not be 0,
     which actually means 0C, and thermal trend is not available.
     In this case, we need specially handling for the first
     thermal_zone_device_update().
     
     Both thermal core framework and step_wise governor is
     enhanced to handle this. And since the step_wise governor
     is the only one that uses trends, so it's the only thermal
     governor that needs to be updated.
     
     Tested-by: Manuel Krause <manuelkrause@netscape.net>
     Tested-by: szegad <szegadlo@poczta.onet.pl>
     Tested-by: prash <prash.n.rao@gmail.com>
     Tested-by: amish <ammdispose-arch@yahoo.com>
     Tested-by: Matthias <morpheusxyz123@yahoo.de>
     Reviewed-by: Javi Merino <javi.merino@arm.com>
     Signed-off-by: Zhang Rui <rui.zhang@intel.com>
     Signed-off-by: Chen Yu <yu.c.chen@intel.com>
     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>



Reverting this plus to other commits in the series (a67208e94d94
"Thermal: handle thermal zone device properly during system sleep"
and 27f356149d59 "Thermal: do thermal zone update after a cooling
device registered") confirmed the performance was back to normal.

Bugzilla has the full discussion but this comment from one of the
reporters sums it up:

"In 4.4.3 and prior, my 2.40 MHz processor would fluctuate between
1000 and 3400 MHz.  In 4.4.4, the processor would fluctuate between
400 and 700 MHz, according to /proc/cpuinfo.

Setting /sys/devices/system/cpu/cpufreq/policy0/scaling_governor to
performance, instead of the default "powersave" forces the CPU to
2400 MHz, and improves performance greatly, but still not to the
same level as in 4.4.3."

Any ideas?

Thanks,
Laura
