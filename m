From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 23/37] Suspend: Clean up Kconfig (V2)
Date: Mon, 4 Feb 2008 14:59:32 +0000
Message-ID: <20080204145932.GA8004__12485.7008377605$1202137425$gmane$org@ucw.cz>
References: <edae89f5d1eb1fbe1cab74333db5a8e29776900e.1201840183.git.len.brown@intel.com>
	<9a72d19a83ff28dd65eae54e210a9141ad993e88.1201840183.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <9a72d19a83ff28dd65eae54e210a9141ad993e88.1201840183.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu 2008-01-31 23:36:54, Len Brown wrote:
> From: Johannes Berg <johannes@sipsolutions.net>
> 
> This cleans up the suspend Kconfig and removes the need to
> declare centrally which architectures support suspend. All
> architectures that currently support suspend are modified
> accordingly.
> 
> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> Acked-by: Russell King <rmk@arm.linux.org.uk>
> Acked-by: Paul Mackerras <paulus@samba.org>
> Acked-by: Ralf Baechle <ralf@linux-mips.org>
> Acked-by: Paul Mundt <lethal@linux-sh.org>
> Cc: Pavel Machek <pavel@suse.cz>

ACK.
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
