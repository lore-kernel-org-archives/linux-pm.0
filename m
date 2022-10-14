Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDF8C4332F
	for <linux-pm@archiver.kernel.org>; Fri, 14 Oct 2022 03:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiJNDuZ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 13 Oct 2022 23:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiJNDuW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Oct 2022 23:50:22 -0400
Received: from mail.nfschina.com (unknown [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F54D10055;
        Thu, 13 Oct 2022 20:50:18 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 9B99B1E80D90;
        Fri, 14 Oct 2022 11:50:12 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id a4pEWmYfR3Is; Fri, 14 Oct 2022 11:50:10 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 503A51E80D53;
        Fri, 14 Oct 2022 11:50:09 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     skhan@linuxfoundation.org
Cc:     kunyu@nfschina.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, ray.huang@amd.com, shuah@kernel.org,
        trenn@suse.com
Subject: Re: [PATCH] power: cpupower: utils: Optimize print_online_cpus and print_offline_cpus function
Date:   Fri, 14 Oct 2022 11:49:56 +0800
Message-Id: <20221014034957.297865-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <7e2043b9-c7fa-236e-de19-5e290deebbdf@linuxfoundation.org>
References: <7e2043b9-c7fa-236e-de19-5e290deebbdf@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


OK, I will make a new patch to determine the malloc memory allocation.

