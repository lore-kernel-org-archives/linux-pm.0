From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/3] intel_pstate: Use pr_fmt
Date: Wed, 06 Apr 2016 08:12:55 -0700
Message-ID: <1459955575.6715.46.camel@perches.com>
References: <cover.1459887986.git.joe@perches.com>
	 <710e23a9e0846d1aaa660849321e433b5f5dd4e7.1459887986.git.joe@perches.com>
	 <1459892619.7030.2.camel@linux.intel.com>
	 <002601d19013$c129de60$437d9b20$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtprelay0087.hostedemail.com ([216.40.44.87]:40333 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753960AbcDFPNA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2016 11:13:00 -0400
In-Reply-To: <002601d19013$c129de60$437d9b20$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, 'Len Brown' <lenb@kernel.org>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Viresh Kumar' <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 2016-04-06 at 07:51 -0700, Doug Smythies wrote:
> On 2016.04.05 02:44 Srinivas Pandruvada wrote:
> >=20
> > On Tue, 2016-04-05 at 13:28 -0700, Joe Perches wrote:
> > >=20
> > > Prefix the output using the more common kernel style.
> > >=20
> > > Signed-off-by: Joe Perches <joe@perches.com>
> > Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > >=20
> > > ---
> > > =A0drivers/cpufreq/intel_pstate.c | 18 ++++++++++--------
> > > =A01 file changed, 10 insertions(+), 8 deletions(-)
> ...[cut, example left]...
>=20
> >=20
> > -		pr_warn("intel_pstate: Turbo disabled by BIOS or
> > unavailable on processor\n");
> > +		pr_warn("Turbo disabled by BIOS or unavailable on
> > processor\n");
> I do=A0=A0not understand.
> The common and unique string "intel_pstate" was added on purpose
> so as to provide a way to easily extract the related message from
> an otherwise huge log file.
>=20

The more common kernel mechanism to prefix messages
is using a pr_fmt define like:

#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

This style is used ~1000 times in the kernel tree.

All of the pr_<level> macros are defined like:

#define pr_info(fmt, ...) \
	printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)

so this prefixes all messages and means that any
new message added later will also be prefixed without
copy/paste defects or omission.

