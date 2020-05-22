Return-Path: <SRS0=ID/Q=7E=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5F3C433DF
	for <linux-pm@archiver.kernel.org>; Fri, 22 May 2020 07:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B27622072C
	for <linux-pm@archiver.kernel.org>; Fri, 22 May 2020 07:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590131760;
	bh=+cgU0wMXtjiiPiwmQF5MdeuXZDnY+h2nwu6P/YI6mO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=n1BPll/044G4ajWp743oz08Lo10GINFmc99JjHyzVlWlA5WCYwxRSF+L5e6nA8iAR
	 UPXEhirqDAbife5mEruouGWGNU4LudYmZbWfN74n+KV+6IFNNDrRELQpm54eWO3FCZ
	 BhWlcnbaUMFum9tDywx8fBtCjzjA75JDuV2++O8Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbgEVHQA (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 22 May 2020 03:16:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:40398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728315AbgEVHQA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 22 May 2020 03:16:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 490AC2072C;
        Fri, 22 May 2020 07:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590131759;
        bh=+cgU0wMXtjiiPiwmQF5MdeuXZDnY+h2nwu6P/YI6mO0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tmpl037AitqltwHJ0INKsejYVbFunwcUkRmyrkwI1nuTm0uQ8d8ZxLsVMenSfU36h
         v48G0OewHOFlzwq0VASfw4oRjexftZ0/qDiWag6MzKufN14wtrLbaBqAQdcoS8JXIG
         U+KrPePzduUlNpL1UNUlKb74QJTao5DfLma+bvaA=
Date:   Fri, 22 May 2020 09:15:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect changes for 5.8
Message-ID: <20200522071535.GA800007@kroah.com>
References: <20200521134304.31099-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521134304.31099-1-georgi.djakov@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 21, 2020 at 04:43:04PM +0300, Georgi Djakov wrote:
> Hello Greg,
> 
> This is the pull request with the interconnect changes for the 5.8-rc1
> merge window. It contains some core framework changes (helper functions,
> conversion of the framework from tristate to bool, etc). Some of these
> are in immutable branch, which is shared with the OPP tree. There are
> also new drivers for several i.MX8 platforms. More details are available
> in the signed tag.
> 
> Patches have been in linux-next without any reported issues. Please pull
> into char-misc-next.

Pulled and pushed out, thanks.

greg k-h
