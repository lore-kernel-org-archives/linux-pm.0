From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: Re: [PATCH linux-next] cpufreq: conservative: Fix sampling_down_factor
 functionality
Date: Tue, 05 Mar 2013 22:15:03 +0200
Message-ID: <51365247.5030005@semaphore.gr>
References: <51351CC3.4010301@semaphore.gr> <CAOh2x=m0KLbjGKvLvTH7-yQb4SU5-v=-r4Ba3LSZz=NvfvO6mg@mail.gmail.com> <51358117.9060902@semaphore.gr> <CAKohpokvqe8860J=XO_GXqxpNtrt9XEuUeqCeR=A4PpSaAsHYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohpokvqe8860J=XO_GXqxpNtrt9XEuUeqCeR=A4PpSaAsHYg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 03/05/2013 09:34 AM, Viresh Kumar wrote:
> On 5 March 2013 13:22, Stratos Karafotis <stratosk@semaphore.gr> wrote:
> I misread it here when i looked at this mail for the first time. :)
> I strongly believe that we need a full stop (.) before "Every sampling_rate",
> otherwise it looks like we check for down_factor while increasing freq :)

I agree. I will do that.

> Even now we aren't checking this 80% thing, right? And so in your patch we can
> actually fix the patch too with the right logic of code.. And
> documentation too :)

In my opinion the logic was initially correct. It was broken in the same 
commit that broke also sampling_down_factor.

Now we check if load < (cs_tuners.down_threshold - 10) to decrease freq.
Down threshold is 20, so we actually check the 80% idle.

I think the subtraction of 10 from down_threshold is wrong. It seems 
similar with ondemand but there is no logic for this in conservative.
User can simply select the down_threshold and the load will be compared 
with user's value. No need to alter user's selection.

I will prepare a patchset for these changes.

Regards,
Stratos
