From: Simon Arlott <simon@fire.lp0.eu>
Subject: Re: Tyan S2923-E suspend to ram fails to resume
Date: Sat, 09 Aug 2008 15:42:22 +0100
Message-ID: <489DACCE.7050000__25907.1836983368$1218293120$gmane$org@simon.arlott.org.uk>
References: <48977AF7.2070300@simon.arlott.org.uk>	<20080808071430.GA10370@ucw.cz>
	<21f16315cade48d9ecdc87a25b769b9f310fa112@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <21f16315cade48d9ecdc87a25b769b9f310fa112@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
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
Cc: linux-pm@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 08/08/08 12:20, Simon Arlott wrote:
> On Fri, August 8, 2008 08:14, Pavel Machek wrote:
>> On Mon 2008-08-04 22:56:07, Simon Arlott wrote:
>>> My system (Tyan S2923-E, dmesg attached) suspends ok in
>>> all pm_test modes, but it won't resume with pm_test
>>> "none".
>>>
>>> [    6.423515] mem full: hash matches
>>>
>>> When I press the power button, the port 80 display shows:
>>> FF D0 23 01 D0 ... DE
>>> (and again each time I press it)
>>>
>>> If I force it to turn off, then on again:
>>> FF D0 23 01 D0 ... FF D0 23 01 D0 ... (D2?) D3 00 01 D5
>>> D6 <normal boot>
>>>
>>> Any ideas? (onboard SAS is disabled, watchdog is
>>> disabled, everything else is enabled, PCI-E graphics
>>> card)
>>
>> Try verifying if it reaches assembly code under realmode/ ...

I've tried acpi_sleep=s3_beep, and this:

diff --git a/arch/x86/kernel/acpi/realmode/wakeup.S b/arch/x86/kernel/acpi/realmode/wakeup.S
index 3355973..50e50df 100644
--- a/arch/x86/kernel/acpi/realmode/wakeup.S
+++ b/arch/x86/kernel/acpi/realmode/wakeup.S
@@ -37,6 +37,11 @@ signature:	.long	0x51ee1111
	.code16
wakeup_code:
_start:
+	movb $0xC1, %al
+	outb %al, $0x80
+	cli
+	hlt
+
	cli
	cld


Which doesn't work either.

-- 
Simon Arlott
