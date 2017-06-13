From: Santosh Shilimkar <santosh.shilimkar-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] dt-bindings: Drop k2g genpd device ID macros
Date: Tue, 13 Jun 2017 13:32:19 -0700
Message-ID: <fc503960-d225-895c-c993-974ba6c5a92d@oracle.com>
References: <20170522183737.24946-1-d-gerlach@ti.com>
 <20170531162850.mf6giowmxj5vetxq@rob-hp-laptop>
 <ca91000a-627b-a655-4304-b64b78bbcf9a@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <ca91000a-627b-a655-4304-b64b78bbcf9a-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>, Andrew Davis <afd-l0cyMroinI0@public.gmane.org>, Franklin Cooper <fcooper-l0cyMroinI0@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 6/13/2017 1:16 PM, Dave Gerlach wrote:
> Santosh,
> On 05/31/2017 11:28 AM, Rob Herring wrote:
>> On Mon, May 22, 2017 at 01:37:37PM -0500, Dave Gerlach wrote:
[...]

>>> [1] https://www.spinics.net/lists/arm-kernel/msg577079.html
>>>
>>>   .../devicetree/bindings/soc/ti/sci-pm-domain.txt   |  5 +-
>>>   include/dt-bindings/genpd/k2g.h                    | 90 ----------------------
>>>   2 files changed, 3 insertions(+), 92 deletions(-)
>>>   delete mode 100644 include/dt-bindings/genpd/k2g.h
>>
>> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>>
> 
> Gentle ping on this. If you're OK with the patch any chance you can pick it up?
> 
Sorry Dave I missed to pick this one in pull request for 4.13. Will pick 
this
one along with what Suman and Tero have been working for following merge
window. Thanks for reminding about this one.

Regards,
Santosh

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
