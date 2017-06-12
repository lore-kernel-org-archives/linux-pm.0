From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/3] ACPI / sleep: Support power button wakeup from S2I on
 recent Dell laptops
Date: Mon, 12 Jun 2017 21:13:05 +0200
Message-ID: <CAJZ5v0i=Oz91tWRwHLqvys-+HK8JkaO28QaGSpS+_VJTrR8jzQ@mail.gmail.com>
References: <CA+kEDGHNOQboMy34=EmH6zVSgtdVz1afOz5hwx5HBKshWhackA@mail.gmail.com>
 <31f516ad46d74225a5d6324c5fd24751@ausx13mpc124.AMER.DELL.COM>
 <CA+kEDGFUuSC1CpCEgOT+HMTrDa-r1y59kM9-CYn0PSgtuKaG5Q@mail.gmail.com>
 <343a8430fb144adf8d65ef9d0b2bfd40@ausx13mpc124.AMER.DELL.COM>
 <CA+kEDGFVgmXf_B=qHfhWS1HCD+Ei6KSp_rSJBOGYtNZVkm+MeA@mail.gmail.com>
 <24ac3bb8850c4b7a8fa9c0c2d9e3cbc4@ausx13mpc124.AMER.DELL.COM>
 <CA+kEDGHev9XYQr=BEVZ8od+nX_cQ637eY0cF81_v3auQZvBKRQ@mail.gmail.com> <1497282852.195383.56.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1497282852.195383.56.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: =?UTF-8?B?SsOpcsO0bWUgZGUgQnJldGFnbmU=?= <jerome.debretagne@gmail.com>, Mario Limonciello <Mario.Limonciello@dell.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Jun 12, 2017 at 5:54 PM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> On Mon, 2017-06-12 at 00:01 +0200, J=C3=A9r=C3=B4me de Bretagne wrote:
>> Hi Mario, Hi Rafael,
>>
>> >
>> > >
>> > > Some assumptions now: either the SCI is ignored erroneously or
>> > > it's
>> > > not interpreted correctly by the expected driver? I guess that's
>> > > the 2
>> > > possibilities I'll try to investigate.
>> >
>> > Well that's too bad.  Yes, you're correct that the EC has changed
>> > between
>> > those versions.  Are you testing on or off AC adapter?
>>
>> I haven't detected a pattern specific to the state of the AC adapter.
>>
>> Good news on another front. By adding some more logs in the
>> s2idle-dell-test branch, I've been able to check and confirm that
>> notify_handler() from intel-hid.c is actually called upon short power
>> key
>> press during s2idle on my Latitude 7275.
>>
>> However, the system with BIOS 1.1.31 doesn't match (anymore?) the
>> current criteria to call pm_wakeup_hard_event introduced in commit:
>>
>> platform: x86: intel-hid: Wake up the system from suspend-to-idle
>> 7871dc61497a71be93c4f80d43ac109152510e7e
>>
>> This ugly 3-line modification I've added on the actual patch here:
>>
>> + if (priv->wakeup_mode) {
>> +
>> + /* Wake up Dell Latitude 7275 BIOS 1.1.31. */
>> + if (event =3D=3D 0xce)
>> + pm_wakeup_hard_event(&device->dev);
> 0xce is a 5 button array press and 0xcf is release.

Right.  And it is there in intel_array_keymap[].

>> +
>> + /* Wake up on 5-button array events only. */
>> + if (event =3D=3D 0xc0 || !priv->array)
>> + return;
> I don't think 0xc0 is any valid 5 button code.
>
>> +
>> + if (sparse_keymap_entry_from_scancode(priv->array, event))
>> + pm_wakeup_hard_event(&device->dev);
>> + else
>> + dev_info(&device->dev, "unknown event 0x%x\n", event);
>> +
>> + return;
>> + }
>>
>> make the system wake up on a standard short press finally!
>>
>> Is the "Wake up on 5-button array events only." assumption broad
>> enough to cover the various Intel systems that need this behavior?
> For the platforms which supported Win 8.1 only the event should be
> handled by vbtn driver.

This is not intel-vbtn, but intel-hid.

Thanks,
Rafael
