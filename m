From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH 2/2] ACPI/thermal: support for thermal zone description
Date: Tue, 8 Aug 2017 10:01:37 -0600
Message-ID: <02b23d6b-a923-3790-5fce-222a11eac951@codeaurora.org>
References: <1500054535-975-1-git-send-email-pprakash@codeaurora.org>
 <1500054535-975-3-git-send-email-pprakash@codeaurora.org>
 <1502180603.4296.15.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1502180603.4296.15.camel@intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: edubezval@gmail.com
List-Id: linux-pm@vger.kernel.org

Hi Rui,

On 8/8/2017 2:23 AM, Zhang Rui wrote:
> On Fri, 2017-07-14 at 11:48 -0600, Prashanth Prakash wrote:
>> Per ACPI 6.2 spec, platforms can optionally add a string(_STR)
>> object within each thermal zone package which provides a user
>> friendly name/description.
>>
>> Add support to parse the string object, which will be exposed
>> to userspace by thermal framework.
>>
> is there any real request for this?

Yes, Qualcomm server platforms adds these description strings.
> _STR is a generic control method for all the ACPI devices.
> Thus I'm wondering, if really needed, should we expose this in acpi bus
> instead?

AFAIK, adding a _STR to any package was not explicitly allowed by the spec.
Updates in APCI 6.2 made it legal to add an _STR object to thermal zone
specifically, so added this support only to thermal zone.

Thanks,
Prashanth
