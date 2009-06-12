From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 14/19] PM: Remove device_type
	suspend()/resume()
Date: Fri, 12 Jun 2009 13:03:32 +0200
Message-ID: <20090612110332.GM18682__44788.0172440366$1244804669$gmane$org@elf.ucw.cz>
References: <0615007ad8090a890586d530b5d3bb98da566014.1244752872.git.rjw@sisk.pl>
	<S4AoGnG.A.OH.VhYMKB@chimera>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <S4AoGnG.A.OH.VhYMKB@chimera>
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
Cc: Sergio Luis <sergio@larces.uece.br>, Lauro Salmito <laurosalmito@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jaswinder Singh Rajput <jaswinder@kernel.org>, Magnus Damm <damm@igel.co.jp>, Linux PM List <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Thu 2009-06-11 22:40:00, Rafael J. Wysocki wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> This patch removes the legacy callbacks ->suspend() and
> ->resume() from struct device_type. These callbacks seem
> unused, and new code should instead make use of struct
> dev_pm_ops.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Ack.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
