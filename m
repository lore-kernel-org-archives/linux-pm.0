From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [RFP] LPC thermal track
Date: Mon, 30 Mar 2015 15:37:40 -0700
Message-ID: <1427755060.26322.40.camel@spandruv-DESK3.jf.intel.com>
References: <20150327000245.GA29752@developer.hsd1.ca.comcast.net>
	 <55154361.90302@arm.com>
	 <1427742677.23036.145.camel@spandruv-DESK3.jf.intel.com>
	 <20150330205057.GA5545@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:65001 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752839AbbC3WjV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 30 Mar 2015 18:39:21 -0400
In-Reply-To: <20150330205057.GA5545@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, Rui Zhang <rui.zhang@intel.com>, Javi Merino <Javi.Merino@arm.com>, "cyndis@lakka.kapsi.fi" <cyndis@lakka.kapsi.fi>, Kapileshwar Singh <Kapileshwar.Singh@arm.com>, "l.majewski@samsung.com" <l.majewski@samsung.com>, "geert+renesas@glider.be" <geert+renesas@glider.be>, "wxt@rock-chips.com" <wxt@rock-chips.com>, Punit Agrawal <punit.agrawal@arm.com>

On Mon, 2015-03-30 at 13:51 -0700, Eduardo Valentin wrote:
Hi Eduardo,

> Hey Srinivas,
> 
> On Mon, Mar 30, 2015 at 12:11:17PM -0700, Srinivas Pandruvada wrote:
> > On Fri, 2015-03-27 at 11:47 +0000, Punit Agrawal wrote: 
> > > Hi Eduardo,
> > > 
> > > Thanks for proposing a thermal micro-conference. It would be good to 
> > > discuss the direction things are heading with regards to thermal in linux.
> > > 
> > > On 27/03/15 00:02, Eduardo Valentin wrote:
> > > > Hello all,
> > > >
> > > > I've created a proposal for a thermal microconference track on the LPC
> > > > 2015 [1]. The basic idea is to get thermal developers together and
> > > > discuss the thermal role within the Linux environment, from kernel and
> > > > userspace perspective.
> > > >
> > > > A initial proposal for the topics to be discussed are:
> > > > . Closed loop control governors
> > > > . Sensor API
> > > > . Thermal class: split of temperature sensor device and thermal driver
> > > > . Improvements on OF-thermal
> > > > . Devfreq vs. clock cooling
> > > > . Power model based policies
> > > > . User space tools
> > > > . User space governors
> > > >
> > > > If you have interest, or if you have ideas on how to improve the
> > > > framework, reply to this email and add it to the wiki.
> > What about
> > Some enhancement in thermal zone user space I/F for user space thermal
> > controllers
> > - Better support for virtual temperature sensors which depends on other
> > sensors. 
> > - Support for Linux IIO style scale and offset in thermal zone
> > temperature calculation.
> > - /dev interface for pushing thermal samples instead of raw read of
> > temperature to improve performances and push sample instead of pull from
> > user space.
> 
> Can you please add these topics to the wiki?
I will. 
> 
> Would you be able to attend LPC and give a talk about your thoughts?
Yes.

Thanks,
Srinivas 
> 
> BR,
> 
> Eduardo Valentin
> 
> > 
> > Thanks,
> > Srinivas 
> > > >
> > > 
> > > I'd like to propose -
> > > 
> > > . Co-ordination among cooling-devices in the system
> > > 
> > > In workloads that involve multiple devices such as camera+CPUs+image 
> > > singal processor or camera+video encoding, etc. often there are 
> > > dependencies across multiple devices' performance states to achieve 
> > > minimum acceptable performance (24fps HD encode for example). When 
> > > thermally constrained it would help to have some mechanisms to 
> > > co-ordinate their performance control. The power allocator governor 
> > > attempts to solve some of these problems but it would be good to have a 
> > > wider discussion on enabling more scenarios.
> > > 
> > > 
> > > > Add your name in the list of participants as well. Also, if you feel
> > > > like giving a talk on the topic, let's add it to the topic list.
> > > >
> > > 
> > > Done.
> > > 
> > > Cheers,
> > > Punit
> > > 
> > > > Currently I am simple checking what would be the level of interest to
> > > > have this topic as a LPC microconference.
> > > >
> > > > BR,
> > > >
> > > > Eduardo Valentin
> > > >
> > > >
> > > > [1] - http://wiki.linuxplumbersconf.org/2015:thermal
> > > >
> > > 
> > 
> > 


