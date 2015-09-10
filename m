From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/7] cpufreq: remove redundant CPUFREQ_INCOMPATIBLE
 notifier event
Date: Thu, 10 Sep 2015 02:53:18 +0200
Message-ID: <CAJZ5v0jRDFJF6_mNvE7JknuUG-Tz1mDFMXw5rOEJP4GqXZtprA@mail.gmail.com>
References: <cover.1438571116.git.viresh.kumar@linaro.org>
	<406f55ac8030043f0349b084878c9b8d04f7ad86.1438571116.git.viresh.kumar@linaro.org>
	<4897937.47p7WB7CoU@vostro.rjw.lan>
	<20150910003918.GL5266@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20150910003918.GL5266@linux>
Sender: linux-doc-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Fabian Frederick <fabf@skynet.be>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jonathan Corbet <corbet@lwn.net>, Len Brown <lenb@kernel.org>, "open list:ACPI" <linux-acpi@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Nicholas Mc Guire <hofrat@osadl.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-pm@vger.kernel.org

Hi,

On Thu, Sep 10, 2015 at 2:39 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 10-09-15, 01:26, Rafael J. Wysocki wrote:
>> On Monday, August 03, 2015 08:36:14 AM Viresh Kumar wrote:
>> > What's being done from CPUFREQ_INCOMPATIBLE, can also be done with
>> > CPUFREQ_ADJUST. There is nothing special with CPUFREQ_INCOMPATIBLE
>> > notifier.
>>
>> The above part of the changelog is a disaster to me. :-(
>>
>> It not only doesn't explain what really goes on, but it's actively confusing.
>>
>> What really happens is that the core sends CPUFREQ_INCOMPATIBLE notifications
>> unconditionally right after sending the CPUFREQ_ADJUST ones, so the former is
>> just redundant and it's more efficient to merge the two into one.
>
> Undoubtedly this looks far better :)
>
> But, isn't this series already applied some time back ?

Right, never mind.  For some reason that patch was left in the "New" state.

The code is OK.

Thanks,
Rafael
