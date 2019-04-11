Return-Path: <SRS0=4kRr=SN=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853B1C282CE
	for <linux-pm@archiver.kernel.org>; Thu, 11 Apr 2019 16:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 556682173C
	for <linux-pm@archiver.kernel.org>; Thu, 11 Apr 2019 16:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="Ivy+8Uxi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfDKQui (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 11 Apr 2019 12:50:38 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42630 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbfDKQuh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Apr 2019 12:50:37 -0400
Received: by mail-lf1-f66.google.com with SMTP id w23so5228844lfc.9
        for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2019 09:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=JR9KyhPs1D7QvJbJSDRs3JR6Aqd2+G4KHFK580FsT8w=;
        b=Ivy+8UxigbSOkFRI6J2RhQLwN12FHBHo21KPFbyCSQd0PsEJ0ycW/a8iDOfR+e0Ol7
         2jvRnz104+c8l1lwJGBO87L/HlsSiBPha0JFdlHNpb9TwJq6x73nq42yM7WunPOR3XXB
         HHOLpFhfMIh5kjIY/vKST5bwaNPBUburehEG48CASlfE1ejMCzAmM6X2u/p4WqnCK7M2
         uQ6GjA6w0DOqiQRMcJODOT0Jln42SPvNvXtgBgZMBP8nQnf/2L+p03GDMsv5krjcoHGA
         1wvFyd/9jydAt/MZufbGPFV0cwe85ij9kLQZhL4SM3UspspIGYQcxIaTsPwqCkLVHiSb
         nczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=JR9KyhPs1D7QvJbJSDRs3JR6Aqd2+G4KHFK580FsT8w=;
        b=U1Sp7gz8A5VzclxmLvkQLXdGz5pl+fUmAokzFfIR0JS5YvLOqlifeC/V30L5N5rtfq
         i/mjUK3fN5MhNwEcp4msLFJj3irgFLdSwT2qjLBJEBsQDh+2CPHehusxsBRZTIVeHs6L
         7rzzsNpVtYMxfMnfuLTxRJEex3/EQcjwPn0p2vCKsV9zvqIJn0im8ujmj3DtyQ87FiBc
         etn8o29hwj8wBrFQzGhBJqNcrp62azmvohWa01cpul/5MQcFqj7CiOnUEbN1xFa/1Hxe
         9Q2BQJ4Ll9nX3LuyuszXc512hsUH375K8/6vjj8USuw84vvxuu/v1x3baGVVEuVcDurB
         FM8g==
X-Gm-Message-State: APjAAAWtXoi0JkE2nv90IYBHu/kqFYucjdzEEYZnxpHP7CyEu/1tGXx/
        Wwkc8XBH4tvQc+HADBc4L8QD5A==
X-Google-Smtp-Source: APXvYqzDc280qeY2HpB1Evx/JKXHPkAVYYQeaR0uhqrH7eEl0YgU/q6dUWQrMnNtMLk/PcC8fky8Xg==
X-Received: by 2002:ac2:4148:: with SMTP id c8mr27946483lfi.2.1555001435257;
        Thu, 11 Apr 2019 09:50:35 -0700 (PDT)
Received: from localhost (89-233-230-99.cust.bredband2.com. [89.233.230.99])
        by smtp.gmail.com with ESMTPSA id t21sm1576532lfk.5.2019.04.11.09.50.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 09:50:34 -0700 (PDT)
Date:   Thu, 11 Apr 2019 18:50:34 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Simon Horman <horms@verge.net.au>
Cc:     Yoshihiro Kaneko <ykaneko0929@gmail.com>, linux-pm@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH/RFT] thermal: rcar_gen3_thermal: Update calculation
 formula due to HW evaluation
Message-ID: <20190411165034.GF30887@bigcity.dyn.berto.se>
References: <1553201273-16757-1-git-send-email-ykaneko0929@gmail.com>
 <20190401133753.5luent76gyzygtcb@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190401133753.5luent76gyzygtcb@verge.net.au>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Kaneko-san,

Thanks for your work.

On 2019-04-01 15:37:57 +0200, Simon Horman wrote:
> On Fri, Mar 22, 2019 at 05:47:53AM +0900, Yoshihiro Kaneko wrote:
> > From: Dien Pham <dien.pham.ry@renesas.com>
> > 
> > 1/ As evaluation of hardware team, temperature calculation formula
> >  of M3-W is difference from all other SoCs as below:
> >  - M3-W: Tj_1: 116 (so Tj_1 - Tj_3 = 157)
> >  - Others: Tj_1: 126 (so Tj_1 - Tj_3 = 167)
> > 
> > 2/ Update the formula to calculate CTEMP:
> >   Currently, the CTEMP is average of val1 (is calculated by
> >   formula 1) and val2 (is calculated by formula 2). But,
> >   as description in HWM (chapter 10A.3.1.1 Setting of Normal Mode)
> > 
> >   If (STEMP < Tj_T) CTEMP value should be val1.
> >   If (STEMP > Tj_T) CTEMP value should be val2.
> > 
> > 3/ Update the formula to calculate temperature:
> >   Currently, current TEMP is calculated as
> >   average of val1 (is calculated by formula 1)
> >   and val2 (is calculated by formula 2). But,
> >   as description in HWM (chapter 10A.3.1.2 Normal Mode.)
> > 
> >   If (TEMP_CODE < THCODE2[11:0]) CTEMP value should be val1.
> >   If (TEMP_CODE > THCODE2[11:0]) CTEMP value should be val2.
> > 
> > Signed-off-by: Dien Pham <dien.pham.ry@renesas.com>
> > [ykaneko0929@gmail.com: use the data field of the of_device_id for Tj_1]
> > [ykaneko0929@gmail.com: revise a description of case 1 of the commit log]
> > Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> 
> I'm wondering if we could split this up into three patches,
> one for each problem it solves? Partly because I think it is good to fix
> one problem per patch. And partly because am having trouble
> verifying this patch - the new if statement in rcar_gen3_thermal_get_temp()
> seems to result in 0 temperature readings when the else case is used.

I think the changes in this patch are good and correct but I agree with 
Simon here, this patch should be split.

> 
> > ---
> >  drivers/thermal/rcar_gen3_thermal.c | 86 +++++++++++++++++++++++++------------
> >  1 file changed, 58 insertions(+), 28 deletions(-)
> > 
> > This patch is based on the master branch of Linus Torvalds's linux tree.
> > 
> > diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
> > index 88fa41c..de6f244 100644
> > --- a/drivers/thermal/rcar_gen3_thermal.c
> > +++ b/drivers/thermal/rcar_gen3_thermal.c
> > @@ -63,6 +63,15 @@
> >  
> >  #define TSC_MAX_NUM	3
> >  
> > +static int tj_2;
> 
> We need to avoid global variables. There can be multiple
> instances of this driver. (Although they will all get the same
> value for tj_2.
> 
> Perhaps it can be added to struct rcar_gen3_thermal_tsc?
> 
> ...

-- 
Regards,
Niklas Söderlund
