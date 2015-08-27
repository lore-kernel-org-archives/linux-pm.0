From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [RFC PATCH] PM / Domains: Ensure subdomain is not in use before
 removing
Date: Thu, 27 Aug 2015 12:47:11 +0100
Message-ID: <55DEF8BF.6000503@nvidia.com>
References: <1440667276-8986-1-git-send-email-jonathanh@nvidia.com>
 <CAMuHMdUtnb1_e9v3U_iUT2qxTdacaVHY7tzbR_1kgykC+1MUyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11155 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751888AbbH0LrT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Aug 2015 07:47:19 -0400
In-Reply-To: <CAMuHMdUtnb1_e9v3U_iUT2qxTdacaVHY7tzbR_1kgykC+1MUyw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>

Hi Geert,

On 27/08/15 12:37, Geert Uytterhoeven wrote:
> Hi Jon,
> 
> On Thu, Aug 27, 2015 at 11:21 AM, Jon Hunter <jonathanh@nvidia.com> wrote:
>> The function pm_genpd_remove_subdomain() removes a subdomain from a
>> generic PM domain, however, it does not check if the subdomain has any
>> slave domains or device attached before doing so. Therefore, add a test
>> to verify that the subdomain does not have any slave domains associated
>> or any device attached before removing.
> 
> So far no-one ran into this, as there are no callers of
> pm_genpd_remove_subdomain() in mainline or -next.
> 
> Do you plan to add a caller?

Yes exactly. However, given that the API was present I thought why not
fix it now or at least get some feedback on this.

I have also noticed that there is no function to remove a pm-domain (ie.
reverse of pm_genpd_init()). I assume that currently people add
pm-domains and never remove them, which makes sense, however the
scenario I am trying to solve is allowing the registering of pm-domains
to be deferred if something is not yet present (ie. a regulator).

Cheers
Jon

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
