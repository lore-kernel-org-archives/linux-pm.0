Return-Path: <SRS0=v2tG=XG=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F70C5ACAE
	for <linux-pm@archiver.kernel.org>; Wed, 11 Sep 2019 10:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07AA92084D
	for <linux-pm@archiver.kernel.org>; Wed, 11 Sep 2019 10:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568196711;
	bh=gZ6bs0LnQLjGM5VBVpFb9Y9GrE9uVAF7+RmNqjsXlYI=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=C6pTTnB6TDGvprVlCEVCo9II92/lwU0QWrP4fMDfVavmyIryUcj7Hbh8z68vGdn+R
	 CrB33EVmNNYZxMrvgc93BJZZEgBU5ml0hNHEZ55ore+kwL0gkK6SmDKG7AaEjN8hXj
	 +Fe3JtL9u+zt697jltjue3O70CBVgEiyWNSkpxqo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfIKKLu (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 11 Sep 2019 06:11:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:39514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbfIKKLu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Sep 2019 06:11:50 -0400
Received: from [192.168.7.66] (unknown [148.69.85.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95E27207FC;
        Wed, 11 Sep 2019 10:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568196709;
        bh=gZ6bs0LnQLjGM5VBVpFb9Y9GrE9uVAF7+RmNqjsXlYI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ffS1OydmfU0f9nYgyOKGyEy/cao5T2q2LocmnSscBCKO32tMbtkddqOeFt2bdx6iT
         1CfOMBz97zLKEGzAgD2pt+sZeyS1n6aG2XoK2GwwrOn+0vbzHEy8XQs//NN09oHRV6
         HmzBmjPN8Wrb9+kFAVVWV0mxBioNjn7BgmQgBYxI=
Subject: Re: [PATCH] cpupower : Handle set and info subcommands for powerpc
To:     Abhishek Goel <huntbag@linux.vnet.ibm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     trenn@suse.com, shuah <shuah@kernel.org>
References: <20190911095424.49605-1-huntbag@linux.vnet.ibm.com>
From:   shuah <shuah@kernel.org>
Message-ID: <3326dc53-f8a1-dd7b-5ae8-b86ef5ef8b24@kernel.org>
Date:   Wed, 11 Sep 2019 04:11:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190911095424.49605-1-huntbag@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/11/19 3:54 AM, Abhishek Goel wrote:
> Cpupower tool has set and info options which are not being used by
> POWER machines. For powerpc, we will return directly for these two
> subcommands. This removes the ambiguous error message while using set
> option in case of power systems.

What is the error message you see? Please include it in the commit log.

> 
> Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
> ---
>   tools/power/cpupower/utils/cpupower-info.c | 5 +++++
>   tools/power/cpupower/utils/cpupower-set.c  | 5 +++++
>   2 files changed, 10 insertions(+)
> 
> diff --git a/tools/power/cpupower/utils/cpupower-info.c b/tools/power/cpupower/utils/cpupower-info.c
> index 4c9d342b70ff..674b707a76af 100644
> --- a/tools/power/cpupower/utils/cpupower-info.c
> +++ b/tools/power/cpupower/utils/cpupower-info.c
> @@ -39,6 +39,11 @@ int cmd_info(int argc, char **argv)
>   	} params = {};
>   	int ret = 0;
>   
> +	#ifdef __powerpc__
> +	printf(_("Cannot read info as system does not support performance bias setting\n"));
> +	return 0;
> +	#endif
> +

I am not in favor of bailing out this early with this ifdef switch.
I would rather see this checked somehow(?) when the ambiguous error
happens.

>   	setlocale(LC_ALL, "");
>   	textdomain(PACKAGE);
>   
> diff --git a/tools/power/cpupower/utils/cpupower-set.c b/tools/power/cpupower/utils/cpupower-set.c
> index 3cd95c6cb974..c95b29278780 100644
> --- a/tools/power/cpupower/utils/cpupower-set.c
> +++ b/tools/power/cpupower/utils/cpupower-set.c
> @@ -41,6 +41,11 @@ int cmd_set(int argc, char **argv)
>   	int perf_bias = 0;
>   	int ret = 0;
>   
> +	#ifdef __powerpc__
> +	printf(_("System does not support performance bias setting\n"));
> +	return 0;
> +	#endif
> +

Same here.

>   	setlocale(LC_ALL, "");
>   	textdomain(PACKAGE);
>   
> 

thanks,
-- Shuah
