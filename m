Return-Path: <SRS0=dKCo=WY=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0108C3A5A6
	for <linux-pm@archiver.kernel.org>; Wed, 28 Aug 2019 03:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB5621883
	for <linux-pm@archiver.kernel.org>; Wed, 28 Aug 2019 03:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566964729;
	bh=m6h+Bl3vJyFNkRo8EsoTNu6M/5eP2UUcfGWd/62JK+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QHUbIeLcvuZHYE7DCPhZ/cfzn7brdvcCL+XgOnLTzEshaWkB4KiwMbYYMgDHxYFE7
	 okT73wiDDzDP9U99+W3IL+lSqJvLA7bRxIM/5fwibSLii5ZLOurlfXB+H3yqaITL67
	 JC5IwCBbwpGzMBBpeQRHndms9AaOVlydNwYPd9JI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfH1D6s (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 27 Aug 2019 23:58:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:44958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbfH1D6s (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 27 Aug 2019 23:58:48 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 465DF20679;
        Wed, 28 Aug 2019 03:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566964727;
        bh=m6h+Bl3vJyFNkRo8EsoTNu6M/5eP2UUcfGWd/62JK+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xm798tLHE3siV/HWJ4c/1D1k7BxnGhZK0ArJZMeW+faT9KFLkOowMYobxb2HHlZmx
         oh5ScM5lh1pwFxK8GSY6KEz3CFPWiywAYvEGVnJoiNuTBZdhfam6eOXcvJOx9zABOs
         YRHMOnQ9tL1F2U7IWtZ+jMUYJg4QGGNOQhXM7plI=
Date:   Tue, 27 Aug 2019 23:58:46 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     thomas.lendacky@amd.com, akpm@linux-foundation.org,
        andrew.cooper3@citrix.com, bp@suse.de, corbet@lwn.net,
        hpa@zytor.com, jgross@suse.com, jpoimboe@redhat.com,
        keescook@chromium.org, linux-doc@vger.kernel.org,
        linux-pm@vger.kernel.org, mingo@redhat.com,
        natechancellor@gmail.com, pavel@ucw.cz, pbonzini@redhat.com,
        rjw@rjwysocki.net, stable@vger.kernel.org, tglx@linutronix.de,
        x86@kernel.org, yu.c.chen@intel.com
Subject: Re: FAILED: patch "[PATCH] x86/CPU/AMD: Clear RDRAND CPUID bit on
 AMD family 15h/16h" failed to apply to 4.9-stable tree
Message-ID: <20190828035846.GY5281@sasha-vm>
References: <1566809975147242@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1566809975147242@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 26, 2019 at 10:59:35AM +0200, gregkh@linuxfoundation.org wrote:
>The patch below does not apply to the 4.9-stable tree.
>If someone wants it applied there, or to any other stable or longterm
>tree, then please email the backport, including the original git commit
>id to <stable@vger.kernel.org>.

I've fixed it up and queued for 4.9 and 4.4.

--
Thanks,
Sasha
