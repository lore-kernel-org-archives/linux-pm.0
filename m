From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [RFC] CPUFreq PowerOP integration, Intro 0/3
Date: Fri, 6 Oct 2006 23:19:33 -0400
Message-ID: <20061007031933.GC1494@dominikbrodowski.de>
References: <45096A52.40706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932472AbWJGDTq@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <45096A52.40706@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Cc: pm list <linux-pm@lists.osdl.org>, Matthew Locke <matt@nomadgs.com>, Amit Kucheria <amit.kucheria@nokia.com>, Igor Stoppa <igor.stoppa@nokia.com>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

Just some nitpicking at the description, will cover the patches next.

On Thu, Sep 14, 2006 at 06:42:26PM +0400, Eugeny S. Mints wrote:
> Integrating CPUFreq and PowerOP was discussed at the Linux PM summit
> and in recent emails exchanges.  Some say keep them separate and some
> say they must be integrated.  There is actually a very natural point
> where integration makes sense - cpufreq_driver.

Well, I don't think that cpufreq_driver is the "natural" point -- in fact,
I think it is one of the worst points for the interaction. My alternative
suggestion will be the last one of the many mails you'll likely receive from
me today :)

> The patches do not change the functionality of the cpufreq core.
> Instead the idea is to redesign the tightly coupled interfaces of
> cpufreq to clearly separate the arch dependent and independent pieces
> layers.  This enables cpufreq to become arch independent and can start
> to use the named operating points in all its layers.

cpufreq is arch independent, as can be seen that it is used by many
different architectures right now.

> cpufreq.c
> - get rid of cpufreq driver calls. the calls are replaced be calls to arch
> independent freq_helpers (freq_helpers.c)

Have you considered the drivers which do not use the frequency table helper
library in cpufreq?

> - available frequencies sysfs interface now can be handled in arch 
> independent way

Also for the case where there are thousands of frequency states? Or only a
range to be set, and a in-CPU-mode [longrun]? There's a reason this export
is optional.

> - cpufreq_sysdev_driver now serves only cpufreq core internal needs upon cpu
> add/remove events (since all hw related is handled by PM Core)

That sounds like a good step forward -- especially as sysdevs may actually
be removed soon. It's orthogonal to the other changes though; i.e. we could
do that with the current cpufreq core without switching to PowerOP/"PM
core".

> freq_table.c (now freq_helpers.c)
> - get rid of cpufreq_frequency_table structures as input parameter and made 
> the code arch independent by leveraging PowerOP interface

arch independent? Well, this helper library is used by different archs already...

Thanks,
	Dominik
