From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH 6/9] cpufreq: pxa3xx: move cpufreq driver to drivers/cpufreq
Date: Sun, 31 Mar 2013 19:34:34 +0800
Message-ID: <CAMPhdO_ix16iy+KX+pXwhpO4u3Lx_eL3vVCyf+Lu4HthodekRA@mail.gmail.com>
References: <cover.1364205812.git.viresh.kumar@linaro.org> <2aa937c3d81776f01c2c1d6fcfcb08ba74163b53.1364205812.git.viresh.kumar@linaro.org>
 <CAKohpokq+JJF2Ec3=_QF5dk_w9tMuKZ0trtcgXbC1if=HXEBRg@mail.gmail.com>
 <CAMPhdO9WbCdJq8NdoOjW2Jreka2dSRrNyit_7xrAbX_haEqNGQ@mail.gmail.com> <CAKohpok6vQtbHC0u+XCbPLyJf3w=v=LUNqZB2eJ5msy7=3zWgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:45921 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753045Ab3CaLey (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 31 Mar 2013 07:34:54 -0400
In-Reply-To: <CAKohpok6vQtbHC0u+XCbPLyJf3w=v=LUNqZB2eJ5msy7=3zWgA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, "arvind.chauhan" <arvind.chauhan@arm.com>, "robin.randhawa" <robin.randhawa@arm.com>, "steve.bannister" <Steve.Bannister@arm.com>, "liviu.dudau" <Liviu.Dudau@arm.com>, "charles.garcia-tobin" <charles.garcia-tobin@arm.com>, cpufreq <cpufreq@vger.kernel.org>, linux-pm <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linaro-kernel@lists.linaro.org, Arnd Bergmann <arnd.bergmann@linaro.org>, Russell King <linux@arm.linux.org.uk>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Sun, Mar 31, 2013 at 2:45 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 31 March 2013 10:54, Eric Miao <eric.y.miao@gmail.com> wrote:
>> On Sun, Mar 31, 2013 at 11:52 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>> Eric/Haojian,
>>>
>>> On 25 March 2013 15:41, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>>> This patch moves cpufreq driver of ARM based pxa3xx platform to drivers/cpufreq.
>>>>
>>>> Cc: Eric Miao <eric.y.miao@gmail.com>
>>
>> Acked-by: Eric Miao <eric.y.miao@gmail.com>
>>
>>>> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
>>>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>>>> ---
>>>>  arch/arm/mach-pxa/Makefile                                           | 1 -
>>>>  arch/arm/mach-pxa/include/mach/generic.h                             | 1 +
>>>>  drivers/cpufreq/Makefile                                             | 1 +
>>>>  .../mach-pxa/cpufreq-pxa3xx.c => drivers/cpufreq/pxa3xx-cpufreq.c    | 5 +----
>>>>  4 files changed, 3 insertions(+), 5 deletions(-)
>>>>  create mode 100644 arch/arm/mach-pxa/include/mach/generic.h
>>>>  rename arch/arm/mach-pxa/cpufreq-pxa3xx.c => drivers/cpufreq/pxa3xx-cpufreq.c (98%)
>>>
>>> Can i have your Ack or views about 6/9 and 7/9 Patch?
>
> Is this for both the patches??

Yes. Take the Ack for both, those two should really belong to drivers/cpufreq.
