From: Jonghwan Choi <jhbird.choi@samsung.com>
Subject: RE: [PATCH 1/3] PM / OPP: Add support for descending order for cpufreq
 table
Date: Wed, 07 May 2014 08:43:29 +0900
Message-ID: <003e01cf6984$fb950280$f2bf0780$@samsung.com>
References: <000001cf643d$69e5e350$3db1a9f0$@samsung.com>
 <CAOh2x=m8DzmLOGqL0E_seOZMuzU=O9vQuu-JEp+E5454RmfEXw@mail.gmail.com>
 <003901cf6664$e4e8d2a0$aeba77e0$@samsung.com>
 <CAKohpon7W726Hxj5OJ6SnmPz3gYhAeBRr1wS3SCa3F2hSLriLQ@mail.gmail.com>
 <5367946F.1030407@ti.com>
 <CAKohpon-KZpSJK7PxpLjZS7sVPcYraDxb4oJHN6dxSagD+F--Q@mail.gmail.com>
 <CAGo_u6pUVeMM9mqe5htvM1X_4pkRGEUVOA2ty4ZPfUyLcLZkrw@mail.gmail.com>
 <CAKohpokfcptseU6ST+e_GfU6poVJxXCXMeoYCvT65060v5GJYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:50016 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbaEFXng convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 May 2014 19:43:36 -0400
In-reply-to: <CAKohpokfcptseU6ST+e_GfU6poVJxXCXMeoYCvT65060v5GJYQ@mail.gmail.com>
Content-language: ko
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Nishanth Menon' <nm@ti.com>
Cc: 'Linux PM list' <linux-pm@vger.kernel.org>, 'open list' <linux-kernel@vger.kernel.org>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Len Brown' <len.brown@intel.com>, 'Amit Daniel Kachhap' <amit.daniel@samsung.com>

Hi  

My holiday is finished.

I implemented another cpufreq driver. And that driver also have to use exynos_sort_descend_freq_table().
Then exynos5440 and new cpufreq have a duplicate function.(exynos_sort_descend_freq_table().
So I want to solve it.

Thanks.~

> -----Original Message-----
> From: Viresh Kumar [mailto:viresh.kumar@linaro.org]
> Sent: Monday, May 05, 2014 11:39 PM
> To: Nishanth Menon
> Cc: Jonghwan Choi; Linux PM list; open list; Rafael J. Wysocki; Len Brown;
> Amit Daniel Kachhap
> Subject: Re: [PATCH 1/3] PM / OPP: Add support for descending order for
> cpufreq table
> 
> On 5 May 2014 19:53, Nishanth Menon <nm@ti.com> wrote:
> > ceil and floor allows us to walk down the opp entries the direction we
> > want it to.
> > one can convert that data any way one wants it - especially when
> > custom mapping such as this is desired.
> 
> Yeah, but doing that for every frequency transition is not right.
> Otherwise they already have a solution, where they reverse order of
> frequencies for their driver. exynos_sort_descend_freq_table().
> 
> Probably that's a better solution then :)
> 
> But, Jonghwan was probably trying to get this solved in the framework only,
> in case anybody else needs it.
> 
> --
> viresh

