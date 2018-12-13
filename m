From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v12 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW driver
Date: Thu, 13 Dec 2018 02:32:13 -0800
Message-ID: <154469713309.19322.12951478077195078609@swboyd.mtv.corp.google.com>
References: <1544687394-331-1-git-send-email-tdas@codeaurora.org> <1544687394-331-3-git-send-email-tdas@codeaurora.org> <154469510700.19322.7762676027024031719@swboyd.mtv.corp.google.com> <20181213100506.sy3haqjbxtmkthvt@vireshk-i7> <154469596755.19322.16319349046735344084@swboyd.mtv.corp.google.com> <20181213101417.dcz66dpbqzbbxkdz@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181213101417.dcz66dpbqzbbxkdz@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Taniya Das <tdas@codeaurora.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org, robh@kernel.org, skannan@codeaurora.org, linux-arm-msm@vger.kernel.org, evgreen@google.com, Matthias Kaehlcke <mka@chromium.org>
List-Id: linux-pm@vger.kernel.org

Quoting Viresh Kumar (2018-12-13 02:14:17)
> On 13-12-18, 02:12, Stephen Boyd wrote:
> > It's on a v4.19 kernel with this cpufreq hw driver backported to it. I
> > think all it takes is to return an error the second time the policy is
> > initialized when cpufreq_online() calls into the cpufreq driver.
>=20
> What do you mean by "the second time the policy is initialized" ?
>=20
> We call cpufreq_online() only once for each policy.
>=20

I have one policy for four CPUs. So take down all four of those CPUs by
writing a 0 to the online file for each CPU, and then bring them back
online. That should make cpufreq_driver->init() be called twice, once
during boot when the CPUs are bound to the cpufreq devices, and second
from the sysfs write when the user brings the first CPU in that policy
online again by writing a 1 to the online file. If that second time it
fails I suspect we hit the lockdep warning.

I may have also catted the policy*/stat/* files before offlining any
CPUs. If you can't trigger it I can try to reproduce again with a static
counter in cpufreq_online() that fails when set to 1 or something.
