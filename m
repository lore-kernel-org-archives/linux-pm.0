From: Karol Wrona <k.wrona@samsung.com>
Subject: Re: [RFC PATCH 1/1] PM / domains: Add support for virtual power domains
Date: Mon, 02 Feb 2015 13:14:36 +0100
Message-ID: <54CF6A2C.5020808@samsung.com>
References: <1422555176-13054-1-git-send-email-k.wrona@samsung.com>
 <1422555176-13054-2-git-send-email-k.wrona@samsung.com>
 <CADGdYn5E9P7cT-bndL4u9g9XRO=BvE5hb1+TEF0mkwkWOmK1VA@mail.gmail.com>
 <20150130115708.GE8787@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50020 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754814AbbBBMOl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Feb 2015 07:14:41 -0500
In-reply-to: <20150130115708.GE8787@red-moon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, amit daniel kachhap <amit.daniel@samsung.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Karol Wrona <wrona.vy@gmail.com>

On 01/30/2015 12:57 PM, Lorenzo Pieralisi wrote:
> On Fri, Jan 30, 2015 at 08:43:22AM +0000, amit daniel kachhap wrote:
>> Hi Karol,
>>
>> I guess this patch series is not complete and use case implementation
>> will be more helpful for clarity. Also I can think of another way in
>> which this complete implementation can be done with pd name as
>> something "pd-virt". This pd can be handled differently inside the
>> platform specific exynos power off/on function.
> 
> Yes, it would be nice to provide an example to understand what this
> patchset has to achieve. Is this supposed to be a power domain
> used as a container to check for devices runtime state ie dependencies ?
> 
Yes, something like that.

In our case exynos do not enter LPD state with mmc host working and its is in
"top" pd which is not managed in conventional way. If we know runtime status of
the host we can decide what to do. Soon I will send full patchset.


I thought about it as exynos specific but I wonder if that would be needed not
only in exynos.

BR,
Karol


[...]
