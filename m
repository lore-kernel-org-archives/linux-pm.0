From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: cpufreq warning with kernel 3.11
Date: Wed, 11 Sep 2013 12:05:18 +0530
Message-ID: <CAKohpo=i1SXnaAUoZN6fT7xBOCCkpoTHqOJHGg-xTf8HvwrFAg@mail.gmail.com>
References: <52234788.1090607@gmail.com>
	<9800169.8Do56q7MsY@vostro.rjw.lan>
	<CAKohpomaLCwVVeGY7HgXubngmod_8rSr6UVwwWxmthbq=k2ncQ@mail.gmail.com>
	<1501850.1zOhJXu0RL@vostro.rjw.lan>
	<CAKohpo=USO=eTqEd8T7DfqMLknxP1_JQ4k39x_NfCGtUC-nUJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpo=USO=eTqEd8T7DfqMLknxP1_JQ4k39x_NfCGtUC-nUJQ@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alessandro Bono <alessandro.bono@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 2 September 2013 18:42, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 2 September 2013 17:19, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> Let me guess, you sent it with GMail?
>>
>> If so, what about filing a bug against it about the tab removal?
>
> Will do that..
>
>>> + /*
>>> + * Some drivers don't send POSTCHANGE notification from their
>>
>> For example?
>
> exynos5440 & longhaul..

Oops!! That was exynos5440 and powernow-k8...

Longhaul doesn't have any such special stuff in..
