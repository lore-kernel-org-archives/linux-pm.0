From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 6/6] Hibernation: Move extern definition to
	header file
Date: Tue, 27 Nov 2007 01:23:39 +0100
Message-ID: <20071127002339.GE9759__43936.502809129$1196123054$gmane$org@elf.ucw.cz>
References: <200711270025.08128.rjw@sisk.pl> <200711270033.04999.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200711270033.04999.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Move the extern definition of resume_file[] from kernel/power/swap.c
> to kernel/power/power.h .
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

can we just get rid of extern? It does not seem to be used. (at least
in very quick grep over 2.6.24-rc3):

pavel@amd:/data/l/linux/kernel/power$ grep resume_file *.c
disk.c:char resume_file[256] = CONFIG_PM_STD_PARTITION;
disk.c:         if (!strlen(resume_file)) {
disk.c:         swsusp_resume_device = name_to_dev_t(resume_file);
disk.c:         pr_debug("swsusp: Resume From Partition %s\n",
resume_file);
disk.c: strncpy( resume_file, str, 255 );
swap.c:extern char resume_file[];
pavel@amd:/data/l/linux/kernel/power$

								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
