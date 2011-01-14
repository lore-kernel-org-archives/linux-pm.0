From: "Bojan Smojver" <bojan@rexursive.com>
Subject: Re: Oops while going into hibernate
Date: Sat, 15 Jan 2011 00:14:10 +1100
Message-ID: <4204848083.979517650__49702.8744699948$1295010946$gmane$org@rexursive.com>
References: <alpine.LFD.2.02.1101121443230.1900@localhost6.localdomain6>
	<20110112162655.GA13496@thunk.org>
	<alpine.LFD.2.02.1101121755400.2011@localhost6.localdomain6>
	<20110112172646.GB13496@thunk.org>
	<alpine.LFD.2.02.1101121934060.2011@localhost6.localdomain6>
	<A01161D0-D08F-4522-A546-90057B2E1F2A@mit.edu>
	<alpine.LFD.2.02.1101131238480.1899@localhost6.localdomain6>
	<20110113133612.GD2534@osiris.boeblingen.de.ibm.com>
	<20110113184626.GA31800@thunk.org>
	<1294954212.2781.8.camel@shrek.rexursive.com>
	<20110114095321.GA2696@osiris.boeblingen.de.ibm.com>
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
To: heiko.carstens@de.ibm.com
Cc: linux-pm@lists.linux-foundation.org, linux-ext4@vger.kernel.org, tytso@mit.edu, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

> However since s390 is the only architecture which has dirty bits for
> physical pages I doubt that there is any such code present. So the
> bug should happen independently of image compression.

Ah, sorry - I wasn't clear there. I meant for other archs, where setting 
the dirty bit on read may matter when compression is off.

Obviously, s390 will have to have its own problem fixed separately.

--
Bojan 
