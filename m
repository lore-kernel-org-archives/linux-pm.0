From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 Resend 07/92] cpufreq: cris: Use generic cpufreq routines
Date: Thu, 3 Oct 2013 21:16:32 +0530
Message-ID: <CAKohpo=+5adkr_OfDhq4WELNb-wk5LdphWmbjHPjVRBz9joQyg@mail.gmail.com>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
	<2906aa4a654021836ca97e717e1cee68ebec93d8.1380783079.git.viresh.kumar@linaro.org>
	<20131003152542.GR11028@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20131003152542.GR11028@axis.com>
Sender: cpufreq-owner@vger.kernel.org
To: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: "rjw@sisk.pl" <rjw@sisk.pl>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Jesper Nilsson <jespern@axis.com>, Mikael Starvik <starvik@axis.com>, linux-cris-kernel <linux-cris-kernel@axis.com>
List-Id: linux-pm@vger.kernel.org

On 3 October 2013 20:55, Jesper Nilsson <jesper.nilsson@axis.com> wrote:
> On Thu, Oct 03, 2013 at 04:58:01PM +0200, Viresh Kumar wrote:
>> Most of the CPUFreq drivers do similar things in .exit() and .verify() routines
>> and .attr. So its better if we have generic routines for them which can be used
>> by cpufreq drivers then.
>>
>> This patch uses these generic routines for this driver.
>
> You should already have gotten my Acked-by: for this series, but here it is again:

Yeah.. So sorry for missing those :(
