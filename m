Return-Path: <SRS0=xQv0=SK=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF082C10F13
	for <linux-pm@archiver.kernel.org>; Mon,  8 Apr 2019 10:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8E5520883
	for <linux-pm@archiver.kernel.org>; Mon,  8 Apr 2019 10:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QA1cwaUU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfDHKpp (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:45:45 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33017 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfDHKpo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Apr 2019 06:45:44 -0400
Received: by mail-pf1-f196.google.com with SMTP id h5so2784683pfo.0
        for <linux-pm@vger.kernel.org>; Mon, 08 Apr 2019 03:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KrSsvytVySKo8ptiJZcGTgwsGgNyRT9iRQal9Er2QnE=;
        b=QA1cwaUUWy5Pf0Uf6T4UGlM6Uln5R21LcIjMCCKK6JyhIF+luK5g/FOJO+hfCsFGLb
         lcWfNbFQnfUyFS8nYeMCDwqn4TuTQl0jFxXmvfnE7NCqopwzg84fl6nN5aGnWg2Jh2Q3
         fnvsd/dKGHCcf/ClxfpI1JssAj1F4lufOLU2VjCFRuUSL3GSmA2ujr3rj2ESV4Ug/SLZ
         tO+z9LiU3a5kjYZSjFnKJzpX3/MhBNgHeb6YRJHA0yVOWpMFUhoRpUqaiyuXppbKzQaL
         f0XlPI6xusfh4X6jWJ3Vr/y93KYRGQ8O47oRZ3OxVHTD4HyP8HEZXd8nvkBzwU95di4W
         ELIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KrSsvytVySKo8ptiJZcGTgwsGgNyRT9iRQal9Er2QnE=;
        b=KjRx/O5aT+PcK5q9puNXbM/uIUHzyjJSCIZjET2HUA+sJ1mzIuY8h1sCY82wEJL87S
         p3JNzr1zquZ/yhhmBBhX02DcdrWQDdtggbfdPfW46SNeKh+6GhShGLknFA6lDerjr8FY
         N1B/L9iZsGm8qIfDms6ffgjJ5q04ONV8DFJUX8ylCErRTk0KUw9kshI1nKjLJUatmpxe
         xAX1MOnqBTa0UP8tf6lFUR06I7OtWQeeMmKD1q5XZ22tmy04WFhJEFAOc9hhQeJrx1Pi
         uM6QJ6kmi8i/KW8v5ihd3mwa+hbBI9uqAQBpbKp82xKApncx4+KnYEoc/4cmAjygRXKv
         oVWw==
X-Gm-Message-State: APjAAAWJ+bVSrgxGSiy91XiiRlJDF3jSDJe/lzmI2WxJmHpbShi7pkPT
        ANPyZVKDRINZwlKOfUfTn7Xr4A==
X-Google-Smtp-Source: APXvYqztXHekqlP5GRInKff46gfK8zZWFGWW5PomeQs+tdln4kYGJpViSfOJ8wikkQpxUAk/DGjjnw==
X-Received: by 2002:a62:e411:: with SMTP id r17mr28762166pfh.127.1554720344199;
        Mon, 08 Apr 2019 03:45:44 -0700 (PDT)
Received: from localhost ([122.172.162.162])
        by smtp.gmail.com with ESMTPSA id y10sm45787487pfm.27.2019.04.08.03.45.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 03:45:43 -0700 (PDT)
Date:   Mon, 8 Apr 2019 16:15:41 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: maple: Remove redundant code from
 maple_cpufreq_init()
Message-ID: <20190408104541.l7kfmjcf4lolri2r@vireshk-i7>
References: <dfb046a881d254f5133e6a1f86a04f49e73c56f9.1554718622.git.viresh.kumar@linaro.org>
 <4531254.vnb8GhbyUH@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <4531254.vnb8GhbyUH@kreacher>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190408104541.JQgLcHAvGsTqKrRCvwUWCcYvGH40nIll3WaOkzbHL9o@z>

On 08-04-19, 12:41, Rafael J. Wysocki wrote:
> On Monday, April 8, 2019 12:17:06 PM CEST Viresh Kumar wrote:
> > The success path and error path both look the same, don't duplicate the
> > code.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/cpufreq/maple-cpufreq.c | 4 ----
> >  1 file changed, 4 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/maple-cpufreq.c
> > b/drivers/cpufreq/maple-cpufreq.c index a05f1342ec02..a94355723ef8 100644
> > --- a/drivers/cpufreq/maple-cpufreq.c
> > +++ b/drivers/cpufreq/maple-cpufreq.c
> > @@ -231,10 +231,6 @@ static int __init maple_cpufreq_init(void)
> > 
> >  	rc = cpufreq_register_driver(&maple_cpufreq_driver);
> > 
> > -	of_node_put(cpunode);
> > -
> > -	return rc;
> > -
> >  bail_noprops:
> >  	of_node_put(cpunode);
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> I'm assuming this to land in your tree.

Yes, applied now. Thanks.

-- 
viresh
