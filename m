From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V6 00/10] Add generic PM domain support for Tegra
Date: Thu, 3 Mar 2016 11:47:58 +0000
Message-ID: <56D8246E.5090909@nvidia.com>
References: <1456501724-28477-1-git-send-email-jonathanh@nvidia.com>
 <20160302153556.GB21035@ulmo.nvidia.com> <7h7fhk3c4o.fsf@baylibre.com>
 <CAJZ5v0juBvU9f61RQRDaHg9B2H=rccNOfT1fXGDRkbpxh-sx=g@mail.gmail.com>
 <7h7fhkxn1r.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <7h7fhkxn1r.fsf-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


On 03/03/16 03:22, Kevin Hilman wrote:
> "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> writes:
> 
>> On Wed, Mar 2, 2016 at 8:36 PM, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org> wrote:
>>> Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
>>>
>>>> On Fri, Feb 26, 2016 at 03:48:34PM +0000, Jon Hunter wrote:
>>>>> Adds generic PM domain support for Tegra SoCs but this series only
>>>>> enables support for it on Tegra 64-bit devices. There is no reason why
>>>>> this cannot be enable for Tegra 32-bit devices, but to keep the patch
>>>>> series to a minimum only 64-bit devices are enabled so far.
>>>>>
>>>>> This series has been boot tested on Tegra210 as well as various 32-bit
>>>>> Tegra platforms.
>>>
>>> [...]
>>>
>>>>> Jon Hunter (10):
>>>>>   PM / Domains: Fix removal of a subdomain
>>>>>   PM / Domains: Add function to get the last domain added
>>>>>   PM / Domains: Add function to remove a pm-domain
>>>>
>>>> Ulf, Kevin, Rafael,
>>>>
>>>> It's too late to take these patches through the Tegra tree for v4.6, but
>>>> if Jon can get the above three patches ready before the merge window,
>>>> would you be willing to pick them up into your trees for v4.6?
>>>
>>> It's a bit late in the cycle, but since one is a fix and the other two
>>> add functions that aren't (yet) used, I think it would be fine to get
>>> them in for v4.6.  But, the final decision is with Rafael.
>>>
>>>> Doing so
>>>> might make it easier to deal with the dependencies. The prerequisites
>>>> would already be in Linus' tree when I apply the Tegra bits for v4.7.
>>>
>>> Yeah, makes sense.
>>>
>>>> I don't mind taking all of it through the Tegra tree for v4.7, though. I
>>>> can provide a stable branch with the PM / Domains patches for you to
>>>> pull in, in case there are any conflicts.
>>>
>>> I think it makes the most sense for these prereqs to merge through
>>> linux-pm.  Let's see what Rafael thinks about the timing.
>>
>> The timing is fine by me.
>>
>> Do you want me to apply [1-3/10] from this series, then?
> 
> Jon has some minor tweaks to do, so he'll respin and then you can take
> them.
> 
> Jon, feel free to add:
> 
> Acked-by: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> 
> For those as well.  I thought I responded, but looks like I didn't.

I am preparing a V7 that I will send out today/tomorrow (latest). I am
going to drop the removal parts for now and send that out separately as
an RFC because it is bigger than I have expected.

Cheers
Jon
