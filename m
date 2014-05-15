From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC PATCH 0/5] Frequency resolution in CCF vs. cpufreq
Date: Thu, 15 May 2014 07:14:30 -0500
Message-ID: <CAGo_u6pxat1=X5tvqb8FYqUttYTaAimbjcdwsUYtS-rYt59v+A@mail.gmail.com>
References: <1400106655-22465-1-git-send-email-soren.brinkmann@xilinx.com>
	<20140515074724.GJ16662@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20140515074724.GJ16662@pengutronix.de>
Sender: cpufreq-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Soren Brinkmann <soren.brinkmann@xilinx.com>, Mike Turquette <mturquette@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Russell King <linux@arm.linux.org.uk>, Michal Simek <michal.simek@xilinx.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thu, May 15, 2014 at 2:47 AM, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
[...]
>> cpufreq, which simply divides values it obtains through clk_round_ra=
te() by
>> 1000, 666666.
>> Since passing 666666 to clk_round_rate() does not result in 66666666=
0
>> (clk_round_rate() always rounds down!), we chose to put 666667 in th=
e OPP. This
> What is OPP?

Operating Performance Point (Documentation/power/opp.txt describes
frequencies in Hz, the bindings we chose in the community
Documentation/devicetree/bindings/power/opp.txt describes it in KHz).

Regards,
Nishanth Menon
