From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH 1/3] intel_pstate: Use pr_fmt
Date: Wed, 6 Apr 2016 08:47:25 -0700
Message-ID: <002d01d1901b$9eab7ad0$dc027070$@net>
References: <cover.1459887986.git.joe@perches.com>	 <710e23a9e0846d1aaa660849321e433b5f5dd4e7.1459887986.git.joe@perches.com>	 <1459892619.7030.2.camel@linux.intel.com>	 <002601d19013$c129de60$437d9b20$@net> <1459955575.6715.46.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459955575.6715.46.camel@perches.com>
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: 'Joe Perches' <joe@perches.com>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, 'Len Brown' <lenb@kernel.org>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Viresh Kumar' <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 2106.03.06 08:13 Joe Perches wrote:
> On Wed, 2016-04-06 at 07:51 -0700, Doug Smythies wrote:
>> On 2016.04.05 02:44 Srinivas Pandruvada wrote: 
>>> On Tue, 2016-04-05 at 13:28 -0700, Joe Perches wrote:

> The more common kernel mechanism to prefix messages
> is using a pr_fmt define like:
>
> #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

> so this prefixes all messages and means that any
> new message added later will also be prefixed without
> copy/paste defects or omission.

Ok. Thanks for your reply and education (and Viresh also).
And sorry for my the ignorance in my patch submission last May.

... Doug
