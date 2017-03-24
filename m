From: Liam Breck <liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
Subject: Re: [PATCH v11 01/10] devicetree: power: Add battery.txt
Date: Fri, 24 Mar 2017 14:11:56 -0700
Message-ID: <CAKvHMgTMWsQFNUYpoH-rbBpgCSeTF-CRdK42bEVeLoFOZPg5cQ@mail.gmail.com>
References: <20170320094335.19224-1-liam@networkimprov.net>
 <20170320094335.19224-2-liam@networkimprov.net> <20170324155531.gn6iw6w3f5nqbpnx@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170324155531.gn6iw6w3f5nqbpnx@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Rob,

On Fri, Mar 24, 2017 at 8:55 AM, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Mon, Mar 20, 2017 at 02:43:26AM -0700, Liam Breck wrote:
>> From: Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
>>
>> Documentation of static battery characteristics that can be defined
>> for batteries which cannot self-identify. This information is required
>> by fuel-gauge and charger chips for proper handling of the battery.
>>
>> Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> Signed-off-by: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
>> Signed-off-by: Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
>> ---
>>  .../devicetree/bindings/power/supply/battery.txt   | 43 ++++++++++++++++++++++
>>  1 file changed, 43 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/power/supply/battery.txt
>
> While "simple" is not generally something I like to see in a compatible
> string, we've beat this one to death.
>
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Thanks. Are you in agreement with Sebastian on the following, or is
this OK to include?

On Thu, Mar 23, 2017 at 3:20 AM, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>> +Battery properties are named, where possible, for the corresponding
>> +elements in enum power_supply_property, defined in
>> +https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/power_supply.h#n86
>
>The above paragraph does not belong into DT bindings.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
