From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 1/2] cpufreq: Don't destroy/realloc policy/sysfs on hotplug/suspend
Date: Fri, 18 Jul 2014 09:49:01 +0530
Message-ID: <CAKohpo=puU-AifGAXMAOs1pnyvTk64u-Fkra5i=-QNn_a-isXQ@mail.gmail.com>
References: <1405464473-3916-1-git-send-email-skannan@codeaurora.org>
	<1405464473-3916-2-git-send-email-skannan@codeaurora.org>
	<CAKohpok2hzwDLy77CZJ+7pHV-Nj4XTviJxVeXQYJRYtKXME00w@mail.gmail.com>
	<53C65F03.1050609@mit.edu>
	<53C6D8EC.1030609@codeaurora.org>
	<CAKohpongsNtEVbHL=w1fbw5tEXK=WaMcp1N03ar9Sx_CU=1O-w@mail.gmail.com>
	<53C8938F.1070706@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <53C8938F.1070706@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: "Srivatsa S. Bhat" <srivatsa@mit.edu>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Todd Poynor <toddpoynor@google.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Stephen Boyd <sboyd@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On 18 July 2014 08:55, Saravana Kannan <skannan@codeaurora.org> wrote:
> Not really. We much never do it during hotplug. We only do it when the
> cpufreq driver unregisters.

Oh yes.
