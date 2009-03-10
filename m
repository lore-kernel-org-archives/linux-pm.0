From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] pm: cleanup includes
Date: Tue, 10 Mar 2009 12:24:39 +0100
Message-ID: <20090310112439.GH1337@ucw.cz>
References: <20090225040604.18532.22158.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090225040604.18532.22158.sendpatchset@rx1.opensource.se>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, akpm@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed 2009-02-25 13:06:04, Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> This patch removes unused/duplicate cruft from asm/suspend.h:
>  - x86_32: remove unused acpi code
>  - powerpc: remove duplicate prototypes, see linux/suspend.h
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

Not tested but looks ok. ACK.
							Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
