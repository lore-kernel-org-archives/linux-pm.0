From: Bojan Smojver <bojan@rexursive.com>
Subject: Re: Oops while going into hibernate
Date: Fri, 14 Jan 2011 08:30:12 +1100
Message-ID: <1294954212.2781.8.camel__12085.6641130105$1294957188$gmane$org@shrek.rexursive.com>
References: <alpine.LFD.2.02.1101121443230.1900@localhost6.localdomain6>
	<20110112162655.GA13496@thunk.org>
	<alpine.LFD.2.02.1101121755400.2011@localhost6.localdomain6>
	<20110112172646.GB13496@thunk.org>
	<alpine.LFD.2.02.1101121934060.2011@localhost6.localdomain6>
	<A01161D0-D08F-4522-A546-90057B2E1F2A@mit.edu>
	<alpine.LFD.2.02.1101131238480.1899@localhost6.localdomain6>
	<20110113133612.GD2534@osiris.boeblingen.de.ibm.com>
	<20110113184626.GA31800@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110113184626.GA31800@thunk.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ted Ts'o <tytso@mit.edu>
Cc: pm list <linux-pm@lists.linux-foundation.org>, "linux-ext4@vger.kernel.org
	development" <linux-ext4@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, LKML Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 2011-01-13 at 13:46 -0500, Ted Ts'o wrote:
> I'm still a bit concerned with the call to set the pages' PTE to be
> dirty that I found in the hibernate code, but I accept the fact that
> removing it doesn't solve the s390 crash.  It still seems wrong to me,
> and hopefully someone from linux-pm can look at that more closely. 

If I'm understanding things correctly, this should affect only the
situation when compression is not used. Otherwise, pages that are read
into by block I/O are decompressed first and copied into different
pages. No?

-- 
Bojan
