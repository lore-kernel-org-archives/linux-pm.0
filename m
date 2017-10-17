From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] thermal: enable broadcom menu for arm64 bcm2835
Date: Mon, 16 Oct 2017 17:27:44 -0700
Message-ID: <20171017002743.GA17189@localhost.localdomain>
References: <1506447464-3234-1-git-send-email-stefan.wahren@i2se.com>
 <565515667.189984.1507829547871@email.1und1.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:45204 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753672AbdJQA1s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Oct 2017 20:27:48 -0400
Content-Disposition: inline
In-Reply-To: <565515667.189984.1507829547871@email.1und1.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Allen Wild <allenwild93@gmail.com>

On Thu, Oct 12, 2017 at 07:32:27PM +0200, Stefan Wahren wrote:
> > Stefan Wahren <stefan.wahren@i2se.com> hat am 26. September 2017 um 19:37 geschrieben:
> > 
> > 
> > From: Allen Wild <allenwild93@gmail.com>
> > 
> > Moving the bcm2835 thermal driver to the broadcom directory prevented it
> > from getting enabled for arm64 builds, since the broadcom directory is only
> > available when 32-bit specific ARCH_BCM is set.
> > 
> > Fix this by enabling the Broadcom menu for ARCH_BCM or ARCH_BCM2835.
> > 
> > Fixes: 6892cf07e733 ("thermal: bcm2835: move to the broadcom subdirectory")
> > Signed-off-by: Allen Wild <allenwild93@gmail.com>
> > Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> > ---
> 
> gentle ping to Eduardo ...

Collecting this
