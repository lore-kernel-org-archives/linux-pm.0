From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 1/2] cpufreq / OPP: Allow boost frequency to be looked
 up from device tree
Date: Wed, 14 May 2014 19:24:54 +0530
Message-ID: <CAKohpon-z-MS68qkEvioBPLVvoieo0WqGBTC+ZJz+KsoZ8CGhQ@mail.gmail.com>
References: <1400029380-5372-1-git-send-email-thomas.ab@samsung.com>
	<1400029380-5372-2-git-send-email-thomas.ab@samsung.com>
	<CAKohponnPSRAotJUu+5a9y8j97QF8Jqgc5DA5WQnwGWCnVY-aA@mail.gmail.com>
	<CAJuA9agfoVwqa88=JB+SirjcO0dXy0s0fTc8=dP=u7H8uarSyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAJuA9agfoVwqa88=JB+SirjcO0dXy0s0fTc8=dP=u7H8uarSyg@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <ta.omasab@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <rob.herring@linaro.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-pm@vger.kernel.org

On 14 May 2014 19:16, Thomas Abraham <ta.omasab@gmail.com> wrote:
> On Wed, May 14, 2014 at 9:10 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

>> Why is this present outside of above if {} ? as boost_freqs is guaranteed to
>> be NULL without that.
>
> Just to reduce indentation by one tab. No technical reasons. The code
> had to wrap at 80 column was becoming unreadable.

That's bad :), you have added an extra comparison just for that :(
Instead kill the below indentation by doing a "goto out" with a ! of
below expression:

>> +       if (of_find_property(dev->of_node, "boost-frequency", &len)) {
