From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] cpufreq: Avoid attempts to create duplicate symbolic links
Date: Wed, 29 Jul 2015 03:38:03 +0200
Message-ID: <2112385.YuDJ7h1x56@vostro.rjw.lan>
References: <1660815.CyKx9SEI9c@vostro.rjw.lan> <4080510.IQ60sVQvbL@vostro.rjw.lan> <20150727143935.GB18535@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150727143935.GB18535@linux>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

On Monday, July 27, 2015 08:09:35 PM Viresh Kumar wrote:
> On 27-07-15, 15:45, Rafael J. Wysocki wrote:
> > Say the subsys add callback runs for a CPU and it doesn't have a policy.
> > If it is offline, we ignore it and the add callback won't be executed
> > for it again.
> > 
> > In turn, if it is online, we create a policy for it and we should (right
> > away) link the policy to all of the CPUs that were offline when the subsys add
> > callback was called for them.  That's what we do today.
> > 
> > Is there anything missing in that?
> 
> So the code is working properly after your patch, but I was talking
> on the lines of what Russell suggested.
> 
> We should play with the links only when we receive add-dev/remove-dev
> from subsys callbacks. The exception to that will be the offline CPUs
> for which add-dev is called before their policy existed.

The rule is supposed to be "all of the present CPUs which do not own
a policy should point to one, unless it doesn't exist".  The right
approach is then to create links from them to a policy object as soon
as we create one for them.  Waiting for something else to happen is just
pointless and this approach covers both the offline and online CPUs, so
I don't think that changing it would improve things really.

Thanks,
Rafael
