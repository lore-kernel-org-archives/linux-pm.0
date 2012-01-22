From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH v2 0/8] RFC: CPU frequency min/max as PM QoS params
Date: Mon, 23 Jan 2012 00:43:46 +0100
Message-ID: <201201230043.46436.rjw@sisk.pl>
References: <1326697201-32406-1-git-send-email-amiettinen@nvidia.com> <201201192315.22590.rjw@sisk.pl> <87d3acf2jh.fsf@amiettinen-lnx.nvidia.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <87d3acf2jh.fsf@amiettinen-lnx.nvidia.com>
Sender: cpufreq-owner@vger.kernel.org
To: Antti P Miettinen <amiettinen@nvidia.com>
Cc: linux-pm@lists.linux-foundation.org, cpufreq@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sunday, January 22, 2012, Antti P Miettinen wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> > On Thursday, January 19, 2012, Antti P Miettinen wrote:
> >> I think we need both, global and per cpu.
> >
> > Well, if we have that per CPU, it will be easy to create a global
> > setting: set all of the per-CPU settings to the same values. :-)
> 
> That is true. Currently the device specific constraints do not have user
> space interface. The pm_qos_interface.txt refers to ongoing
> discussion. Is there a thread I should read?
> 
> Seems that the device specific constraints are not yet in use in
> 3.3-rc1, or am I not looking hard enough?

They are in use through generic PM domains (drivers/base/power/domain*.c
and friends) and ARM/shmobile uses those.

Thanks,
Rafael
