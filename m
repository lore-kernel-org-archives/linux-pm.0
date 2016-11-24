From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: conservative: Rename get_freq_target() to get_freq_step()
Date: Thu, 24 Nov 2016 02:19:44 +0100
Message-ID: <3404774.ZXRieeDzsF@vostro.rjw.lan>
References: <4f72891a684f0a8510e8b9560e2d7922b133d591.1479106815.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4f72891a684f0a8510e8b9560e2d7922b133d591.1479106815.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, stratosk@semaphore.gr
List-Id: linux-pm@vger.kernel.org

On Monday, November 14, 2016 12:30:43 PM Viresh Kumar wrote:
> What's returned from this function is the delta by which the frequency
> must be increased or decreased and not the final frequency that should
> be selected.
> 
> Name it properly to match its purpose. Also update the variables used to
> store that value.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied.

Thanks,
Rafael
