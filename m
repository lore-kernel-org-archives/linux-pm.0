Return-Path: <SRS0=6Td0=4I=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7332FC11D05
	for <linux-pm@archiver.kernel.org>; Thu, 20 Feb 2020 10:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D8B2467B
	for <linux-pm@archiver.kernel.org>; Thu, 20 Feb 2020 10:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582196160;
	bh=qPsr2SWZlj8NnVvJey7tGh27YrIHO/JutMrOFdqCmio=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yIQGHuHp4L3AMuz+iLBje0K7FUDsJZ7Xsqb/UQfEVwB9FSd5O+hpkR4pVDpXFByJ0
	 U/AuIkD8LSBvpQlmy1HvLzDhEspJrR04CXnXK5beUKDa6Hb0bEg9P7EjsIq4i4vXU9
	 deUbpnyC+u0IsJjzE6eRY411PbF1q9zWbo6gbObA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgBTKz7 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 20 Feb 2020 05:55:59 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33067 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgBTKz7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 05:55:59 -0500
Received: by mail-oi1-f195.google.com with SMTP id q81so27148091oig.0;
        Thu, 20 Feb 2020 02:55:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G99URgKphVxwp7Ra7ZFOznbKMKp/kFSH0MuSo7Gxdb0=;
        b=pfURzScUjgFxsmBdLH2h5Beg1Pds63EoEPRYgyy5qeRqH/9iJIsUEZV+HsGR5L96a5
         HQYYXSbUEzXvelDMoflVdRlwjo8j1ezjF/F3r7SFfastvplkZMKUc0Dq9X/60FpHBh8K
         EaByq4+ZhU8aI+26a4Zkl5upT/D3IDX+aoLu1J6BwywTFZX2obOzqTac/cgPRmlPp9H7
         a5wLv9E9M/NSr5huXacdFyRyJvqcQd3OtZfPk6cMUSeLmTSZN9ABW7QMQltvvB5hb5Ov
         BNfRTfhmnSAWklKGxgGitNJ2YJGxsYwx+/wTTmWeR3AP+xye69tIBop9v6dNPue/Pu1B
         NaXQ==
X-Gm-Message-State: APjAAAV2fRN1BhX6nlNjOveXSRnMJGKH8ax+K4JCpk4NvbfggGuHU8Yh
        Sojpf4TvZBjanheuZE+jrLj0bQyQNlGNa7ho6Fg=
X-Google-Smtp-Source: APXvYqwLmmbws9uz7Vla3YX3g5Wu8BZk334H6JmjpzH7fRjakCQh96hafjJ6EVIcNOYq5mnIwGSPliJ8FdSR6qDlIAE=
X-Received: by 2002:a54:488d:: with SMTP id r13mr1438289oic.115.1582196158627;
 Thu, 20 Feb 2020 02:55:58 -0800 (PST)
MIME-Version: 1.0
References: <561e2780-111a-1939-43fb-ae32d7abce8d@infradead.org>
In-Reply-To: <561e2780-111a-1939-43fb-ae32d7abce8d@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 20 Feb 2020 11:55:47 +0100
Message-ID: <CAJZ5v0ijpwHCysTHmG6t3y1XZY3DS0ySYNXa+2c+0Jczg85=GA@mail.gmail.com>
Subject: Re: [PATCH -next] Documentation/power: fix pm_qos_interface.rst
 format warning
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Feb 17, 2020 at 5:54 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix Sphinx warnings by indenting the bullet list (and making it
> unnumbered).
>
> Documentation/power/pm_qos_interface.rst:12: WARNING: Unexpected indentation.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: linux-pm@vger.kernel.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/power/pm_qos_interface.rst |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> --- linux-next-20200217.orig/Documentation/power/pm_qos_interface.rst
> +++ linux-next-20200217/Documentation/power/pm_qos_interface.rst
> @@ -7,8 +7,8 @@ performance expectations by drivers, sub
>  one of the parameters.
>
>  Two different PM QoS frameworks are available:
> -1. CPU latency QoS.
> -2. The per-device PM QoS framework provides the API to manage the
> + * CPU latency QoS.
> + * The per-device PM QoS framework provides the API to manage the
>     per-device latency constraints and PM QoS flags.
>
>  The latency unit used in the PM QoS framework is the microsecond (usec).

Applied, thanks!
