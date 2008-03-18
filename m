From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: suspend slow in 2.6.25-rc6 (was Re: Suspend and
 hibernation	patchset against -rc6)
Date: Tue, 18 Mar 2008 21:48:46 +0300
Message-ID: <47E00E8E.2000401@suse.de>
References: <200803120129.25585.rjw@sisk.pl> <200803172317.33745.rjw@sisk.pl>
	<20080318130642.GA1609@elf.ucw.cz>
	<20080318130710.GB1609@elf.ucw.cz>
	<20080318170706.GA1580@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080318170706.GA1580@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@suse.cz>
Cc: Len Brown <len.brown@intel.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

Pavel Machek wrote:
> On Tue 2008-03-18 14:07:10, Pavel Machek wrote:
>> On Tue 2008-03-18 14:06:42, Pavel Machek wrote:
>>> Confirmed, suspend slowness is in 2.6.25-rc6, too. It takes 15 seconds
>>> to suspend/resume, while 2.6.24 takes 9. Thinkpad x60.
>> IIRC 2.6.25-rc5 was "fast".
> 
> rc6:
> 
> CPU0 attaching sched-domain:
>  domain 0: span 3
>   groups: 1 2
> CPU1 attaching sched-domain:
>  domain 0: span 3
>   groups: 2 1
> CPU1 is up
> ACPI: EC: missing OBF confirmation, don't expect it any longer.
This means that either ACPI interrupt or EC GPE is already disabled,
but readings from EC continue. 
> 
> 
> (there's ~.5 sec delay here)
> 
> ACPI: EC: missing write data confirmation, don't expect it any longer.
> 
> (and > 3 sec delay here)
> 
> PM: Writing back config space on device 0000:00:02.0 at offset 1 (was
> 900003, writing 900007)
> PCI: Setting latency timer of device 0000:00:02.0 to 64
> PM: Writing back config space on device 0000:00:02.1 at offset 1 (was
> 900000, writing 900003)
> PM: Writing back config space on device 0000:00:1b.0 at offset 1 (was
> 100106, writing 100102)
> PCI: Setting latency timer of device 0000:00:1b.0 to 64
> PCI: Setting latency timer of device 0000:00:1c.0 to 64
> PCI: Setting latency timer of device 0000:00:1c.1 to 64
> 
> 
