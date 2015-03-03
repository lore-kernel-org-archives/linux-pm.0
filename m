From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq-dt: support cluster level clock
Date: Tue, 3 Mar 2015 20:49:25 +0530
Message-ID: <CAKohponQ1keZ3x9mK=9qchfwPF=cYKAA9aYgmu52X5NDGJLECg@mail.gmail.com>
References: <1425387817-11382-1-git-send-email-leo.yan@linaro.org>
	<1425387817-11382-2-git-send-email-leo.yan@linaro.org>
	<CAKohpoksXwMRWYzSBmbV1nN5_LvUiB1Y2wfgOcCJPx+oipaXZw@mail.gmail.com>
	<20150303140331.GA11325@leoy-linaro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150303140331.GA11325@leoy-linaro>
Sender: linux-kernel-owner@vger.kernel.org
To: Leo Yan <leo.yan@linaro.org>
Cc: Shawn Guo <shawn.guo@linaro.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 3 March 2015 at 19:33, Leo Yan <leo.yan@linaro.org> wrote:
> I'm just thinking to finish things in one time. From my previous
> experience, clocks per cluster are common cases for ARM's
> multi-clusters, so i think it's reasonable to add related support.

Yes they are common, but that will be fixed with new OPP bindings
I am working on [1].

> Regarding of testing this patch, i created two virtual clocks for
> every cluster and passed the test. Do u think this is acceptable?

Just to confirm again, we aren't going to accept or apply these
patches. It will work without any changes for you, for now.

--
viresh

[1] https://www.marc.info/?l=linaro-kernel&m=142364262800650&w=3
