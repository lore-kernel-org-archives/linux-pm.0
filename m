From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: RFC on cpufreq implementation
Date: Mon, 19 Jan 2015 13:22:52 +0530
Message-ID: <CAKohponGjLkniP2=Aj-Jsg7hfAEnW3p0+EwtrobdCymgT-yqgg@mail.gmail.com>
References: <54B7F7CD.7030903@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <54B7F7CD.7030903@free.fr>
Sender: cpufreq-owner@vger.kernel.org
To: Mason <mpeg.blue@free.fr>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux PM <linux-pm@vger.kernel.org>, cpufreq <cpufreq@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

On 15 January 2015 at 22:54, Mason <mpeg.blue@free.fr> wrote:
> I decided to expose only a small subset of frequencies (namely
> {999,500,333,111} MHz) because, in my tests, the ondemand gov
> chose mostly min and max, and the intermediate frequencies not
> so much; so I figured "2 intermediate freqs" is good enough.
> (I'm ready to hear otherwise.)

Following patch solved this issue in 3.17..

6393d6a1027e cpufreq: ondemand: Eliminate the deadband effect
