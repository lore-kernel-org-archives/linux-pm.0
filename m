From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH v2 0/8] RFC: CPU frequency min/max as PM QoS params
Date: Thu, 19 Jan 2012 23:40:24 +0100
Message-ID: <201201192340.24503.rjw@sisk.pl>
References: <1326697201-32406-1-git-send-email-amiettinen@nvidia.com> <201201190024.27022.rjw@sisk.pl> <871uqwqja2.fsf@amiettinen-lnx.nvidia.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <871uqwqja2.fsf@amiettinen-lnx.nvidia.com>
Sender: cpufreq-owner@vger.kernel.org
To: Antti P Miettinen <amiettinen@nvidia.com>
Cc: linux-pm@lists.linux-foundation.org, cpufreq@vger.kernel.org, markgross@thegnar.org
List-Id: linux-pm@vger.kernel.org

On Thursday, January 19, 2012, Antti P Miettinen wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> [..]
> > Perhaps we need a new cpufreq governor that would take use PM QoS internally
> > to store requests from different sources, but that would work on a per-CPU
> > basis (not globally) and would provide a new interface for user space?
> >
> > Rafael
> 
> I think it would be nice if the choice of governor could be independent
> of the constraints. Also, implementing the constraints in the cpufreq
> core is easier than in governors.

Well, while it might be easier, the _whole_ _point_ of governors is to make
decisions on the basis of available data.  By introducing an independent
mechanism for that we're bypassing governors in a sense.

Thanks,
Rafael
