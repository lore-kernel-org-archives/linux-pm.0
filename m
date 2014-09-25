From: Robert =?ISO-8859-1?Q?Sch=F6ne?= <robert.schoene@tu-dresden.de>
Subject: Re: [PATCH 1/2] cpufreq: serialize calls to __cpufreq_governor()
Date: Thu, 25 Sep 2014 08:07:28 +0200
Message-ID: <1411625248.18835.10.camel@x200t>
References: <efa1d8ae3e7b227b73a951d6072fa211d3cfe593.1410235439.git.viresh.kumar@linaro.org>
	 <1478598.DgG2vI5Y04@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-7"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.zih.tu-dresden.de ([141.30.67.72]:47611 "EHLO
	mailout1.zih.tu-dresden.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750793AbaIYGHi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Sep 2014 02:07:38 -0400
In-Reply-To: <1478598.DgG2vI5Y04@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, prarit@redhat.com, skannan@codeaurora.org

+AD4 What's the current status of this series?
+AD4 
We had some iterations of patches, but the only solution that works for
me is the patch with the coarse-grained lock that I sent at Mon, 08 Sep
2014 10:16:48 CEST +AFs-1+AF0
Viresh is pretty occupied lately, but he told me that he might do the
tests himself when the current period of busyness is over as he is
supplied with a test system. I'm not sure about his current status (busy
or testing). 

+AFs-1+AF0 http://permalink.gmane.org/gmane.linux.power-management.general/49272

-- 

Dipl.-Inf. Robert Schoene
Computer Scientist - R+ACY-D Energy Efficient Computing

Technische Universitaet Dresden
Center for Information Services and High Performance Computing
Distributed and Data Intensive Computing
01062 Dresden
Tel.: +-49 (351) 463-42483
Fax : +-49 (351) 463-37773
E-Mail: Robert.Schoene+AEA-tu-dresden.de

