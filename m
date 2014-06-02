From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v2 1/7] arm: firmware: Check firmware is running or not
Date: Mon, 02 Jun 2014 15:05:54 +0200
Message-ID: <7579658.qxmXgWLkvU@amdc1032>
References: <1401712543-14281-1-git-send-email-b.zolnierkie@samsung.com>
 <1401712543-14281-2-git-send-email-b.zolnierkie@samsung.com>
 <538C7342.4000700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <538C7342.4000700@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <t.figa@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org
List-Id: linux-pm@vger.kernel.org


Hi,

On Monday, June 02, 2014 02:51:14 PM Tomasz Figa wrote:
> Hi,
> 
> On 02.06.2014 14:35, Bartlomiej Zolnierkiewicz wrote:
> > From: Kyungmin Park <kyungmin.park@samsung.com>
> > 
> > To support multi-platform, it needs to know it's running under secure
> > OS or not.  Sometimes it needs to access physical address by SMC calls.
> > 
> > e.g.,
> >         if (firmware_run()) {
> >                 addr = physical address;
> >         } else {
> >                 addr = virtual address;
> >         }
> > 
> >         call_firmware_ops(read_address, addr, &value);
> 
> Hmm, I don't understand the code above. It first asks whether the
> firmware is available and then calls a firmware operation anyway
> (assuming that firmware is available regardless of the check above)...
> 
> I don't like the idea of this function, because we have designed the
> firmware API to not require this kind of checks. Instead, you just call
> whatever firmware operation you need and if it returns -ENOSYS you need
> to fallback to legacy (firmware-less) way of doing it.
> 
> Could you provide your use case for which this doesn't work?

Please take a look at patch #7.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
