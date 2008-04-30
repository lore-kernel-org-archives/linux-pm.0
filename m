From: Gabriel C <nix.or.die@googlemail.com>
Subject: Re: Some sort corruption of my Thermal Subsystem after
 suspend to ram
Date: Wed, 30 Apr 2008 22:59:53 +0200
Message-ID: <4818DDC9.70305__4412.58238065547$1209589405$gmane$org@googlemail.com>
References: <4818D9AB.3040402@googlemail.com> <4818DA98.4040001@bellsouth.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4818DA98.4040001@bellsouth.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: jacliburn@bellsouth.net
Cc: Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, pavel@suse.cz
List-Id: linux-pm@vger.kernel.org

Jay Cliburn wrote:
> Gabriel C wrote:
>> Hi all,
>>
>> I thought I've found all issue with that new box but I was wrong ;)
>>
>> On an ASUS P5E-VM DO , 4G RAM , Q9300 CPU after suspend to ram Thermal 
>> Subsystem gets corrupted in some way.
> 
> Does this board contain an Attansic L1 NIC?

No,

Intel 82566DM-2.

here full lspci output :

00:00.0 Host bridge [0600]: Intel Corporation 82Q35 Express DRAM Controller [8086:29b0] (rev 02)
00:02.0 VGA compatible controller [0300]: Intel Corporation 82Q35 Express Integrated Graphics Controller [8086:29b2] (rev 02)
00:03.0 Communication controller [0780]: Intel Corporation 82Q35 Express MEI Controller [8086:29b4] (rev 02)
00:03.2 IDE interface [0101]: Intel Corporation 82Q35 Express PT IDER Controller [8086:29b6] (rev 02)
00:03.3 Serial controller [0700]: Intel Corporation 82Q35 Express Serial KT Controller [8086:29b7] (rev 02)
00:19.0 Ethernet controller [0200]: Intel Corporation 82566DM-2 Gigabit Network Connection [8086:10bd] (rev 02)
00:1a.0 USB Controller [0c03]: Intel Corporation 82801I (ICH9 Family) USB UHCI Controller #4 [8086:2937] (rev 02)
00:1a.1 USB Controller [0c03]: Intel Corporation 82801I (ICH9 Family) USB UHCI Controller #5 [8086:2938] (rev 02)
00:1a.2 USB Controller [0c03]: Intel Corporation 82801I (ICH9 Family) USB UHCI Controller #6 [8086:2939] (rev 02)
00:1a.7 USB Controller [0c03]: Intel Corporation 82801I (ICH9 Family) USB2 EHCI Controller #2 [8086:293c] (rev 02)
00:1b.0 Audio device [0403]: Intel Corporation 82801I (ICH9 Family) HD Audio Controller [8086:293e] (rev 02)
00:1c.0 PCI bridge [0604]: Intel Corporation 82801I (ICH9 Family) PCI Express Port 1 [8086:2940] (rev 02)
00:1c.4 PCI bridge [0604]: Intel Corporation 82801I (ICH9 Family) PCI Express Port 5 [8086:2948] (rev 02)
00:1d.0 USB Controller [0c03]: Intel Corporation 82801I (ICH9 Family) USB UHCI Controller #1 [8086:2934] (rev 02)
00:1d.1 USB Controller [0c03]: Intel Corporation 82801I (ICH9 Family) USB UHCI Controller #2 [8086:2935] (rev 02)
00:1d.2 USB Controller [0c03]: Intel Corporation 82801I (ICH9 Family) USB UHCI Controller #3 [8086:2936] (rev 02)
00:1d.7 USB Controller [0c03]: Intel Corporation 82801I (ICH9 Family) USB2 EHCI Controller #1 [8086:293a] (rev 02)
00:1e.0 PCI bridge [0604]: Intel Corporation 82801 PCI Bridge [8086:244e] (rev 92)
00:1f.0 ISA bridge [0601]: Intel Corporation 82801IO (ICH9DO) LPC Interface Controller [8086:2914] (rev 02)
00:1f.2 SATA controller [0106]: Intel Corporation 82801IR/IO/IH (ICH9R/DO/DH) 6 port SATA AHCI Controller [8086:2922] (rev 02)
00:1f.3 SMBus [0c05]: Intel Corporation 82801I (ICH9 Family) SMBus Controller [8086:2930] (rev 02)
00:1f.6 Signal processing controller [1180]: Intel Corporation 82801I (ICH9 Family) Thermal Subsystem [8086:2932] (rev 02)
01:00.0 IDE interface [0101]: JMicron Technologies, Inc. JMB368 IDE controller [197b:2368]
03:02.0 FireWire (IEEE 1394) [0c00]: Agere Systems FW323 [11c1:5811] (rev 70)


