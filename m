Return-Path: <SRS0=9RE4=SZ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15C2C282DD
	for <linux-pm@archiver.kernel.org>; Tue, 23 Apr 2019 13:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC30A21738
	for <linux-pm@archiver.kernel.org>; Tue, 23 Apr 2019 13:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="OrOly8o8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbfDWNzJ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:55:09 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:34978 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727746AbfDWNzJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Apr 2019 09:55:09 -0400
Received: by mail-pg1-f169.google.com with SMTP id g8so7668389pgf.2
        for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2019 06:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=luZOP+M2Br1z6JjqvbCNY8qb9/6fC4RpgjiwRzb9+fM=;
        b=OrOly8o89edT05ye0GoFYglLRnhBVI2iEJom83aUVZS3azbqR0BfYsNQg4K3yNldrW
         +g9wz3kH6GRB7RS2YOWrcjSEk7Gkz5xGOpOn3S5JlJ9yqedh5+FDEaOx6yFF2FOL93Px
         FIRoMpMW0yTRsShbBKv395hY1iGxcyovrjcYARVsJPMJ9qXkWeWpwfUDYZFgbmAb3LPU
         ZsZAuh6gYD/3ZCG1WQAZXGjhLrxl2Xa5WBWpw3u+6v4/6RZ11a5a5rXP3UX2r1W4Hdf5
         SHtN7SU1zX6LMJbFBE787Gn7MHSfRNeowo4R7N358R1cdG2asO7DgvsbxhL43Eheda5h
         PS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=luZOP+M2Br1z6JjqvbCNY8qb9/6fC4RpgjiwRzb9+fM=;
        b=FfgoRTQfWIw7xaru7CD+QRSsMvOmdg851BV8RubPck/0X/Cj0dsLUuszLXkaqben41
         iuLqypRLgxK6edsYzRxC7otCn/8c6xONQY84WNpyXRHJZcuKcFkr2eGFnqz4J/eil7Ur
         h8wz3+tVmntKQPR2iyZp4oZu1tO2gQmjWH/leTSdUEFOoyq2HjL6WkUYAF2lJ+Ue/S6h
         +ZrcJglKrZGSBuFy6G0rdIpKORTkrqfoS5cwy0sAMAE0UaGhvrudozv8dvGvvn1h6MUg
         IKKEcp4XenBDaXqK/prtRCnH3YmFQWKtTxXmnNow4m79xSLTBiBKVE5RKfdS9td5Dylr
         VncA==
X-Gm-Message-State: APjAAAWPif2s78TliS97zKuEWU2l8/iYXN1XA0SHLSfEzl+P36DpwqMY
        Dcz0pvRpwvVIqG0IWELZY1+Nvw==
X-Google-Smtp-Source: APXvYqyPSeybmMUZTM8bgnWD06hCQaiW8B7Q9aMgFMFTf9FftneTu4UxQjo9GJ4QdLhH6QuMuxEgvg==
X-Received: by 2002:a65:60c7:: with SMTP id r7mr19209315pgv.191.1556027708285;
        Tue, 23 Apr 2019 06:55:08 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id v15sm21933247pff.105.2019.04.23.06.55.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 06:55:07 -0700 (PDT)
Subject: Re: next-20190408..0418: Suspend/resume problems on Thinkpad X60
To:     Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net,
        linux-pm@vger.kernel.org, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, hdegoede@redhat.com,
        linux-ide@vger.kernel.org
References: <20190408173928.GB13260@amd> <20190412102812.GA24977@amd>
 <20190423102239.GA15531@amd>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <41d56ba6-d0cb-5d5e-f5f4-9bca045440dd@kernel.dk>
Date:   Tue, 23 Apr 2019 07:55:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423102239.GA15531@amd>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190423135505.OAnHTHaal_zxuMCRWIKyND4KG12mf7nGDLa4HjcT3dQ@z>

On 4/23/19 4:22 AM, Pavel Machek wrote:
> Hi!
> 
>>> It boots ok (unlike mainline -- I'm debugging that), and I can suspend
>>> and resume... but then cursor in X is moving and I can talk to
>>> applications cached in memory, but any access to disk hangs.
>>
>> Mainline problem was identified.
>>
>> But resume is still broken. I took advantage of fact that I can still
>> do cached commands, and got complete dmesg. I'm attaching it.
> 
> Still broken in 0418. Ideas would be welcome at this point.

Bisect it?

-- 
Jens Axboe

