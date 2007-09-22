From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Re: [RFC][PATCH 1/2 -mm] kexec based hibernation -v3:
	kexec jump
Date: Sat, 22 Sep 2007 14:00:05 -0400
Message-ID: <3BCF760C-D77D-417A-809A-B20D04DD01D3__19109.527153387$1190484112$gmane$org@mac.com>
References: <Pine.LNX.4.44L0.0709211540100.5816-100000@iolanthe.rowland.org>
	<878x6z67n8.fsf@jbms.ath.cx>
	<BF08447B-234F-4851-89BF-92A57EA801C6@mac.com>
	<200709221234.18426.rjw@sisk.pl>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200709221234.18426.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, nigel@suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, "Huang,
	Ying" <ying.huang@intel.com>, linux-pm@lists.linux-foundation.org, huang ying <huang.ying.caritas@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Sep 22, 2007, at 06:34:17, Rafael J. Wysocki wrote:
> On Saturday, 22 September 2007 01:19, Kyle Moffett wrote:
>> On Sep 21, 2007, at 17:16:59, Jeremy Maitin-Shepard wrote:
>>> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
>>>> The ACPI platform firmware is allowed to preserve information  
>>>> accross the hibernation-resume cycle, so this need not be the same.
>>>
>>> All of my comments related to the case where S4 is not being used  
>>> (instead the system is just powered off normally), and a boot  
>>> kernel that does not initialize ACPI is used.  In that case, the  
>>> ACPI platform firmware should not be able to distinguish a normal  
>>> boot from a resume from hibernation.
>>
>> I think that in order for this to work, there would need to be  
>> some ABI whereby the resume-ing kernel can pass its entire ACPI  
>> state and a bunch of other ACPI-related device details to the  
>> resume-ed kernel, which I believe it does not do at the moment.
>
> In fact we don't need to do this.
>
> The solution is not to touch ACPI in the boot kernel (ie. the one  
> that loads the image) and pass control to the image kernel.  This  
> is how it's supposed to work according to the spec, more or less  
> (well, there are some ugly details  that need handling, like the  
> restoration of the NVS area).

First of all, we will need to make the resumed kernel throw away  
*ALL* of its ACPI state on S5 and completely reinitialize ACPI as  
though it was booting for the first time on resume.  From what I can  
tell, we "throw away" all the ACPI state in the boot kernel and  
reinitialize it there, but then the reinitialized state is  
overwritten with the resumed kernel's state and the two don't always  
happen to be the same.  (Like if a battery got replaced or AC status  
changed).

Umm, I don't see how that can possibly work properly.  For a laptop,  
for example, the restore kernel will need to access the disk, the LCD  
display, and possibly the AC/battery and current CPU frequency.  From  
what I understand of ACPI, both of the former may need ACPI code to  
operate properly (Isn't there an ATA taskfile object of some kind?)  
and the latter two almost definitely need ACPI.  Ergo the boot kernel  
may need to initialize and use ACPI just to run an ATA taskfile so it  
can read from the HDD efficiently.

>> I believe that what causes problems is the ACPI state data that  
>> the kernel stores is *different* between identical sequential  
>> boots, especially when you add/remove/replace batteries, AC, etc.
>
> Rather the ACPI state data that the platform firmware stores may be  
> different, depending on whether you enter S4 or S5 during "power  
> off" and that determines the interactions between the kernel and  
> the firmware after the next boot.

That's not what he was talking about.  The problem discussed was:
   (A) You hibernate your box, entering S5 (IE: power off)
   (B) You resume the box and the boot kernel inits all the ACPI stuff.
   (C) The boot kernel's ACPI state is completely replaced by the  
resumed kernel's state.
   (D) Hardware stops working mysteriously because of ACPI problems.

The only possible conclusion is that the state between the boot  
kernel and the resume kernel was *different* and so the device failed  
because the ACPI state in the resume kernel doesn't match the actual  
state of the hardware.

Cheers,
Kyle Moffett
