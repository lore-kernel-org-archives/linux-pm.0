From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 00/10] cpufreq: Add flag to auto-register as cooling device
Date: Thu, 17 Jan 2019 11:31:13 +0100
Message-ID: <CAJZ5v0idoGcc-j1kZVjsNE9Z76xzN1xe0bb=AW-JFcL0ZjfyMg@mail.gmail.com>
References: <cover.1547481320.git.amit.kucheria@linaro.org>
 <20190117054916.dqduckt7larn32av@vireshk-i7> <CAJZ5v0jUKcRQot9m5VOxqppWWrD-Cy=USpKMRtcq4zJ5EgmHCg@mail.gmail.com>
 <CAJZ5v0jMOnV-maVfxbD-8HWOV30qzLfYUYN+xMNBhhgJWB2aFw@mail.gmail.com> <20190117102839.xrkhmghp44nzlytd@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190117102839.xrkhmghp44nzlytd@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Amit Kucheria <amit.kucheria@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Stephen Boyd <swboyd@chromium.org>, Doug Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Matthias Brugger <matthias.bgg@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>, "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, "open list:CPU FREQUENCY DRIVERS" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 17, 2019 at 11:28 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 17-01-19, 11:14, Rafael J. Wysocki wrote:
> > Alternatively, "depends on THERMAL=y" under CPU_THERMAL should work
> > too, shouldn't it?  "!CPU_THERMAL || THERMAL" would be always true
> > then, AFAICS.
>
> That works and this is the easiest of the changes to make :)

Let's do that, then, I think.
