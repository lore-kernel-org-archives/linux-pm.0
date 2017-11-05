From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: Request to add cpupower git to linux-next
Date: Sun, 5 Nov 2017 13:10:22 +1100
Message-ID: <20171105131022.401a880a@canb.auug.org.au>
References: <72704c6e-fefd-74a0-74b3-3ebe862df1ba@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:59513 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751508AbdKECKZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 4 Nov 2017 22:10:25 -0400
In-Reply-To: <72704c6e-fefd-74a0-74b3-3ebe862df1ba@osg.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shuah Khan <shuahkh@osg.samsung.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Hi Shuah,

On Fri, 3 Nov 2017 10:26:58 -0600 Shuah Khan <shuahkh@osg.samsung.com> wrote:
>
> Could you please add
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git cpupower
> to linux-next
> 
> I will be sending pull requests to Rafael Wysocki for cpupower to be
> included in linux-pm starting soon for 4.15 release.

Added from tomorrow.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window. 

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and 
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

-- 
Cheers,
Stephen Rothwell 
sfr@canb.auug.org.au
