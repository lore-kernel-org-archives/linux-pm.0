From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: Re: Too many timer interrupts in NO_HZ
Date: Mon, 3 Mar 2008 01:55:06 +0530
Message-ID: <20080302202506.GE10028__20144.8475862437$1204489646$gmane$org@dirshya.in.ibm.com>
References: <20080302194812.GD10028@dirshya.in.ibm.com>
	<20080302115709.30403490@laptopd505.fenrus.org>
Reply-To: svaidy@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080302115709.30403490@laptopd505.fenrus.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Chanda Sethia <chanda.sethia@in.ibm.com>, suresh.b.siddha@intel.com, Linux Kernel <linux-kernel@vger.kernel.org>, tglx@linutronix.de, discuss@LessWatts.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

* Arjan van de Ven <arjan@infradead.org> [2008-03-02 11:57:09]:
[sniped]
 
> 
> please show us powertop -d output; that way we can at least see sort of what
> is going on...

Here you go...

[root@XXXX sv]# powertop -d
PowerTOP 1.9    (C) 2007 Intel Corporation 

Collecting data for 15 seconds 
< Detailed C-state information is only available on Mobile CPUs (laptops) >
P-states (frequencies)
  2.40 Ghz     0.0%
  2.13 Ghz     0.0%
  1.87 Ghz     0.0%
  1.60 Ghz   100.0%
Wakeups-from-idle per second :  3.1     interval: 15.0s
no ACPI power usage estimate available
Top causes for wakeups:
  41.4% (  2.4)       <interrupt> : eth0 
  17.2% (  1.0)                ip : bnx2_open (bnx2_timer) 
   9.2% (  0.5)     <kernel core> : neigh_table_init_no_netlink (neigh_periodic_timer) 
   3.4% (  0.2)      <kernel IPI> : function call interrupts 
   3.4% (  0.2)              init : schedule_timeout (process_timeout) 
   3.4% (  0.2)            python : schedule_timeout (process_timeout) 
   3.4% (  0.2)     <kernel core> : __netdev_watchdog_up (dev_watchdog) 
   3.4% (  0.2)          sendmail : schedule_timeout (process_timeout) 
   3.4% (  0.2)     <kernel core> : page_writeback_init (wb_timer_fn) 
   2.3% (  0.1)       <interrupt> : aacraid 
   2.3% (  0.1)        rc.sysinit : start_this_handle (commit_timeout) 
   1.1% (  0.1)     <kernel core> : sk_reset_timer (tcp_delack_timer) 
   1.1% (  0.1)              sshd : sk_reset_timer (tcp_write_timer) 
   1.1% (  0.1)     <kernel core> : cache_register (delayed_work_timer_fn) 
   1.1% (  0.1)     <kernel core> : init_nonfatal_mce_checker (delayed_work_timer_fn) 
   1.1% (  0.1)             crond : do_nanosleep (hrtimer_wakeup) 
   1.1% (  0.1)     <kernel core> : neigh_add_timer (neigh_timer_handler) 

Suggestion: increase the VM dirty writeback time from 5.00 to 15 seconds with:
  echo 1500 > /proc/sys/vm/dirty_writeback_centisecs 
This wakes the disk up less frequenty for background VM activity

Suggestion: enable the noatime filesystem option by executing the following command:
   mount -o remount,noatime /          or by pressing the T key 
noatime disables persistent access time of file accesses, which causes lots of disk IO.

--Vaidy
