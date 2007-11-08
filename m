From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH (2.6.25) 1/2] hibernation: clean up Kconfig
Date: Thu, 8 Nov 2007 10:06:18 -0800
Message-ID: <20071108100618.40e6c0af.akpm__23047.2611649477$1194545340$gmane$org@linux-foundation.org>
References: <20071107135758.100171000@sipsolutions.net>
	<200711072317.48023.rjw@sisk.pl>
	<1194533053.6294.42.camel@johannes.berg>
	<20071108092149.e27c5ba3.akpm@linux-foundation.org>
	<1194543003.4793.19.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1194543003.4793.19.camel@johannes.berg>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

> On Thu, 08 Nov 2007 18:30:03 +0100 Johannes Berg <johannes@sipsolutions.net> wrote:
> This cleans up the hibernation Kconfig and removes the need to
> declare centrally which architectures support hibernation. All
> architectures that currently support hibernation are modified
> accordingly.
> 
> ...
>
>  arch/powerpc/Kconfig |   14 ++++++++++++--
>  arch/x86_64/Kconfig  |    3 +++
>  kernel/power/Kconfig |   18 +++---------------

I assume this was against 2.6.23.  Please, it's not very useful to prepare
patches against such an old kernel.  Even if the receiver were to fix te
patch up, there isn't much confidence that it will actually work at
compile-time and runtime.
