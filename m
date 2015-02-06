From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: ACPI PCC probe failed.
Date: Fri, 6 Feb 2015 10:32:53 -0500
Message-ID: <CAJ5Y-eaiGeK=yKsnuCZvQv4z=2yaqj3zzaEFhAgBzwFfg+quoA@mail.gmail.com>
References: <CABwnbUkGNJEZkW5bL9pXvcZwqz4fZKiub_-vTRDLp=FeiQq8cw@mail.gmail.com>
	<6825579.hyRLxbRUP5@vostro.rjw.lan>
	<CAJ5Y-eaPjOsm82PDiCBM9pcO4h6bzKHkTu5tNgQqqfRbrqbTcw@mail.gmail.com>
	<2809506.4Qklo5lDla@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <2809506.4Qklo5lDla@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Cristian <caravena@gmail.com>, linux acpi <linux-acpi@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hello,

On 5 February 2015 at 19:49, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Thursday, February 05, 2015 10:44:13 AM Ashwin Chaugule wrote:
>> Hi Rafael,
>> On 4 February 2015 at 20:28, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> > On Wednesday, February 04, 2015 06:38:39 PM Ashwin Chaugule wrote:
>> >> On 4 February 2015 at 18:04, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> >> > On Wednesday, February 04, 2015 05:06:26 PM Ashwin Chaugule wrote:
>> >> >> > I have one more concern about this driver.  Namely, what benefit is there to
>> >> >> > people like Cristian from it at all?
>> >> >>
>> >> >> Its of use only if they have a PCC client (MPST, CPPC, RAS) driver.
>> >> >> Looks like PCC was explicitly enabled in this kernel.
>> >> >>
>> >> >> config PCC
>> >> >> bool "Platform Communication Channel Driver"
>> >> >> depends on ACPI
>> >> >
>> >> > Can we make it depend on the clients instead and be set automatically
>> >> > when at least one of the clients is enabled?
>> >> >
>> >> > Otherwise distros will have a problem with deciding whether or not they
>> >> > should enable this driver and most of them will end up enabling it.
>> >>
>> >> I see your point, but I'm not aware of any upstreamed client as of
>> >> yet. There might be folks using this driver internally though with
>> >> other clients. In such a case, is there a way to keep PCC disabled
>> >> until a client (e.g. CPPC) is upstreamed?
>> >
>> > Make it depend on EXPERT or something like that until the first client is
>> > added and then make it depend on that client. :-)
>>
>> Doesn't sound too bad. Hope that doesn't end up enabling unintended
>> options in the kernel which aren't exposed in kconfig.
>> FWIW, I think its better to make it depend on CPPC as part of the PCC
>> cleanup patch that I have going in the CPPC patchset.
>
> That's fine by me.

Thanks.

>
>> >> Alternately, is it that bad to keep it the way it is, given that the
>> >> driver wont do anything unless PCCT is detected in firmware and a PCC
>> >> client explicitly uses its API?
>> >
>> > Well, is it really useful this way?
>>
>> Not really, but not particularly harmful either. :) Besides, it seems
>> like for the sake of genericness, distros enable several options that
>> are irrelevant to a platform. In this case, PCC would be harmlessly
>> enabled only until CPPC makes its way upstream (which is actively
>> being worked on anyway).
>
> For one, I don't like it being easy to enable by mistake on x86 where it is
> not useful at all (and won't be at least for some time).

I hear you. I knew about the trend for CPPC on x86, wasn't sure about
MPST and RAS. :)
Anyway, this shouldnt be an issue anymore with the approach mentioned
above for CPPC on ARM64.

Cheers,
Ashwin.
