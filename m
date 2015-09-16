From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH 0/2] Update OF thermal properties for cooling-{min,max}-level
Date: Wed, 16 Sep 2015 09:58:46 +0100
Message-ID: <9hhtwquu4e1.fsf@e105922-lin.cambridge.arm.com>
References: <1441711013-11220-1-git-send-email-punit.agrawal@arm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:59090 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752076AbbIPI67 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2015 04:58:59 -0400
In-Reply-To: <1441711013-11220-1-git-send-email-punit.agrawal@arm.com> (Punit
	Agrawal's message of "Tue, 8 Sep 2015 12:16:51 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, rui.zhang@intel.com, mark.rutland@arm.com, robh+dt@kernel.org, ijc+devicetree@hellion.org.uk, galak@codeaurora.org

Punit Agrawal <punit.agrawal@arm.com> writes:

> Hi,
>
> The device tree properties regarding the specification and usage of
> states for cooling devices suffer from inconsistency in the bindings
> as well as the usage.
>
> The two patches here update the bindings to be consistent without
> breaking existing support for the device trees already in upstream.
>

Gentle reminder to request review of the below two patches!

> Thanks,
> Punit
>
> Punit Agrawal (2):
>   of: thermal: Fix inconsitency between cooling-*-state and
>     cooling-*-level
>   of: thermal: Mark cooling-*-level properties optional
>
>  .../devicetree/bindings/thermal/thermal.txt        | 27 +++++++++++-----------
>  1 file changed, 14 insertions(+), 13 deletions(-)
