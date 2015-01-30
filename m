From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: RFC on cpufreq implementation
Date: Fri, 30 Jan 2015 06:45:56 +0530
Message-ID: <CAKohponrzDb4ZGvRtJ5jtGTPAy4RCfRsYGvdjR5fx51K2=evCg@mail.gmail.com>
References: <54B7F7CD.7030903@free.fr>
	<54CA6327.5070707@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <54CA6327.5070707@free.fr>
Sender: cpufreq-owner@vger.kernel.org
To: Mason <mpeg.blue@free.fr>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux PM <linux-pm@vger.kernel.org>, cpufreq <cpufreq@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

On 29 January 2015 at 22:13, Mason <mpeg.blue@free.fr> wrote:
> OK, so this is my TAKE 2 on the cpufreq driver, trying to remove
> some dependencies on machine-specific definitions by getting the
> virtual address at init via ioremap. (Is -EFAULT the right error
> to return if ioremap fails?)
>
> I'm not sure where machine-specific information is supposed to
> be stored though? Such as register definitions, or the physical
> addresses/offsets. What if they need to be shared among several
> source files? I can't just duplicate them... (I've tentatively
> called it temp.h for the time being.)

What do you want to do with this driver? If you want to get it reviewed,
please send it properly with git-send-email instead of attachments..

If its just an internal one, then sorry, the lists aren't for such reviews.

--
viresh