> 
>> I got some reboot , halt problems and was hunting the issue and noticed these problems only
>> occurred when I've suspend the box to ram , at least once.
>>
>> I've tested 2.6.{24*,25,linus-git(before ACPI merge),x86-latest-git} and all got that problem.
>>
>> Also on x86-latest-git I've tested with MTRR_SANITIZER on/off. It does not make any difference.
>>
>>
>> lspci output before s2r is :
>>
>> ..
>>
>>
>> 00:1f.6 Signal processing controller [1180]: Intel Corporation 82801I (ICH9 Family) Thermal Subsystem [8086:2932] (rev 02)
>>         Subsystem: ASUSTeK Computer Inc. Device [1043:8277]
>>         Flags: fast devsel
>>         Memory at fed08000 (64-bit, non-prefetchable) [size=4K]
>>         Capabilities: [50] Power Management version 3                                                                                                       
>>
>> ...
>>
>>
>> and after :
>>
>> ...
>>
>> 00:1f.6 Signal processing controller [1180]: Intel Corporation 82801I (ICH9 Family) Thermal Subsystem [8086:2932] (rev ff) (prog-if ff)
>>         !!! Unknown header type 7f
>>
>> ...
>>
>> dmesg | grep 00:1f.6
>> [21520.103062] PM: Writing back config space on device 0000:00:1f.6 at offset f (was ffffffff, writing 300)
>> [21520.103066] PM: Writing back config space on device 0000:00:1f.6 at offset e (was ffffffff, writing 0)
>> [21520.103070] PM: Writing back config space on device 0000:00:1f.6 at offset d (was ffffffff, writing 50)
>> [21520.103074] PM: Writing back config space on device 0000:00:1f.6 at offset c (was ffffffff, writing 0)
>> [21520.103078] PM: Writing back config space on device 0000:00:1f.6 at offset b (was ffffffff, writing 82771043)
>> [21520.103083] PM: Writing back config space on device 0000:00:1f.6 at offset a (was ffffffff, writing 0)
>> [21520.103087] PM: Writing back config space on device 0000:00:1f.6 at offset 9 (was ffffffff, writing 0)
>> [21520.103091] PM: Writing back config space on device 0000:00:1f.6 at offset 8 (was ffffffff, writing 0)
>> [21520.103095] PM: Writing back config space on device 0000:00:1f.6 at offset 7 (was ffffffff, writing 0)
>> [21520.103099] PM: Writing back config space on device 0000:00:1f.6 at offset 6 (was ffffffff, writing 0)
>> [21520.103103] PM: Writing back config space on device 0000:00:1f.6 at offset 5 (was ffffffff, writing 0)
>> [21520.103107] PM: Writing back config space on device 0000:00:1f.6 at offset 4 (was ffffffff, writing fed08004)
>> [21520.103111] PM: Writing back config space on device 0000:00:1f.6 at offset 3 (was ffffffff, writing 0)
>> [21520.103115] PM: Writing back config space on device 0000:00:1f.6 at offset 2 (was ffffffff, writing 11800002)
>> [21520.103119] PM: Writing back config space on device 0000:00:1f.6 at offset 1 (was ffffffff, writing 100002)
>> [21520.103123] PM: Writing back config space on device 0000:00:1f.6 at offset 0 (was ffffffff, writing 29328086)
>>
>> ..
>>
>>
>> Please let me know if you need my config , dmesg or any other informations.
>>
>>
>> Best Regards,
>>
>> Gabriel C
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
> 
> 
