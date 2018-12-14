From: Nick Fan <nick.fan@mediatek.com>
Subject: Re: [PATCH] opp: Add API for getting voltage from supplies
Date: Fri, 14 Dec 2018 09:36:49 +0800
Message-ID: <1544751409.6417.22.camel@mtksdaap41>
References: <1543906760-15631-1-git-send-email-Nick.Fan@mediatek.com>
         <20181204082158.rb7uzdiwmcotwoxh@vireshk-i7>
         <1544445372.3502.42.camel@mtksdaap41>
         <20181213063850.c5nu3bbe7gm647ca@vireshk-i7>
         <1544697412.6417.13.camel@mtksdaap41>
         <20181213104247.kosguuoukoi645pf@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181213104247.kosguuoukoi645pf@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, tfiga@chromium.org, Chiawen.Lee@mediatek.com, erin.lo@mediatek.com
List-Id: linux-pm@vger.kernel.org

On Thu, 2018-12-13 at 16:12 +0530, Viresh Kumar wrote:
> On 13-12-18, 18:36, Nick Fan wrote:
> > This new API is suitable for the users that required to access for
> > multiple regulators. And I am one of users who uses this API, but I am
> > not able to upstream the GPU kernel driver which uses the new API.
> 
> Look at it from mainline's perspective..
> 
> - We don't (can't) care about non-mainline stuff. Actually we do care,
>   but we can't add code to mainline which is not going to be used by
>   any mainline user.
> 
> - I am fine with introducing the new API, but that will happen only if
>   there is going to be a mainline user as well.
> 
> - As you are going to maintain your GPU driver offline, you can
>   maintain this patch too.
> 
> Sorry Nick.
> 
It's OK.
I got your ideas.
Thanks a lot for the explanation and review on this patch.

--
Nick Fan
