From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.29-rc: PM notifiers are not called during
	hibernation
Date: Wed, 4 Mar 2009 08:47:33 +0100
Message-ID: <20090304074733.GA1405__26208.6516865113$1236153124$gmane$org@ucw.cz>
References: <200901292254.09562.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200901292254.09562.arvidjaar@mail.ru>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu 2009-01-29 22:53:57, Andrey Borzenkov wrote:
> rc2 and now rc3
> 
> Orinoco driver uses notifications to request firmware before 
> suspend/hibernation. This is OK for suspend, but does not seem to work 
> for hibernation. I get what suspiciously looks like 60 seconds timeout 
> for request_firmware, but I do not see either usual request_firmware 
> output, nor debug output.
> 
> Suspend is OK.
> 
> orinoco notification handlers is:

Is it fixed in newer -rc? If not, does rafael know?


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
