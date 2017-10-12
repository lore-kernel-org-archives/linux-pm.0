From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH] thermal: enable broadcom menu for arm64 bcm2835
Date: Thu, 12 Oct 2017 19:32:27 +0200 (CEST)
Message-ID: <565515667.189984.1507829547871@email.1und1.de>
References: <1506447464-3234-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:54882 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751067AbdJLRcg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Oct 2017 13:32:36 -0400
In-Reply-To: <1506447464-3234-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Allen Wild <allenwild93@gmail.com>

> Stefan Wahren <stefan.wahren@i2se.com> hat am 26. September 2017 um 19:37 geschrieben:
> 
> 
> From: Allen Wild <allenwild93@gmail.com>
> 
> Moving the bcm2835 thermal driver to the broadcom directory prevented it
> from getting enabled for arm64 builds, since the broadcom directory is only
> available when 32-bit specific ARCH_BCM is set.
> 
> Fix this by enabling the Broadcom menu for ARCH_BCM or ARCH_BCM2835.
> 
> Fixes: 6892cf07e733 ("thermal: bcm2835: move to the broadcom subdirectory")
> Signed-off-by: Allen Wild <allenwild93@gmail.com>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---

gentle ping to Eduardo ...
