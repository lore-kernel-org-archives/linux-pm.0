From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH 1/3] PM / Domains: Allow overriding the ->xlate() callback
Date: Wed, 15 Mar 2017 13:43:57 +0000
Message-ID: <8e4623c4-fd51-eadc-661b-5d2a88f3a8ef@nvidia.com>
References: <20170314191516.13083-1-thierry.reding@gmail.com>
 <20170314191516.13083-2-thierry.reding@gmail.com>
 <20d4efbc-b3f1-4d64-0aae-ac51e171a09a@nvidia.com>
 <20170315133652.GA29259@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:5079 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751920AbdCONoE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Mar 2017 09:44:04 -0400
In-Reply-To: <20170315133652.GA29259@ulmo.ba.sec>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Stefan Kristiansson <stefank@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org


On 15/03/17 13:36, Thierry Reding wrote:
> * PGP Signed by an unknown key
> 
> On Tue, Mar 14, 2017 at 08:34:01PM +0000, Jon Hunter wrote:
>>
>> On 14/03/17 19:15, Thierry Reding wrote:
>>> From: Thierry Reding <treding@nvidia.com>
>>>
>>> Allow generic power domain providers to override the ->xlate() callback
>>> in case the default genpd_xlate_onecell() translation callback is not
>>> good enough.
>>>
>>> One potential use-case for this is to allow generic power domains to be
>>> specified by an ID rather than an index.
>>
>> Are you sure this is necessary, because I recall that the genpd core
>> does allow for holes in the domain array (which is what we have). See
>> commit 609bed67bd8f ('PM / Domains: Allow holes in genpd_data.domains
>> array').
> 
> I suppose we could use that, but it feels like the wrong solution to me.
> Why would we want to deal with holes in the array when we can simply do
> all the required work at probe time and add only the existing domains in
> any particular SoC.
> 
> For example on Tegra186 we've got a maximum ID of 43, so we'd need to
> allocate 44 pointers, but we only use 17 of those IDs. People usually
> reply to that that newer SoCs come with enough memory to make this
> waste irrelevant. I don't buy that. Why should we waste memory if it
> can be easily avoided?

I was wondering how many holes we have. That seems a bit excessive and
so I would agree it is a waste.

Cheers
Jon

-- 
nvpublic
