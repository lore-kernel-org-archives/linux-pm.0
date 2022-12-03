Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B542EC4708D
	for <linux-pm@archiver.kernel.org>; Sat,  3 Dec 2022 13:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiLCNYj (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 3 Dec 2022 08:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiLCNYj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 3 Dec 2022 08:24:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C7131F9F;
        Sat,  3 Dec 2022 05:24:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2753D601D9;
        Sat,  3 Dec 2022 13:24:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335A5C433C1;
        Sat,  3 Dec 2022 13:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670073877;
        bh=ojR43rsS1kVOk3YKwtWt2Cp45BWXchvmMHKWe+SKOKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DceOYrNSzFIcnrJALcx2UQzq+02vGYRUcluzKhb4gCXPZLExIjL3s/TAFf9rtoLon
         I71OfyYJPpfLQvqkzTrOJlTntsSBjiRx1vSJrillCyro+ze3UJ1JKgmxCy3zdKQgFD
         ArAKZdrCi3YuFJ7Z95KY5cYNxO9ZPz8yX3hI2zcY=
Date:   Sat, 3 Dec 2022 14:24:33 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kant Fan <kant@allwinnertech.com>
Cc:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.4-] PM/devfreq: governor: Add a private governor_data
 for governor
Message-ID: <Y4tOEY4ga4OCWzbc@kroah.com>
References: <20221202023812.84174-1-kant@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202023812.84174-1-kant@allwinnertech.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Dec 02, 2022 at 10:38:12AM +0800, Kant Fan wrote:
> Commit fbd567e56942ecc4da906c4f3f3652c94773af5b upstream.

This is not a valid git commit in Linus's tree :(

