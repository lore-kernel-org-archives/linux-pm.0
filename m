From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/3] xen: Use PM/Hibernate events for
	save/restore/chkpt
Date: Sun, 20 Feb 2011 08:49:31 +0100
Message-ID: <20110220074931.GA28485__24529.4578526684$1298188341$gmane$org@elf.ucw.cz>
References: <1298157158-5421-1-git-send-email-rshriram@cs.ubc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1298157158-5421-1-git-send-email-rshriram@cs.ubc.ca>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Shriram Rajagopalan <rshriram@cs.ubc.ca>
Cc: linux-pm@lists.linux-foundation.org, xen-devel@lists.xensource.com, Iam Campbell <ian.campbell@citrix.com>
List-Id: linux-pm@vger.kernel.org

On Sat 2011-02-19 15:12:35, Shriram Rajagopalan wrote:
> The current implementation of xen guest save/restore/checkpoint functionality
> uses PM_SUSPEND and PM_RESUME events. This is not optimal when taking
> checkpoints of a virtual machine (where the suspend hypercall returns
> non-zero, requiring the devices and xenbus to just pickup from where they left
> off instead of a complete teardown/reconnect to backend). 
> 
> The following set of patches modify this implementation to use Hibernate style
> control flow (freeze/restore for save/restore and freeze/thaw for checkpoint,
> which is merely a cancelled save akin to failed swsusp() ).
> 
> These patches are against Ian Campbell's PVHVM tree at
> git://xenbits.xen.org/people/ianc/linux-2.6.git for-stefano/pvhvm
> 
> at commit 8a8d1bc753c4e2dda5f2890292d60c67d6ebb573
> kernel version: 2.6.38-rc4

Series looks ok to me...
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
