From: "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [RFC][PATCH 2/2 -mm] kexec based hibernation -v3:
	kexec restore
Date: Thu, 20 Sep 2007 16:19:41 +0800
Message-ID: <1190276381.21818.21.camel__48639.7242210389$1190276335$gmane$org@caritas-dev.intel.com>
References: <1190266450.21818.18.camel@caritas-dev.intel.com>
	<20070920081524.GA8732@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070920081524.GA8732@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Thu, 2007-09-20 at 10:15 +0200, Pavel Machek wrote:
> > This patch adds writing support for /dev/oldmem. This is used to
> > restore the memory contents of hibernated system.
> > 
> > Signed-off-by: Huang Ying <ying.huang@intel.com>
> 
> ACK. (And this can even go in before the patch #1, right?)

Yes. This patch does not depend on patch #1.

Best Regards,
Huang Ying
