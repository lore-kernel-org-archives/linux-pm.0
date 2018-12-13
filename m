From: Nick Fan <nick.fan@mediatek.com>
Subject: Re: [PATCH] opp: Add API for getting voltage from supplies
Date: Thu, 13 Dec 2018 18:36:52 +0800
Message-ID: <1544697412.6417.13.camel@mtksdaap41>
References: <1543906760-15631-1-git-send-email-Nick.Fan@mediatek.com>
         <20181204082158.rb7uzdiwmcotwoxh@vireshk-i7>
         <1544445372.3502.42.camel@mtksdaap41>
         <20181213063850.c5nu3bbe7gm647ca@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181213063850.c5nu3bbe7gm647ca@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, tfiga@chromium.org, Chiawen.Lee@mediatek.com, erin.lo@mediatek.com
List-Id: linux-pm@vger.kernel.org

On Thu, 2018-12-13 at 12:08 +0530, Viresh Kumar wrote:
> On 10-12-18, 20:36, Nick Fan wrote:
> > For the users who only use one supply, they can use
> > dev_pm_opp_get_voltage to get the voltage data from an opp.
> > But if the users who use more than one supply, they will need this API
> > to get their voltage data from OPP.
> > The users should know about the supply count while creating opp table by
> > using dev_pm_opp_set_regulators function.
> > By using this API, the users can get the voltages by using index to
> > specify which supplies they want.
> > 
> > The following is a simple example to get multiple regulators by this
> > API.
> > for (i = 0; i < regulator_num; i++)
> > 	target_volt[i] = dev_pm_opp_get_voltage_supply(opp, i);
> 
> Fair enough. I couldn't find anything wrong with the patch. Will it be
> possible to send this patch as part of a series which uses the new API
> ? So that we are sure of somebody using it eventually.
> 
This new API is suitable for the users that required to access for
multiple regulators. And I am one of users who uses this API, but I am
not able to upstream the GPU kernel driver which uses the new API.

--
Nick Fan
