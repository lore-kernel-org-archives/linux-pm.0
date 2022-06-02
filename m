Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77E6C433EF
	for <linux-pm@archiver.kernel.org>; Thu,  2 Jun 2022 20:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239074AbiFBUDC (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 2 Jun 2022 16:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239094AbiFBUCm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jun 2022 16:02:42 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Jun 2022 13:02:31 PDT
Received: from smtp687out9.mel.oss-core.net (smtp687out9.mel.oss-core.net [210.50.216.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 60E6F1013
        for <linux-pm@vger.kernel.org>; Thu,  2 Jun 2022 13:02:30 -0700 (PDT)
X-IPAS-Result: =?us-ascii?q?A2AQcwDRFZli/7NplnpaGQEBAQEBAQ0eCwYBAQEBAQEBA?=
 =?us-ascii?q?QEBAQECAQEBAQEBAQEBAQEBCwkJgUYCgToCAQEBAaQ9hxkbgiWJYwsBAQEhM?=
 =?us-ascii?q?AQBAYR4AQFZBYRzJjcGDgECBAEBAQEDAgMBAQEBAQEDAQEGAQEBAQEBBgSBH?=
 =?us-ascii?q?IUvRoZUIAcBgVYBDgEehXUBAaxugTMNdIRZFIIQBAqCc4E7AgEBAQEBAYlBh?=
 =?us-ascii?q?V99gRCBWII4AYV9g0CCLgSSRoQjBBs7AyEVGDQSgSFFLAEIBgYHCgUyBgIMG?=
 =?us-ascii?q?BQEAhMSUx0CEgwKHA5UGQwPAxIDEQEHAgsSCBUsCAMCAwgDAgMuAgMYCQcKA?=
 =?us-ascii?q?x0ICgoSEhAUAgQGDR4LCAMZHy0JAgQOA0MICwoDEQQDExgLFggQBAYDCS8NK?=
 =?us-ascii?q?AsDFA8BBgMGAgUFAQMgAxQDBScHAyEHCyYNDQQjHQMDBSYDAgIbBwICAwIGF?=
 =?us-ascii?q?wYCAnEKKA0IBAgEDBAdJRMFAgcxBQQvAh4EBQYRCQIWAgYEBQIEBBYCAhIIA?=
 =?us-ascii?q?ggnGwcWNhkBBQ5PBgsJIRwJIBEFBhYDI3MFSA8pNTkGfA+uUpBAnjMKg04FK?=
 =?us-ascii?q?QeBCQeeSTGDYwGXEhEBJ4FXi1SWaKgSgRiBf3AVggiBHFAonRCBEAIGCwEBA?=
 =?us-ascii?q?wmPCgEB?=
IronPort-Data: A9a23:5pi5oKNep8l5bBTvrR0rlcFynXyQoLVcMsEvi/4bfWQNrUp3hWQHz
 GVMDGGDOPreMGv9fI91O4+0oUMP6sDTmoVlTXM5pCpnJ55ogZScWYjBRqvT04J+CuWZESqLO
 u1HMoGowPjZyhYwnz/1WlTbhSAUOZqgG/ytUYYoBggrHVU+EHl500o58wIEqtcAbeaRUlvlV
 eza+6UzCHf9s9KjGjtJg04rgEoHUMXa4Fv0jHRnDRx4lAO2e00uMX4qDfrZw00U7WVjNrXSq
 +7rlNlV945ClvsnIovNfr3TKiXmTlNOVOSDoiI+ZkSsvvRNjio4wIxjG6ogUkJGrguToYh22
 udsr4PlHG/FPoWU8AgceyZ5NWRcYoJo1JXuBiXmk6R/zWWfKSGqmqg2ShhuYMtBpbcf7WJmr
 JT0LBgMaB6Er+e/xr6qDOJrg6zPKeG7ZttC5C48lVk1C94pGcDkeb/v1+V5zQxhuINEXvnUP
 +YwPG8HgBPoJkcn1k0sIJY/mvq4w2H6WyNXpUjTpqct5WXXigtr39DQ3MH9I4bQAJwIxgPB/
 j+DpjuoRAoGPZqAwyCC+36mj+nD2yX2RMQbCdVU68JXvbFa/URLYDV+aLdxiaDRZpKWMz6HF
 3Epxw==
IronPort-HdrOrdr: A9a23:0JgpT6+r4d6jj5J4gUluk+C7I+orL9Y04lQ7vn2ZLiY7TiX4ra
 yTdZsgtCMc5Ax7ZJhfo7C90cC7KBvhHPhOj7X5Vo3JYOCJggaVEL0=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,272,1647262800"; 
   d="scan'208";a="82056740"
Received: from 122-150-105-179.sta.wbroadband.net.au (HELO WIN-J7GFDBAO51J) ([122.150.105.179])
  by smtp687.mel.oss-core.net with ESMTP; 03 Jun 2022 06:01:24 +1000
From:   "Martin Otamori" <info@mandy.com>
Subject: Acknowledge this message
To:     <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Reply-To: <okkmart68@gmail.com>
Date:   Thu, 2 Jun 2022 13:01:21 -0700
Message-Id: <202202061301207EDDC436AD-2DF4A6CFE6@mandy.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

I will give you more details as soon as you acknowledge this message.
Thank you.
Martin Otamori.

