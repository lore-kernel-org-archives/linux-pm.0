From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: Re: [patch] hibernation: utilize ACPI hardware
	signature
Date: Fri, 04 Jan 2008 09:10:12 +1100
Message-ID: <477D5D44.5060401__43984.0150801048$1199404330$gmane$org@nigel.suspend2.net>
References: <1199257162.14632.4.camel@sli10-desk.sh.intel.com>
	<200801022301.45706.rjw@sisk.pl>
	<477C9D51.5000604@nigel.suspend2.net>
	<200801031758.03056.rjw@sisk.pl>
Reply-To: nigel@nigel.suspend2.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801031758.03056.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, Pavel Machek <pavel@suse.cz>, linux acpi <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi.

Rafael J. Wysocki wrote:
> On Thursday, 3 of January 2008, Nigel Cunningham wrote:
>> Hi.
>>
>> Rafael J. Wysocki wrote:
>>>> I suppose we can always disable this when we start to support hardware
>>>> changing over hibernate (I have ideas in this direction - memory cold
>>>> plugging, for a start).
>>> Well, if we support such features, we won't be following ACPI any more.
>> Mmm. Apparently I'm not as focused on specs as you :).
>>
>> I was starting to think through whether it could make for a new and much
>> faster was to boot live cds - something along the lines of complete
>> redetection of hardware and memory cold plugging. Of course it's only in
>> the 'I wonder if this would be possible' stage at the mo, but seemed at
>> least feasible - keep the e820 tables from boot, make _init routines not
>> get thrown away and do something like the kexec device shutdown etc
>> around an atomic restore.
>>
>> I know there'd be limitations, but perhaps worth thinking about...
> 
> Well, what if the new e820 map is incompatible with the old one?

In the worst case, you tell the user about it and carry on with the old
one. Perhaps this would be the killer for the live cd idea - perhaps
e820 maps vary too much, there'd be no possible workaround and this
would never be practical. It's worth at least thinking about, though,
isn't it?

Nigel
