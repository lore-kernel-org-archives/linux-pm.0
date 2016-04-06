From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/7] cpufreq: remove redundant CPUFREQ_INCOMPATIBLE
 notifier event
Date: Wed, 6 Apr 2016 23:45:07 +0200
Message-ID: <CAJZ5v0igB+iQSZO_GngNwRymVKTCKx2YK4BysO2KFXzpMqWwyw@mail.gmail.com>
References: <cover.1438571116.git.viresh.kumar@linaro.org>
	<406f55ac8030043f0349b084878c9b8d04f7ad86.1438571116.git.viresh.kumar@linaro.org>
	<4897937.47p7WB7CoU@vostro.rjw.lan>
	<20150910003918.GL5266@linux>
	<CAJZ5v0jRDFJF6_mNvE7JknuUG-Tz1mDFMXw5rOEJP4GqXZtprA@mail.gmail.com>
	<57057201.9030109@codeaurora.org>
	<CAJZ5v0iUdkYrEzKrGDEiDnexsxfY7o9xOHPoWELk88gau=gAhA@mail.gmail.com>
	<57057FB1.2050904@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <57057FB1.2050904@codeaurora.org>
Sender: linux-doc-owner@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Fabian Frederick <fabf@skynet.be>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jonathan Corbet <corbet@lwn.net>, Len Brown <lenb@kernel.org>, open@codeaurora.org, "list@codeaurora.org:ACPI" <linux-acpi@vger.kernel.org>, "list@codeaurora.org:DOCUMENTATION" <linux-doc@vger.kernel.org>, "list@codeaurora.org:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Nicholas Mc Guire <hofrat@osadl.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 6, 2016 at 11:29 PM, Saravana Kannan <skannan@codeaurora.org> wrote:
> On 04/06/2016 02:21 PM, Rafael J. Wysocki wrote:
>>
>> On Wed, Apr 6, 2016 at 10:30 PM, Saravana Kannan <skannan@codeaurora.org>
>> wrote:
>>>
>>> On 09/09/2015 05:53 PM, Rafael J. Wysocki wrote:
>>>>

[cut]

>>
>> Well, nobody was using that event.
>>
>
> True, but that's more of a bug in drivers/thermal/cpu-cooling.c and
> drivers/acpi/processor_thermal.c. We should revert this patch and fix those
> drivers. Does that seem acceptable to you?

I'd rather see a patch series adding the event back along with some
users.  One user at least.
