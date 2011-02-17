From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Still having problems with Suspend-To-Ram an Intel
 Atom D525
Date: Thu, 17 Feb 2011 10:16:07 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1102171012020.2153-100000@iolanthe.rowland.org>
References: <4D5C1C61.7000200@rwth-aachen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4D5C1C61.7000200@rwth-aachen.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm.20.masuefke@spamgourmet.com
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 16 Feb 2011 linux-pm.20.masuefke@spamgourmet.com wrote:

> Hello,
> 
> I still have no success suspending my Intel Atom D525 (with the NM10
> chipset) to ram.
> 
> Suspend to ram does not work at all, suspend to disk works.
> 
> Please see the mailing list thread from 20Dec2011 for a detailed problem 
> description:
> https://lists.linux-foundation.org/pipermail/linux-pm/2010-December/thread.html#29654
> and the screenshots on http://www-users.rwth-aachen.de/martin.suefke/s2ram/
> 
> I re-tested now with 2.6.38-rc4 and 2.6.22 (git pulls from Linus 
> Torvald's kernel tree) in a desperate attempt to find any working
> version, so I could maybe try to pin down the problem by git-bisect.
> However, also with 2.6.22 and 2.6.38-rc4 suspend to ram does not work.
> 
> The configurations for these kernels were made with 'make oldconfig'
> from this configuration:
> http://www-users.rwth-aachen.de/martin.suefke/s2ram/Kernel_config_2.6.37-rc6
> 
> If anybody has any clue, hint, suggestion or questions regarding the
> issue, please drop me a note.

I don't have any ideas about debugging this, but I do have an idea
about where you might get more help.  Post a message to LKML, and don't
describe it as a suspend problem.  Instead, describe it as a problem
enabling CPU cores after the system has gone through a suspend/resume
cycle.  This may help attract the attention of people who are familiar
with the issues involved in enabling and disabling CPUs -- which 
appears to be the source of your difficulties.

Alan Stern
