From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: Re: [PATCH v3 linux-next] cpufreq: ondemand: Calculate gradient of
 CPU load to early increase frequency
Date: Tue, 16 Apr 2013 21:34:21 +0300
Message-ID: <516D99AD.4070104@semaphore.gr>
References: <ore61p9gvaic2j0fc083dpbd.1364970699079@email.android.com> <CAKohponUuwiQ9EiKq66Mgf7zZxonxHs=DNbhx=uydDVB5bed6w@mail.gmail.com> <3060957.HxB12olH3c@vostro.rjw.lan> <515CBB98.4020607@semaphore.gr> <CAKohpomV7uSS1suFKGiGJfGvvqodKHhvc_uO3WsR4jzUg+1o9g@mail.gmail.com> <515F2AF3.9050709@semaphore.gr> <51644855.1090300@semaphore.gr> <CAKohponhGA1LCe8Hv7xHk0ULXVVPTgmEY-nKTgpE0w6VmX--Ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohponhGA1LCe8Hv7xHk0ULXVVPTgmEY-nKTgpE0w6VmX--Ng@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 04/10/2013 06:22 AM, Viresh Kumar wrote:
> On 9 April 2013 22:26, Stratos Karafotis <stratosk@semaphore.gr> wrote:
>> On 04/05/2013 10:50 PM, Stratos Karafotis wrote:
>>>
>>> Hi Viresh,
>>>
>>> On 04/04/2013 07:54 AM, Viresh Kumar wrote:
>>>>
>>>> Hi Stratos,
>>>>
>>>> Yes, your results show some improvements. BUT if performance is the only
>>>> thing
>>>> we were looking for, then we will never use ondemand governor but
>>>> performance
>>>> governor.
>>>>
>>>> I suspect this little increase in performance must have increased power
>>>> numbers
>>>> too (significantly). So, if you can get numbers in the form of
>>>> power/performance
>>>> with and without your patch, it will be great.
>>>>
>>>> --
>>>> viresh
>>>>
>>>
>>> I run some more tests. I increased the number of iterations to 100 (from
>>> 20).
>>> I also test for counter 1,000,000 (~4200us), 5,000,000 (~10000us),
>>> 15,000,000 (~30000us).
>>>
>>> This time, I also extracted statistics from cpufreq_stats driver. I think
>>> this will be an
>>> indication for power consumption. Below the results and attached the
>>> program I used for to
>>> get these numbers.
>>
>>
>> Any comments would be appreciated.
>
> Sorry, i forgot about this mail earlier..
>
> Your performance numbers look improved but i am still not sure about
> power consumption. But as this is not going to be the default settings, i
> think we can take this patch.
>
> @Rafael:?
>

Hi Rafael,

I'm sorry for bothering you again for this patch.
Are these number adequate? Should I provide more benchmark results?

Thanks for your time.

Stratos
