From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: cpufreq warning with kernel 3.11
Date: Mon, 02 Sep 2013 15:23:59 +0200
Message-ID: <8428119.BLdDE6zerK@vostro.rjw.lan>
References: <52234788.1090607@gmail.com> <1501850.1zOhJXu0RL@vostro.rjw.lan> <CAKohpo=USO=eTqEd8T7DfqMLknxP1_JQ4k39x_NfCGtUC-nUJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:52266 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753376Ab3IBNNL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 2 Sep 2013 09:13:11 -0400
In-Reply-To: <CAKohpo=USO=eTqEd8T7DfqMLknxP1_JQ4k39x_NfCGtUC-nUJQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Alessandro Bono <alessandro.bono@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>

On Monday, September 02, 2013 06:42:13 PM Viresh Kumar wrote:
> On 2 September 2013 17:19, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > Let me guess, you sent it with GMail?
> >
> > If so, what about filing a bug against it about the tab removal?
> 
> Will do that..
> 
> >> + /*
> >> + * Some drivers don't send POSTCHANGE notification from their
> >
> > For example?
> 
> exynos5440 & longhaul..

OK, thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
