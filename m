From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/2] ACPI/thermal: support for thermal zone description
Date: Mon, 21 Aug 2017 23:53:28 +0200
Message-ID: <CAJZ5v0gA-Doe25b+3suUjRY4hNPCZcLX0hmMxwBp6cOjF5Z0Mg@mail.gmail.com>
References: <1500054535-975-1-git-send-email-pprakash@codeaurora.org>
 <CAJZ5v0iR5eJHPOf2ptL9WPO9TFXthER2awVLFSRvSgYqhSj3wA@mail.gmail.com>
 <1503022487.31913.4.camel@intel.com> <2914243.eTDoGm6UPx@aspire.rjw.lan> <1503325719.2619.46.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1503325719.2619.46.camel@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael@kernel.org>, "Prakash, Prashanth" <pprakash@codeaurora.org>, Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Aug 21, 2017 at 4:28 PM, Zhang Rui <rui.zhang@intel.com> wrote:
> On Fri, 2017-08-18 at 14:34 +0200, Rafael J. Wysocki wrote:
>> On Friday, August 18, 2017 4:14:47 AM CEST Zhang Rui wrote:
>> >
>> > On Fri, 2017-08-18 at 02:09 +0200, Rafael J. Wysocki wrote:
>> > >
>> > > On Wed, Aug 9, 2017 at 4:27 PM, Zhang Rui <rui.zhang@intel.com>
>> > > wrote:
>> > > >
>> > > >
>> > > > Hi, Prakash,
>> > > >
>> > > > On Tue, 2017-08-08 at 10:01 -0600, Prakash, Prashanth wrote:
>> > > > >
>> > > > >
>> > > > > Hi Rui,
>> > > > >
>> > > > > On 8/8/2017 2:23 AM, Zhang Rui wrote:
>> > > > > >
>> > > > > >
>> > > > > >
>> > > > > > On Fri, 2017-07-14 at 11:48 -0600, Prashanth Prakash wrote:
>> > > > > > >
>> > > > > > >
>> > > > > > >
>> > > > > > > Per ACPI 6.2 spec, platforms can optionally add a
>> > > > > > > string(_STR)
>> > > > > > > object within each thermal zone package which provides a
>> > > > > > > user
>> > > > > > > friendly name/description.
>> > > > > > >
>> > > > > > > Add support to parse the string object, which will be
>> > > > > > > exposed
>> > > > > > > to userspace by thermal framework.
>> > > > > > >
>> > > > > > is there any real request for this?
>> > > > > Yes, Qualcomm server platforms adds these description
>> > > > > strings.
>> > > > > >
>> > > > > >
>> > > > > >
>> > > > > > _STR is a generic control method for all the ACPI devices.
>> > > > > > Thus I'm wondering, if really needed, should we expose this
>> > > > > > in
>> > > > > > acpi
>> > > > > > bus
>> > > > > > instead?
>> > > > > AFAIK, adding a _STR to any package was not explicitly
>> > > > > allowed by
>> > > > > the
>> > > > > spec.
>> > > > > Updates in APCI 6.2 made it legal to add an _STR object to
>> > > > > thermal
>> > > > > zone
>> > > > > specifically, so added this support only to thermal zone.
>> > > > >
>> > > > I see that _STR is stated explicitly in 11.4.14, ACPI spec 6.2,
>> > > > but
>> > > > according to section 6.1.10, "The _STR object evaluates to a
>> > > > Unicode
>> > > > string that describes the device or thermal zone. "
>> > > > _STR is still a generic control method that can exist in any
>> > > > other
>> > > > device scope.
>> > > >
>> > > > so to me, this is a optional but generic feature for all the
>> > > > ACPI
>> > > > devices, and we don't have a solid reason that it should be
>> > > > part of
>> > > > thermal sysfs I/F, thus a better solution to me is to expose
>> > > > this
>> > > > as an
>> > > > attribute of ACPI device, and we can link to the ACPI device
>> > > > from
>> > > > thermal sysfs I/F in userspace.
>> > > >
>> > > > what do you think, Rafael?
>> > > Since you have a ->get_desc method, I don't have a big problem
>> > > with
>> > > the approach here.
>> > >
>> > > I'm not particularly liking the "<not supported>" thing returned
>> > > if
>> > > _STR is not present, though.
>> > No, actually I mean adding a new sysfs attribute under ACPI device
>> > node, just like path/hid/status/adr, etc.
>> Yes, I understood that, but since the power supply framework has a
>> description callback, why not to use it really?
>>
> I just checked the code, and ACPI devices indeed have 'description'
> sysfs attribute if there is _STR. Cool, that's what I'm proposing.

OK

> But your statement, "the power supply framework has a description
> callback" still confuses me.

That's because I was confused, sorry about that.

But as you said, since we have the description thing already, it
should be sufficient for the use case at hand.

Thanks,
Rafael
