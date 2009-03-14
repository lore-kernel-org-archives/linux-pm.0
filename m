From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH][0/8] PM: Rework suspend-resume ordering
	to avoid problems with shared interrupts
Date: Sat, 14 Mar 2009 23:31:26 +0100
Message-ID: <200903142331.27304.rjw__40458.5650693209$1237070195$gmane$org@sisk.pl>
References: <200902221837.49396.rjw@sisk.pl> <200903141259.02164.rjw@sisk.pl>
	<200903141511.58455.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200903141511.58455.elendil@planet.nl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Frans Pop <elendil@planet.nl>
Cc: linux-pm@lists.linux-foundation.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Saturday 14 March 2009, Frans Pop wrote:
> On Saturday 14 March 2009, you wrote:
> > Could you please also test the last iteration of the $subject patch
> > series (just sent) with the appended patch applied on top and post
> > dmesg output?
> 
> Here you are:
> - boot
> - STR with wireless networking
> - STD with wireless networking
> - STR with wired networking and killswitch on wireless
> 
> No problems seen :-)

Great, thanks for the log, it looks correct.

Best,
Rafael
