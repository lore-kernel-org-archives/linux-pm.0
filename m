From: Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 0/2] thermal: mediatek: Add cpu power cooling model
Date: Mon, 02 Nov 2015 15:53:33 +0000
Message-ID: <9hh4mh4bdoi.fsf@e105922-lin.cambridge.arm.com>
References: <1445515359-8587-1-git-send-email-dawei.chien@mediatek.com>
 <20151028154449.GH3716@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20151028154449.GH3716@ubuntu> (Viresh Kumar's message of "Wed,
 28 Oct 2015 21:14:49 +0530")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Dawei Chien <dawei.chien-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> writes:

> On 22-10-15, 20:02, Dawei Chien wrote:
>> Use Intelligent Power Allocation (IPA) technical to add static/dynamic power model for binding CPU thermal zone.
>> The power allocator governor allocates power budget to control CPU temperature.
>> 
>> Power Allocator governor is able to keep SOC temperature within a
>> defined temperature range to avoid SOC overheat and keep it's
>> performance. mt8173-cpufreq.c need to register its' own power model
>> with power allocator thermal governor, so that power allocator
>> governor can allocates suitable power budget to control CPU
>> temperature.
>> 
>> PATCH1 is base on
>> https://patchwork.kernel.org/patch/7034601/
>> 
>> PATCH2 is base on Sascha's thermal driver V9
>> https://patchwork.kernel.org/patch/7249821/
>> https://patchwork.kernel.org/patch/7249861/
>> https://patchwork.kernel.org/patch/7249891/
>> 
>> Change since V1:
>> include mt8171.h and sort header file for mt8173.dtsi
>> 
>> Change since V2:
>> Move dynamic/static power model in device tree
>> 
>> Dawei.Chien (2):
>>   thermal: mediatek: Add cpu power cooling model.
>>   arm64: dts: mt8173: Add thermal zone node for mt8173.
>
> Sorry for being extremely late in reviewing this stuff. You are
> already on v3 and I haven't reviewed it once. Mostly due to bad timing
> of my holidays and other work pressure.
>
> Now, there are few things that I feel are not properly addressed here,
> and I may be wrong:
> - Where are the bindings for static-power-points and
>   dynamic-power-coefficient. Sorry I failed to see them in this or
>   other series you mentioned.

For dynamic power, I had posted some patches[0][1][2] introducing the
binding as well as updating cooling device registration via cpufreq
driver. Now that the SCPI hwmon driver is merged, I should re-send the
remaining patches.

[0] http://lkml.iu.edu/hypermail/linux/kernel/1508.0/01020.html
[1] http://lkml.iu.edu/hypermail/linux/kernel/1508.0/01022.html
[3] http://lkml.iu.edu/hypermail/linux/kernel/1508.0/01031.html

> - Even then, why should we be adding another table into DT for
>   voltage/power ? And not reuse and extend the opp-v2 stuff which is
>   already mainlined now.
> - There are few issues with the code as well, but I want to see where
>   the bindings should go first. And then only discuss the code
>   further.
