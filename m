From: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v5 02/16] dt/bindings: Update binding for PM domain idle
 states
Date: Fri, 16 Sep 2016 18:39:37 +0100
Message-ID: <7af4c2d7-70a3-1881-2980-8ea49e594e5b@arm.com>
References: <1472242678-33700-1-git-send-email-lina.iyer@linaro.org>
 <1472242678-33700-3-git-send-email-lina.iyer@linaro.org>
 <0b233802-f459-c6bb-ff42-70745a225cfb@arm.com>
 <20160902201605.GA1705@linaro.org> <87sht59mcw.fsf@arm.com>
 <20160912161600.GA21885@linaro.org>
 <a4fc71ae-6fa5-4142-6dd4-7bc96eb20186@arm.com> <87intz665i.fsf@arm.com>
 <20160913193844.GB28944@linaro.org> <87h99i6b5d.fsf@arm.com>
 <7hpoo3ix80.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <7hpoo3ix80.fsf-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Brendan Jackman <brendan.jackman-5wv7dgnIgG8@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, Juri.Lelli-5wv7dgnIgG8@public.gmane.org, Axel Haslam <ahaslam+renesas-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marc Titinger <mtitinger+renesas-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Kevin,

Thanks for looking at this and simplifying various discussions we had so
far. I was thinking of summarizing something very similar. I couldn't
due to lack of time.

On 16/09/16 18:13, Kevin Hilman wrote:

[...]

> I think we're having some terminology issues...
>
> FWIW, the kernel terminolgy is actually "PM domain", not power domain.
> This was intentional because the goal of the PM domain was to group
> devices that some PM features.  To be very specific to the kernel, they
> us the same set of PM callbacks.  Today, this is most commonly used to
> model power domains, where a group of devices share a power rail, but it
> does not need to be limited to that.
>

Agreed/Understood.

> That being said, I'm having a hard time understanding the root of the
> disagreement.
>

Yes. I tried to convey the same earlier, but have failed. The only
disagreement is about a small part of this DT bindings. We would like to
make it completely hierarchical up to CPU nodes. More comments on that
below.

> It seems that you and Sudeep would like to use domain-idle-states to
> replace/superceed cpu-idle-states with the primary goal (and benefit)
> being that it simplifies the DT bindings.  Is that correct?
>

Correct, we want to deprecate cpu-idle-states with the introduction of
this hierarchical PM bindings. Yes IMO, it simplifies things and avoids
any ABI break we might trigger if we miss to consider some use-case now.

> The objections have come in because that means that implies that CPUs
> become their own domains, which may not be the case in hardware in the
> sense that they share a power rail.
>

Agreed.

> However, IMO, thinking of a CPU as it's own "PM domain" may make some
> sense based on the terminology above.
>

Thanks for that, we do understand that it may not be 100% correct when
we strictly considers hardware terminologies instead of above ones.
As along as we see no issues with the above terminologies it should be fine.

> I think the other objection may be that using a genpd to model domain
> with only a single device in it may be overkill, and I agree with that.

I too agree with that. Just because we represent that in DT in that way
doesn't mean we need to create a genpd to model domain. We can always
skip that if not required. That's pure implementation specifics and I
have tried to convey the same in my previous emails. I must say you have
summarized it very clearly in this email. Thanks again for that.

> But, I'm not sure if making CPUs use domain-idle-states implies that
> they necessarily have to use genpd is what you are proposing.  Maybe
> someone could clarify that?
>

No, I have not proposing anything around implementation in the whole
discussion so far. I have constrained myself just to DT bindings so far.
That's the main reason why I was opposed to mentions of OS vs platform
co-ordinated modes of CPU suspend in this discussion. IMO that's
completely out of scope of this DT binding we are defining here.

Hope that helps/clarifies the misunderstanding/disagreement.

-- 
Regards,
Sudeep
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
