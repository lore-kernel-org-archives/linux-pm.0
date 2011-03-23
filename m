From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 9/10] sh: Use struct syscore_ops instead of
	sysdev	class and sysdev
Date: Wed, 23 Mar 2011 09:45:58 +0000
Message-ID: <20110323094557.GA3040__36361.6147348241$1300873765$gmane$org@n2100.arm.linux.org.uk>
References: <201103100131.58206.rjw@sisk.pl>
	<20110322214922.GA7503@linux-sh.org>
	<1300831256.1815.22.camel@zag> <201103222323.42627.rjw@sisk.pl>
	<1300833843.1815.53.camel@zag>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1300833843.1815.53.camel@zag>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kay Sievers <kay.sievers@suse.de>
Cc: linux-sh@vger.kernel.org, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 22, 2011 at 11:44:03PM +0100, Kay Sievers wrote:
> When we started to clean up /sys (again only talking about devices, not
> other stuff) we had:
>   /block/*
>   /class/<subsys>/*
>   /bus/<subsys>/devices/*
>   /devices/system/<subsys>/*
> which are 4 different exports of exactly the same thing, a "device".
> "Block" we converted to "class" already, "class" will be converted to
> "bus", and "bus" will be renamed to "subsystem". All the current names
> will be kept as compat symlinks, just as we did for "block".

I bet userspace will end up failing with that and need updating yet
again, inspite of the symlinks.

While Linus complains about the churn in the ARM subtree, I'd like to
officially complain about the pointless churn in sysfs which actively
breaks (and sometimes prevents) userspace booting when you upgrade
kernels.
