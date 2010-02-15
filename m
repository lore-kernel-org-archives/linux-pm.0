From: Andy Lutomirski <luto@mit.edu>
Subject: Re: iwlagn on Thinkpad X200
Date: Mon, 15 Feb 2010 09:00:47 -0500
Message-ID: <4B79538F.4090501@mit.edu>
References: <20100215134823.GA2864@qi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100215134823.GA2864@qi>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthias-Christian Ott <ott@mirix.org>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Matthias-Christian Ott wrote:
> Hi,
> 

[...]

> 
> # dmesg
> [...]
> thinkpad_acpi: ThinkPad BIOS 6DET61WW (3.11 ), EC 7XHT24WW-1.06
> thinkpad_acpi: Lenovo ThinkPad X200, model 7458AD9
> [...]
> 
> I figured out howto enable most power savings, but I wasn't able to
> find out why iwlagn generates so many interrupts without network
> activity:
> 
> $ powertop -d
> PowerTOP 1.11   (C) 2007, 2008 Intel Corporation 
> 
> Collecting data for 15 seconds 
> 
> 
> Cn	          Avg residency
> C0 (cpu running)        ( 0.0%)
> polling		  0.0ms ( 0.0%)
> C1 mwait	  0.0ms ( 0.0%)
> C2 mwait	  0.2ms ( 0.0%)
> C4 mwait	 30.0ms (100.0%)
> P-states (frequencies)
>   2.41 Ghz     0.0%
>   2.40 Ghz     0.0%
>   1.60 Ghz     0.0%
>    800 Mhz   100.0%
> Wakeups-from-idle per second : 33.4	interval: 15.0s
> no ACPI power usage estimate available
> Top causes for wakeups:
>   61.4% ( 22.5)       <interrupt> : iwlagn 

[...]

> 
> I'm not sure if it's normal, a driver bug or simply
> misconfiguration. Some website say that there should be power_level
> file for the device in /sys, but it's not present on my system. Maybe
> you can help me or just point to the correct mailing list for this.

Looks mostly reasonable to me.  Did you try 'iwconfig wlan0 power on'?

If you're feeling adventurous, try iwlcore.no_sleep_autoadjust=0 and 
'iwconfig wlan0 power on'.  The combination works for me and decreases 
power consumption a lot at the cost of a little bit of latency.

--Andy
