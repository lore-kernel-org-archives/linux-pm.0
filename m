From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 1/4] ARM: dts: s5pv210: Add dmc nodes
Date: Fri, 11 Jan 2019 15:11:20 +0530
Message-ID: <20190111094120.6dcnspccp6ufxd4y@vireshk-i7>
References: <20190110205215.22030-1-pawel.mikolaj.chmiel@gmail.com>
 <20190110205215.22030-2-pawel.mikolaj.chmiel@gmail.com>
 <CAJKOXPcWOtTh5nDpZuX=NfrcOcQDPUXoFJLc8JtLs6UEY9LL6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJKOXPcWOtTh5nDpZuX=NfrcOcQDPUXoFJLc8JtLs6UEY9LL6w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>, kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 11-01-19, 09:32, Krzysztof Kozlowski wrote:
> On Thu, 10 Jan 2019 at 21:53, Paweł Chmiel
> <pawel.mikolaj.chmiel@gmail.com> wrote:
> >
> > This commit adds dmc nodes, which are needed by s5pv210 cpufreq driver
> > to work.
> >
> > Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> > ---
> >  arch/arm/boot/dts/s5pv210.dtsi | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> 
> Thanks, applied (actually I applied v1 - I hope there were no changes).

Would you like to Ack the other patches so that I can apply them ?

-- 
viresh
