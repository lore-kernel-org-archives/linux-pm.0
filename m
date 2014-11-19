From: "Kasagar, Srinidhi" <srinidhi.kasagar@intel.com>
Subject: Re: [PATCH v5] cpufreq: Add SFI based cpufreq driver support
Date: Wed, 19 Nov 2014 15:32:27 +0530
Message-ID: <20141119100226.GA24518@intel-desktop>
References: <20141118054537.GA28516@intel-desktop>
 <CAKohpokVi-6+mwhm6qqWCbjnNmm0L-3=6hezYBNg2zoE=ov=5Q@mail.gmail.com>
 <20141118172130.GA29590@intel-desktop>
 <CAKohpo=hveN_pcmNHz4G2dGRM4u+ZSZEUTBgOTUzTqK-SPW-wQ@mail.gmail.com>
 <20141119094536.GA24181@intel-desktop>
 <CAKohpon=Yjdbn5VKCP3uN0v+EDRGg1SBX6+kUtnftg5Hww04cA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:35786 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753125AbaKSKCG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 19 Nov 2014 05:02:06 -0500
Content-Disposition: inline
In-Reply-To: <CAKohpon=Yjdbn5VKCP3uN0v+EDRGg1SBX6+kUtnftg5Hww04cA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rudramuni, Vishwesh M" <vishwesh.m.rudramuni@intel.com>, Len Brown <lenb@kernel.org>

On Wed, Nov 19, 2014 at 03:17:54PM +0530, Viresh Kumar wrote:
> On 19 November 2014 15:15, Kasagar, Srinidhi <srinidhi.kasagar@intel.com> wrote:
> > The architecture supports both, and the current code allows me
> > to change the freq independently and that's why the above
> > output lines.
> 
> Which part of the code exactly controls this ?
That's the default behavior and I need not have to control it.
What I did wrong was to report the output of out-of-my-tree kernel
which leads to this confusion..

Srinidhi
