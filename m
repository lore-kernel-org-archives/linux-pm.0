From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: cpufreq warning with kernel 3.11
Date: Mon, 2 Sep 2013 18:42:13 +0530
Message-ID: <CAKohpo=USO=eTqEd8T7DfqMLknxP1_JQ4k39x_NfCGtUC-nUJQ@mail.gmail.com>
References: <52234788.1090607@gmail.com>
	<9800169.8Do56q7MsY@vostro.rjw.lan>
	<CAKohpomaLCwVVeGY7HgXubngmod_8rSr6UVwwWxmthbq=k2ncQ@mail.gmail.com>
	<1501850.1zOhJXu0RL@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1501850.1zOhJXu0RL@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alessandro Bono <alessandro.bono@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 2 September 2013 17:19, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> Let me guess, you sent it with GMail?
>
> If so, what about filing a bug against it about the tab removal?

Will do that..

>> + /*
>> + * Some drivers don't send POSTCHANGE notification from their
>
> For example?

exynos5440 & longhaul..

> It looks like it will work.  I'll queue it up for 3.12.

Thanks..
