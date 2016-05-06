From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: cpufreq governors broken with !CONFIG_SMP?
Date: Thu, 5 May 2016 17:25:19 -0700
Message-ID: <20160506002519.GB14673@sky.smuckle.net>
References: <20160505234922.GA14673@sky.smuckle.net>
 <1961527.dEtpL4HAvs@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1961527.dEtpL4HAvs@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Steve Muckle <steve.muckle@linaro.org>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, May 06, 2016 at 02:09:07AM +0200, Rafael J. Wysocki wrote:
> In turn, schedutil should probably depend on CONFIG_SMP.

In the long term I wonder if it's worth putting PELT under its own
separate feature or just removing #ifdef CONFIG_SMP.

Aside from task migration CPU frequency updates there's also task
creation and deletion which would apply on UP. The tunable
infrastructure being created for scheduler-guided frequency may be of
interest on UP also.
