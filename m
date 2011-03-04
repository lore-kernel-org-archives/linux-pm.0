From: Vasiliy Kulikov <segoon@openwall.com>
Subject: Re: [Security] [PATCH] power: disable hibernation if
 module loading is disabled
Date: Sat, 5 Mar 2011 00:51:20 +0300
Message-ID: <20110304215118.GA30253__14597.2706647173$1299275663$gmane$org@albatros>
References: <1299255084-4390-1-git-send-email-segoon@openwall.com>
	<20110304212709.GA28680@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110304212709.GA28680@kroah.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Greg KH <greg@kroah.com>
Cc: Len Brown <len.brown@intel.com>, security@kernel.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 04, 2011 at 13:27 -0800, Greg KH wrote:
> On Fri, Mar 04, 2011 at 07:11:24PM +0300, Vasiliy Kulikov wrote:
> > If /proc/sys/kernel/modules_disabled is set to 1, then nobody (even full
> > root) may not read/write arbitrary kernel memory.  In spite of it,
> > hibernation allows anyone with an access to either /dev/snapshot or
> > /sys/power/ make the full snapshot of the system.  This snapshot may be
> > freely changed and uploaded back.
> 
> This sounds like a very unintentional change to the "don't load any
> modules" option, right?  If so, you should really document this
> somewhere, otherwise people are going to get very confused when their
> system suspends suddenly stop working for no obvious reason.

Agreed, thank you.  Is Documentation/sysctl/kernel.txt an appropriate
place?

-- 
Vasiliy Kulikov
http://www.openwall.com - bringing security into open computing environments
