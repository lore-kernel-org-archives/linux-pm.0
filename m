Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C94C6FD1D
	for <linux-pm@archiver.kernel.org>; Mon, 27 Mar 2023 17:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjC0R2x (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 27 Mar 2023 13:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjC0R2w (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Mar 2023 13:28:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 897372132;
        Mon, 27 Mar 2023 10:28:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76D73C14;
        Mon, 27 Mar 2023 10:29:35 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6455C3F6C4;
        Mon, 27 Mar 2023 10:28:49 -0700 (PDT)
Date:   Mon, 27 Mar 2023 18:28:47 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, sudeep.holla@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@huawei.com,
        f.fainelli@gmail.com, vincent.guittot@linaro.org,
        tarek.el-sherbiny@arm.com, nicola.mazzucato@arm.com,
        souvik.chakravarty@arm.com, wleavitt@marvell.com,
        wbartczak@marvell.com
Subject: Re: [PATCH v2 1/3] firmware: arm_scmi: Refactor powercap get/set
 helpers
Message-ID: <ZCHOyqZ2tqOkogp6@e120937-lin>
References: <20230309140724.2152712-1-cristian.marussi@arm.com>
 <20230309140724.2152712-2-cristian.marussi@arm.com>
 <CAJZ5v0ixFvJ6akSMZmcUsg1n_kufq_WonWhS+ef=ps1FXKqUGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0ixFvJ6akSMZmcUsg1n_kufq_WonWhS+ef=ps1FXKqUGQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 27, 2023 at 07:06:36PM +0200, Rafael J. Wysocki wrote:
> On Thu, Mar 9, 2023 at 3:09 PM Cristian Marussi
> <cristian.marussi@arm.com> wrote:
> >
> > Refactor SCMI powercap internal get/set helpers.
> >
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> 

Hi Rafael,

Thanks for having a look.

> I can apply this series if I get an ACK or preferably Reviewed-by:
> from an SCMI person.
> 

I'll see if I can chase someone for this cycle :D

> However, I think that it would be more appropriate to route it through
> ARM/ARM64 anyway.
> 

Yes, indeed it is what usually happens I think, but I thought
appropriate to Cc you being power related.

Thanks,
Cristian

