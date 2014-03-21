From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 2/3] cpufreq: Convert existing drivers to use cpufreq_freq_transition_{begin|end}
Date: Fri, 21 Mar 2014 13:29:25 +0530
Message-ID: <CAKohpo=R60e8S8qFNbDcWvBgOWJj=1Sa2AFj5SnidAyuMbE8uw@mail.gmail.com>
References: <cover.1395379422.git.viresh.kumar@linaro.org>
	<6c531c2fb48c3092bba1098459ef0862a6179375.1395379422.git.viresh.kumar@linaro.org>
	<532BEEDC.9000106@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <532BEEDC.9000106@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "ego@linux.vnet.ibm.com" <ego@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

On 21 March 2014 13:18, Srivatsa S. Bhat
<srivatsa.bhat@linux.vnet.ibm.com> wrote:
> Nitpick: Instead of using 'false' as an argument to _post_transition(),
> you could use '0', since the argument is supposed to be an int. But that's
> minor, I won't insist.

You should :)

I will update that with a Macro actually, to make it more readable.
