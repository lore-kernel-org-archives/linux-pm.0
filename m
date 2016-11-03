From: Justin Chen <justinpopo6@gmail.com>
Subject: [RFC] Potential deadlock with PM and vmstat
Date: Thu, 3 Nov 2016 15:35:26 -0700
Message-ID: <CAJx26kWEEuWL6G9+EQ7Y89HKR5kL1Qqa0iQguXW23-4aKPT8cA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hello,

I am experiencing a deadlock in my system when looping through the PM
sequence. The system locks up when trying to bring nonboot cpus down
(hot plugging cpus) with vmstat enabled. The issue is the
cpu_hotplug.lock.

In kernel/cpu.c:_cpu_down(), we begin the cpu bring down. The deadlock
occurs when parking kthreads. This will lock up if the kthread we are
trying to park is waiting on the cpu_hotplug.lock, because this lock
is currently held by the boot cpu at cpu_hotplug_begin().

Here is the sequence that I am seeing(4.1 kernel):
CPU0 goes into the suspend sequence and drops into kernel/cpu.c:_cpu_down().
CPU0 calls cpu_hotplug_begin() and grabs the cpu_hotplug.lock.
CPU0 blocks at smpboot_park_threads(...) waiting for kthreads to be stopped.

CPU1 has a kthread started by vmstat at mm/vmstat.c:
vmstat_shepherd(). In get_online_cpus() the kthread tries to grab the
cpu_hotplug.lock and blocks. So the kthread cannot be parked.

If I am understanding this correctly, this deadlock may happen if
kthreads are parked with the cpu_hotplug.lock held. I haven't tested
this on the most recent kernel(4.9-rc3), but it seems like the
conditions for the deadlock still exist except called in a different
sequence.

If this seems like a valid issue, I will try to put together a patch
to address this issue. Suggestions welcome!

Thanks,
Justin
