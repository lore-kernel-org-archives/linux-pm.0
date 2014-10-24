From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Subject: Re: [PATCH v8 0/7] QCOM 8974 and 8084 cpuidle driver
Date: Fri, 24 Oct 2014 13:01:25 +0300
Message-ID: <1414144885.2025.4.camel@mm-sol.com>
References: <1412718106-17049-1-git-send-email-lina.iyer@linaro.org>
	 <1414078317.4214.4.camel@mm-sol.com>
	 <20141023155435.GA30210@ilina-mac.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ns.mm-sol.com ([37.157.136.199]:51886 "EHLO extserv.mm-sol.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755320AbaJXKBM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 24 Oct 2014 06:01:12 -0400
In-Reply-To: <20141023155435.GA30210@ilina-mac.qualcomm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org


On Thu, 2014-10-23 at 09:54 -0600, Lina Iyer wrote:
> On Thu, Oct 23 2014 at 09:31 -0600, Ivan T. Ivanov wrote:
> > >
> > >Hi,
> > >
> > >On Tue, 2014-10-07 at 15:41 -0600, Lina Iyer wrote:
> > >  Hi,
> > > >
> > >  This v8 revision of the cpuidle driver is available at
> > >  git.linaro.org:/people/lina.iyer/linux-next cpuidle-v8
> > > >
> > >
> > >Probably I missing something, but should I expect that
> > >once these patches are applied driver could be successfully
> >  compiled?
> Yes they should.

Do these patches depends on other patches, which I am missing.
I am applying them on current linus/master. At least <soc/qcom/scm.h> 
and <soc/qcom/scm-boot.h> are missing from this patch-set v8 :-|

Ivan

