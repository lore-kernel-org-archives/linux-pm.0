From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2 v2] cpufreq: Add cpufreq driver for Freescale e500mc SoCs
Date: Fri, 29 Mar 2013 10:20:53 +0530
Message-ID: <CAKohponzY8Lfx=PRnBdcC4UebeUJyQAwXMDJfHt-ANE+E6w-tA@mail.gmail.com>
References: <1364464508-25393-1-git-send-email-Yuantian.Tang@freescale.com>
	<CAKohpomPubV=E_wCLyOR6X0PQNvrJpTc94950PEF+YUam9ituw@mail.gmail.com>
	<D07C73A334FF604B95B3CBD2A545D07B0B1178B6@039-SN2MPN1-013.039d.mgd.msft.net>
	<CAKohpom9=HmVDvSVvgPC1zdzHmd+YpMU85SW34b9jun1dp6+HA@mail.gmail.com>
	<D07C73A334FF604B95B3CBD2A545D07B0B119911@039-SN2MPN1-013.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <D07C73A334FF604B95B3CBD2A545D07B0B119911@039-SN2MPN1-013.039d.mgd.msft.net>
Sender: cpufreq-owner@vger.kernel.org
To: Tang Yuantian-B29983 <B29983@freescale.com>
Cc: "rjw@sisk.pl" <rjw@sisk.pl>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Li Yang-R58472 <r58472@freescale.com>
List-Id: linux-pm@vger.kernel.org

On 29 March 2013 10:17, Tang Yuantian-B29983 <B29983@freescale.com> wrote:
> I thought it was OK here. Apparently, sizeof(*table) is better.
> But kcalloc is OK.

Yes yes, Kcalloc is okay... I have misread that part earlier when i
suggested kzalloc.
In last mail i was referring to sizeof() only.
