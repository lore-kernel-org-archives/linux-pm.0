From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: Cpufreq userspace governor start/stop issue
Date: Thu, 6 Jun 2013 09:58:04 +0530
Message-ID: <CAKohpon7nac-itgddOSBU+LmWDxmbWuQk=yVBtVBqmmo-vzQVg@mail.gmail.com>
References: <CAFgnuDd_6z+g2m8QAfZBaCnwUYUPWB6Dku_3KvmTJ4mOrcOa6Q@mail.gmail.com>
	<CAKohpok=tUf=9peEkriM9Ow8J2NfZxDBuaFQhW+uyfeEVYiRjw@mail.gmail.com>
	<CAFgnuDeDUSCd8UMKSBOXVNW+aJwqtr9jd4DTBL=HhsbkDtXgwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAFgnuDeDUSCd8UMKSBOXVNW+aJwqtr9jd4DTBL=HhsbkDtXgwQ@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Xiaoguang Chen <chenxg.marvell@gmail.com>
Cc: rjw@sisk.pl, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 6 June 2013 09:10, Xiaoguang Chen <chenxg.marvell@gmail.com> wrote:
> Yes, I missed the governor start in the end.
> There is still a chance that After governor stop but before governor start,
> cpu0 tries to set frequency through userspace governor, it will fail.
> This should be the same problem I described to you before that
> governor stop and start
> should be protected by a lock to keep it in sequence and no body
> should interrupt.
> It seems we need to use the same lock for userspace governor set
> freuqency to delay freq_set until
> governor is started.

Maybe we have one more option other than locking the sequence.
Use locks properly in governor and a mechanism similar to
cpu_is_managed from userspace governor. If we aren't managed
now or governor isn't enabled for cpu return -EBUSY.
