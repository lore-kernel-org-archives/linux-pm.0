From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] cpufreq: mvebu: fix integer to pointer cast
Date: Thu, 09 Jun 2016 09:07:08 +0200
Message-ID: <32804824.nq0AOIbNnC@wuerfel>
References: <1465299013-32369-1-git-send-email-ben.dooks@codethink.co.uk> <5757CF9B.3080402@free.fr> <d3c117ea-2dce-63a2-7888-31ee8320a3dd@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:49808 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672AbcFIHGZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jun 2016 03:06:25 -0400
In-Reply-To: <d3c117ea-2dce-63a2-7888-31ee8320a3dd@codethink.co.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, Mason <slash.tmp@free.fr>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@lists.codethink.co.uk, linux-pm@vger.kernel.org

On Wednesday, June 8, 2016 9:59:26 AM CEST Ben Dooks wrote:
> On 08/06/16 08:56, Mason wrote:
> > On 07/06/2016 13:30, Ben Dooks wrote:
> > 
> >> Fix the use of 0 instead of NULL to clk_get() call. This stops the
> >> following warning:
> >>
> >> drivers/cpufreq/mvebu-cpufreq.c:73:40: warning: Using plain integer as NULL pointer
> > 
> > May I ask which compiler/version produced that diagnostic?
> 
> I was running with "make C=2 bzImage" for ARM multi_v7_config
> 
> $ sparse --version
> v0.5.0
> 

I believe gcc-6 will also produce a similar warning when building with
'make W=1'. I've started looking into moving some of the warnings from
W=1 level to default, which can probably be done with relatively little
effort for many warnings.

I see that you are making very good progress at eliminating the
-Wmissing-declarations warnings, which are also at W=1 level. Do
you have an estimate of how many there are? Do you plan to do them
all, or just the ones for some subsystems? I've stayed away from
this one for now since there are lots of such warnings, but it
seems particularly worthwhile.

	Arnd

