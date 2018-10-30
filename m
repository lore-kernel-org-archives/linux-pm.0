From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH RFC v1 3/8] timer: Export next wakeup time of a CPU
Date: Tue, 30 Oct 2018 11:29:29 +0100
Message-ID: <CAPDyKFrV-YJ4k_4Vnm-eFx8YAUF9b82U7PLPLFkz2fzcqYWybw@mail.gmail.com>
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
 <1539206455-29342-4-git-send-email-rplsssn@codeaurora.org> <alpine.DEB.2.21.1810292334160.5984@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.21.1810292334160.5984@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, linux-soc@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>, Evan Green <evgreen@chromium.org>, Doug Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>, Lina Iyer <ilina@codeaurora.org>, Lina Iyer <lina.iyer@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Frederic
List-Id: linux-pm@vger.kernel.org

On 29 October 2018 at 23:36, Thomas Gleixner <tglx@linutronix.de> wrote:
> Raju,
>
> On Thu, 11 Oct 2018, Raju P.L.S.S.S.N wrote:
>>
>> +/**
>> + * tick_nohz_get_next_wakeup - return the next wake up of the CPU
>
> Lacks documentation of @cpu. Please include kernel docs into your test
> builds.

Good point!

>
>> + */
>> +ktime_t tick_nohz_get_next_wakeup(int cpu)
>> +{
>> +     struct clock_event_device *dev = per_cpu(tick_cpu_device.evtdev, cpu);
>> +
>> +     return dev->next_event;
>> +}

Thanks for your review!

Kind regards
Uffe
