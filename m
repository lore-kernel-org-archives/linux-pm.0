From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 2/2] ACPI/thermal: support for thermal zone description
Date: Wed, 09 Aug 2017 22:27:56 +0800
Message-ID: <1502288876.5343.19.camel@intel.com>
References: <1500054535-975-1-git-send-email-pprakash@codeaurora.org>
         <1500054535-975-3-git-send-email-pprakash@codeaurora.org>
         <1502180603.4296.15.camel@intel.com>
         <02b23d6b-a923-3790-5fce-222a11eac951@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <02b23d6b-a923-3790-5fce-222a11eac951@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
To: "Prakash, Prashanth" <pprakash@codeaurora.org>, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: edubezval@gmail.com
List-Id: linux-pm@vger.kernel.org

Hi, Prakash,

On Tue, 2017-08-08 at 10:01 -0600, Prakash, Prashanth wrote:
> Hi Rui,
> 
> On 8/8/2017 2:23 AM, Zhang Rui wrote:
> > 
> > On Fri, 2017-07-14 at 11:48 -0600, Prashanth Prakash wrote:
> > > 
> > > Per ACPI 6.2 spec, platforms can optionally add a string(_STR)
> > > object within each thermal zone package which provides a user
> > > friendly name/description.
> > > 
> > > Add support to parse the string object, which will be exposed
> > > to userspace by thermal framework.
> > > 
> > is there any real request for this?
> Yes, Qualcomm server platforms adds these description strings.
> > 
> > _STR is a generic control method for all the ACPI devices.
> > Thus I'm wondering, if really needed, should we expose this in acpi
> > bus
> > instead?
> AFAIK, adding a _STR to any package was not explicitly allowed by the
> spec.
> Updates in APCI 6.2 made it legal to add an _STR object to thermal
> zone
> specifically, so added this support only to thermal zone.
> 

I see that _STR is stated explicitly in 11.4.14, ACPI spec 6.2, but
according to section 6.1.10, "The _STR object evaluates to a Unicode
string that describes the device or thermal zone. "
_STR is still a generic control method that can exist in any other
device scope.

so to me, this is a optional but generic feature for all the ACPI
devices, and we don't have a solid reason that it should be part of
thermal sysfs I/F, thus a better solution to me is to expose this as an
attribute of ACPI device, and we can link to the ACPI device from
thermal sysfs I/F in userspace.

what do you think, Rafael?

thanks,
rui
> Thanks,
> Prashanth
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" 
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
