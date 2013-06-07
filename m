From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [GIT PULL] CPUFreq: ARM Updates for v3.11
Date: Fri, 07 Jun 2013 13:16:34 +0200
Message-ID: <4129326.tFXhKE6MIr@vostro.rjw.lan>
References: <CAKohpokdrw1KZuCx6Y5E1JyK-Yq0T1fh0qP+bEaqgZjoK8JEEQ@mail.gmail.com> <54837539.yBQlA0EhhC@vostro.rjw.lan> <CAKohponx-dSdRVX77Fa8ePKhppvvE=dS=ofJT0_+3014b38ZOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:59445 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752047Ab3FGLH2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 7 Jun 2013 07:07:28 -0400
In-Reply-To: <CAKohponx-dSdRVX77Fa8ePKhppvvE=dS=ofJT0_+3014b38ZOg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Lists linaro-dev <linaro-dev@lists.linaro.org>, linux-arm-kernel@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org

On Friday, June 07, 2013 04:35:24 PM Viresh Kumar wrote:
> On 7 June 2013 16:41, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Friday, June 07, 2013 04:26:36 PM Viresh Kumar wrote:
> 
> >>       cpufreq: bit.LITTLE needs cpufreq table
> >
> > That should be big.LITTLE I suppose?
> 
> Yes. This is not the first time I face this issue where big is
> written as bit. Even I named one of my external repo like this
> earlier and after a long time some other careful viewer caught
> it :)
> 
> Fixed my branch now with s/bit/big.

OK, thanks!

Care to resend the request, since the commit IDs have changed?

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
