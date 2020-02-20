Return-Path: <SRS0=6Td0=4I=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B40BC11D07
	for <linux-pm@archiver.kernel.org>; Thu, 20 Feb 2020 11:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED9AC207FD
	for <linux-pm@archiver.kernel.org>; Thu, 20 Feb 2020 11:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582197657;
	bh=Jp1RQZF8hLT8E2hu5n/YvUZMWBwsoJaU4Yvt5ycGIXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=urdwOzZiyPnANj2Wtek9hTPB0APfWFMB2tP4A9YdP5quxl2AMI23YyU+V5q7FsZOq
	 MKagA0H0So5+/VAsIlPCacveBn9TkH/G5GMPIFWVgMi+uEgRJNXbC6tauc+wRhDOsM
	 p6UWWgGUrjP9I5dvirVE60BgAI2yO6mkpVf8XTtg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgBTLUw (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 20 Feb 2020 06:20:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:51682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbgBTLUw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 20 Feb 2020 06:20:52 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C8BC207FD;
        Thu, 20 Feb 2020 11:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582197651;
        bh=Jp1RQZF8hLT8E2hu5n/YvUZMWBwsoJaU4Yvt5ycGIXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YK9w8LcKch7k67N+sqdukZGZ53h6U2iWnllYNMJO//z0BZlrjQOQOWgPMXN68ZR+e
         iOWn/S06KtjVb705/Br9Q9S02Y1dCyQE9OkP0569rLWnPhLo0A5Gv+63jLlviWNK2C
         CgPg1k4FzeFRFw7ottO7w0yu/yDPzIOC/d2pj8fo=
Date:   Thu, 20 Feb 2020 12:20:49 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/9] sysfs: add
 sysfs_file_change_owner{_by_name}()
Message-ID: <20200220112049.GF3374196@kroah.com>
References: <20200218162943.2488012-1-christian.brauner@ubuntu.com>
 <20200218162943.2488012-2-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218162943.2488012-2-christian.brauner@ubuntu.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Feb 18, 2020 at 05:29:35PM +0100, Christian Brauner wrote:
> +/**
> + *	sysfs_file_change_owner - change owner of a file.
> + *	@kobj:	object.
> + *	@kuid: new owner's kuid
> + *	@kgid: new owner's kgid
> + */
> +int sysfs_file_change_owner(struct kobject *kobj, kuid_t kuid, kgid_t kgid)
> +{
> +	struct kernfs_node *kn;
> +	int error;
> +
> +	if (!kobj->state_in_sysfs)
> +		return -EINVAL;
> +
> +	kernfs_get(kobj->sd);
> +
> +	kn = kobj->sd;
> +	error = internal_change_owner(kn, kobj, kuid, kgid);
> +
> +	kernfs_put(kn);
> +
> +	return error;
> +}
> +EXPORT_SYMBOL_GPL(sysfs_file_change_owner);

Oops, wait, what "file" are you changing here?  You aren't changing the
kobject's attributes, but rather a file in the kobject's directory,
right?  But kobj->sd is the directory of the kobject itself, so why
isn't this function just the same thing as sysfs_change_owner()?

Why would you call this function at all?

confused,

greg k-h
