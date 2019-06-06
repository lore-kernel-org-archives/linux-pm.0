Return-Path: <SRS0=ZIL/=UF=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F2EC28D18
	for <linux-pm@archiver.kernel.org>; Thu,  6 Jun 2019 03:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3023D20872
	for <linux-pm@archiver.kernel.org>; Thu,  6 Jun 2019 03:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WZ3Fvdh/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfFFDP3 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 5 Jun 2019 23:15:29 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:41084 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfFFDP3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jun 2019 23:15:29 -0400
Received: by mail-pf1-f173.google.com with SMTP id q17so561794pfq.8
        for <linux-pm@vger.kernel.org>; Wed, 05 Jun 2019 20:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aQaPbWDXavNRu7iOgwRHmYDUom2MXcE3ZI99h8uIByc=;
        b=WZ3Fvdh/fIOmKtwoVSjN3gj8nuE5cMhxReyGHL+oQM9kaT3bVtXy34TL5mC7J49hhU
         LRN13bJQACT1qMLH4c4haFMqz66iiDDvz2IzI/92IUs6DZlZyeMYecwylfSkvE3bS5Do
         ardjEJSLUx8yI5ggqluKPlCFYPju3HLQPq4YC6YZg2V+XZv/2FexM4CTFiEaU5L4uXvx
         aT4DAGPzbqf7v/OeXP1qDBZ8faJpWcR5eRqO+5Bov9N7XgwkDISA/BOef4xEO5MdkWE9
         lOpQBvnNxHrYGIHbyxMCtworrsd5yaMo5Cz5uphqlYeuM2nNJXgApz1k2XvmFha1hxCO
         Mv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aQaPbWDXavNRu7iOgwRHmYDUom2MXcE3ZI99h8uIByc=;
        b=jDZBBmr5U1v8qeQ8sAtGuSTY9ltgZK+J/spOjk2VKIKLdTTYPdp9bMJIeUaoudIajc
         3Tbg+j0vEQhU9Ba2zkoVCR7xz0N4bqn8wkihR5fVyKi0uEYui3UI5XPEBErYt1y2mUfL
         ab19xIQxeB+ezDdS4MVPqMnNdVQWuUBfaKEvfbrunGStuK5C1g4+ZepOmhe3Q6SFj5m5
         6P3ul6x2Ij/UPwdkh0+QACbsJogJgwBaX4eePfQN9dkLjfb0I6GO+ZeGQPQCL0zELXEU
         JCWo2z37VLMQMQ54qb5NLl+Dr5S5GSnichiQei66cgeE6/FYXQAhMvYDXfFT1R40A11Y
         qTrw==
X-Gm-Message-State: APjAAAW4CstoB703w+FWYaZN8kXV78cP097UxZE5/7HZnK4kNeNT4uyx
        5nKPJMfaUONYLdBHdiRzvimq+w==
X-Google-Smtp-Source: APXvYqx3naFQT7F/C/KDKO36iTavZgfZJHhHPggIkqir5gQYvj8f0p7/nEzDq+JMzQ8ZwOdj+E/eJQ==
X-Received: by 2002:a65:6295:: with SMTP id f21mr1221471pgv.416.1559790928747;
        Wed, 05 Jun 2019 20:15:28 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id o20sm258525pgj.70.2019.06.05.20.15.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 20:15:28 -0700 (PDT)
Date:   Thu, 6 Jun 2019 08:45:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Anson Huang <Anson.Huang@nxp.com>, Stephen Boyd <sboyd@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Jacky Bai <ping.bai@nxp.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel@pengutronix.de,
        linux-clk@vger.kernel.org, linux-imx@nxp.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC] devfreq: Add generic devfreq-dt driver
Message-ID: <20190606031526.xknv5qdoqufim6tr@vireshk-i7>
References: <e48d7e3d71166cea20c3c200300e0ffa6d26d085.1559737589.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e48d7e3d71166cea20c3c200300e0ffa6d26d085.1559737589.git.leonard.crestez@nxp.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05-06-19, 15:31, Leonard Crestez wrote:
> +static const struct of_device_id devfreq_dt_of_match[] = {
> +	{ .compatible = "generic-devfreq", },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, devfreq_dt_of_match);

DT can't contain nodes for any virtual devices, this will have similar
problems to cpufreq-dt. How is this driver going to get probed ? Who
will create the device ?

> +static struct platform_driver devfreq_dt_platdrv = {
> +	.probe		= devfreq_dt_probe,
> +	.shutdown	= devfreq_dt_shutdown,
> +	.driver = {
> +		.name	= "devfreq-dt",
> +		.of_match_table = of_match_ptr(devfreq_dt_of_match),
> +	},
> +};
> +module_platform_driver(devfreq_dt_platdrv);
> +
> +MODULE_DESCRIPTION("Generic devfreq-dt driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.17.1

-- 
viresh
