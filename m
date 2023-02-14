Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EE1C636CC
	for <linux-pm@archiver.kernel.org>; Tue, 14 Feb 2023 02:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjBNCQP (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 13 Feb 2023 21:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjBNCQL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Feb 2023 21:16:11 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4826E8A5F;
        Mon, 13 Feb 2023 18:16:10 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id z14-20020a17090abd8e00b00233bb9d6bdcso8907786pjr.4;
        Mon, 13 Feb 2023 18:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j0usO4jGkLQMVlzI7ZmYdbZ3TD6rNBgw6pqhHvh0Qr4=;
        b=OJoKSazIkUq4KN5GglUDQAbyKwGQlwiZBwiDverChDRsOMbR+YODRjEGi7IiHLUw96
         +zoUsJdKUo2ujThzYrYxOGpa7155m8XVXafKUSS3ZNVZ5KfOLcHHPBOXUaJ4O6HRz6SQ
         uQqcDwnDR1rMBRGnNhVKjmFZ7ErKudSvnuq7WnDZ5KPvJ4i5eoacpxXGI5KgQqSRydVA
         n9Cs64sViwuF/+a7acC3YDz9EuUgop3HWrcOatY28cYqNDT5eRuMxyp8Wk6LH/7ySfZf
         vAusdhXHui+JwENMRgaL0lMhZrZeeqCdSdguXPXSJnsS6QXcYoiw/6AFKSqEgJKZGkx3
         uVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j0usO4jGkLQMVlzI7ZmYdbZ3TD6rNBgw6pqhHvh0Qr4=;
        b=GoXZ/AdH+H35GlvhnguLWm14plB/mdPtONP8YQbzv4SC7QeAW39iwecfyxNaBdVy4C
         7OD66oUjmItPrEZ5aGfh6MYwE4vpGDucVSSVutOT+X7B98KMYllsjPMHhnWDgsevBews
         jlUoEFuoMQx8OTwSVGfbIUuOH/byCjhh9/WuFrJh4Osx0jRrvIvzKfgk+OAIK9VbgcU6
         lrFPZS5SlKkPHxuxThbRMsDwOcS1fEV8IGIPmC6+8Waht4PpkDsv5JDeANKoflavZEat
         tQ9MtSKB6549CgiRcXwu3CvzU/zS2FJKQtGyVrUN81RBYuk4912wvqX6+Uf6rrGhhjr+
         NATQ==
X-Gm-Message-State: AO0yUKUWGGoMEO/cp3zcEbqgbiU/nLdvp3gHtQmg1dqroQ6grchdFHFM
        3kMw6I8VKXlx4Dgv97MQUQU=
X-Google-Smtp-Source: AK7set/+u844rqTiRxHEMU+dAbarueYq4Py77iyNVGWt2KnQ5YNZHIRIOkUefCUn5atgHdRvvMeQhQ==
X-Received: by 2002:a17:90a:b304:b0:234:2807:55e3 with SMTP id d4-20020a17090ab30400b00234280755e3mr1107387pjr.7.1676340969726;
        Mon, 13 Feb 2023 18:16:09 -0800 (PST)
Received: from [192.168.43.80] (subs28-116-206-12-37.three.co.id. [116.206.12.37])
        by smtp.gmail.com with ESMTPSA id p10-20020a637f4a000000b004f22f5297bcsm7716739pgn.67.2023.02.13.18.16.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 18:16:09 -0800 (PST)
Message-ID: <848a6a77-9cc8-3cf7-98a6-8ca0bb0f329e@gmail.com>
Date:   Tue, 14 Feb 2023 09:16:02 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 1/3] Documentation: admin-guide: Add toctree entry for
 thermal docs
Content-Language: en-US
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Power Management <linux-pm@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        oe-kbuild-all@lists.linux.dev, kernel test robot <lkp@intel.com>
References: <20230213100800.28333-1-bagasdotme@gmail.com>
 <20230213100800.28333-2-bagasdotme@gmail.com>
 <6cc45a32e92e6a261b7d497eb48ac59472c35508.camel@linux.intel.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <6cc45a32e92e6a261b7d497eb48ac59472c35508.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2/13/23 17:15, srinivas pandruvada wrote:
> Hi Sanjaya,
> 
> On Mon, 2023-02-13 at 17:07 +0700, Bagas Sanjaya wrote:
>> kernel test robot reported htmldocs warnings:
>>
>> Documentation/admin-guide/index.rst:62: WARNING: toctree contains
>> reference to nonexisting document 'admin-guide/thermal'
>> Documentation/admin-guide/thermal/intel_powerclamp.rst: WARNING:
>> document isn't included in any toctree
>>
>> Add toctree entry for thermal/ docs to fix these warnings.
>>
> I submitted a patch 
> 	[thermal-bleeding-edge][PATCH] thermal: intel: powerclamp: Fix
> warnings
> 
> Thanks,
> Srinivas
> 

OK, thanks!

-- 
An old man doll... just what I always wanted! - Clara

