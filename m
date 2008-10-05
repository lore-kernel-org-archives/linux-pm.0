From: Pavel Machek <pavel@ucw.cz>
Subject: Re: uevent before resume completion
Date: Sun, 5 Oct 2008 11:49:47 +0200
Message-ID: <20081005094947.GA2351@ucw.cz>
References: <20080922141959.GA7976@jeknote.loshitsa1.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080922141959.GA7976@jeknote.loshitsa1.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Yauhen Kharuzhy <jekhor@gmail.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon 2008-09-22 17:19:59, Yauhen Kharuzhy wrote:
> Hi.
> 
> We have an ARM board which does wakeup on USB cable connection to
> it. In our power supply driver "USB connect" interrupt handler calls
> power_supply_changed() which cause generation of uevent (in
> power_supply_changed_work() ). But usermodehelper_disabled
> still equals to 1 because resume process is not finished yet and
> userspace helper is not executed.
> 
> How to fix this behaviour without breaking other kernel parts? We
> definitely need to invoke userspace helper on USB cable insertion. Yes,
> we can generate event after some time with timer but I think that a more
> elegant solution can be found.

If you do it such that your 'delayed uevent' code can be reused by
other subsystems, it should not be too bad...
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
