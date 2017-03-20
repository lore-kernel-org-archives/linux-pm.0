From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 0/4] Avoid duplicate registering of ACPI and native
 power-supplies
Date: Mon, 20 Mar 2017 14:11:15 +0100
Message-ID: <5bdbcb12-57c1-13cf-a591-22c9334d85b6@redhat.com>
References: <20170316161601.32267-1-hdegoede@redhat.com>
 <20170320013305.v4mof5qoie3w7xdb@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170320013305.v4mof5qoie3w7xdb@earth>
Sender: linux-acpi-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 20-03-17 02:33, Sebastian Reichel wrote:
> Hi,
>
> On Thu, Mar 16, 2017 at 05:15:57PM +0100, Hans de Goede wrote:
>> The last 2 patches of this series depend on the first 2, as such it might
>> be better to merge all 4 through the acpi tree if Sebastius is ok with
>> that.
>>
>> Otherwise these patches are pretty self-explanatory.
>
> I'm fine with this going through acpi. I wonder if acpi has a method
> to avoid loading the generic drivers in the first place, though.

I thought about just not loading them as a first approach, but it is
not really doable in a clean way. For example the Whiskey Cove fuel
gauge driver I'm working on will need to do the same thing, but devices
with that fuel-gauge use the same ACPI HID for different fuel-gauges
and we've some extra magic in the fuel-gauge's probe method to see
if it really is the one we want like this:

         status = acpi_evaluate_integer(ACPI_HANDLE(dev), "PTYP", NULL, &ptyp);
         if (ACPI_FAILURE(status)) {
                 dev_err(dev, "Failed to get PTYPE\n");
                 return -ENODEV;
         }

         /*
          * The same ACPI HID is used with different PMICs check PTYP to
          * ensure that we are dealing with a Whiskey Cove PMIC.
          */
         if (ptyp != CHT_WC_FG_PTYPE)
                 return -ENODEV;

And on some Bay Trail / Cherry Trail devices there is a functional
ACPI battery so we really only want to not use the ACPI battery if
we have an alternative battery power_supply driver.

Regards,

Hans
