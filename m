From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 0/3] power: supply: Fix AXP288 fallback when not needed
Date: Fri, 16 Feb 2018 09:52:16 +0100
Message-ID: <6e1f34ae-54d3-8daf-e531-976f36f3cb07@redhat.com>
References: <20180216082616.25084-1-carlo@caione.org>
 <da070fa2-9678-5a53-6984-2f200ac93862@redhat.com>
 <CAJZ5v0hLa5O18OPnX9zke9F0PMNdyy+3wgAvT4GXBJGaqngTzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0hLa5O18OPnX9zke9F0PMNdyy+3wgAvT4GXBJGaqngTzw@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Carlo Caione <carlo@caione.org>, Linux Upstreaming Team <linux@endlessm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Carlo Caione <carlo@endlessm.com>
List-Id: linux-pm@vger.kernel.org

Hi,

On 16-02-18 09:51, Rafael J. Wysocki wrote:
> On Fri, Feb 16, 2018 at 9:41 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 16-02-18 09:26, Carlo Caione wrote:
>>>
>>> From: Carlo Caione <carlo@endlessm.com>
>>>
>>> With commits af3ec837 and dccfae6d a blacklist was introduced to avoid
>>> using the ACPI drivers for AC and battery when a native PMIC driver was
>>> already present. While this is in general a good idea (because of broken
>>> DSDT or proprietary and undocumented ACPI opregions for the ACPI
>>> AC/battery devices) we have come across at least one CherryTrail laptop
>>> (ECS EF20EA) shipping the AXP288 together with a separate FG controller
>>> (a MAX17047) instead of the one embedded in the AXP288.
>>
>>
>> Thank you for the new version. This looks good and surprisingly
>> clean / small given amounts of warts surrounding this all.
>>
>> The entire series is:
>>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> Well, to be honest, I very much prefer it when changes are made to one
> driver at a time.

I understand completely, Carlo can you do a v4 with the changes
Rafael requested please? Feel free to keep my Reviewed-by for the v4.

Regards,

Hans

