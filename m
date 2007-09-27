From: "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [RFC][PATCH 1/2 -mm] kexec based hibernation -v3:
	kexec jump
Date: Thu, 27 Sep 2007 14:33:54 +0800
Message-ID: <1190874834.21818.300.camel__1309.24887857891$1190874897$gmane$org@caritas-dev.intel.com>
References: <1190266447.21818.17.camel@caritas-dev.intel.com>
	<200709211225.25874.nigel@nigel.suspend2.net>
	<1190342757.21818.75.camel@caritas-dev.intel.com>
	<200709211259.00195.nigel@nigel.suspend2.net>
	<m1r6ksiq27.fsf@ebiederm.dsl.xmission.com>
	<20070921094512.GA20149@elf.ucw.cz>
	<20070926203036.GF31759@nineveh.local>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070926203036.GF31759@nineveh.local>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Joseph Fannin <jfannin@gmail.com>
Cc: nigel@suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Wed, 2007-09-26 at 16:30 -0400, Joseph Fannin wrote:
>     But, in my ignorance, I'm not sure even fixing the ext3 bug will
> guarantee you consistent metadata so that you can handle a
> swap/hibernate file.  You can do a sync(), but how do you make that
> not race against running processes without the freezer, or blkdev
> snapshots?
> 
>     I guess uswsusp and the-patch-previously-known-as-suspend2 handle
> this somehow, though.

The image-writing kernel of kexec based hibernation run in a controlled
way. It is not used by normal user, so only really necessary process
need to be run. For example, it is possible that there is only one user
process -- the image-writing process running in image-writing kernel.
So, no freezer or blkdev snapshot is needed.

Best Regards,
Huang Ying
