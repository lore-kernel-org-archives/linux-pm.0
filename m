From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RESEND][PATCH] cpufreq: stats: Add 'load_table' sysfs file to
 show accumulated data of CPU
Date: Fri, 14 Jun 2013 09:41:13 +0530
Message-ID: <CAKohpokL1PNsYXJvnrkYesUHhe4s9-HsZe_c5KW+toeHJep2PA@mail.gmail.com>
References: <1370419882-16831-1-git-send-email-cw00.choi@samsung.com>
	<11735265.3zXb8Z81XT@vostro.rjw.lan>
	<CAKohpomwDonECPOPoSZvrOS+mRyNARX4Sk1XoEAGLXrOQQjYjA@mail.gmail.com>
	<2801243.ZfLEluCnpU@vostro.rjw.lan>
	<51BA7BDB.9070801@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <51BA7BDB.9070801@samsung.com>
Sender: cpufreq-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, kyungmin.park@samsung.com, myungjoo.ham@samsung.com
List-Id: linux-pm@vger.kernel.org

On 14 June 2013 07:41, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> OK, I will reimplement load_table node by using debugfs instead of sysfs.

@Rafael: Would it be move trans_table to debugfs??
