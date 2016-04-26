From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH v2 0/3] Support INT3406 Display thermal device
Date: Tue, 26 Apr 2016 15:33:24 +0800
Message-ID: <cdf06c09-c30b-05ee-8195-a60aac5a88ea@intel.com>
References: <1460532771-22779-1-git-send-email-aaron.lu@intel.com>
 <2383528.7J2tIpIfEZ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <2383528.7J2tIpIfEZ@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jingoo Han <jingoohan1@gmail.com>, Zhang Rui <rui.zhang@intel.com>, linux-fbdev@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, srinivas.pandruvada@intel.com
List-Id: linux-pm@vger.kernel.org

On 04/26/2016 08:58 AM, Rafael J. Wysocki wrote:
> On Wednesday, April 13, 2016 03:32:48 PM Aaron Lu wrote:
>> The display thermal device represents the LED/LCD display panel
>> that may or may not include touch support. The main function of
>> the display thermal device is to allow control of the display
>> brightness in order to address a thermal condition or to reduce
>> power consumed by display device.
>>
>> Due to the way this thermal device changes brightness level is said
>> to be deprecated so we are using the raw interface to do the actual
>> backlight change. This requires the backlight core support so two
>> new APIs are added and exported in patch 1/3. With this, the previous
>> API backlight_device_registered can be removed and this is done in
>> patch 2/3. Patch 3/3 adds the new int3406 thermal driver.
>>
>> The 1st version is here:
>> http://thread.gmane.org/gmane.linux.acpi.devel/72619
>>
>> This whole series should go through the thermal tree if applied.
>>
>> Aaron Lu (3):
>>   video / backlight: add two APIs for drivers to use
>>   video / backlight: remove the backlight_device_registered API
>>   Thermal: add INT3406 thermal driver
> 
> So I have nothing against [1-2/3], but the [3/3] tries to do too many things
> in one go.  It should be at least two separate patches to my eyes, one making
> changes to the ACPI video driver and the other adding the INT3406 one.

Thanks for the review, will split the last patch and re-send.

Regards,
Aaron
