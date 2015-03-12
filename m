From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 05/22] PM / AVS: SmartReflex: %pF is only for function
 pointers
Date: Thu, 12 Mar 2015 13:14:38 -0500
Message-ID: <5501D78E.10102@ti.com>
References: <1426130037-17956-1-git-send-email-scottwood@freescale.com>	<1426130037-17956-5-git-send-email-scottwood@freescale.com> <7hy4n2w0ix.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57686 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751168AbbCLSOo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 12 Mar 2015 14:14:44 -0400
In-Reply-To: <7hy4n2w0ix.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>, Scott Wood <scottwood@freescale.com>
Cc: trivial@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On 03/12/2015 01:09 PM, Kevin Hilman wrote:
> Scott Wood <scottwood@freescale.com> writes:
> 
>> Use %pS for actual addresses, otherwise you'll get bad output
>> on arches like ppc64 where %pF expects a function descriptor.
>>
>> Signed-off-by: Scott Wood <scottwood@freescale.com>
>> Cc: linux-pm@vger.kernel.org
>> Cc: Kevin Hilman <khilman@kernel.org>
>> Cc: Nishanth Menon <nm@ti.com>
> 
> Acked-by: Kevin Hilman <khilman@linaro.org>
> 
Acked-by: Nishanth Menon <nm@ti.com>

I suppose this goes via Jiri Kosina's trivial tree?

-- 
Regards,
Nishanth Menon
