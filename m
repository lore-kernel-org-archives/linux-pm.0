From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 19/21] cpuidle: create list of registered drivers
Date: Thu, 03 Oct 2013 12:47:52 +0200
Message-ID: <524D4B58.8070206@linaro.org>
References: <cover.1379779777.git.viresh.kumar@linaro.org>	<7e9565e323c1e065eeb2a2a1075967bd21ee6066.1379779777.git.viresh.kumar@linaro.org>	<5243641B.6050604@linaro.org>	<CAKohpo=3qFQ+gD+3u__NtZEL4xu51FBN+og+_UE7aTR26XvRng@mail.gmail.com>	<5243EE02.9020207@linaro.org>	<20130928213343.GA19582@linux.vnet.ibm.com>	<5249C4FB.1060705@linaro.org> <CAKohpomcnRrkKmBtrVDyCUx0E00roD2R=XMS3WH9QTpOF9AJjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ee0-f43.google.com ([74.125.83.43]:32890 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753552Ab3JCKry (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Oct 2013 06:47:54 -0400
Received: by mail-ee0-f43.google.com with SMTP id e52so995950eek.2
        for <linux-pm@vger.kernel.org>; Thu, 03 Oct 2013 03:47:53 -0700 (PDT)
In-Reply-To: <CAKohpomcnRrkKmBtrVDyCUx0E00roD2R=XMS3WH9QTpOF9AJjQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 10/03/2013 06:38 AM, Viresh Kumar wrote:
> On 1 October 2013 00:07, Daniel Lezcano <daniel.lezcano@linaro.org> w=
rote:
>> Interesting, thanks for the pointer.
>
> So, should I keep this patch with SRCU?

IMHO, we should, for now, keep the code as it is and then focus on the=20
lock/refcount for drivers in a separate series.


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

