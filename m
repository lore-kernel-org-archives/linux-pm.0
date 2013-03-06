From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH linux-next] cpufreq: conservative: Fix sampling_down_factor
 functionality
Date: Wed, 6 Mar 2013 14:43:45 +0800
Message-ID: <CAKohpo=LVj+1RSFSmKk1WUYZJDY_rNSYd8H=B1sBK3NObgd=wg@mail.gmail.com>
References: <51351CC3.4010301@semaphore.gr>
	<CAOh2x=m0KLbjGKvLvTH7-yQb4SU5-v=-r4Ba3LSZz=NvfvO6mg@mail.gmail.com>
	<51358117.9060902@semaphore.gr>
	<5135FD01.8060306@verisign.com>
	<5135FF50.4020001@verisign.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <5135FF50.4020001@verisign.com>
Sender: cpufreq-owner@vger.kernel.org
To: David C Niemi <dniemi@verisign.com>
Cc: Stratos Karafotis <stratosk@semaphore.gr>, "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 5 March 2013 22:21, David C Niemi <dniemi@verisign.com> wrote:
> I'd like to ask -- what is the intended use of the conservative governor these days as differentiated from the ondemand governor?  At one time it seemed more oriented towards power savings, but the ondemand governor had picked up most or all of its power-saving features.

I believe the difference is still the same.. conservative is not as
aggressive as
ondemand now also, i don't know which people are using it though :)
