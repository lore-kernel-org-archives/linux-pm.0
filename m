From: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 0/5] ARM: K2G: Add support for TI-SCI Generic PM Domains
Date: Thu, 16 Mar 2017 13:31:17 -0500
Message-ID: <58CAD9F5.7030904@ti.com>
References: <1488882154-21485-1-git-send-email-d-gerlach@ti.com> <2133897.t9KqoeriS0@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2133897.t9KqoeriS0-yvgW3jdyMHm1GS7QM15AGw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, Russell King <rmk+kernel-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Santosh,
On 03/12/2017 12:02 PM, Rafael J. Wysocki wrote:
> On Tuesday, March 07, 2017 04:22:29 AM Dave Gerlach wrote:
>> Hi,
>> This is v4 of the series to add support for TI-SCI Generic PM Domains.
>> Previous versions can be found here:
>>
>> v3: https://www.spinics.net/lists/kernel/msg2413975.html
>> v2: https://www.spinics.net/lists/kernel/msg2364612.html
>> v1: http://www.spinics.net/lists/arm-kernel/msg525204.html
>>
>> After much debate I have returned to using the phandle cell to pass the SCI ID
>> rather than the separate "ti,sci-id" property that was not very popular. In
>> order to do this I needed to make a change to the genpd framework which can be
>> seen in patch 2 and should benefit others that have client . Rather than
>> checking for zero phandle args and failing if any are present the
>> of_genpd_add_provider_simple call does not check at all and instead leaves
>> parsing and interpretation up to the platform genpd driver.
>>
>> This allows the ti_sci_pm_domains driver to parse the phandle and use the first
>> phandle cell as the sci-id rather than getting it from a separate property.
>>
>> Besides that none of the original patches have changed apart from updating the
>> year to 2017 in patches 3 and 4 and of course a small update to patch 4 to let
>> the ti_sci_pm_domains parse the phandle and extract the sci-id rather than
>> looking for the rejected ti,sci-id property.
>>
>> I did not update the "power-domain" binding document because in regards to
>> #power-domain-cells it already states "can be any value as specified by device
>> tree binding documentation of particular provider" which I think already
>> describes the change in patch 2.
> 
> I'm assuming that this will go in through the arm-soc tree.

Assuming that Rob is OK with the v5 of patch 3 that I just sent in response to
the v4 patch email, can this series go through you? We should be good to go with
v4 of the series + the small v5 update to patch 3 if Rob is ok with it.

Regards,
Dave

> 
> Thanks,
> Rafael
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
