Return-Path: <SRS0=ntgF=WI=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718A2C31E40
	for <linux-pm@archiver.kernel.org>; Mon, 12 Aug 2019 09:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4109F2070C
	for <linux-pm@archiver.kernel.org>; Mon, 12 Aug 2019 09:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565600525;
	bh=Uq/hajB4eQIELn5ASQwGOM5FMrVke/6+MK7OrEsddjM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mBAu9YF6BCzmV0W9Xrpehp9m0sQB0J3DBe7PbdinobOxPgA7v45yn0q0RRU+bldk5
	 dn9068aCEb3tVsi1vicrU/35Re2cXtgt7PYfmVNrI6JP5J0z+33QwKxfVGbEm3KGZd
	 wpz8d9xfER3sZWjUjJJ6bg0XSfpJg00Ey8oXJRwg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbfHLJCE (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 12 Aug 2019 05:02:04 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35976 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbfHLJCE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Aug 2019 05:02:04 -0400
Received: by mail-ot1-f65.google.com with SMTP id k18so24048338otr.3
        for <linux-pm@vger.kernel.org>; Mon, 12 Aug 2019 02:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uq/hajB4eQIELn5ASQwGOM5FMrVke/6+MK7OrEsddjM=;
        b=NSO8CvnNJ1SnStzsQ/ORewyW2qBD9li5m2Mae6pSLq5Z51Zcwi3PTiWzlhK+IWMiIx
         A5XUg4uXBfcDzK1MRFSexG3yoTcrVMrrP6iH00tW2/MBP8NpQ5BxkXudeX5YfCr+MNvq
         uq9Dz0AuvmiT8nHJ63AvQT2AdbT47cGxNvC98q/e2qclSV4LFlK2cHIj17UwXCdKv/bz
         Ryh/uzbSlQPuGRJijyCTRuhGX6D1OVlZRkMZJJZb+w2NIq/CQJH2RUZiOqhUuH/W8eBB
         JC1ZIahQz3QXzgu6KHNm9BkisaqJeszYpOum1lE3gUxnqyejk5Uy465sJuxUz3aJLgGh
         8NBg==
X-Gm-Message-State: APjAAAXWZJ7SRWwYLT7/ed5r+slGD8BFyz8LfsAjhpkUIjh0v2/xIWau
        rZ8+nVLD0gWR0NnWUFsMvZwkzWOZ9iwupyYGleqQVg==
X-Google-Smtp-Source: APXvYqx+9kC0S+v2Se/yTF9/9O+hk0CsldsOprqZfxFUEUCLOp2k2tWhJwbaL96kucUWN2CRl4GJ4RRN2etmDsP0z10=
X-Received: by 2002:a9d:6b96:: with SMTP id b22mr30325356otq.262.1565600523933;
 Mon, 12 Aug 2019 02:02:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190802173424.5844-1-daniel.lezcano@linaro.org> <4512ae04-e9a5-f0aa-2e6f-bf7a17b069e4@linaro.org>
In-Reply-To: <4512ae04-e9a5-f0aa-2e6f-bf7a17b069e4@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 12 Aug 2019 11:01:49 +0200
Message-ID: <CAJZ5v0jDTBkRab8+XmOokkpDiPtn7NoR1VhgZJLiWDQCO=00bg@mail.gmail.com>
Subject: Re: [PATCH 1/2] cpuidle: play_idle: Increase the resolution to usec
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 12, 2019 at 10:59 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
> Can you consider these two patches for merging. There is no functional
> changes.

They are in my queue for review.

Thanks!
