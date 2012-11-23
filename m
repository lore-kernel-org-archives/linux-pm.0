From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v4 1/2] cpufreq: ondemand: handle SW coordinated CPUs
Date: Fri, 23 Nov 2012 20:54:01 +0100
Message-ID: <1694807.007dnPzdVx@vostro.rjw.lan>
References: <1353663117-10074-1-git-send-email-fabio.baltieri@linaro.org> <20121123124221.GA7378@balto.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20121123124221.GA7378@balto.lan>
Sender: cpufreq-owner@vger.kernel.org
To: Fabio Baltieri <fabio.baltieri@linaro.org>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Rickard Andersson <rickard.andersson@stericsson.com>, Vincent Guittot <vincent.guittot@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday, November 23, 2012 01:42:21 PM Fabio Baltieri wrote:
> Hi Rafael,
> 
> On Fri, Nov 23, 2012 at 10:31:56AM +0100, Fabio Baltieri wrote:
> >  drivers/cpufreq/cpufreq_ondemand.c | 152 ++++++++++++++++++++++++++++++++-----
> >  1 file changed, 132 insertions(+), 20 deletions(-)
> 
> I just noticed that the whole ondemand driver was refactored in your
> linux-pm.git/linux-next branch so my patch does not apply.  I'm
> preparing a rebased version of the set, so feel free to skip this one.

Thanks for the heads up, I'll wait for the new version.

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
