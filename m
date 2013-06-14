From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RESEND][PATCH] cpufreq: stats: Add 'load_table' sysfs file to show accumulated data of CPU
Date: Fri, 14 Jun 2013 14:48:27 +0200
Message-ID: <8166789.M9n1Uisvhs@vostro.rjw.lan>
References: <1370419882-16831-1-git-send-email-cw00.choi@samsung.com> <51BA7BDB.9070801@samsung.com> <CAKohpokL1PNsYXJvnrkYesUHhe4s9-HsZe_c5KW+toeHJep2PA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:37266 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752471Ab3FNMjN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 14 Jun 2013 08:39:13 -0400
In-Reply-To: <CAKohpokL1PNsYXJvnrkYesUHhe4s9-HsZe_c5KW+toeHJep2PA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, kyungmin.park@samsung.com, myungjoo.ham@samsung.com

On Friday, June 14, 2013 09:41:13 AM Viresh Kumar wrote:
> On 14 June 2013 07:41, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> > OK, I will reimplement load_table node by using debugfs instead of sysfs.
> 
> @Rafael: Would it be move trans_table to debugfs??

I'm not sure who uses it now.  If there are any user space tools depending on
it in use, I'm afraid we can't just move it around.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
