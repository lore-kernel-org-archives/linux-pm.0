From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [BUG] oops in cpufreq driver with AMD Kaveri CPU
Date: Tue, 12 Aug 2014 11:22:28 +0530
Message-ID: <CAOh2x=k2xpfqz+VjYpPbQy6Z5aeo8DxkYmk7JSmrAZxQOJSU9Q@mail.gmail.com>
References: <4708675.eITUXPv8Ih@spock>
	<2651364.4shODVy8cx@spock>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2651364.4shODVy8cx@spock>
Sender: linux-kernel-owner@vger.kernel.org
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 8, 2014 at 2:23 AM, Oleksandr Natalenko
<oleksandr@natalenko.name> wrote:
> Disabling cpufreq code in kernel config works around this issue.

Yeah, because this is happening while the notifiers are being served.
Can you debug it a bit to go to the exact notifier routine where this crashes?

> Is this bug related to sleeping in atomic context, which is caused by improper
> GFP_KERNEL usage instead of GFP_ATOMIC? Should I test tat patch, or there will
> be another fix?

Which patch are you talking about here?
