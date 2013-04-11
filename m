From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 9/9] powerpc: cpufreq: move cpufreq driver to
 drivers/cpufreq
Date: Wed, 10 Apr 2013 23:59:57 -0700
Message-ID: <20130411065957.GB31465@quad.lixom.net>
References: <cover.1364229828.git.viresh.kumar@linaro.org>
 <4180fd5b43906421fc155126e8b7bea5fb3ff375.1364229828.git.viresh.kumar@linaro.org>
 <CAKohpo=LOJ3DfaGzCm6a6ev2+dNUgEpJd+04pGMhdSpkyZNR9A@mail.gmail.com>
 <CAKohpomRMkKouiy+iJUiheTcPGCDVLbxppL5f4oc-WMu2E5T8g@mail.gmail.com>
 <1364985034.16520.12.camel@pasglop>
 <CAKohpo=EPbGocbNaZcNtGuZy4Tst5jH4rPviQ6L=YuZceDnKMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:42720 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736Ab3DKG76 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Apr 2013 02:59:58 -0400
Received: by mail-pb0-f41.google.com with SMTP id mc17so706581pbc.0
        for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2013 23:59:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAKohpo=EPbGocbNaZcNtGuZy4Tst5jH4rPviQ6L=YuZceDnKMw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, arvind.chauhan@arm.com, Arnd Bergmann <arnd.bergmann@linaro.org>, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org

On Thu, Apr 04, 2013 at 11:55:56AM +0530, Viresh Kumar wrote:
> On 3 April 2013 16:00, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > On Wed, 2013-04-03 at 15:00 +0530, Viresh Kumar wrote:
> >> On 31 March 2013 09:33, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> 
> >> > Benjamin/Paul/Olof,
> >> >
> >> > Any comments on this?
> >>
> >> Ping!!
> >
> > I'm on vacation until end of April. No objection to the patch but
> > somebody needs to test it.
> 
> Hi,
> 
> Can somebody else from powerpc world give it a try?
> 
> OR
> 
> @Rafael: Can we get this pushed in linux-next as is and then people would
> be forced to test it and in case there are any complains, i will fix them or
> you can revert it?


That's not very nice this late in the staging cycle. Give the powerpc
guys a little more time than a single day to come back with test results,
please.


-Olof
