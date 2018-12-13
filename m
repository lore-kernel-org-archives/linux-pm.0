From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] opp: Add API for getting voltage from supplies
Date: Thu, 13 Dec 2018 16:12:47 +0530
Message-ID: <20181213104247.kosguuoukoi645pf@vireshk-i7>
References: <1543906760-15631-1-git-send-email-Nick.Fan@mediatek.com>
 <20181204082158.rb7uzdiwmcotwoxh@vireshk-i7>
 <1544445372.3502.42.camel@mtksdaap41>
 <20181213063850.c5nu3bbe7gm647ca@vireshk-i7>
 <1544697412.6417.13.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1544697412.6417.13.camel@mtksdaap41>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Fan <nick.fan@mediatek.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, tfiga@chromium.org, Chiawen.Lee@mediatek.com, erin.lo@mediatek.com
List-Id: linux-pm@vger.kernel.org

On 13-12-18, 18:36, Nick Fan wrote:
> This new API is suitable for the users that required to access for
> multiple regulators. And I am one of users who uses this API, but I am
> not able to upstream the GPU kernel driver which uses the new API.

Look at it from mainline's perspective..

- We don't (can't) care about non-mainline stuff. Actually we do care,
  but we can't add code to mainline which is not going to be used by
  any mainline user.

- I am fine with introducing the new API, but that will happen only if
  there is going to be a mainline user as well.

- As you are going to maintain your GPU driver offline, you can
  maintain this patch too.

Sorry Nick.

-- 
viresh
