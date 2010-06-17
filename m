From: Victor Lowther <victor.lowther@gmail.com>
Subject: Re: [linux-pm] RFC: /sys/power/policy_preference
Date: Thu, 17 Jun 2010 17:23:35 -0500
Message-ID: <AANLkTimWfE0WXr558sOnjZFptxpP4k6IvMWriR3seIKu@mail.gmail.com>
References: <alpine.LFD.2.00.1006161659140.24913@localhost.localdomain>
	<0F1C0B07-60D6-405B-890B-F9C320820CA5@gmail.com>
	<alpine.LFD.2.00.1006171500260.4214@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.1006171500260.4214@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linux Power Management List <linux-pm@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 17, 2010 at 2:02 PM, Len Brown <lenb@kernel.org> wrote:
>
>> On Jun 16, 2010, at 4:05 PM, Len Brown <lenb@kernel.org> wrote:
>>
>> > Create /sys/power/policy_preference, giving user-space
>> > the ability to express its preference for kernel based
>> > power vs. performance decisions in a single place.
>> >
>> > This gives kernel sub-systems and drivers a central place
>> > to discover this system-wide policy preference.
>> > It also allows user-space to not have to be updated
>> > every time a sub-system or driver adds a new power/perf knob.
>>
>> I would prefer documenting all the current knobs and adding them to =
pm-utils
>> so that pm-powersave knows about and can manage them. Once that is d=
one,
>> creating arbitrary powersave levels should be fairly simple.
>
>
> The idea here is to not require user-space to need updating
> whenever a future knob is invented. =A0We can do a great job
> at documenting the past, but a poor job of documenting the future:-)

Well, I would suggest that the habit of not documenting what is
happening with power management in the kernel needs to change, then.

Having the documentation and example code for how to tweak the various
power management settings from userspace is inherently more flexible
than trying to expose a single knob from the kernel to userspace for
power management, with little loss of flexibility.
> cheers,
> Len Brown, Intel Open Source Technolgy Center
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
