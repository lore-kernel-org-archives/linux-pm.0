From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH v2 0/8] RFC: CPU frequency min/max as PM QoS params
Date: Thu, 19 Jan 2012 23:15:22 +0100
Message-ID: <201201192315.22590.rjw@sisk.pl>
References: <1326697201-32406-1-git-send-email-amiettinen@nvidia.com> <20120119164144.GA8757@mgross-G62> <87y5t35v96.fsf@amiettinen-lnx.nvidia.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <87y5t35v96.fsf@amiettinen-lnx.nvidia.com>
Sender: cpufreq-owner@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: Antti P Miettinen <amiettinen@nvidia.com>, cpufreq@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday, January 19, 2012, Antti P Miettinen wrote:
> mark gross <markgross@thegnar.org> writes:
> > Hmm, your right this patch set is global in its request and not
> > "per-cpu".  I need to think on that.  Making it per-cpu would likely
> > infer we need to make the qos request per cpu as well.  
> 
> I think we need both, global and per cpu.

Well, if we have that per CPU, it will be easy to create a global
setting: set all of the per-CPU settings to the same values. :-)

Thanks,
Rafael
