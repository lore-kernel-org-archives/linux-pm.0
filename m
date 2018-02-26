From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: scpi: invoke frequency-invariance setter function
Date: Mon, 26 Feb 2018 10:32:14 +0100
Message-ID: <CAJZ5v0iYdR84O-z99yNBeK3kd7fE7AZYDKWH+oDFN77Ai_a6xw@mail.gmail.com>
References: <20180220111057.14756-1-dietmar.eggemann@arm.com>
 <CAJZ5v0hB+Uk8SNVqUH3fr1y0SXbY1Rd26b84P-8PPV8FiPbnWw@mail.gmail.com> <23dba70b-aa83-4a21-a33d-733bec215264@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <23dba70b-aa83-4a21-a33d-733bec215264@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 26, 2018 at 8:49 AM, Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
> On 02/22/2018 11:27 PM, Rafael J. Wysocki wrote:
>> On Tue, Feb 20, 2018 at 12:10 PM, Dietmar Eggemann
>> <dietmar.eggemann@arm.com> wrote:
>
> [...]
>
>>> Fixes: 343a8d17fa8d ("cpufreq: scpi: remove arm_big_little dependency")
>>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>>> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
>>> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
>>
>> This is really minor, but I would reorder this slightly.
>
> Tried to figure out what would be the better order. Not sure since I saw
> different examples. Can you tell what would be the best tag order?

I was talking about the patch, not about tags, sorry for the confusion.

Frankly, I don't care about the ordering of the tags. :-)
