From: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: Re: [PATCH v3 3/3] memory: tegra124-emc: Add EMC driver
Date: Tue, 19 Aug 2014 11:06:05 +0200
Message-ID: <CAAObsKA+JofL3JANtdqAqGgtA3-x+GMQ0Ei7gMzmmWynP3U9Sg@mail.gmail.com>
References: <1408437523-8542-1-git-send-email-tomeu.vizoso@collabora.com>
 <1408437523-8542-4-git-send-email-tomeu.vizoso@collabora.com> <20140819090314.GC7862@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140819090314.GC7862@amd>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Terje_Bergstr=C3=B6m?= <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 19 August 2014 11:03, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org> wrote:
> On Tue 2014-08-19 10:38:43, Tomeu Vizoso wrote:
>> Sets the EMC clock rate based on the bandwidth requirements registered by
>> memory clients through the PM_QOS_MEMORY_BANDWIDTH class.
>>
>> Note: this is just an example and not a proper driver for a external memory
>> controller. Its only purpose is to illustrate how such a driver
>> would set the
>
> So... you don't want this to be merged?

Not really, there's quite some work left to do until we have a proper
EMC driver for Tegra124.

Thanks,

Tomeu
