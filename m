From: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] PM / OPP: 'UNKNOWN' status of opp-table->shared
Date: Thu, 16 Jun 2016 15:26:33 +0200
Message-ID: <CAJZ5v0h3iO3UhzOiUb41TnDaSOLvBxkCCNp-9D0ndtbBnh31-Q@mail.gmail.com>
References: <87bd097db7b673b1f75ca2086dfa76f4dfbf7f8c.1466058619.git.viresh.kumar@linaro.org>
 <CAJZ5v0gqbU8bc0k8ZHare6Tv4Nno5o4pYQwwzTP6Ha1xS3WDOg@mail.gmail.com> <20160616124818.GN5726@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160616124818.GN5726@vireshk-i7>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Lists linaro-kernel <linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 16, 2016 at 2:48 PM, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On 16-06-16, 14:25, Rafael J. Wysocki wrote:
>> On Thu, Jun 16, 2016 at 8:33 AM, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>> > +                       if (opp_table->shared_opp == OPP_TABLE_IS_SHARED)
>> > +                               return opp_table;
>> > +
>> > +                       return NULL;
>>
>> That still can be
>>
>> return opp_table->shared_opp == OPP_TABLE_IS_SHARED ? opp_table : NULL;
>>
>> >                 }
>> >         }
>> >
>
>> > +       if (of_property_read_bool(opp_np, "opp-shared"))
>> > +               opp_table->shared_opp = OPP_TABLE_IS_SHARED;
>> > +       else
>> > +               opp_table->shared_opp = OPP_TABLE_IS_NOT_SHARED;
>>
>> And here
>>
>> opp_table->shared_opp = of_property_read_bool(opp_np, "opp-shared") ?
>>                                             OPP_TABLE_IS_SHARED :
>> OPP_TABLE_IS_NOT_SHARED;
>
> Conditional statement for both these cases is getting very long and
> if/else looks much more readable. And so I would like to stick with
> that, if you allow.

Fair enough.
