From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH] cpufreq: mvebu: fix integer to pointer cast
Date: Wed, 8 Jun 2016 09:59:26 +0100
Message-ID: <d3c117ea-2dce-63a2-7888-31ee8320a3dd@codethink.co.uk>
References: <1465299013-32369-1-git-send-email-ben.dooks@codethink.co.uk>
 <5757CF9B.3080402@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:59544 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932551AbcFHI7c (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jun 2016 04:59:32 -0400
In-Reply-To: <5757CF9B.3080402@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mason <slash.tmp@free.fr>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@lists.codethink.co.uk, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 08/06/16 08:56, Mason wrote:
> On 07/06/2016 13:30, Ben Dooks wrote:
> 
>> Fix the use of 0 instead of NULL to clk_get() call. This stops the
>> following warning:
>>
>> drivers/cpufreq/mvebu-cpufreq.c:73:40: warning: Using plain integer as NULL pointer
> 
> May I ask which compiler/version produced that diagnostic?

I was running with "make C=2 bzImage" for ARM multi_v7_config

$ sparse --version
v0.5.0


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
