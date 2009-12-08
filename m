From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Async resume patch (was: Re: [GIT PULL] PM updates
	for 2.6.33)
Date: Tue, 8 Dec 2009 07:35:27 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912080728590.3560__49047.7787134752$1260286597$gmane$org@localhost.localdomain>
References: <Pine.LNX.4.44L0.0912072225390.4179-100000@netrider.rowland.org>
	<200912081323.50606.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912081323.50606.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org



On Tue, 8 Dec 2009, Rafael J. Wysocki wrote:
> 
> The wait queue plus the op_complete flag combo plays the role of the locking
> in the Linus' picture

Please just use the lock. Don't make up your own locking crap. Really. 

Your patch is horrible. Exactly because your locking is horribly 
mis-designed. You can't say things are complete from an interrupt, for 
example, since you made it some random bitfield, which has unknown 
characteristics (ie non-atomic read-modify-write etc).

The fact is, any time anybody makes up a new locking mechanism, THEY 
ALWAYS GET IT WRONG. Don't do it.

I suggested using the rwsem locking for a good reason. It made sense. It 
was simpler. Just do it that way, stop making up crap.

		Linus
