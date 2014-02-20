From: Dirk Brandewie <dirk.brandewie@gmail.com>
Subject: Re: Commit fcb6a15c2e7e (intel_pstate: Take core C0 time into account
 for core busy calculation) sucks rocks
Date: Wed, 19 Feb 2014 16:03:40 -0800
Message-ID: <5305465C.7060806@gmail.com>
References: <20140219224752.GA370@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20140219224752.GA370@kroah.com>
Sender: cpufreq-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: dirk.brandewie@gmail.com, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 02/19/2014 02:47 PM, Greg KH wrote:
> Hi Dirk,
>
> I've been having some huge slowdowns on my box building kernels, and I
> took the time to bisect it down to commit
> fcb6a15c2e7e76d493e6f91ea889ab40e1c643a4 (intel_pstate: Take core C0
> time into account for core busy calculation).  With that patch reverted
> on Linus's current tree, my build speeds are back up to the normal rate.
>
> The difference is huge, 2 minutes to do a kernel build with that patch
> reverted, 8-10 minutes with it applied!  With all of the stable kernel
> builds and other trees, this is a huge problem for my workload (all I do
> is kernel builds it seems...)
>
> I see some patches you marked as "fixes" that you sent to Rafael, do you
> want me to test any of those?  How am I the only one seeing this
> problem, do you need my cpu information or anything else?

Can you give me a description of you build system?  CPU, number of sockets,
building from/to local media.  Any special setup I should use here for my test?

If you have time having the output of turbostat for a build with and
without would be very useful.

On my single socket Sandybridge test system I don't see any difference.
I tested against v3.10.30, v3.12.11 and v3.13.3

>
> Oh, and because of the problems, I'll just drop this patch from the
> -stable trees for now, I don't want to pollute them with the issue until
> it is resolved properly.
>


> thanks,
>
> greg k-h
> --
> To unsubscribe from this list: send the line "unsubscribe cpufreq" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

