From: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2 1/4] nvmem: rockchip-efuse: Change initcall to subsys
Date: Fri, 19 Aug 2016 11:19:13 -0500
Message-ID: <m2a8g8n33y.fsf@baylibre.com>
References: <1471510341-63926-1-git-send-email-finley.xiao@rock-chips.com>
        <1471510341-63926-2-git-send-email-finley.xiao@rock-chips.com>
        <m2mvkaq6c5.fsf@baylibre.com> <2844104.lMUOkH8YJy@phil>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2844104.lMUOkH8YJy@phil> (Heiko Stuebner's message of "Fri, 19
        Aug 2016 00:29:55 +0200")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: Finlye Xiao <finley.xiao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org, jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, rocky.hao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, tim.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org, tony.xie-TNX95d0MmH7DzftRWevZcw@public.gmane.org, ulysses.huang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, lin.huang-TNX95d0MmH7DzftRWevZcw@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org> writes:

> Am Donnerstag, 18. August 2016, 13:28:58 CEST schrieb Kevin Hilman:
>> Finlye Xiao <finley.xiao-TNX95d0MmH7DzftRWevZcw@public.gmane.org> writes:
>> > From: Finley Xiao <finley.xiao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>> > 
>> > We will register a cpufreq notifier for adjusting opp's voltage, and it
>> > need to fetch cpu's leakage from efuse in the notifier_call. so the efuse
>> > driver should probe before cpufreq driver.
>> > 
>> > Signed-off-by: Finley Xiao <finley.xiao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>> 
>> Why can't this be handled with deferred probling?  initcall ordering is
>> a can of worms.
>
> I think the issue is less between efuse and avs driver, but more between avs 
> driver and cpufreq. The avs driver aims to modify the opp table and thus wants 
> to do that / register the notifier before cpufreq starts.
>
> And as there is no direct connection between cpufreq and the avs driver, 
> making cpufreq defer probing is probably not really easy.

Thanks for the explanation.

Sounds like something that belongs in the changelog.

Kevin


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
