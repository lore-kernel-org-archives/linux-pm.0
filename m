Return-Path: <SRS0=sepJ=V5=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FED8C433FF
	for <linux-pm@archiver.kernel.org>; Thu,  1 Aug 2019 06:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E5DC214DA
	for <linux-pm@archiver.kernel.org>; Thu,  1 Aug 2019 06:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564640385;
	bh=yRIp6hN1XexHfmK2LSwOgSihVBEA/pyfHGohPSn8E5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BvgoaEkmo92NM5e5vUd4mnO7bJ0pfp5GyJbNs41YC+4tWLiZFO9HEjrnmkNeLf21S
	 GQ3ZVzQKmJK6TXH1lYRdeD6FvUxPgpP3UNtquDHlMtjVFLmvjHrwzfmLt66aS/UIt6
	 69y9EeiFo9sP4eNGez8qkRuILingifBr+aGtszGs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbfHAGTo (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 1 Aug 2019 02:19:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:58340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728884AbfHAGTo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 1 Aug 2019 02:19:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37B89206A3;
        Thu,  1 Aug 2019 06:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564640383;
        bh=yRIp6hN1XexHfmK2LSwOgSihVBEA/pyfHGohPSn8E5o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nkiUt0Z15vKj+VQFeQUC1YH2XEATo3cMiOXARIWCnR6nJfWWwqXRUkwGzb2uOr5M3
         dttsU/gnyYL3REwhrbQDaMty2GLlG0Tamc7x4QGJi7OWBgTvZXq16opkNIAPAcjSxN
         VJYYv/VHDpn2rYqxYFwyLXp8EwAOqRtoOuMwquyg=
Date:   Thu, 1 Aug 2019 08:19:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     rjw@rjwysocki.net, trong@google.com, trong@android.com,
        sspatil@google.com, hridya@google.com, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] PM/sleep: Expose suspend stats in sysfs
Message-ID: <20190801061941.GB4338@kroah.com>
References: <20190731050549.GA20809@kroah.com>
 <20190731212933.23673-1-kaleshsingh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731212933.23673-1-kaleshsingh@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 31, 2019 at 02:29:33PM -0700, Kalesh Singh wrote:
> Userspace can get suspend stats from the suspend stats debugfs node.
> Since debugfs doesn't have stable ABI, expose suspend stats in
> sysfs under /sys/power/suspend_stats.
> 
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---
> Changes in v2:
>   - Added separate show functions for last_failed_* stats, as per Greg
>   - Updated ABI Documentation

This is nice, I didn't even know some of these were in the debugfs
entries, so this should be more helpful to people.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
