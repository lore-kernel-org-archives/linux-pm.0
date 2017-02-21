From: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH/RFC 3/6] drivers: firmware: psci: Implement shallow
 suspend mode
Date: Tue, 21 Feb 2017 11:14:16 +0000
Message-ID: <de2a15d4-9ac2-9ba9-a47a-eacbf478f601@arm.com>
References: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
 <1487622809-25127-4-git-send-email-geert+renesas@glider.be>
 <20170221110712.GB5021@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170221110712.GB5021@amd>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Cc: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "Rafael J . Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org



On 21/02/17 11:07, Pavel Machek wrote:
> Hi!
> 
>> Enable support for "shallow" suspend mode, also known as "Standby" or
>> "Power-On Suspend".
>>
>> As secondary CPU cores are taken offline, "shallow" suspend mode saves
>> slightly more power than "s2idle", but less than "deep" suspend mode.
>> However, unlike "deep" suspend mode, "shallow" suspend mode can be used
>> regardless of the presence of support for PSCI_SYSTEM_SUSPEND, which is
>> an optional API in PSCI v1.0.
> 
> If system supports "shallow" suspend, why does not PSCI implement it?
> 

Yes it can, and IIUC it already does on this platform with CPU_SUSPEND.
All it now needs is just to use existing "freeze" suspend mode in Linux.

> In the past, I was told PSCI will not turn into ACPI-like mess, and
> that we'll be able to fix PSCI and will not have to work around its
> problems in kernel :-(.

Can you be more elaborate on the mess you see on this Renesas platform.

For me, it looks like this patch is attempting to *re-implement* the
existing "suspend-to-idle" functionality. So IMO, this patch set is
creating unnecessary mess giving an illusion that PSCI specification is
broken.

-- 
Regards,
Sudeep
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
