Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4073BC433ED
	for <linux-pm@archiver.kernel.org>; Wed, 21 Apr 2021 11:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 183006144C
	for <linux-pm@archiver.kernel.org>; Wed, 21 Apr 2021 11:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238783AbhDUL7X (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 21 Apr 2021 07:59:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50687 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239546AbhDUL7K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Apr 2021 07:59:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619006313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NaElvfhG1ut7UsAJQ3t0dihJhEtIJBT86R6S/1O/j40=;
        b=gUGXJ4E+AI61sCTC3GjZtsGjly7BS7z92ESwA8iiqzFXksNWUJp2WGhlZ8zw6VLkwoqKdE
        017yL7xwALAHTLtttsWgIXs62bG6PI44SwrrjLBcctMjRs43Eqjo+lMFQvIBDU5bH+zba2
        zy2fck+qZJw8UT11NAwD5rfPF+4Bs/E=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-KBNQh19uMpG1ZM5kdrdw-A-1; Wed, 21 Apr 2021 07:58:32 -0400
X-MC-Unique: KBNQh19uMpG1ZM5kdrdw-A-1
Received: by mail-ed1-f70.google.com with SMTP id l22-20020a0564021256b0290384ebfba68cso11055490edw.2
        for <linux-pm@vger.kernel.org>; Wed, 21 Apr 2021 04:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NaElvfhG1ut7UsAJQ3t0dihJhEtIJBT86R6S/1O/j40=;
        b=lzlNOBGuLMelDsgrvf1TTBRyRZnoqXVyW4Fn6VDWbE62ocQKYlsLux2xoQMxAf3MpV
         6M+nqivALbLdhqRI1+UMtzIb81JMwb3Zmzsl2ToSRj3t32NxxlUH7xrEaPGoL2f7Zoh8
         m+vpLWF/gJHc+HJoNx+KvAIRNO3cd8vesvUftB+8UhNtRsl5njotGS7VSgiBIXCMUJyE
         +9iejfQ5bARa9oOqxepFA73chdeIg8JDrpIZ8DIR/bAgto7ujw1FAbNnUCtPJzrzGR6j
         vfqmBHbzsVFkX3QbNZdNmsn0SpJt/Gn+qUjzXdccg8JhKGUgJr20UkZ2EV0GYDkVZ+WS
         1fYw==
X-Gm-Message-State: AOAM533oyBQV9zV5kCpz5maHrPZRj461ClRSYuURWM3IGAY9DBjrU+As
        iIfFwRFbyUQ+o0JfO76GnxIa1wa2mVaj+ZTF/25QGPQHgD8kWdyL0+RBWUEEWIBt516TmZaGnDI
        6krealKNdFio6VV0IaTM=
X-Received: by 2002:a17:907:7b98:: with SMTP id ne24mr29344567ejc.304.1619006311006;
        Wed, 21 Apr 2021 04:58:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykm9U2sPDdnZLZb6hlL89pkjGxYx3pEKARR632PdA1BtTOsGpN7kfPinTw7pl16aa0kkYw3A==
X-Received: by 2002:a17:907:7b98:: with SMTP id ne24mr29344543ejc.304.1619006310788;
        Wed, 21 Apr 2021 04:58:30 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id hg19sm2234762ejc.24.2021.04.21.04.58.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 04:58:30 -0700 (PDT)
Subject: Re: [PATCH v3 2/8] MAINTAINERS: Add entry for devm helpers
To:     matti.vaittinen@fi.rohmeurope.com,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Gross <mgross@linux.intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-hwmon@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <cover.1616506559.git.matti.vaittinen@fi.rohmeurope.com>
 <eec1797734e3d080662aa732c565ed4a3c261799.1616506559.git.matti.vaittinen@fi.rohmeurope.com>
 <e064fdd7-b276-6732-16fe-2eb2564b2179@redhat.com>
 <YFn5CSB1O3i+SzgR@kroah.com>
 <da0233f3223d7c0816581afe0969caf0abe20378.camel@fi.rohmeurope.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <96935c55-c799-595e-024c-56fd352f279e@redhat.com>
Date:   Wed, 21 Apr 2021 13:58:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <da0233f3223d7c0816581afe0969caf0abe20378.camel@fi.rohmeurope.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 4/21/21 9:51 AM, Matti Vaittinen wrote:
> 
> On Tue, 2021-03-23 at 15:19 +0100, Greg KH wrote:
>> On Tue, Mar 23, 2021 at 02:58:28PM +0100, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 3/23/21 2:56 PM, Matti Vaittinen wrote:
>>>> Devm helper header containing small inline helpers was added.
>>>> Hans promised to maintain it.
>>>>
>>>> Add Hans as maintainer and myself as designated reviewer.
>>>>
>>> Ultimately this is up to Greg though, so lets wait and see what
>>> Greg has to say about this.
>>
>> Can we move some of the devm_* calls in include/device.h into here as
>> well so that you all can be in charge of them instead of me?
> 
> Seems like this was left w/o answer. I guess the question was pointed
> to Hans

I believe that Greg was (mostly) joking here. At least that is how
I interpreted Greg's reply,which is why I did not answer.

Also note that Greg merged this series, but not this patch,
so the new devm-helpers.h file will presumably be maintained by Greg.

Regards,

Hans

