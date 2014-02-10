From: Naveen Krishna Ch <naveenkrishna.ch-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] thermal: exynos: handle gate clock for misplaced TRIMINFO register
Date: Mon, 10 Feb 2014 16:39:39 +0530
Message-ID: <CAHfPSqCMvygUwa3o-qeuf-Yxcdzmbq_FgS6q5MJtmeeKFHo3Ng@mail.gmail.com>
References: <1383828154-428-1-git-send-email-ch.naveen@samsung.com>
 <20140210103354.GT25314@e106331-lin.cambridge.arm.com> <CAHfPSqANMKSW=dFKUXXM1pXAr3+rmFz8v3rpksbf4Bzc+XSNOw@mail.gmail.com>
 <20140210110723.GV25314@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140210110723.GV25314-NuALmloUBlrZROr8t4l/smS4ubULX0JqMm0uRHvK7Nw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "eduardo.valentin-l0cyMroinI0@public.gmane.org" <eduardo.valentin-l0cyMroinI0@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "amit.daniel-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <amit.daniel-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "cpgs-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <cpgs-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hello Mark,

On 10 February 2014 16:37, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org> wrote:
> On Mon, Feb 10, 2014 at 10:50:01AM +0000, Naveen Krishna Ch wrote:
>> Hello Mark,
>>
>> On 10 February 2014 16:03, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org> wrote:
>> > On Thu, Nov 07, 2013 at 12:42:34PM +0000, Naveen Krishna Chatradhi wrote:
>> >> On Exynos5420 the TMU(4) for GPU has a seperate clock enable bit from
>> >> the other TMU channels(0 ~ 3). Hence, accessing TRIMINFO for base_second
>> >> should be acompanied by enabling the respective clock.
>> >>
>> >> This patch which allow for a "clk_sec" clock to be specified in the
>> >> device-tree which will be ungated when accessing the TRIMINFO register.
>> >
>> > Missing binding document update? Or was "clk_sec" originally in the
>> > binding but unused?
>> >
>> > The code seems to expect "tmu_apbif_sec" as the clock name in the DT,
>> > but this isn't mentioned in the commit message.
>> >
>> > I grepped Documentation/devicetree in mainline, but found no reference
>> > of either.
>> >
>> > Thanks,
>> > Mark.
>> This CL is to be abandoned.
>
> Ok.
>
>>
>> As mentioned in the previous replies to this patch.
>> The changes in this patched were merged with
>> http://www.spinics.net/lists/devicetree/msg15165.html
>>
>> The latest patch set can be found at.
>> 1. http://www.spinics.net/lists/devicetree/msg15163.html
>> 2. http://www.spinics.net/lists/devicetree/msg15164.html
>> 3. http://www.spinics.net/lists/devicetree/msg15165.html
>> 4. http://www.spinics.net/lists/devicetree/msg15165.html
>
> I responded here because of your ping message on 2014-02-07. The latest
> patches seem to have been posted before that. Was the ping misplaced or
> have I misunderstood?
It was my bad, I replied to the patches in that series and i myself forgot that
it was abandoned patch. Sorry.
>
> Thanks,
> Mark



-- 
Shine bright,
(: Nav :)
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
