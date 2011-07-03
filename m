From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/7] pm: improve error code of
	pm_notifier_call_chain()
Date: Sun, 3 Jul 2011 19:15:39 +0200
Message-ID: <20110703171539.GF21127__38434.9789623686$1309713493$gmane$org@elf.ucw.cz>
References: <1309702581-16863-1-git-send-email-akinobu.mita@gmail.com>
	<1309702581-16863-2-git-send-email-akinobu.mita@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1309702581-16863-2-git-send-email-akinobu.mita@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-s390@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com, akpm@linux-foundation.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sun 2011-07-03 23:16:15, Akinobu Mita wrote:
> This enables pm_notifier_call_chain() to get the actual error code
> in the callback rather than always assume -EINVAL by converting all
> PM notifier calls to return encapsulate error code with
> notifier_from_errno().
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Pavel Machek <pavel@ucw.cz>

Nothing obviously wrong here.
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
