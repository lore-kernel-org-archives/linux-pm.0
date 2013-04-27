From: "Artem S. Tashkinov" <t.artem@lycos.com>
Subject: CONFIG_X86_INTEL_PSTATE disables CPU frequency transition stats,
 many governors and other standard features
Date: Sat, 27 Apr 2013 04:58:53 +0000 (UTC)
Message-ID: <475427035.74642.1367038733183.JavaMail.mail@webmail08>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: dirk.j.brandewie@intel.com, rjw@sisk.pl, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hello,

Just wanted to let everyone know that CONFIG_X86_INTEL_PSTATE wreaks
havoc with the CPU frequency subsystem in the Linux kernel.

With this option enabled:

1) All governors except performance and powersave are gone, ondemand
userspace, conservative

2) scaling_cur_freq is gone, thus user space utilities monitoring the CPU
frequency have stopped working

3) CPU frequency transition stats are gone, there's no "stats" directory
anywhere

4) scaling_available_frequencies is gone, so I cannot set the desired constant
CPU frequency (the userspace governor is not available anyway)

Is this an intended behavior? I shrivel to think that's the case.

The bug report is filed here: https://bugzilla.kernel.org/show_bug.cgi?id=57141

Best regards,

Artem
