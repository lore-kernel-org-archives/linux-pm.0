From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: intel_pstate divide error with v3.13-rc4-256-gb7000ad
Date: Fri, 03 Jan 2014 23:46:35 +0100
Message-ID: <2513222.AheLcigoE8@vostro.rjw.lan>
References: <CA+5PVA6YpKc6kYK5UiTnGLZpB8uts=-QPtyhotAyZ2kuoG8PPQ@mail.gmail.com> <52C6F3B4.3050904@gmail.com> <20140103180435.GK10961@minantech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60100 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753550AbaACWcy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jan 2014 17:32:54 -0500
In-Reply-To: <20140103180435.GK10961@minantech.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gleb Natapov <gleb@kernel.org>
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>, Kashyap Chamarthy <kchamart@redhat.com>, Josh Boyer <jwboyer@fedoraproject.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Viresh Kumar <viresh.kumar@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, "Richard W.M. Jones" <rjones@redhat.com>

On Friday, January 03, 2014 08:04:36 PM Gleb Natapov wrote:
> On Fri, Jan 03, 2014 at 09:30:28AM -0800, Dirk Brandewie wrote:
> > Hi All,
> > 
> > Sorry for being late to the party but I just got back from vacation.
> > 
> > There is something deeply wrong here.  We should have never gotten to
> > intel_pstate_init_cpu().  The VM had to have returned value from the read
> > of the max pstate at driver init time and 0 when the CPU was being brought up.
> > 
> > intel_pstate_msrs_not_valid() was added to solve this issue early on
> > if I remember correctly it was Josh that reported it then.  Is there
> > a definative way to detect whether we are running in a VM?
> > 
> Checking for VM is a wrong thing to do here. KVM should behave like it
> does not support p-state.
> 
> > Can some one tell me how the nested environment differs in regards to
> > reading MSRs?
> > 
> It shouldn't differ, but there may be bug somewhere in nested emulation.
> We shouldn't try and hind the bug by doing more checks in Linux but
> rather fixing KVM bug that causes Linux to behave incorrectly.

Well, fixing the KVM bug is surely welcome.

That said, adding checks to ensure that your assumptions are valid is rarely
wrong, especially if they are done once per kernel boot.  And the kernel only
should panic if it cannot continue to run, which isn't the case here.

Thanks,
Rafael

