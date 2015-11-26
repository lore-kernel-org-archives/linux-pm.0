From: Hongtao Jia <hongtao.jia@freescale.com>
Subject: RE: [PATCH V2] cpufreq: qoriq: Register cooling device based on
 device tree
Date: Thu, 26 Nov 2015 09:29:09 +0000
Message-ID: <BLUPR03MB1496BFEB452577A73497A27E1040@BLUPR03MB149.namprd03.prod.outlook.com>
References: <1448519249-11449-1-git-send-email-hongtao.jia@freescale.com>
 <20151126090805.GJ3869@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bn1on0113.outbound.protection.outlook.com ([157.56.110.113]:40160
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752819AbbKZJ3L convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Nov 2015 04:29:11 -0500
In-Reply-To: <20151126090805.GJ3869@ubuntu>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "edubezval@gmail.com" <edubezval@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Scott Wood <scottwood@freescale.com>

Thanks.
I just sent the new patch.

> -----Original Message-----
> From: Viresh Kumar [mailto:viresh.kumar@linaro.org]
> Sent: Thursday, November 26, 2015 5:08 PM
> To: Jia Hongtao-B38951
> Cc: edubezval@gmail.com; linux-pm@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org; devicetree@vger.kernel.org; Wood Scott-B07421
> Subject: Re: [PATCH V2] cpufreq: qoriq: Register cooling device based on
> device tree
> 
> On 26-11-15, 14:27, Jia Hongtao wrote:
> > +static void qoriq_cpufreq_ready(struct cpufreq_policy *policy) {
> > +	struct cpu_data *cpud = policy->driver_data;
> > +	struct device_node *np = of_get_cpu_node(policy->cpu, NULL);
> > +
> > +	if (WARN_ON(!np))
> > +		return;
> 
> Drop this and add my:
> 
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> --
> viresh
