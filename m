From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: Value for policy-cpuinfo.transition_latency
Date: Wed, 26 Nov 2014 12:06:30 +0530
Message-ID: <CAKohpomsneb1mcQF3BM_4S39Zn7FZ6y8EEYuUmDw2J9rjT6ivQ@mail.gmail.com>
References: <5474FBF5.1040300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5474FBF5.1040300@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nick <xerofoify@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 26 November 2014 at 03:30, nick <xerofoify@gmail.com> wrote:
> Greeting Viresh and Rafael,

Hi,

> I am wondering what the values for transition latency are set to in this file our they nanoseconds or microseconds.
> As there seem to be two rather easy FIX MEs in this file, if someone tells me the units of transition latency.

Which file? Solving FIXME's isn't that easy always. And all the information
you need is present in cpufreq core or documentation. Please search that.
This time I can help you: Documentation/cpu-freq/cpu-drivers.txt

If you are looking to fix FIXME's like this:

FIXME: what's the actual transition time?

Then forget it. It can only be done by people who have a board to fix it
+ they have to measure the time it takes to change freqs.
