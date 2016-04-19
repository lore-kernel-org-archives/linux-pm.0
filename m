From: Mason <slash.tmp@free.fr>
Subject: Re: [PATCH v8 1/2] thermal: add temperature sensor support for tango
 SoC
Date: Tue, 19 Apr 2016 16:49:14 +0200
Message-ID: <5716456A.5070605@free.fr>
References: <20160308214846.GA10950@localhost.localdomain>
 <56F84427.1000507@free.fr> <56F91A47.9060901@free.fr>
 <20160329020050.GA15721@localhost.localdomain> <56FACE0B.9060606@free.fr>
 <20160330000503.GA2625@localhost.localdomain> <56FBEE4F.3060106@free.fr>
 <56FD8582.80002@free.fr> <20160401015240.GB19409@localhost.localdomain>
 <570254D8.3090406@free.fr> <20160406155155.GB326@localhost.localdomain>
 <57163EDC.7030307@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:19705 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754013AbcDSOtg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 19 Apr 2016 10:49:36 -0400
In-Reply-To: <57163EDC.7030307@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Javi Merino <javi.merino@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sebastian Frias <sf84@laposte.net>, arm-soc <arm@kernel.org>

On 19/04/2016 16:21, Mason wrote:

> The Tango thermal driver provides support for the primitive temperature
> sensor embedded in Tango chips since the SMP8758.
> 
> This sensor only generates a 1-bit signal to indicate whether the die
> temperature exceeds a programmable threshold.

Tested with the following script:

X=3
TEMP="/sys/class/thermal/thermal_zone0/temp"

echo RUN IDLE
for ((I=0; I<30; ++I)); do cat $TEMP; sleep $X; done

echo RUN HEAVY LOAD
cpuburn-a9 &
cpuburn-a9 &
for ((I=0; I<60; ++I)); do cat $TEMP; sleep $X; done

echo KILL HEAVY LOAD
kill $(jobs -p)
for ((I=0; I<30; ++I)); do cat $TEMP; sleep $X; done


RUN IDLE
43000
47000
47000
43000
52000
52000
52000
52000
47000
43000
47000
47000
47000
52000
52000
52000
52000
52000
52000
47000
43000
47000
43000
47000
43000
43000
52000
43000
52000
52000
RUN HEAVY LOAD
52000
61000
56000
61000
65000
65000
65000
65000
65000
65000
65000
65000
65000
61000
65000
65000
61000
65000
65000
65000
65000
65000
65000
65000
61000
65000
65000
65000
65000
65000
65000
65000
61000
65000
70000
70000
70000
70000
70000
70000
70000
70000
70000
70000
70000
70000
70000
70000
70000
70000
70000
74000
70000
70000
70000
74000
70000
74000
70000
70000
KILL HEAVY LOAD
70000
./thermo2.sh: line 14:   972 Terminated              cpuburn-a9
./thermo2.sh: line 14:   973 Terminated              cpuburn-a9
61000
61000
56000
56000
61000
56000
61000
56000
56000
56000
56000
56000
56000
56000
56000
56000
56000
56000
56000
56000
52000
52000
52000
52000
52000
47000
52000
47000
52000

Regards.
