From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v2] cpufreq: tests: Providing cpufreq regression test
Date: Thu, 24 Jul 2014 09:04:02 +0200
Message-ID: <20140724090402.1f981470@amdc2363>
References: <1405678985-21677-1-git-send-email-l.majewski@samsung.com>
 <1405926154-27214-1-git-send-email-l.majewski@samsung.com>
 <3777635.Nvoh2EpFlu@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:21106 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171AbaGXHE0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Jul 2014 03:04:26 -0400
In-reply-to: <3777635.Nvoh2EpFlu@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Thomas Abraham <ta.omasab@gmail.com>, "thomas.ab@samsung.com" <thomas.ab@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tomasz Figa <t.figa@samsung.com>, Sachin Kamat <spk.linux@gmail.com>

Hi Rafael,

> On Monday, July 21, 2014 09:02:34 AM Lukasz Majewski wrote:
> > This commit adds first regression test "cpufreq_freq_test.sh" for
> > the cpufreq subsystem.
> 
> First of all, I'm not seeing any explanation why this script should be
> shipped with the kernel.

OK.

> 
> What regressions it tests against in particular and 

Do you require SHA's/commit messages of commits which were developed to
fix issues spotted with this test script?

> how it does that.

Is this information required in the commit message or can it stay in
the README file created in the same commit?

> 
> Please write that down in the changelog.  It doesn't need to be very
> detailed.
> 
> Second, I'm not sure this is the first such test (someone already
> mentioned cpupower).

It's no problem for me to add such scripts to other work.

> 
> > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> > 
> > ---
> > Changes for v2:
> > - Replace *_PATCH with *_PATH for variables names
> > - Corrected mistakes in the README file
> > - Providing detailed explanation of the patch in the README file
> > ---
> >  drivers/cpufreq/tests/README               |  33 +++++++
> >  drivers/cpufreq/tests/cpufreq_freq_test.sh | 149
> > +++++++++++++++++++++++++++++ 2 files changed, 182 insertions(+)
> >  create mode 100644 drivers/cpufreq/tests/README
> >  create mode 100755 drivers/cpufreq/tests/cpufreq_freq_test.sh
> > 
> > diff --git a/drivers/cpufreq/tests/README
> > b/drivers/cpufreq/tests/README
> 
> drivers/cpufreq/ is not a place for scripts.
> 
> We have scripts/ for that and you can add a "power" subdirectory in
> there and put your script into it.
> 
> Alternatively, you can use the existing tools/power/ directory for
> that (but then please add a subdirectory for your script).

Ok.

