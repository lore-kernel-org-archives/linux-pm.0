From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 5/9] PM: suspend_block: Add debugfs file
Date: Sun, 25 Apr 2010 21:39:12 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1004252137480.1524-100000__7109.84169641069$1272246015$gmane$org@netrider.rowland.org>
References: <4BD4DCEA.8060602@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4BD4DCEA.8060602@oracle.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Len Brown <len.brown@intel.com>, tytso@mit.edu, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sun, 25 Apr 2010, Randy Dunlap wrote:

> > Well, I'll note right now we have a somewhat annoying gap.  If you
> > need to export multiple values such that they are consistent with each
> > other, what's the choice?  /proc, where some (but not all) kernel
> > developers will say, "eeeeeeviilllll".  /sys is explicitly for single
> > value per files only.  And then we have /debugfs, where some pendants
> > are kvetching about whether something is "really" debug information.
> 
> First of all, I am not a pendant.

Are you sure about that?  At the moment, Arve may feel that you're 
hanging around his neck (although perhaps not looking very pretty!).
:-)

Alan Stern
