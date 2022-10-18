Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF52C4332F
	for <linux-pm@archiver.kernel.org>; Tue, 18 Oct 2022 02:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbiJRCMS (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 17 Oct 2022 22:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbiJRCMB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Oct 2022 22:12:01 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6026010B7A
        for <linux-pm@vger.kernel.org>; Mon, 17 Oct 2022 19:11:45 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id a13so18566797edj.0
        for <linux-pm@vger.kernel.org>; Mon, 17 Oct 2022 19:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DR8hRkwA5AHSr93eWnm+mbNvWthEwcd3tUUpP30+XjU=;
        b=vPFiv2pSZYqXK7zlUUAUlTIy5gRtzCU6KQVTMIRYUEhR+Os1YRvZQTfLeRwsQS63xz
         mOOay++6Jx6LcU6OineY3OJi5WPeEbw/pGsTFyFE9ThEL1prf9zstgHJzE2yaK7Tsjta
         aFlzkm1midhSCm23mSAbLloSuqVrtIz2kItawHR1amF8T6YAXV25CriHhMD1ivhBJkOk
         s6nM9/64zGgd9n65ck7iK8DYx2RFFNU+ODv0yPGgAFcmjxo8jfzReMZriXgH1j0JwuMV
         e6qc3wBHWKiUDSLh340daMMTC3jXcSSsWDeihqn6+G4H9PWh1tess/x4MgHvQMsEiv65
         5kWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DR8hRkwA5AHSr93eWnm+mbNvWthEwcd3tUUpP30+XjU=;
        b=iB4wJho+bbtfboOi9mwzp2pRD3SB0lYcTcQ5pJDWMhZODi+AgxVfz4oHnpdeKjU89C
         jr7jz50QscLnm9AtKUoHENIi84+omRvtwr7Ju4/+ecm+x1KN+4hSs9h4CJYtmvstenlM
         7zz7DxHEAZFVWQ2qFoH0fcIiAmJDpM4LuOGwpgwNY/xPH851e6TbXIqhVF+64DeAg8Mm
         BwEVwmAckavlV+IycZZmvhNTu2dgqlV39E9i1RfdaBOhlPcR80gmbBQhlwccpm3+mOQZ
         JRKMIswvuCoZY5UqvPxWfRr2V52jRwcVKjK1OTKe5bqHTHNCn+BjVEsQuzvNx1cb6F3H
         cEFg==
X-Gm-Message-State: ACrzQf2WZ/3O8cr3r5YMWxdFcKQKQl2A4trcxrqxxjmv1orEm8xvQjrV
        VAfhxxLDtApqg81T8SLYyqzD5bIN2bND+EDhwnULCA==
X-Google-Smtp-Source: AMsMyM6nNjPP5x1mR6UreoCEUeDuD3+sm4OPQ+qse36C0LTDFSUCZ26xYBzGTwr0I1q+TwI92sXwAjKQVMNAzujYHPw=
X-Received: by 2002:a05:6402:354d:b0:45c:b772:5ef4 with SMTP id
 f13-20020a056402354d00b0045cb7725ef4mr522114edd.225.1666059093228; Mon, 17
 Oct 2022 19:11:33 -0700 (PDT)
MIME-Version: 1.0
References: <20221016095815.2550034-3-shawn.guo@linaro.org> <202210172205.YWukV2qP-lkp@intel.com>
In-Reply-To: <202210172205.YWukV2qP-lkp@intel.com>
From:   Shawn Guo <shawn.guo@linaro.org>
Date:   Tue, 18 Oct 2022 10:11:21 +0800
Message-ID: <CAAQ0ZWQ-KV81HdjODQu1kDrKhxyn-VU=US4aqYV-nxxSjVAmOA@mail.gmail.com>
Subject: Re: [PATCH 2/3] PM: domains: Consolidate genpd_restore_noirq() and genpd_resume_noirq()
To:     kernel test robot <lkp@intel.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>, kbuild-all@lists.01.org,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 17, 2022 at 10:50 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Shawn,
>
> I love your patch! Perhaps something to improve:
>
> [auto build test WARNING on rafael-pm/linux-next]
> [also build test WARNING on linus/master v6.1-rc1 next-20221017]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Shawn-Guo/Manage-domain-power-state-for-hibernate-freeze/20221017-114450
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
> patch link:    https://lore.kernel.org/r/20221016095815.2550034-3-shawn.guo%40linaro.org
> patch subject: [PATCH 2/3] PM: domains: Consolidate genpd_restore_noirq() and genpd_resume_noirq()
> config: xtensa-randconfig-r032-20221017
> compiler: xtensa-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/07af89f71f5cf3e02a29c7da292968404e8ae5be
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Shawn-Guo/Manage-domain-power-state-for-hibernate-freeze/20221017-114450
>         git checkout 07af89f71f5cf3e02a29c7da292968404e8ae5be
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash drivers/base/power/
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> drivers/base/power/domain.c:1258: warning: expecting prototype for genpd_resume_noirq(). Prototype was for genpd_finish_resume() instead

It will be fixed in the next version.

Shawn
