From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: 2.6.37.1 s2disk regression (TPM)
Date: Tue, 22 Feb 2011 09:42:24 +0100
Message-ID: <4D6376F0.4020200__40965.6712356538$1298364356$gmane$org@gmail.com>
References: <4D60E93D.1050205@gmail.com> <4D60F108.9000106@gmail.com>
	<201102201151.11635.rjw@sisk.pl> <201102201248.10779.rjw@sisk.pl>
	<4D628521.8000205@linux.vnet.ibm.com>
	<20110222053932.GB21903@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110222053932.GB21903@gamma.logic.tuwien.ac.at>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Norbert Preining <preining@logic.at>
Cc: stefanb@linux.vnet.ibm.com, Rajiv Andrade <srajiv@linux.vnet.ibm.com>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, debora@linux.vnet.ibm.com, linux-pm <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, stable@kernel.org
List-Id: linux-pm@vger.kernel.org

On 02/22/2011 06:39 AM, Norbert Preining wrote:
> Hi everyone,
> 
> sorry for late reply, was night over here in Japan.
> 
> On Mo, 21 Feb 2011, Rajiv Andrade wrote:
>> Norbert, can 'cat /sys/devices/pnp0/00\:0*/timeouts' and send the output?
> 
> I don't have any of these files:
> $ ls /sys/devices/pnp0/*
> /sys/devices/pnp0/uevent
> 
> /sys/devices/pnp0/00:00:
> id  options  power  resources  subsystem  uevent
> 
> /sys/devices/pnp0/00:01:
> driver	firmware_node  id  options  power  resources  subsystem  uevent
> 
> /sys/devices/pnp0/00:02:
> firmware_node  id  options  power  resources  subsystem  uevent
> 
> /sys/devices/pnp0/00:03:
> driver	       id     options  resources  subsystem
> firmware_node  nvram  power    rtc	  uevent
> 
> /sys/devices/pnp0/00:04:
> firmware_node  id  options  power  resources  subsystem  uevent
> 
> /sys/devices/pnp0/00:05:
> firmware_node  id  options  power  resources  subsystem  uevent
> 
> /sys/devices/pnp0/00:06:
> firmware_node  id  options  power  resources  subsystem  uevent
> 
> /sys/devices/pnp0/00:07:
> driver	firmware_node  id  options  power  resources  subsystem  uevent
> 
> /sys/devices/pnp0/00:08:
> driver	firmware_node  id  options  power  resources  subsystem  uevent
> 
> /sys/devices/pnp0/00:09:
> firmware_node  id  options  power  resources  subsystem  uevent
> 
> /sys/devices/pnp0/00:0a:
> active	driver	       id	owned  pubek	  temp_deactivated
> cancel	enabled        misc	pcrs   resources  uevent
> caps	firmware_node  options	power  subsystem
> 
> /sys/devices/pnp0/power:
> async		      runtime_status	      wakeup_count
> autosuspend_delay_ms  runtime_suspended_time  wakeup_hit_count
> control		      runtime_usage	      wakeup_last_time_ms
> runtime_active_kids   wakeup		      wakeup_max_time_ms
> runtime_active_time   wakeup_active	      wakeup_total_time_ms
> runtime_enabled       wakeup_active_count
> $
> 
> running git kernel 6f576d57f1 (were the commit is reverted)

Ok, run some older kernel where this is not reverted (.38-rc5, 2.6.37.1)
or revert the revert :).

regards,
-- 
js
