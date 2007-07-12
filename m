From: jimmy bahuleyan <knight.camelot@gmail.com>
Subject: Re: [PATCH 0/2] Kexec jump: The first step to kexec base
	hibernation
Date: Thu, 12 Jul 2007 18:52:24 +0530
Message-ID: <46962B10.3040909__9011.5844541744$1184246608$gmane$org@gmail.com>
References: <1184167831.12556.13.camel@caritas-dev.intel.com>
	<1184260683.9346.91.camel@caritas-dev.intel.com>
	<Pine.LNX.4.64.0707120247230.25614@asgard.lang.hm>
	<200707121501.03016.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707121501.03016.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: david@lang.hm, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:
[snip]
> 
> So if a user wants to install a kernel.org kernel on his system, (s)he'll have
> to compile and install two kernels with different options.
> 
> That doesn't sound good to me. :-)
> 

definitely. that sounds kind of strange, not to think of having to
remember which kernel to choose on booting.

would it be possible to have the same kernel (or image) act as both
kernel 'a' & 'b', kind of like operating in two different modes.

the kexec-style-hibernate does sound more appealing though..

> Greetings,
> Rafael

-jb
-- 
Tact is the art of making a point without making an enemy.
