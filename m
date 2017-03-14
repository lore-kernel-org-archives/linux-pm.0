From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH 1/3] PM / Domains: Allow overriding the ->xlate() callback
Date: Tue, 14 Mar 2017 20:34:01 +0000
Message-ID: <20d4efbc-b3f1-4d64-0aae-ac51e171a09a@nvidia.com>
References: <20170314191516.13083-1-thierry.reding@gmail.com>
 <20170314191516.13083-2-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:18538 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751128AbdCNUeQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Mar 2017 16:34:16 -0400
In-Reply-To: <20170314191516.13083-2-thierry.reding@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Stefan Kristiansson <stefank@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org


On 14/03/17 19:15, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Allow generic power domain providers to override the ->xlate() callback
> in case the default genpd_xlate_onecell() translation callback is not
> good enough.
> 
> One potential use-case for this is to allow generic power domains to be
> specified by an ID rather than an index.

Are you sure this is necessary, because I recall that the genpd core
does allow for holes in the domain array (which is what we have). See
commit 609bed67bd8f ('PM / Domains: Allow holes in genpd_data.domains
array').

Cheers
Jon

-- 
nvpublic
