From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH -mm 1/5] Hibernation: Introduce
	SNAPSHOT_GET_IMAGE_SIZE ioctl
Date: Mon, 3 Sep 2007 03:17:35 +0000
Message-ID: <20070903031734.GG21721@ucw.cz>
References: <200709022315.59652.rjw@sisk.pl> <200709022317.41708.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200709022317.41708.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun 2007-09-02 23:17:41, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Add a new ioctl, SNAPSHOT_GET_IMAGE_SIZE, returning the size of the (just created)
> hibernation image, to the hibernation userland interface.
> 
> This ioctl is necessary so that the userland utilities using the interface need
> not access the hibernation image header, owned by the kernel, in order to obtain
> the size of the image.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