> 
> > new file mode 100644
> > index 0000000..3e9cd80
> > --- /dev/null
> > +++ b/drivers/cpufreq/tests/README
> > @@ -0,0 +1,33 @@
> > +This file contains list of cpufreq's available regression tests
> > with a short +usage description.
> > +
> > +1. cpufreq_freq_test.sh
> > +
> > +Description:
> > +------------
> > +This script is supposed to test if cpufreq attributes exported by
> > sysfs are +exposing correct values.
> > +
> > +To achieve this goal it saves the current governor and changes it
> > to +"performance". Afterwards, it reads the
> > "scaling_available_frequencies" +property. With the list of
> > supported frequencies it is able to enforce each of +them by
> > writing to "scaling_max_freq" attribute. To make the test more
> > reliable +a superfluous load with gzip is created to be sure that
> > we are running with +highest possible frequency. This high load is
> > regulated with the 'sleep' +duration. After this time the
> > "cpufreq_cur_freq" is read and compared with the +original value.
> > As the last step the original governor is restored. + +This script
> > can work with or without BOOST enabled and helps in spotting errors
> > +related to cpufreq and common clock framework. +
> > +Used attributes:
> > +----------------
> > +- "scaling_available_frequencies"
> > +- "cpuinfo_cur_freq"
> > +- "scaling_governor"
> > +- "scaling_max_freq"
> > +
> > +Target devices:
> > +---------------
> > +
> > +All devices which exports mentioned above sysfs attributes.
> > \ No newline at end of file
> > diff --git a/drivers/cpufreq/tests/cpufreq_freq_test.sh
> > b/drivers/cpufreq/tests/cpufreq_freq_test.sh new file mode 100755
> > index 0000000..c25f05c
> > --- /dev/null
> > +++ b/drivers/cpufreq/tests/cpufreq_freq_test.sh
> > @@ -0,0 +1,149 @@
> > +#!/bin/bash
> > +#
> > +# This file provides a simple mean to test if all declared freqs at
> > +# "scaling_available_frequencies" can be set and if
> > "cpuinfo_cur_freq" +# returns this value.
> > +#
> > +# Usage: ./cpufreq_freq_test.sh
> > +# Requisite: Compiled in "performance" governor
> > +#
> > +# This program is free software; you can redistribute it and/or
> > modify +# it under the terms of the GNU General Public License as
> > published by +# the Free Software Foundation; either version 2 of
> > the License, or +# (at your option) any later version.
> > +#
> > +# This program is distributed in the hope that it will be useful,
> > +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> > +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > +# GNU General Public License for more details.
> > +#
> > +# You should have received a copy of the GNU General Public License
> > +# along with this program; if not, you can access it online at
> > +# http://www.gnu.org/licenses/gpl-2.0.html.
> > +#
> > +# Copyright (C) Samsung Electronics, 2014
> > +#
> > +# Author: Lukasz Majewski <l.majewski@samsung.com>
> > +
> > +set +x
> > +
> > +COLOUR_RED="\33[31m"
> > +COLOUR_BLUE="\33[34m"
> > +COLOUR_GREEN="\33[32m"
> > +COLOUR_DEFAULT="\33[0m"
> > +
> > +T_PATH=/sys/devices/system/cpu/cpu0/cpufreq
> > +BOOST_PATH=/sys/devices/system/cpu/cpufreq
> > +
> > +if [ ! -d "$T_PATH" ]; then
> > +    printf "   $COLOUR_RED No path to CPUFREQ $COLOUR_DEFAULT\n"
> > +    exit 1
> > +fi
> > +
> > +ERRORS=0
> > +
> > +OLD_GOV=`cat $T_PATH/scaling_governor`
> > +echo "CURRENT GOVERNOR: $OLD_GOV"
> > +echo "SET GOVERNOR: performance"
> > +echo "performance" > $T_PATH/scaling_governor
> > +
> > +function test_freqs1 {
> > +    FREQS=`cat $1`
> > +    for I in $FREQS; do
> > +	cpufreq_set_freq $I
> > +	if [ "$2" ]; then
> > +	    printf "$COLOUR_BLUE BOOST $COLOUR_DEFAULT" $I
> > +	fi
> > +	cpufreq_test_freq $I
> > +    done
> > +}
> > +
> > +function test_freqs2 {
> > +    FREQ=`cat $1`
> > +    FREQS_ARRAY=($FREQ)
> > +
> > +    for freq in ${FREQS_ARRAY[@]}
> > +    do
> > +	echo "REFERENCE FREQ: $freq"
> > +	for f in ${FREQS_ARRAY[@]}
> > +	do
> > +	    cpufreq_set_freq $freq
> > +	    echo -n "----> "
> > +	    cpufreq_set_freq $f
> > +	    cpufreq_test_freq $f
> > +	done
> > +    done
> > +}
> > +
> > +function restore {
> > +    if [ -f $BOOST_PATH/boost ]; then
> > +	cpufreq_boost_state $BOOST_STATE
> > +    fi
> > +
> > +    echo "SET GOVERNOR: $OLD_GOV"
> > +    echo $OLD_GOV > $T_PATH/scaling_governor
> > +}
> > +
> > +function die {
> > +    printf "   $COLOUR_RED FAILED $COLOUR_DEFAULT\n"
> > +    restore_gov
> > +    exit 1
> > +}
> > +
> > +function cpufreq_test_freq {
> > +    gzip < /dev/urandom > /dev/null &
> > +    pid=$!
> > +    sleep 0.1
> > +    CURR_FREQ=`cat $T_PATH/cpuinfo_cur_freq`
> > +    if [ $1 -eq $CURR_FREQ ]; then
> > +	printf "\t$COLOUR_GREEN OK $COLOUR_DEFAULT\n"
> > +    else
> > +	printf "$COLOUR_RED CURRENT $CURR_FREQ $COLOUR_DEFAULT\n"
> > +	ERRORS=`expr $ERRORS + 1`
> > +	#die
> > +    fi
> > +    kill -9 $pid
> > +    wait $! 2>/dev/null
> > +}
> > +
> > +function cpufreq_set_freq {
> > +    echo $1 > $T_PATH/scaling_max_freq || die $?
> > +    printf "FREQ:$COLOUR_GREEN %s $COLOUR_DEFAULT" $1
> > +}
> > +
> > +function cpufreq_boost_state {
> > +   echo $1 > $BOOST_PATH/boost
> > +}
> > +
> > +function cpufreq_boost_status {
> > +   cat $BOOST_PATH/boost
> > +}
> > +
> > +if [ -f $BOOST_PATH/boost ]; then
> > +    echo "######################################"
> > +    echo "TEST BOOST OPERATION"
> > +    echo "######################################"
> > +
> > +    BOOST_STATE=$(cpufreq_boost_status)
> > +    if [ $BOOST_STATE -eq 0 ]; then
> > +	cpufreq_boost_state 1
> > +    fi
> > +    test_freqs1 $T_PATH/scaling_boost_frequencies 1
> > +fi
> > +
> > +echo "######################################"
> > +echo "TEST AVAILABLE FREQS"
> > +echo "######################################"
> > +test_freqs1 $T_PATH/scaling_available_frequencies
> > +
> > +echo "######################################"
> > +echo "TEST FREQS SWITCHING"
> > +echo "######################################"
> > +test_freqs2 $T_PATH/scaling_available_frequencies
> > +
> > +echo "######################################"
> > +echo "ERRORS: $ERRORS"
> > +echo "######################################"
> > +
> > +restore
> > +exit 0
> > 
> 



-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
