From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] cpuidle: Convert to using %pOF instead of full_name
Date: Wed, 23 Aug 2017 15:49:00 -0500
Message-ID: <CABGGisxq7jQh+7etb8RnThTkQ09Svmz6+D3Bwqx9yQUOihoVQA@mail.gmail.com>
References: <20170718214339.7774-15-robh@kernel.org> <CAL_JsqJVrCHsj23GQrbsAuVkwsnMEOA0QFLN5hjBNrSBZ=yZog@mail.gmail.com>
 <CAJZ5v0groP7jZRgRK5egHfCU+nMDb7zVw6P2HRv5L_ArDB5+kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAJZ5v0groP7jZRgRK5egHfCU+nMDb7zVw6P2HRv5L_ArDB5+kg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 23, 2017 at 3:34 PM, Rafael J. Wysocki <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Wed, Aug 23, 2017 at 8:14 PM, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>> On Tue, Jul 18, 2017 at 4:42 PM, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>>> Now that we have a custom printf format specifier, convert users of
>>> full_name to use %pOF instead. This is preparation to remove storing
>>> of the full path string for each node.
>>>
>>> Signed-off-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>>> Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
>>> Cc: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>> Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>> ---
>>>  drivers/cpuidle/dt_idle_states.c | 20 ++++++++++----------
>>>  1 file changed, 10 insertions(+), 10 deletions(-)
>>
>> Rafael, Ping. Please apply this one and 2 others for cpufreq and
>> PM-domains which haven't been applied yet.
>
> I thought that these would go in through the DT tree.
>
> I'll try to find them, but next time please make it clear how you want
> to route things.

Sorry, I thought addressed TO you and not in a series was enough to imply that.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
