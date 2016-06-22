From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [RFC PATCH 1/8] PM / Domains: Add new helper functions for
 device-tree
Date: Wed, 22 Jun 2016 16:22:51 +0100
Message-ID: <576AAD4B.2020905@nvidia.com>
References: <1457090634-14785-1-git-send-email-jonathanh@nvidia.com>
 <1457090634-14785-2-git-send-email-jonathanh@nvidia.com>
 <576AA7B2.5030004@nvidia.com>
 <CAPDyKFqEis0OX68eFD0dbneYOngGQfvu4JYbWzm7tTbs8WPS5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:10589 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146AbcFVPXE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jun 2016 11:23:04 -0400
In-Reply-To: <CAPDyKFqEis0OX68eFD0dbneYOngGQfvu4JYbWzm7tTbs8WPS5A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Alexander Aring <alex.aring@gmail.com>, Eric Anholt <eric@anholt.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>


On 22/06/16 16:08, Ulf Hansson wrote:
> On 22 June 2016 at 16:58, Jon Hunter <jonathanh@nvidia.com> wrote:
>> Hi Ulf,
>>
>> On 04/03/16 11:23, Jon Hunter wrote:
>>> Ideally, if we are returning a reference to a PM domain via a call to
>>> of_genpd_get_from_provider(), then we should keep track of such
>>> references via a reference count. The reference count could then be used
>>> to determine if a PM domain can be safely removed. Alternatively, it is
>>> possible to avoid such external references by providing APIs to access
>>> the PM domain and hence, eliminate any calls to
>>> of_genpd_get_from_provider().
>>>
>>> Add new helper functions for adding a device and a subdomain to a PM
>>> domain when using device-tree, so that external calls to
>>> of_genpd_get_from_provider() can be removed.
>>
>> While we are at it, does it make sense to add helpers for
>> of_genpd_remove_device/subdomain() as well? Seems that these could be
>> useful for doing the inverse when cleaning up.
> 
> I would prefer if we could avoid adding new APIs until we really see
> the need for it.
> 
> Moreover, I would like to avoid us adding OF specific APIs, unless
> those can be really justified.
> Hope that made sense.

Yes makes sense. However, after this series, the
pm_genpd_remove_device/subdomain really become provider only APIs
because clients can no longer get access to the genpd struct. Although
today none of the users of the new of_genpd_add_device/subdomain do any
clean-up on failure, it is possible that someone may. Therefore, I was
thinking that we should have a way for a client to remove a subdomain or
device it has added.

Does that make sense? I guess we could always add those as needed.

I am looking at a use-case for usb where we are populating the
pm-domains at runtime and we may need to clean-up on failure. However, I
can always wait to add more APIs until we really need them.

Let me know what you think about my response to patch 6/8.

Cheers
Jon

-- 
nvpublic
