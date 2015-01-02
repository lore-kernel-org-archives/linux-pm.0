From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] power: ab8500_fg.c:  Remove unused function
Date: Fri, 02 Jan 2015 10:32:32 +0100
Message-ID: <1460774.MbDnb649Ak@wuerfel>
References: <1420131892-31486-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:58270 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750723AbbABJcn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 Jan 2015 04:32:43 -0500
In-Reply-To: <1420131892-31486-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

On Thursday 01 January 2015 18:04:52 Rickard Strandqvist wrote:
> Remove the function ab8500_fg_reinit() that is not used anywhere.
> 
> This was partially found by using a static code analysis program called cppcheck.
> 
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>

Acked-by: Arnd Bergmann <arnd@arndb.de>
