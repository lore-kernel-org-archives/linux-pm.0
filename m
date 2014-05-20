From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V4] PM/OPP: discard duplicate OPPs
Date: Tue, 20 May 2014 09:54:14 -0500
Message-ID: <CAGo_u6p0VMEOxcvQMzyCjTN2MQqgdPCsuYvJdKRmdoqDs0qKLw@mail.gmail.com>
References: <d0200ee9e30de19f69ca1b7e53a8cd7a047fa436.1400595283.git.viresh.kumar@linaro.org>
	<537B6663.30005@ti.com>
	<CAKohpok5QZvQzSkDxeLTnRK9F0Zf0kr2PD+gbP+FqmhL_dYLCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohpok5QZvQzSkDxeLTnRK9F0Zf0kr2PD+gbP+FqmhL_dYLCQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arvind Chauhan <arvind.chauhan@arm.com>, Ips Gandhi <inderpal.s@samsung.com>, Chander Kashyap <chander.kashyap@linaro.org>, Pavel Machek <pavel@ucw.cz>, "Brown, Len" <len.brown@intel.com>, Chander Kashyap <k.chander@samsung.com>, Viresh Kumar <viresh.kumar@linrao.org>
List-Id: linux-pm@vger.kernel.org

On Tue, May 20, 2014 at 9:49 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> breaking printk string into multiple line isn't suggested as it affects
> readability and so I kept it this way. Another was was to break printk
> itself intro two-three printk lines, but that would have looked bad
> on console.
>
> So, will retain it :(
OK, dev_warn at least should be done.. we use dev_warn everywhere else.

Regards,
Nishanth Menon
