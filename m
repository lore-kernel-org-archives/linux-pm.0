From: "Alon Bar-Lev" <alon.barlev@gmail.com>
Subject: Re: [RFC][PATCH 1/2 -mm] kexec based hibernation -v3:
	kexec jump
Date: Sun, 23 Sep 2007 00:02:06 +0200
Message-ID: <9e0cf0bf0709221502u1701cd16vcb31f88896924d6e__10592.5629185096$1190498592$gmane$org@mail.gmail.com>
References: <1190266447.21818.17.camel@caritas-dev.intel.com>
	<200709211157.28622.nigel@nigel.suspend2.net>
	<1190341137.21818.52.camel@caritas-dev.intel.com>
	<200709211225.25874.nigel@nigel.suspend2.net>
	<1190342757.21818.75.camel@caritas-dev.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1190342757.21818.75.camel@caritas-dev.intel.com>
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
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, nigel@suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On 9/21/07, Huang, Ying <ying.huang@intel.com> wrote:
> This is fairly simple in fact. For example, you can specify the
> bdev/sectors in kernel command line when do kexec load "kexec -l <...>
> --append='...'", then the image writing system can get it through
> "cat /proc/cmdline".

I hope you take into account encrypted swap configuration.
Currently all three suspend implementations support using encrypted
swap in order to suspend/resume.
A configuration which forces the user to remap encryption on the kexec
kernel during suspend is not valid.

Best Regards,
Alon Bar-Lev.
