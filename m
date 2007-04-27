From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC/PATCH 1/2] swsusp: preserve boot-time printk
	output after resume
Date: Fri, 27 Apr 2007 14:57:34 +0200
Message-ID: <20070427125734.GK22250@elf.ucw.cz>
References: <Pine.LNX.4.64.0704271522070.11149@sbz-30.cs.Helsinki.FI>
	<20070427123615.GF22250@elf.ucw.cz>
	<Pine.LNX.4.64.0704271551250.12688@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0704271551250.12688@sbz-30.cs.Helsinki.FI>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pekka J Enberg <penberg@cs.helsinki.fi>
Cc: nigel@nigel.suspend2.net, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Fri 2007-04-27 15:52:12, Pekka J Enberg wrote:
> On Fri, 27 Apr 2007, Pavel Machek wrote:
> > 1. This should not be a config option
> 
> Ok.

Unfortunately, we loose dmesg from the state saving this way, so I do
not think it can be hardcoded, either. Best way would be to somehow
preserve both dmesg buffers.

Other way is to just control it by the define in the .c file; person
using this is by definition kernel hacker, anyway. Or this can simply
live like debugging patch, interested parties can apply.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
