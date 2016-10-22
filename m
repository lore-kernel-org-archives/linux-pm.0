From: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Subject: Re: [PATCH v2 4/4] cpufreq: pxa: convert to clock API
Date: Sat, 22 Oct 2016 23:37:09 +0200
Message-ID: <877f902hh6.fsf@belgarion.home>
References: <1476561450-28407-1-git-send-email-robert.jarzmik@free.fr>
        <1476561450-28407-5-git-send-email-robert.jarzmik@free.fr>
        <20161018114025.GD11471@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161018114025.GD11471@vireshk-i7> (Viresh Kumar's message of
        "Tue, 18 Oct 2016 17:10:25 +0530")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> writes:

> On 15-10-16, 21:57, Robert Jarzmik wrote:
>> As the clock settings have been introduced into the clock pxa drivers,
>> which are now available to change the CPU clock by themselves, remove
>> the clock handling from this driver, and rely on pxa clock drivers.
>> 
>> Signed-off-by: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
>> ---
>> Since v1: added !OF Kconfig dependency
>> ---
>>  drivers/cpufreq/Kconfig.arm      |   2 +-
>>  drivers/cpufreq/pxa2xx-cpufreq.c | 191 ++++++++-------------------------------
>>  2 files changed, 40 insertions(+), 153 deletions(-)
>
> Acked-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Okay, after some more testing, I'd like to remove the !OF for next iteration.
The reason is that I have a usecase where I have a single kernel image with
devictree support (ie CONFIG_OF=y), but with support for both devicetree and
legacy platforms. In this case, a platform such as lubbock can boot :
 - with devicetree
 - with legacy arch/arm/mach-pxa/lubbock.c

In this kernel, the !OF Kconfig prevents the legacy version from working, as
pxa2xx-cpufreq is descarded even if it is needed in the legacy version.

Therefore, I'd like to respin without this !OF.

Cheers.

-- 
Robert
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
