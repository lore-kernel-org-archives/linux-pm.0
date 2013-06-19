From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v5] cpufreq: fix governor start/stop race condition
Date: Wed, 19 Jun 2013 08:45:19 +0530
Message-ID: <CAKohpokN_iJ5in0t3Mo68Tost0u2WT65PQtynQ7-wxGZr0LDQQ@mail.gmail.com>
References: <1371114118-19488-1-git-send-email-chenxg@marvell.com>
	<1912850.KuRKhn87Nf@vostro.rjw.lan>
	<CAFgnuDe1bUub92uE1H9Fc9U7AJCYL=WKdyDe2bg00yEr=kMEbQ@mail.gmail.com>
	<CAKohpoktu5+h0YOCtoS6sq2UP2iU+z+nYjwB6rH7cRWDAOhRSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpoktu5+h0YOCtoS6sq2UP2iU+z+nYjwB6rH7cRWDAOhRSA@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Xiaoguang Chen <chenxg.marvell@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Xiaoguang Chen <chenxg@marvell.com>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, njiang1@marvell.com, zjwu@marvell.com, ylmao@marvell.com
List-Id: linux-pm@vger.kernel.org

On 19 June 2013 08:43, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 19 June 2013 06:50, Xiaoguang Chen <chenxg.marvell@gmail.com> wrote:
>> 2013/6/19 Rafael J. Wysocki <rjw@sisk.pl>:
>
>>>> 2) Current governor is userspace, now cpu0 hotplugs in cpu3, it will
>>>
>>> Can you please tell me what the above is supposed to mean?  Is it supposed to
>>> mean "the online of cpu3 is being run on cpu0" or something different?  If
>>> something different, then what?
>
> Please read all the questions carefully. You missed this one.
>
> Actually you should write: Current governor is userspace, now cpu0 hot-unplugs
> cpu3, it will **

Ahh I am mistaken, you are actually bringing cpu3 back to the system. Then you
must have mentioned earlier that cpu3 wasn't online.
