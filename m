Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48ED0EB64DC
	for <linux-pm@archiver.kernel.org>; Tue, 11 Jul 2023 12:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjGKMIK (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 11 Jul 2023 08:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjGKMIK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jul 2023 08:08:10 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BD1E5C;
        Tue, 11 Jul 2023 05:08:09 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 31B7467373; Tue, 11 Jul 2023 14:08:06 +0200 (CEST)
Date:   Tue, 11 Jul 2023 14:08:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Azat Khuzhin <a3at.mail@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] Fix writing maj:min to /sys/power/resume (fixes
 hiberation with systemd)
Message-ID: <20230711120806.GA27809@lst.de>
References: <20230711114821.1273-1-a3at.mail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711114821.1273-1-a3at.mail@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 11, 2023 at 01:48:12PM +0200, Azat Khuzhin wrote:
> resume_store() first calls lookup_bdev() and after tries to handle
> maj:min, but it does not reset the error before, hence if you will write
> maj:min you will get ENOENT:
> 
>     # echo 259:2 >| /sys/power/resume
>     bash: echo: write error: No such file or directory
> 
> This also should fix hiberation via systemd, since it uses this way.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
