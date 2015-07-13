From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH RFC v2 09/16] arm: domain: Add platform callbacks for
 domain power on/off
Date: Mon, 13 Jul 2015 10:36:35 -0600
Message-ID: <20150713163635.GI2049@linaro.org>
References: <1435374156-19214-1-git-send-email-lina.iyer@linaro.org>
 <1435374156-19214-10-git-send-email-lina.iyer@linaro.org>
 <CAMuHMdULThWEZmyLEK_9WeK6DSNhrQdiZQLWNhi1Q6dwZTkkMg@mail.gmail.com>
 <20150629163201.GA1524@linaro.org>
 <CAMuHMdWL09Loe2EFUMc-kRML7Ckn7a6G1_hvPnaqkDYnhkXjog@mail.gmail.com>
 <20150702193826.GA885@linaro.org>
 <CAMuHMdWQRy2RMfyeyNz=6AgTDem67a1VogN3RWSJ1Y+9yNFx6g@mail.gmail.com>
 <20150706151853.GA1018@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:36636 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566AbbGMQgj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2015 12:36:39 -0400
Received: by pdjr16 with SMTP id r16so65479595pdj.3
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2015 09:36:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150706151853.GA1018@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kevin Hilman <khilman@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Krzysztof =?utf-8?Q?Koz=C5=82owski?= <k.kozlowski@samsung.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, msivasub@codeaurora.org, Andy Gross <agross@codeaurora.org>

On Mon, Jul 06 2015 at 09:18 -0600, Lina Iyer wrote:
>On Fri, Jul 03 2015 at 05:36 -0600, Geert Uytterhoeven wrote:
>>Hi Lina,
>>
>>On Thu, Jul 2, 2015 at 9:38 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
>>>On Tue, Jun 30 2015 at 09:10 -0600, Geert Uytterhoeven wrote:
>>>>On Mon, Jun 29, 2015 at 6:32 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
>>>>>On Mon, Jun 29 2015 at 07:36 -0600, Geert Uytterhoeven wrote:
>
>[...]
>
>>>With what you have suggested, the platform driver creates the genpd and
>>>would pass the CPU genpd to the common code for common operations. (This
>>>was what was done in [1]). The platform driver would set the power_on()
>>>and power_off() callbacks and that would have to be overriden in order
>>>handle common CPU domain suspend/resume activities. Overwriting members
>>>of an object allocated by the platform driver, is something we should
>>>avoid.
>>
>>Instead of letting the generic code override the .power_{on,off}() callbacks,
>>the platform code could call the generic CPU-related methods from its own
>>.power_{on,off}() callbacks?
>>
>We dont want to impose on platform drivers to call back into the CPU
>domain core code to do common domain power down activities. On a generic
>ARM CPU domain, we may not even need a platform specific domain
>callbacks. IMHO, this is not desirable.
>
Any thoughts on this?

>>struct rmobile_pm_domain already has .suspend() and .resume() methods.
>>The former is used to e.g. prevent the PM domains containing CPUs to be
>>powered down (in the absence of cpuidle integration). That requires scanning
>>the DT for CPUs, and it would indeed be good to have that scanning support
>>in generic code.
>>The latter became unused after the removal of sh7372 support, which did have
>>some cpuidle integration.
>>
>The CPUs may still be attached to domain, even if they are not powered
>off by CPUIdle. The code increases the reference count for every online
>CPU and any CPUs that may come online. The reference count, only goes
>down when the CPU powers down through CPUIdle or hotplug. So, if a CPU
>is not integrated with CPUIdle, it would remain in use (unless powered
>off by hotplug) and the domain would not be powered down.
>
>>>Or instead of allocating the memory in your platform driver for the CPU
>>>genpd, you could query and get the genpd and then add your additions on
>>>top. You could add other flags like GENPD_FLAG_PM_CLK, but *not*
>>>overwrite the power on/off callbacks in the genpd. They still have to be
>>>registered separately like in this patch. Again, not every elegant, IMO.
>>
>>Just wondering, can I set up the .attach_dev() and .detach_dev()?
>>
>I am presuming, you are concerned with the fore mentioned case of CPUs
>not participating in CPUIdle. With pm_runtime_put_sync() not happening
>for CPUs that do not power down, you should not have to worry about the
>domain being powered down.
>
>Please correct me if I misunderstood your point.
>
>>Actually, for R-Mobile hardware I don't have a need to set GENPD_FLAG_PM_CLK
>>or .attach_dev() and .detach_dev() for CPU PM domains, as they are only
>>needed for devices with MSTP clocks. CPU and L2 cache don't have these,
>>and there are no other devices in e.g. a3sm and a2sl.
>>
>>The GIC has an MSTP clock, but it's part of a different power domain.
>>
>Okay.
>
>[...]
>
>>>This the common code would get its own callbacks and when that genpd
>>>powers off, the platform genpd would power down. But no new code is
>>>needed in your platform driver. The benefit is that platform code and
>>>generic CPU domain code may exist and act in parallel and may only be
>>>related if specified in the DT and the problem with that approach is
>>>that this virtual PM domain is not a h/w domain, hence specifying in DT
>>>is questionable.
>>
>>Indeed, I don't like this option, as the DT would no longer describe HW,
>>but the Linux implementation.
>>
>>So let's continue with your approach, and see how it turns out. We can
>>always change and improvide code, while changing DT is more complicated.
>>
>Agreed.
>
>Thanks for your time, Geert.
>
>-- Lina
