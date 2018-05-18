From: skannan@codeaurora.org
Subject: Re: [PATCH 1/2] Revert "cpufreq: Remove policy create/remove
 notifiers"
Date: Fri, 18 May 2018 01:47:40 -0700
Message-ID: <e86a168756927b9fe4fb1c6bcc4eb198@codeaurora.org>
References: <1526631889-5084-1-git-send-email-skannan@codeaurora.org>
 <1526631889-5084-2-git-send-email-skannan@codeaurora.org>
 <CAJZ5v0geHvVUfL=+x-XNMQt4ygpt8QumOaWSjG268Sbtw9oeKw@mail.gmail.com>
 <1a66e15a401b2e1602f26cff5e904f12@codeaurora.org>
 <CAJZ5v0i_nCj=sBSwrTjxCbL74Q-AwXJb5L2fV1e9SEMYACZC=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0i_nCj=sBSwrTjxCbL74Q-AwXJb5L2fV1e9SEMYACZC=g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Rajendra Nayak <rjendra@codeaurora.org>, Amit Kucheria <amit.kucheria@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, rjwysocki@gmail.com
List-Id: linux-pm@vger.kernel.org

On 2018-05-18 01:33, Rafael J. Wysocki wrote:
> On Fri, May 18, 2018 at 10:31 AM,  <skannan@codeaurora.org> wrote:
>> On 2018-05-18 01:29, Rafael J. Wysocki wrote:
>>> 
>>> On Fri, May 18, 2018 at 10:24 AM, Saravana Kannan
>>> <skannan@codeaurora.org> wrote:
>>>> 
>>>> This reverts commit f9f41e3ef99ac9d4e91b07634362e393fb929aad.
>>> 
>>> 
>>> No explanation, no cake. :-)
>>> 
>>>> Change-Id: Iddde3ef56c9e5b14dcb14f8737899b85e56f5b43
>>> 
>>> 
>>> S-o-b missing.
>> 
>> 
>> Sorry, forgot the S-o-b. But there's a long explanation in the cover 
>> letter
>> :)
> 
> Cover letters don't go into git repositories, so please move it to the
> patch itself.

Will do. Do you have any opposition to what the series is trying to do?

Thanks,
Saravana
