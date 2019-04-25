Return-Path: <SRS0=5pBW=S3=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D19EC43218
	for <linux-pm@archiver.kernel.org>; Thu, 25 Apr 2019 17:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 106D32084F
	for <linux-pm@archiver.kernel.org>; Thu, 25 Apr 2019 17:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556214040;
	bh=Gp9HFhIf0MFeF1myvT53+k97wqBOoD9MYhvMgtG0iQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Q+wNUM+917YJ9x6eJ0L8glqkhmL/8Y1TulbWtDBJ85y38vYIWEYiQWCk6FCmIv3Ui
	 Esfw93cA5un+G+KOtPVL8LjsqwHa0IVDynPSJHWmIve0WsBVDqgedO12vSx3xbLzzX
	 c6MG4kd0WjhIJk4c07NijN/1uNTIlJPAtBhUhR/8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbfDYRki (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 25 Apr 2019 13:40:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:52178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726916AbfDYRki (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 25 Apr 2019 13:40:38 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53F342084F;
        Thu, 25 Apr 2019 17:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556214038;
        bh=Gp9HFhIf0MFeF1myvT53+k97wqBOoD9MYhvMgtG0iQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jPq8D4FL1rtD5pn9xoNeC/Yso285LV4E0wVu7pwFNh3tc/NbKpJN2E9y691NRlIsU
         oswhI7GD0mBniRQqTji6W2Na8MfponjEucgVS6H4+gGSgpV1PyYQfoE/mPc4LSA3FQ
         BfPmrCmH0qbS9sIiLm26QpZz0wJeIND0xITNOH1I=
Date:   Thu, 25 Apr 2019 19:40:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] interconnect changes for v5.2-rc1
Message-ID: <20190425174035.GA8690@kroah.com>
References: <eafe23a5-e3cd-760d-f3f0-c82b50e78417@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <eafe23a5-e3cd-760d-f3f0-c82b50e78417@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190425174035.F7xGf4wamEeZzFU9Yjz8ENkGs293N50IyZ772IaPJ4c@z>

On Thu, Apr 25, 2019 at 02:25:55PM +0300, Georgi Djakov wrote:
> Hi Greg,
> 
> This is a tiny pull request with interconnect patches for the 5.2 merge window.
> The patches have spent a few weeks in linux-next without reported issues. The
> details are in the signed tag. Please consider pulling into char-misc-next.
> 
> Thanks,
> Georgi
> 
> The following changes since commit 79a3aaa7b82e3106be97842dedfd8429248896e6:
> 
>   Linux 5.1-rc3 (2019-03-31 14:39:29 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.linaro.org/people/georgi.djakov/linux.git tags/icc-5.2-rc1

Pulled and pushed out, thanks,

greg k-h
