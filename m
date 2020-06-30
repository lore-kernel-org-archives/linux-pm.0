Return-Path: <SRS0=ZeAD=AL=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D7EC433E1
	for <linux-pm@archiver.kernel.org>; Tue, 30 Jun 2020 22:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67C8220780
	for <linux-pm@archiver.kernel.org>; Tue, 30 Jun 2020 22:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgF3Wc6 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 30 Jun 2020 18:32:58 -0400
Received: from smtprelay0202.hostedemail.com ([216.40.44.202]:41432 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726065AbgF3Wc6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jun 2020 18:32:58 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 2A75F18029131;
        Tue, 30 Jun 2020 22:32:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: step63_201156426e7b
X-Filterd-Recvd-Size: 1899
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Tue, 30 Jun 2020 22:32:55 +0000 (UTC)
Message-ID: <e0bc6b4fa54612a09f1f05a779b8d506d9e0ac2f.camel@perches.com>
Subject: Re: [PATCH v14 2/4] dt-bindings: power: Convert battery.txt to
 battery.yaml
From:   Joe Perches <joe@perches.com>
To:     Ricardo Rivera-Matos <r-rivera-matos@ti.com>, sre@kernel.org,
        pali@kernel.org, robh@kernel.org
Cc:     afd@ti.com, dmurphy@ti.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        sspatil@android.com
Date:   Tue, 30 Jun 2020 15:32:53 -0700
In-Reply-To: <20200630215426.26450-3-r-rivera-matos@ti.com>
References: <20200630215426.26450-1-r-rivera-matos@ti.com>
         <20200630215426.26450-3-r-rivera-matos@ti.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2020-06-30 at 16:54 -0500, Ricardo Rivera-Matos wrote:
> bindings/power/supply/battery.txt

Do any of these also need updating?

Documentation/devicetree/bindings/power/supply/bq24190.txt:  See also Documentation/devicetree/bindings/power/supply/battery.txt
Documentation/devicetree/bindings/power/supply/bq27xxx.yaml:       See Documentation/devicetree/bindings/power/supply/battery.txt
Documentation/devicetree/bindings/power/supply/rohm,bd99954.yaml:#   See also Documentation/devicetree/bindings/power/supply/battery.txt
Documentation/devicetree/bindings/power/supply/sc2731_charger.txt:  See Documentation/devicetree/bindings/power/supply/battery.txt
Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt:  See Documentation/devicetree/bindings/power/supply/battery.txt
Documentation/power/power_supply_class.rst:Documentation/devicetree/bindings/power/supply/battery.txt. This is

