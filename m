Return-Path: <SRS0=e+u9=DB=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89236C4363D
	for <linux-pm@archiver.kernel.org>; Thu, 24 Sep 2020 13:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4988421D7F
	for <linux-pm@archiver.kernel.org>; Thu, 24 Sep 2020 13:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600954535;
	bh=jNYB+k706dvukRlfQCKIIeYhSWdl/6xpkY0GwY25mZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=D33S0avV9jyeOQJBon53cVrkJqT9PlRPfKog1QQMsNwduWHZ1XYJTnsVoQs1Od3sd
	 lOiqYQd/RPNb6rrLl8vn2OFtwANjsZY5tHJQcB0c0/UBW4GR9zTgdHFk+Att5+p3iR
	 tbsU30TyawYWvSFPStZ7/C/yZSSAugzfvcm8Z73U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgIXNfe (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 24 Sep 2020 09:35:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:54024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727742AbgIXNfd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 24 Sep 2020 09:35:33 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89ACC239CF;
        Thu, 24 Sep 2020 13:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600954533;
        bh=jNYB+k706dvukRlfQCKIIeYhSWdl/6xpkY0GwY25mZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YtsVSiNv8kv/pgfi/D1vADNUaNbpXNnTvbIHhUqxXYOkJi878WzcX2cV755gn+MjU
         +sYN9x8a8ZoIsJ1FaD5eA7rJjAwpkquFqEspHXhbm1GWMGU48E5BUOlYwhuZedK5US
         Gcp/PMzn6VJ7EV33ZdT2ZwfClGPl6T5czAyLLtaE=
Date:   Thu, 24 Sep 2020 15:35:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect changes for 5.10
Message-ID: <20200924133517.GA719043@kroah.com>
References: <20200924130242.24867-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924130242.24867-1-georgi.djakov@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 24, 2020 at 04:02:42PM +0300, Georgi Djakov wrote:
> Hello Greg,
> 
> This is the pull request with the interconnect changes for the 5.10-rc1
> merge window. It contains both core changes and new drivers. More details
> are available in the signed tag.
> 
> All patches have been in linux-next without any reported issues. Please
> pull into char-misc-next.
> 
> Thanks,
> Georgi
> 
> The following changes since commit 91e045b93db79a2ef66e045ad0d1f8f9d348e1f4:
> 
>   interconnect: qcom: Fix small BW votes being truncated to zero (2020-09-04 00:07:12 +0300)
> 
> are available in the Git repository at:
> 
>   https://git.linaro.org/people/georgi.djakov/linux.git tags/icc-5.10-rc1


Pulled and pushed out, thanks.

greg k-h
