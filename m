From: Dave Jones <davej@codemonkey.org.uk>
Subject: Re: [PATCH] cpuidle: avoid singing capacitors
Date: Mon, 3 Mar 2008 23:00:48 -0500
Message-ID: <20080304040048.GA31562__13662.0205747478$1204603509$gmane$org@codemonkey.org.uk>
References: <924EFEDD5F540B4284297C4DC59F3DEEA2E8B2@orsmsx423.amr.corp.intel.com>
	<Pine.LNX.4.44L0.0803031804330.8280-100000@iolanthe.rowland.org>
	<20080303231033.GB15255@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080303231033.GB15255@one.firstfloor.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andi Kleen <andi@firstfloor.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Adam Belay <abelay@novell.com>, Lee Revell <rlrevell@joe-job.com>, Pierre Ossman <drzeus-list@drzeus.cx>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 04, 2008 at 12:10:33AM +0100, Andi Kleen wrote:
 > On Mon, Mar 03, 2008 at 06:05:35PM -0500, Alan Stern wrote:
 > > On Mon, 3 Mar 2008, Pallipadi, Venkatesh wrote:
 > > 
 > > > But, with this patch:
 > > > - we are penalizing good hardware and making them less power efficient
 > > > to match the bad ones.
 > > > - There may also be server systems which first may not have these sort
 > > > of power fluctuations and even when buggy and have this noise, system
 > > > may be in some corner of some lab with fans making more noise than the
 > > > capacitors.
 > > 
 > > Can you make it configurable through sysfs?  
 > 
 > It already is, through a writable module_parm() 
 > 
 > > Default to disabled, but 
 > > allow the user to turn it on if the machine makes too much noise.
 > 
 > 99+% of the users wouldn't be able to figure that out.

99+% of users don't have singing capacitors. (Or don't care enough to complain)
For those that do can't figure out what to do from google,
we have a documentation problem.

	Dave 

-- 
http://www.codemonkey.org.uk
