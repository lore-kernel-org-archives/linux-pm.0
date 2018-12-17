From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] cpufreq: nforce2: Remove meaningless return
Date: Mon, 17 Dec 2018 12:44:00 +0100
Message-ID: <4562223.GN38KlamCS@aspire.rjw.lan>
References: <20181205155751.15945-1-tiny.windzz@gmail.com> <20181206042025.njiw3rzmgmzb6ki4@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206042025.njiw3rzmgmzb6ki4@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Yangtao Li <tiny.windzz@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday, December 6, 2018 5:20:25 AM CET Viresh Kumar wrote:
> On 05-12-18, 10:57, Yangtao Li wrote:
> > Delete a line of meaningless return and some useless blank lines. In a function
> > whose return type is void, returning on the last line is not required.
> > 
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> > Changes in v2:
> > -revert modify of MODULE_
> > -delete some blank lines
> > ---
> >  drivers/cpufreq/cpufreq-nforce2.c | 3 ---
> >  1 file changed, 3 deletions(-)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Patch applied, thanks!
