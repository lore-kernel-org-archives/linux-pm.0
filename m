From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: 2.6.37-rc5, pata_atiixp,
 DVD-ROM: kernel log flooded with "rpm_resume flags 0x4",
 "rpm_resume returns 1"
Date: Sat, 18 Dec 2010 20:08:37 +0100
Message-ID: <20101218200837.03a23f62__30978.623397141$1292699377$gmane$org@stein>
References: <20101217211556.2789cb80@stein>
	<Pine.LNX.4.44L0.1012181259080.3334-100000@saphir.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1012181259080.3334-100000@saphir.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-ide@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Dec 18 Alan Stern wrote:
> On Fri, 17 Dec 2010, Stefan Richter wrote:
> > On Dec 11 Rafael J. Wysocki wrote:
> > > I guess you have either CONFIG_PM_VERBOSE set or CONFIG_PM_DEBUG unset.
> > > 
> > > Which is the case?
> > 
> > I have both options off on 2.6.36 and older kernels.  I have both
> > options on on 2.6.37-rc5/-rc6 (because I wanted to check something
> > unrelated on 2.6.37).
> 
> These messages are produced by dev_dbg() calls.  The debug output is 
> enabled by either CONFIG_PM_VERBOSE or CONFIG_DEBUG_DRIVER.  Since you say 
> CONFIG_PM_VERBOSE is off, the other must be on -- unless maybe you have 
> CONFIG_DYNAMIC_DEBUG enabled.

No, CONFIG_PM_VERBOSE is of course _on_ in the kernel that spams the
log.  It is off in the older kernel that does not spam the log.
-- 
Stefan Richter
-=====-==-=- ==-- =--=-
http://arcgraph.de/sr/
