From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH V5 3/3] OPP: Add binding for 'opp-suspend'
Date: Thu, 21 May 2015 01:04:07 -0500
Message-ID: <555D7557.6060501@ti.com>
References: <cover.1432091956.git.viresh.kumar@linaro.org> <618b02107af650bcb3246e165095bbca207d511a.1432091956.git.viresh.kumar@linaro.org> <555D6DD3.7000404@ti.com> <20150521054935.GG22904@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150521054935.GG22904@linux>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, rob.herring-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, arnd.bergmann-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mike.turquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, Sudeep.Holla-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, viswanath.puttagunta-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ta.omasab-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kesavan.abhilash-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, santosh.shilimkar-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 05/21/2015 12:49 AM, Viresh Kumar wrote:
> On 21-05-15, 00:32, Nishanth Menon wrote:
>> Why not just mark it as a property of an OPP rather than a phandle? just
>> thinking that this might setup a precedence for future needs like
>> "shutdown OPP" or "Reboot OPP" or something different that some other
>> SoC might have..
> 
> AFAIU, a property should be present in the OPP if and only if any OPP
> can set it. But in this case, only one OPP from the entire list can
> set it. So, its more a property of the list rather than every OPP
> within it. And then there wouldn't be any need to code that would
> check bugs in dtbs where multiple OPPs have it set.
> 
True.. fair enough.

Acked-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>

-- 
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
