From: "Bojan Smojver" <bojan@rexursive.com>
Subject: Re: Oops while going into hibernate
Date: Thu, 13 Jan 2011 23:11:45 +1100
Message-ID: <6009472527.979427505__37471.1502380252$1294920764$gmane$org@rexursive.com>
References: <alpine.LFD.2.02.1101121443230.1900@localhost6.localdomain6>
	<20110112162655.GA13496@thunk.org>
	<alpine.LFD.2.02.1101121755400.2011@localhost6.localdomain6>
	<20110112172646.GB13496@thunk.org>
	<alpine.LFD.2.02.1101121934060.2011@localhost6.localdomain6>
	<A01161D0-D08F-4522-A546-90057B2E1F2A@mit.edu>
	<alpine.LFD.2.02.1101131238480.1899@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: sebott@linux.vnet.ibm.com
Cc: linux-pm@lists.linux-foundation.org, linux-ext4@vger.kernel.org, tytso@mit.edu, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

> Yes. I basically did a
> echo reboot > /sys/power/disk
> for i in {1..5} ;do echo disk > /sys/power/state ;done
> and it crashed very early in the second suspend.

Was compression on or off?

--
Bojan 
