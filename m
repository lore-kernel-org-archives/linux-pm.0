From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC PATCH 1/8] PM / Domains: Add new helper functions for device-tree
Date: Wed, 22 Jun 2016 17:08:44 +0200
Message-ID: <CAPDyKFqEis0OX68eFD0dbneYOngGQfvu4JYbWzm7tTbs8WPS5A@mail.gmail.com>
References: <1457090634-14785-1-git-send-email-jonathanh@nvidia.com>
 <1457090634-14785-2-git-send-email-jonathanh@nvidia.com> <576AA7B2.5030004@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36644 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759AbcFVPIq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jun 2016 11:08:46 -0400
Received: by mail-wm0-f54.google.com with SMTP id f126so91813742wma.1
        for <linux-pm@vger.kernel.org>; Wed, 22 Jun 2016 08:08:46 -0700 (PDT)
In-Reply-To: <576AA7B2.5030004@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Alexander Aring <alex.aring@gmail.com>, Eric Anholt <eric@anholt.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>

On 22 June 2016 at 16:58, Jon Hunter <jonathanh@nvidia.com> wrote:
> Hi Ulf,
>
> On 04/03/16 11:23, Jon Hunter wrote:
>> Ideally, if we are returning a reference to a PM domain via a call to
>> of_genpd_get_from_provider(), then we should keep track of such
>> references via a reference count. The reference count could then be used
>> to determine if a PM domain can be safely removed. Alternatively, it is
>> possible to avoid such external references by providing APIs to access
>> the PM domain and hence, eliminate any calls to
>> of_genpd_get_from_provider().
>>
>> Add new helper functions for adding a device and a subdomain to a PM
>> domain when using device-tree, so that external calls to
>> of_genpd_get_from_provider() can be removed.
>
> While we are at it, does it make sense to add helpers for
> of_genpd_remove_device/subdomain() as well? Seems that these could be
> useful for doing the inverse when cleaning up.

I would prefer if we could avoid adding new APIs until we really see
the need for it.

Moreover, I would like to avoid us adding OF specific APIs, unless
those can be really justified.
Hope that made sense.

Kind regards
Uffe
