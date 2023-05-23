Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65015C7EE2D
	for <linux-pm@archiver.kernel.org>; Tue, 23 May 2023 16:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237038AbjEWQ6U (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 23 May 2023 12:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237694AbjEWQ6S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 May 2023 12:58:18 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1801A4
        for <linux-pm@vger.kernel.org>; Tue, 23 May 2023 09:57:27 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-3f4f47336bcso37131931cf.3
        for <linux-pm@vger.kernel.org>; Tue, 23 May 2023 09:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684861046; x=1687453046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6cIpc2hkpfcX9ytnNlNra4xHWCIbNM5n2UygyBIAgU8=;
        b=fr7VlOdxgP6744u9BZGqoXKC+UiTeM3z3BPB6vw5ZptQF3XLYH7wv9lYHVW1jwJ4oC
         RfjJZEUcc7JXm+pNxO8n9xoKFhGe1iEFYwG9leCaY4fKLPSxGkgBLqRXC4UYc7VfhWGf
         9H2AqLgYmbrZp2VbyQrAAqNId6WI4PI8J9IT+OQsIPecdSPERtdZR5XfnI2rl3aTAVSp
         a/1A/sGDrMtGDGiwUg3At1GJqz9NMUCRFLy0sEHZK6JoA8QziAu7EGF+juxwOZ7Ur8OS
         3ryRB0CB8ORgt0rPiJY74uudl39z2l3gy9pBonxPIJAbYG0Hjt7/4GL9ZZ2Emvy/wryD
         pU1Q==
X-Gm-Message-State: AC+VfDxdAKlSLFnC4xJiQ/FQ8L2HtUBY95MD3p9SJRi60nXwVXavZ9ju
        hJ66XkCHWv/+HwEvgacWZ4L6
X-Google-Smtp-Source: ACHHUZ6FTUIWRZ17w4sgstUiGYRBur4Ios77FwtNmNA/oETp74y448b9irsL1KV98Bhgct8ETOyo4g==
X-Received: by 2002:a05:622a:112:b0:3f5:3a79:f863 with SMTP id u18-20020a05622a011200b003f53a79f863mr23323837qtw.25.1684861046295;
        Tue, 23 May 2023 09:57:26 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id y14-20020a0ceace000000b0062120b054ebsm2930934qvp.19.2023.05.23.09.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 09:57:25 -0700 (PDT)
Date:   Tue, 23 May 2023 12:57:24 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Joern Engel <joern@lazybastard.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 18/24] dm: open code dm_get_dev_t in dm_init_init
Message-ID: <ZGzwdLQz5IJUURCH@redhat.com>
References: <20230523074535.249802-1-hch@lst.de>
 <20230523074535.249802-19-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523074535.249802-19-hch@lst.de>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, May 23 2023 at  3:45P -0400,
Christoph Hellwig <hch@lst.de> wrote:

> dm_init_init is called from early boot code, and thus lookup_bdev
> will never succeed.  Just open code that call to early_lookup_bdev
> instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>
