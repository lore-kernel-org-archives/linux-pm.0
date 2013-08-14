From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: add frequency table to at32ap driver
Date: Wed, 14 Aug 2013 11:39:29 +0530
Message-ID: <CAKohpomQYN_D76qkDxc2HOHYB09rwOTo7K35XFqbSdEePO61Dg@mail.gmail.com>
References: <1376334657-23578-1-git-send-email-egtvedt@samfundet.no>
	<CAKohpokCsCLS=8FNZpUBgEVi7YropyR4UoLC9XNN+rs5xuigMw@mail.gmail.com>
	<CAKohponh4tW8j3qk7eP9YnfXufutNkK-+iCQRvqSUC2=GwvqeA@mail.gmail.com>
	<20130813065208.GB7055@samfundet.no>
	<CAKohponXSvxQwyx7YJYbcQHD8X2F=EuFpFd31DR5HY3JjvS+rQ@mail.gmail.com>
	<20130813090613.GA1850@samfundet.no>
	<CAKohpokqMt2L_r3WR=vTPyW0kUS5wZ8FxS3ii=B=H=Yizuu=ig@mail.gmail.com>
	<CAKohpomya5EcqRabz7k=eT_vMdb5yuMCbk0vJuY7fLwpCZbc-A@mail.gmail.com>
	<20130814060718.GA6539@samfundet.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20130814060718.GA6539@samfundet.no>
Sender: cpufreq-owner@vger.kernel.org
To: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>
List-Id: linux-pm@vger.kernel.org

On 14 August 2013 11:37, Hans-Christian Egtvedt <egtvedt@samfundet.no> wrote:
> Around Tue 13 Aug 2013 19:00:22 +0530 or thereabout, Viresh Kumar wrote:
>> On 13 August 2013 14:39, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>> Yes, that's what.. That generic routine can be used instead of your .verify()..
>>
>> So here is a patch for that which I will include in my original series. It uses
>> functions from this patch:
>>
>> http://www.kernelhub.org/?msg=309940&p=2
>
> Great. Is there anything left for the at32ap cpufreq driver?

You are cc'd for one more patch which simplifies target()...
Other than that nothing else for now.. But more will come
soon :)

I am running a cpufreq cleanup drive :) ... That may end only once I have
reduced code redundancy to the lowest possible level :)
