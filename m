From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/5] cpufreq: Fixes for 3.12
Date: Tue, 20 Aug 2013 18:07:14 +0530
Message-ID: <CAKohpomCaUvns+45qV-MdcxmRJ9fihdDf--BgH5uxEFqVnFPHQ@mail.gmail.com>
References: <cover.1376979090.git.viresh.kumar@linaro.org>
	<4207583.84U9qMI9uv@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <4207583.84U9qMI9uv@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 20 August 2013 18:13, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> Well, this looks good, but do we really need it in 3.12?  It doesn't look
> like 3.12 will be missing these changes a lot?

Hmm.. If its too late for 3.12 we can skip them, but first two are bug
fixes really (though nobody is affected as cpufreq_policy_list isn't used
yet :) ) and other three are cleanups..

So, if there is any chance that we can queue them up for 3.12, it would
be good.. but definitely not a must to have stuff. :)

--
viresh
