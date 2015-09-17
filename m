From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 0/2] Update OF thermal properties for
 cooling-{min,max}-level
Date: Thu, 17 Sep 2015 14:39:59 -0500
Message-ID: <55FB170F.4020807@kernel.org>
References: <1441711013-11220-1-git-send-email-punit.agrawal@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:34548 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbbIQTkB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Sep 2015 15:40:01 -0400
In-Reply-To: <1441711013-11220-1-git-send-email-punit.agrawal@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: edubezval@gmail.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, rui.zhang@intel.com, mark.rutland@arm.com, robh+dt@kernel.org, ijc+devicetree@hellion.org.uk, galak@codeaurora.org

On 09/08/2015 06:16 AM, Punit Agrawal wrote:
> Hi,
> 
> The device tree properties regarding the specification and usage of
> states for cooling devices suffer from inconsistency in the bindings
> as well as the usage.
> 
> The two patches here update the bindings to be consistent without
> breaking existing support for the device trees already in upstream.
> 
> Thanks,
> Punit
> 
> Punit Agrawal (2):
>   of: thermal: Fix inconsitency between cooling-*-state and
>     cooling-*-level
>   of: thermal: Mark cooling-*-level properties optional

Applied, thanks.

Rob

> 
>  .../devicetree/bindings/thermal/thermal.txt        | 27 +++++++++++-----------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 

