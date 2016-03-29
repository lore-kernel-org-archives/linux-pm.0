From: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V8 00/14] Add T210 support in Tegra soctherm
Date: Mon, 28 Mar 2016 20:04:41 -0700
Message-ID: <20160329030440.GA2315@localhost.localdomain>
References: <1458118571-29717-1-git-send-email-wni@nvidia.com>
 <56F4CE8D.5020108@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56F4CE8D.5020108-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, mikko.perttunen-/1wQRMveznE@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 25, 2016 at 01:37:17PM +0800, Wei Ni wrote:
> Hi, Eduardo
> Will you take this series, it seems no more comments.

Yeah, I am taking a look at it. Something is fishy about it. Patch 04
does not apply cleanly. Also, why did you split the patches into two
email threads, one which is 1-4 and another one is 5-14?

I have ammended patch 04 at my side, but you need to validate your
series is one piece (please check my tree and linux-next).

BR,

Eduardo Valentin

> 
