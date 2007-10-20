From: david@lang.hm
Subject: Re: [PATCH 0/2 -mm] kexec based hibernation -v5
Date: Fri, 19 Oct 2007 18:53:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0710191852560.1538__6528.26415976069$1192845038$gmane$org@asgard.lang.hm>
References: <1192068833.27482.13.camel@caritas-dev.intel.com>
	<47190B28.6070405@cfl.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <47190B28.6070405@cfl.rr.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Phillip Susi <psusi@cfl.rr.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Fri, 19 Oct 2007, Phillip Susi wrote:

> Huang, Ying wrote:
>> 
>> 
>> The restore process with the patch set is as follow:
>> 
>> 1. Boot a kernel C (crash dump enabled), the memory area used by
>>    kernel C must be a subset of memory area used by kernel B.
>
> Why is a third kernel needed?  Why can't kernel B be used for this as well? 
> In fact, if kernel A has been compiled to be relocatable and crash dump 
> enabled, why wouldn't it suffice for all 3 instances?

you could use one kernel for all three, or you could use three different 
kernels, and three different sets of userspace if it's appropriate.

David Lang
