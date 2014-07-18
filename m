From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: tests: Providing cpufreq regression test
Date: Fri, 18 Jul 2014 13:42:39 +0200
Message-ID: <2218713.u72ghDj0Dh@vostro.rjw.lan>
References: <1405678985-21677-1-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63967 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1761305AbaGRLYW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Jul 2014 07:24:22 -0400
In-Reply-To: <1405678985-21677-1-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Thomas Abraham <ta.omasab@gmail.com>, "thomas.ab@samsung.com" <thomas.ab@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tomasz Figa <t.figa@samsung.com>

On Friday, July 18, 2014 12:23:05 PM Lukasz Majewski wrote:
> This commit adds first regression test "cpufreq_freq_test.sh" for the
> cpufreq subsystem.

Care to add any description of how it is supposed to work and what it is
going to test?

> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> ---
>  drivers/cpufreq/tests/README               |  23 +++++
>  drivers/cpufreq/tests/cpufreq_freq_test.sh | 149 +++++++++++++++++++++++++++++
>  2 files changed, 172 insertions(+)
>  create mode 100644 drivers/cpufreq/tests/README
>  create mode 100755 drivers/cpufreq/tests/cpufreq_freq_test.sh
> 
> diff --git a/drivers/cpufreq/tests/README b/drivers/cpufreq/tests/README
> new file mode 100644
> index 0000000..66638d2
> --- /dev/null
> +++ b/drivers/cpufreq/tests/README
> @@ -0,0 +1,23 @@
> +This file contains list of cpufreq's available regression tests with a short
> +usage description.
> +
> +1. cpufreq_freq_test.sh
> +
> +Description:
> +------------
> +This test is supposed to test if cpufreq attributes exported by sysfs are
> +exposing a correct values.
> +
> +It can work with or without boost enabled and helps spotting errors related to
> +cpufreq and common clock framework.
> +
> +Used attributes:
> +----------------
> +- "scaling_available_frequencies"
> +- "cpuinfo_cur_freq"
> +- "scaling_governor"
> +
> +Target devices:
> +---------------
> +
> +All devices which exports mentioned above sysfs attributes.
> \ No newline at end of file
> diff --git a/drivers/cpufreq/tests/cpufreq_freq_test.sh b/drivers/cpufreq/tests/cpufreq_freq_test.sh
> new file mode 100755
> index 0000000..53156ca
> --- /dev/null
> +++ b/drivers/cpufreq/tests/cpufreq_freq_test.sh
> @@ -0,0 +1,149 @@
> +#!/bin/bash
> +#
> +# This file provides a simple mean to test if all declared freqs at
> +# "scaling_available_frequencies" can be set and if "cpuinfo_cur_freq"
> +# returns this value.
> +#
> +# Usage: ./cpufreq_freq_test.sh
> +# Requisite: Compile in "performance" governor
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, you can access it online at
> +# http://www.gnu.org/licenses/gpl-2.0.html.
> +#
> +# Copyright (C) Samsung Electronics, 2014
> +#
> +# Author: Lukasz Majewski <l.majewski@samsung.com>
> +
> +set +x
> +
> +COLOUR_RED="\33[31m"
> +COLOUR_BLUE="\33[34m"
> +COLOUR_GREEN="\33[32m"
> +COLOUR_DEFAULT="\33[0m"
> +
> +T_PATCH=/sys/devices/system/cpu/cpu0/cpufreq
> +BOOST_PATCH=/sys/devices/system/cpu/cpufreq
> +
> +if [ ! -d "$T_PATCH" ]; then
> +    printf "   $COLOUR_RED No patch to CPUFREQ $COLOUR_DEFAULT\n"
> +    exit 1
> +fi
> +
> +ERRORS=0
> +
> +OLD_GOV=`cat $T_PATCH/scaling_governor`
> +echo "CURRENT GOVERNOR: $OLD_GOV"
> +echo "SET GOVERNOR: performance"
> +echo "performance" > $T_PATCH/scaling_governor
> +
> +function test_freqs1 {
> +    FREQS=`cat $1`
> +    for I in $FREQS; do
> +	cpufreq_set_freq $I
> +	if [ "$2" ]; then
> +	    printf "$COLOUR_BLUE BOOST $COLOUR_DEFAULT" $I
> +	fi
> +	cpufreq_test_freq $I
> +    done
> +}
> +
> +function test_freqs2 {
> +    FREQ=`cat $1`
> +    FREQS_ARRAY=($FREQ)
> +
> +    for freq in ${FREQS_ARRAY[@]}
> +    do
> +	echo "REFERENCE FREQ: $freq"
> +	for f in ${FREQS_ARRAY[@]}
> +	do
> +	    cpufreq_set_freq $freq
> +	    echo -n "----> "
> +	    cpufreq_set_freq $f
> +	    cpufreq_test_freq $f
> +	done
> +    done
> +}
> +
> +function restore {
> +    if [ -f $BOOST_PATCH/boost ]; then
> +	cpufreq_boost_state $BOOST_STATE
> +    fi
> +
> +    echo "SET GOVERNOR: $OLD_GOV"
> +    echo $OLD_GOV > $T_PATCH/scaling_governor
> +}
> +
> +function die {
> +    printf "   $COLOUR_RED FAILED $COLOUR_DEFAULT\n"
> +    restore_gov
> +    exit 1
> +}
> +
> +function cpufreq_test_freq {
> +    gzip < /dev/urandom > /dev/null &
> +    pid=$!
> +    sleep 0.1
> +    CURR_FREQ=`cat $T_PATCH/cpuinfo_cur_freq`
> +    if [ $1 -eq $CURR_FREQ ]; then
> +	printf "\t$COLOUR_GREEN OK $COLOUR_DEFAULT\n"
> +    else
> +	printf "$COLOUR_RED CURRENT $CURR_FREQ $COLOUR_DEFAULT\n"
> +	ERRORS=`expr $ERRORS + 1`
> +	#die
> +    fi
> +    kill -9 $pid
> +    wait $! 2>/dev/null
> +}
> +
> +function cpufreq_set_freq {
> +    echo $1 > $T_PATCH/scaling_max_freq || die $?
> +    printf "FREQ:$COLOUR_GREEN %s $COLOUR_DEFAULT" $1
> +}
> +
> +function cpufreq_boost_state {
> +   echo $1 > $BOOST_PATCH/boost
> +}
> +
> +function cpufreq_boost_status {
> +   cat $BOOST_PATCH/boost
> +}
> +
> +if [ -f $BOOST_PATCH/boost ]; then
> +    echo "######################################"
> +    echo "TEST BOOST OPERATION"
> +    echo "######################################"
> +
> +    BOOST_STATE=$(cpufreq_boost_status)
> +    if [ $BOOST_STATE -eq 0 ]; then
> +	cpufreq_boost_state 1
> +    fi
> +    test_freqs1 $T_PATCH/scaling_boost_frequencies 1
> +fi
> +
> +echo "######################################"
> +echo "TEST AVAILABLE FREQS"
> +echo "######################################"
> +test_freqs1 $T_PATCH/scaling_available_frequencies
> +
> +echo "######################################"
> +echo "TEST FREQS SWITCHING"
> +echo "######################################"
> +test_freqs2 $T_PATCH/scaling_available_frequencies
> +
> +echo "######################################"
> +echo "ERRORS: $ERRORS"
> +echo "######################################"
> +
> +restore
> +exit 0
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
