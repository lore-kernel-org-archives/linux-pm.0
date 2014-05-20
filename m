From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4] PM/OPP: discard duplicate OPPs
Date: Tue, 20 May 2014 20:19:29 +0530
Message-ID: <CAKohpok5QZvQzSkDxeLTnRK9F0Zf0kr2PD+gbP+FqmhL_dYLCQ@mail.gmail.com>
References: <d0200ee9e30de19f69ca1b7e53a8cd7a047fa436.1400595283.git.viresh.kumar@linaro.org>
	<537B6663.30005@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <537B6663.30005@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arvind Chauhan <arvind.chauhan@arm.com>, Ips Gandhi <inderpal.s@samsung.com>, Chander Kashyap <chander.kashyap@linaro.org>, Pavel Machek <pavel@ucw.cz>, "Brown, Len" <len.brown@intel.com>, Chander Kashyap <k.chander@samsung.com>, Viresh Kumar <viresh.kumar@linrao.org>
List-Id: linux-pm@vger.kernel.org

On 20 May 2014 19:57, Nishanth Menon <nm@ti.com> wrote:
>> +             pr_warn("%s: duplicate OPPs detected. Existing: freq: %lu, volt: %lu, enabled: %d. New: freq: %lu, volt: %lu, enabled: %d\n",
> dev_warn please? we already know the dev pointer. Also can we reduce
> this down to 80 character limit if possible?

breaking printk string into multiple line isn't suggested as it affects
readability and so I kept it this way. Another was was to break printk
itself intro two-three printk lines, but that would have looked bad
on console.

So, will retain it :(
