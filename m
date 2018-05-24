From: <ilialin@codeaurora.org>
Subject: RE: [PATCH v12 1/2] cpufreq: Add Kryo CPU scaling driver
Date: Thu, 24 May 2018 17:52:03 +0300
Message-ID: <000901d3f36e$c9c995e0$5d5cc1a0$@codeaurora.org>
References: <1527152242-31281-1-git-send-email-ilialin@codeaurora.org> <1527152242-31281-2-git-send-email-ilialin@codeaurora.org> <860be68b-cac0-9efc-b3c7-cc75b391a4c3@arm.com> <000501d3f35f$96794910$c36bdb30$@codeaurora.org> <b4e221af-57f7-fd11-942d-6bc6f6b55a73@arm.com> <000701d3f368$fd31e410$f795ac30$@codeaurora.org> <15d6025c-1307-64e0-6715-34240fcaf8eb@arm.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <15d6025c-1307-64e0-6715-34240fcaf8eb@arm.com>
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
To: 'Sudeep Holla' <sudeep.holla@arm.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, robh@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net
List-Id: linux-pm@vger.kernel.org

OK, got you.
Is "operating-points-v2-kryo-cpu" good enough?

> -----Original Message-----
> From: Sudeep Holla <sudeep.holla@arm.com>
> Sent: Thursday, May 24, 2018 17:48
> To: ilialin@codeaurora.org
> Cc: Sudeep Holla <sudeep.holla@arm.com>; linux-pm@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> vireshk@kernel.org; nm@ti.com; sboyd@kernel.org; robh@kernel.org;
> mark.rutland@arm.com; rjw@rjwysocki.net
> Subject: Re: [PATCH v12 1/2] cpufreq: Add Kryo CPU scaling driver
> 
> 
> 
> On 24/05/18 15:10, ilialin@codeaurora.org wrote:
> > Thank you for the explanation. However, could you suggest, which
> > condition should I check then? Device tree?
> >
> 
> Yes some compatible which is applicable for all the SoCs or platforms on
> which this driver can work ?
> 
> --
> Regards,
> Sudeep
