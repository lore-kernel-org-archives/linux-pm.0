Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E8CC4332F
	for <linux-pm@archiver.kernel.org>; Thu, 13 Oct 2022 01:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiJMBtV (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 12 Oct 2022 21:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiJMBtU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Oct 2022 21:49:20 -0400
Received: from mail.nfschina.com (unknown [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 98AF9112ABF;
        Wed, 12 Oct 2022 18:49:19 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id BBDEF1E80D9B;
        Thu, 13 Oct 2022 09:49:23 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id G6W7QMe6cfWn; Thu, 13 Oct 2022 09:49:21 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id A267F1E80D99;
        Thu, 13 Oct 2022 09:49:20 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     skhan@linuxfoundation.org
Cc:     kunyu@nfschina.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, ray.huang@amd.com, shuah@kernel.org,
        trenn@suse.com
Subject: 
Date:   Thu, 13 Oct 2022 09:49:10 +0800
Message-Id: <20221013014911.2682-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <14d690a4-d2d5-01db-b2a2-e3c87b4a6394@linuxfoundation.org>
References: <14d690a4-d2d5-01db-b2a2-e3c87b4a6394@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


I'm glad to get your reply. In previous tests, it was found that variable initialization and assignment use mov related instructions. Therefore, when I analyze the code and find that removing some variable initialization and assignment does not affect the function and security, I will try to remove variable initialization.

Find the malloc function and find that its return value is void * type, so it does not need to cast.

thanks,
kunyu

