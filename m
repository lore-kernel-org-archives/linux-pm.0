From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH V2 1/4] fix a problem that linux/async.h can
	not be	included in another header file
Date: Fri, 24 Jul 2009 09:12:07 +0200
Message-ID: <20090724071207.GA10760__18124.5365798988$1248419612$gmane$org@elf.ucw.cz>
References: <1248404520.2670.109.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1248404520.2670.109.camel@rzhang-dt>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Fri 2009-07-24 11:02:00, Zhang Rui wrote:
> 
> include/linux/async.h:16: error: redefinition of typedef ???async_cookie_t???
> include/linux/async.h:16: error: previous declaration of ???async_cookie_t??? was here
> include/linux/async.h:17: error: redefinition of typedef ???async_func_ptr???
> include/linux/async.h:17: error: previous declaration of ???async_func_ptr??? was here
> 
> fix a problem that include/linux/async.h can not be included in another header file
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Acked-by: Pavel Machek <pavel@ucw.cz>
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
