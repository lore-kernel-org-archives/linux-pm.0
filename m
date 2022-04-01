Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20B5C433FE
	for <linux-pm@archiver.kernel.org>; Fri,  1 Apr 2022 14:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346662AbiDAOHl (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 1 Apr 2022 10:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346664AbiDAOHk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Apr 2022 10:07:40 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4934214FB2;
        Fri,  1 Apr 2022 07:05:50 -0700 (PDT)
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KVMNb2TzHz67m9N;
        Fri,  1 Apr 2022 22:04:15 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 1 Apr 2022 16:05:48 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 1 Apr 2022 15:05:47 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        <linux-iio@vger.kernel.org>
CC:     Paul Cercueil <paul@crapouillou.net>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH v2 0/3] IIO: Where dev_pm_ops rework and namespaces meet.
Date:   Fri, 1 Apr 2022 15:06:02 +0100
Message-ID: <20220401140605.31871-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

v2:
Just the first 3 patches so they can go via the PM tree.
Remainder of series will go via IIO in due course.

Hi All,

As these two activities have been ongoing across IIO at the same time
it was inevitable that there would be drivers were they both interact.
In particularly when we have EXPORT* of struct dev_pm_ops.

This series covers those cases by introducing (in patch 2)
EXPORT_NS[_GPL]_SIMPLE_DEV_PM_OPS() and
EXPORT_NS[_GPL]_RUNTIME_DEV_PM_OPS()
that add a namespace as the final parameter.

Thanks,

Jonathan

Jonathan Cameron (3):
  iio: chemical: scd30: Export dev_pm_ops instead of suspend() and
    resume()
  PM: core: Add NS varients of EXPORT[_GPL]_SIMPLE_DEV_PM_OPS and
    runtime pm equiv
  iio: chemical: scd30: Move symbol exports into IIO_SCD30 namespace

 drivers/iio/chemical/scd30.h        |  5 +----
 drivers/iio/chemical/scd30_core.c   | 10 +++++-----
 drivers/iio/chemical/scd30_i2c.c    |  3 ++-
 drivers/iio/chemical/scd30_serial.c |  3 ++-
 include/linux/pm.h                  | 14 +++++++++-----
 include/linux/pm_runtime.h          | 10 ++++++++--
 6 files changed, 27 insertions(+), 18 deletions(-)

-- 
2.32.0

