From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: IDE/ACPI related hibernation regression: Second
	attempt fails
Date: Tue, 01 Jan 2008 13:01:52 -0600
Message-ID: <477A8E20.6080205__48547.1441330903$1199214278$gmane$org@shaw.ca>
References: <fa.YfFzDQkBpp/RTlj/iee/tko3pIo@ifi.uio.no>
	<fa.huIB+rvfVIoeHDRyFMxWSdbnhlw@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <fa.huIB+rvfVIoeHDRyFMxWSdbnhlw@ifi.uio.no>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andreas Mohr <andi@lisas.de>
Cc: len.brown@intel.com, htejun@gmail.com, bzolnier@gmail.com, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Mikko Vinni <mmvinni@yahoo.com>
List-Id: linux-pm@vger.kernel.org

Andreas Mohr wrote:
> [added Tejun and Rafael CCs]
> 
> Hi,
> 
> On Mon, Dec 31, 2007 at 01:27:50PM -0800, Mikko Vinni wrote:
>> Hi,
>>
>> I noticed my ancient laptop (HP nx9005) fails to hibernate (suspend to disk) more than once while running recent 2.6.24-rc kernels. First hibernation succeeds happily, but when I try to do it again after resuming, the machine hangs immediately after the familiar two pops from the speakers."Hanging" in this case means that none of the usual keys work (e.g. Caps Lock led doesn't toggle), but alt-sysrq-b does reboot the laptop.
> 
> I'm sorry, but "recent 2.6.24-rc kernels" unfortunately is a statement almost
> as broad as "there's a violent fire in India, please come and rescue us!",
> given that this very issue has been handled with lots of activity by Tejun Heo
> recently (see bug #9530 and http://lkml.org/lkml/2007/12/9/184 for details).
> 
> 2.6.24-rc6 is the version that has all ACPI IDE fixes in a state that made
> my system fully work, so there should be a sizeable chance that it works
> for you, too, hopefully.
> 
> What's interesting is that you're ALi-based, whereas I'm VIA-based, so
> your problem might still be unsupported by -rc6 after all.
> 
>> Dmesg of the failing kernel after first hibernation (version is untouched e697789d64f8748cb219d7f5c413c512953802cc, i.e. current 2.6.24-rc6):
>            ^^^^^^^^^
> 
> Argh, just saw this at the very last moment, IOW if this is _really_
> -rc6+ already then we certainly do have a problem.
> 
> Disassembled ACPI BIOS AML code (DSDT) of your machine would be very useful
> in this case, I'm afraid (done via acpidump and iasl, search the internet for
> pointers).
> lspci -x or better -xxx of the IDE device would be very useful, too.

They're using drivers/ide not libata. I don't think there have been any 
ACPI changes very recently in that code.

These lines seem suspicious that the drivers/ide code is doing something 
funny to the ACPI layer:

ACPI: Cannot set device to a higher-powered state than parent

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/
