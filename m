From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/2] cpufreq: don't allow governor limits to be changed when it is disabled
Date: Sun, 01 Sep 2013 15:29:20 +0200
Message-ID: <8685493.XaYGerLxqW@vostro.rjw.lan>
References: <085013f4e584e3fef97187bcb349c3fa76942e19.1378012620.git.viresh.kumar@linaro.org> <CAKohpomt4vAxHiCkiSzpX6UttMqox=Sc9Oqhgxw6YHtkJfghGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpomt4vAxHiCkiSzpX6UttMqox=Sc9Oqhgxw6YHtkJfghGQ@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sunday, September 01, 2013 11:56:09 AM Viresh Kumar wrote:
> On 1 September 2013 10:56, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > Its better if we can get these in for 3.11, otherwise we need to get them in the
> > stable tree..
> 
> They can't get into 3.11 due to two reasons..
> - I haven't tested them over 3.11 but linux-next/master.
> - Few more dependency patches might also be required for 3.11..
> 
> So get them into 3.12-rc1 if they look okay to you :)

I'm going to do that, but please add explanation to the [2/2] changelog.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
