From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC/PATCH 2/2] driver core: power management
	debugging
Date: Fri, 27 Apr 2007 14:37:51 +0200
Message-ID: <20070427123751.GG22250@elf.ucw.cz>
References: <Pine.LNX.4.64.0704271525071.11149@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0704271525071.11149@sbz-30.cs.Helsinki.FI>
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

Hi!

> Add power management related debugging into driver core. Make the
> kernel complain if a device driver lacks bus and class support for
> resume or if a PCI or USB driver does not have a driver specific
> resume function.
> 
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>

Looks ok to me. Probably should go to Greg.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
