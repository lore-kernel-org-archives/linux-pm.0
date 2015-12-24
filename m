From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: scpi-cpufreq: signedness bug in scpi_get_dvfs_info()
Date: Thu, 24 Dec 2015 02:45:47 +0100
Message-ID: <1952184.nII0v5K5QD@vostro.rjw.lan>
References: <1450178204-26172-1-git-send-email-sudeep.holla@arm.com> <CAPKp9ubzg3hfondHoiR1qgc057Dobrz+1KoPp69-TEy9-_yZiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPKp9ubzg3hfondHoiR1qgc057Dobrz+1KoPp69-TEy9-_yZiA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday, December 23, 2015 11:20:04 AM Sudeep Holla wrote:
> Hi Rafael,
> 
> On Tue, Dec 15, 2015 at 11:16 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > From: Dan Carpenter <dan.carpenter@oracle.com>
> >
> > The "domain" variable needs to be signed for the error handling to work.
> >
> > Fixes: 8def31034d03 ('cpufreq: arm_big_little: add SCPI interface driver')
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/cpufreq/scpi-cpufreq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Hi Rafael,
> >
> > This patch seem to have slipped through the cracks somehow. I don't see
> > in patchwork too. So I am resending so that you can pick for your next
> > rc fix if you plan to send one else for -next
> >
> 
> This got missed again, can you please ensure to pull this for your next -rc.
> If you have none planned, please pull this for-next.

Applied now, thanks!

I'm going to push it for -rc7.

Thanks,
Rafael
