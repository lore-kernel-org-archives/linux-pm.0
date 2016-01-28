From: Tyler Baker <tyler.baker-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: Re: [PATCH] PM / devfreq: tegra: Set freq in rate callback
Date: Thu, 28 Jan 2016 15:07:41 -0800
Message-ID: <CANMBJr7iufrhqAAb85kG-Q9DKxdGWmTDSj3hH8VjvDz+2RgjKA@mail.gmail.com>
References: <987619535.304031453954442569.JavaMail.weblogic@epmlwas09c>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <987619535.304031453954442569.JavaMail.weblogic@epmlwas09c>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, =?UTF-8?B?67CV6rK966+8?= <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 27 January 2016 at 20:14, MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
>> Hi Thierry,
>>
>> On 21 January 2016 at 02:54, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> > On Thu, Jan 21, 2016 at 08:52:26AM +0100, Tomeu Vizoso wrote:
> []
>> >> Signed-off-by: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
>> >> Reported-by: Tyler Baker <tyler.baker-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> []
>> >>
>> >
>> > I had noticed it recently but hadn't got around to look into it, thanks
>> > for fixing it.
>> >
>> > Tested-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>> > Acked-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>>
>> I don't see this patch in -next yet, so I'm guess it hasn't been
>> applied. Any chance you could pick it up? This issue is now
>> manifesting in mainline, and causing ton of noise in the boot reports.
>>
>> Cheers,
>>
>> Tyler
>
>
> Hey, the patch appeared at the mailing list a week ago.
> Linux 4.5-rc1 appeared 3 days ago.
> The fastest possible for mainline inclusion is 4.5-rc2 or 3.
>
> You cannot simply expect the patch to be included in the maiinline that fast.

I agree, and I was not asking for this patch to be included into
mainline yet, just that it would be applied to maintainers tree so it
could be included in linux-next. I want to ensure this issue is not
masking other issues in linux-next.

Cheers,

Tyler
