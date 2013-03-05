From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: Re: [PATCH linux-next] cpufreq: conservative: Fix sampling_down_factor
 functionality
Date: Tue, 05 Mar 2013 22:37:33 +0200
Message-ID: <5136578D.3040908@semaphore.gr>
References: <51351CC3.4010301@semaphore.gr> <CAOh2x=m0KLbjGKvLvTH7-yQb4SU5-v=-r4Ba3LSZz=NvfvO6mg@mail.gmail.com> <51358117.9060902@semaphore.gr> <5135FD01.8060306@verisign.com> <5135FF50.4020001@verisign.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <5135FF50.4020001@verisign.com>
Sender: cpufreq-owner@vger.kernel.org
To: David C Niemi <dniemi@verisign.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi David,
On 03/05/2013 04:21 PM, David C Niemi wrote:
>
> I should clarify -- I wrote the sampling_down_factor in the *ondemand* governor.  I chose the name of the parameter based on the vaguely similar parameter in the conservative governor, but the documentation that was referenced (about it only applying at top speed and the comment about skipping evaluation opportunities when it is active) was written by me in reference to the ondemand governor.  It could be that someone backported some of the ondemand sampling_down_factor's behavior to the conservative governor.
>
> I'd like to ask -- what is the intended use of the conservative governor these days as differentiated from the ondemand governor?  At one time it seemed more oriented towards power savings, but the ondemand governor had picked up most or all of its power-saving features.

Thanks for the information.
I would agree about the use of conservative, but I think that I'm not
the right person to answer this question. :)

Regards,
Stratos
