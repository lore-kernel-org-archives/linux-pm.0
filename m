From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: kyro: Reduce frame-size of
 qcom_cpufreq_kryo_probe()
Date: Thu, 21 Feb 2019 10:14:23 +0530
Message-ID: <20190221044423.utea76twxplxusna@vireshk-i7>
References: <5919a74b74f466e803e07f70136517119dcd4560.1550661235.git.viresh.kumar@linaro.org>
 <CAP245DWuJTXfAc3QyqXjePqy32GHQsEqHbuSvjiS4EE3-TV1PA@mail.gmail.com>
 <20190221034534.n5jli3bj4mwtoudd@vireshk-i7>
 <CAP245DV9m-foV8vAWSq5ZpvPHa_dLJyBQzRkta5B_yO2+bwL2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAP245DV9m-foV8vAWSq5ZpvPHa_dLJyBQzRkta5B_yO2+bwL2A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ilia Lin <ilia.lin@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 21-02-19, 10:02, Amit Kucheria wrote:
> Perhaps I was just unfamiliar with the dev_pm_opp_set_supported_hw()
> API where the actual allocation happens 3 levels deep. Maybe the
> comment should apply to dev_pm_opp_set_supported_hw(). I leave it to
> you to decide.

I think we are fine without any comments here :)

Thanks for your reviews Amit.

-- 
viresh
