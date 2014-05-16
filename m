From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / OPP: Implement free_opp_table function
Date: Fri, 16 May 2014 22:56:39 +0530
Message-ID: <CAKohpomoXs+ybYvDa8_NdXqT7T4xqgtbbtEHp2CR1T=f6GVbNA@mail.gmail.com>
References: <1400231366-1221-1-git-send-email-inderpal.s@samsung.com>
	<CAKohponY6Nn5kYGyps2SLm5uBbH1JWuJBpzzVD=QOc=oM7crAg@mail.gmail.com>
	<CAOqmu82GQ2qsm0c7fq8n5ovR7+4j5t_Y3=03S=nWtR+bH3yhdg@mail.gmail.com>
	<CAKohpokCBbL1OkxB3rh0Pr3yqiG1H6UsZgD-WQTRvihxJt1-Qw@mail.gmail.com>
	<CAOqmu81Np91-GRe-GndjE2FnbGA-xttvu64gr=h9FaNpbBSoBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOqmu81Np91-GRe-GndjE2FnbGA-xttvu64gr=h9FaNpbBSoBw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Inderpal Singh <inderpal.s@samsung.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On 16 May 2014 22:54, Inderpal Singh <inderpal.s@samsung.com> wrote:
> by the time "pos = list_entry_rcu(pos->member.
> next, typeof(*pos), member)" is executed, the pos would have been
> freed in the loop.

Oops!!
